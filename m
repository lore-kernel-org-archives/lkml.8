Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A05C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6782065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glasLEIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbgEZUbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:31:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389096AbgEZUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590525080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5HsvkOS39/pqJszGcOndT9nAZ5CE8YwcSNpRDQR19E=;
        b=glasLEIMaePFeMSDMGMlSshMNVS/Vg6BOOtWY23mCGZVb7ObQKKSjKJg+UuMgtSfrjKwKH
        3IjZdB0XqneagGYnn2RyifRlGcXB80M2c9UPT+e6fccupath44525ult7flfg73l+zGfH9
        hy8ejbNE+BciowxEHxXFm4gDjPRN3d8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-m1fjb71ROuu8T7Pn8UUmZQ-1; Tue, 26 May 2020 16:31:00 -0400
X-MC-Unique: m1fjb71ROuu8T7Pn8UUmZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD22A107ACCA;
        Tue, 26 May 2020 20:30:59 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15C975C1C5;
        Tue, 26 May 2020 20:30:58 +0000 (UTC)
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
 <20200526195630.GF325280@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
Date:   Tue, 26 May 2020 16:30:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200526195630.GF325280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 3:56 PM, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:
>
>> I still don't understand why reading all sysfs files on this system
>> could increase that much, but here is the lockdep file after
>> running sysfs read to see if you could spot anything obviously,
>>
>> https://cailca.github.io/files/lockdep.txt
> 00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834
>
> is that somewhere near the number of CPUs you have?
>
> Anyway, there's very long "kn->active#..." chains in there, which seems
> to suggest some annotation is all sorts of buggered.
>
It is actually one active lock per instance of the kerfs_node 
structures. That means more than 800 sysfs files are accessed in some 
way. As we could have much more than 800 sysfs files in the system, we 
could easily overwhelm the lockdep tables if we really try to access all 
of them.

Cheers,
Longman

