Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E2C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63252073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7qaDjxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAOO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:27:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgAOO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579098442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVwo9D//7EZc6w4rGHFygYSsWAT2K7IH/zSD8SF2614=;
        b=M7qaDjxhlewW3RMiXKx0l2vr0GSjAW9/XwY6hAM3jfZD0mXKskTJN3trRgeUElBfPwh7uh
        tUfOCvQe21k5U5hjPJu8uzAXtlok2AOrf7yPGOS6wrLkAtgKgDGp59BwHADGAx6ENfeCDv
        k1AlnOX0ztZKBNw3Wgz2ax2ksYaWAn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-oaRjp2R1PiWVqv_kEv8Dmg-1; Wed, 15 Jan 2020 09:27:18 -0500
X-MC-Unique: oaRjp2R1PiWVqv_kEv8Dmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68761101EC29;
        Wed, 15 Jan 2020 14:27:17 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5B0A60E1C;
        Wed, 15 Jan 2020 14:27:16 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Fix kernel crash when spinning on
 RWSEM_OWNER_UNKNOWN
To:     Christoph Hellwig <hch@lst.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200114190303.5778-1-longman@redhat.com>
 <20200115065055.GA21219@lst.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <021830af-fd89-50e5-ad26-6061e5abdce1@redhat.com>
Date:   Wed, 15 Jan 2020 09:27:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115065055.GA21219@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 1:50 AM, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 02:03:03PM -0500, Waiman Long wrote:
>> The commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer
>> optimistically spin on owner") will allow a recently woken up waiting
>> writer to spin on the owner. Unfortunately, if the owner happens to be
>> RWSEM_OWNER_UNKNOWN, the code will incorrectly spin on it leading to a
>> kernel crash. This is fixed by passing the proper non-spinnable bits
>> to rwsem_spin_on_owner() so that RWSEM_OWNER_UNKNOWN will be treated
>> as a non-spinnable target.
>>
>> Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
>>
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> This survives all the tests that showed the problems with the original
> code:
>
> Tested-by: Christoph Hellwig <hch@lst.de>
>
>>  		if ((wstate == WRITER_HANDOFF) &&
>> -		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
>> +		    rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE) == OWNER_NULL)
> Nit: the inner braces in the first half of the conditional aren't required
> either.

I typically over-parenthesize the code to make it easier to read as we
don't need to think too much about operator precedence to see if it is
doing the right thing. I remove the 2nd parentheses to avoid breaking
the 80-colnum limit.

Cheers,
Longman

