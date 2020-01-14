Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1979BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9262467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI49oSZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgANO5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:57:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727092AbgANO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579013840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRnkICnNJBIzJOH97eFHI4gLkkkXhQ+8DcPEdenNZ4Q=;
        b=AI49oSZ5j/ILSJdXRBl6BlPC9gMf6FZte3/qmDo6+qi4KMcnaam8OYiuyJnhf0pPbvyOKV
        H93iXuAnqOEqMY4LnTmJdBRi+K2L2C9cetFNSWLWk5dLzSe3wvGwJ0BHhyWrPtdGsVmSke
        offpBobCMcT62owWzR1xwfbQLwM7y8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-G_2eAZEZOOOvrcdG1DZZ9A-1; Tue, 14 Jan 2020 09:57:17 -0500
X-MC-Unique: G_2eAZEZOOOvrcdG1DZZ9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 117DA801E78;
        Tue, 14 Jan 2020 14:57:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-77.rdu2.redhat.com [10.10.124.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4ED75DA7D;
        Tue, 14 Jan 2020 14:57:13 +0000 (UTC)
Subject: Re: [mm/hugetlb] c77c0a8ac4: will-it-scale.per_process_ops 15.9%
 improvement
To:     Michal Hocko <mhocko@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200114085637.GA29297@shao2-debian>
 <20200114091251.GE19428@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bd474ca4-9f47-0ab1-f461-513789fc074d@redhat.com>
Date:   Tue, 14 Jan 2020 09:57:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114091251.GE19428@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 4:12 AM, Michal Hocko wrote:
> On Tue 14-01-20 16:56:37, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a 15.9% improvement of will-it-scale.per_process_ops due to commit:
>>
>>
>> commit: c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d ("mm/hugetlb: defer freeing of huge pages if in non-task context")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> This is more than surprising because the patch has only changed the
> behavior for hugetlb pages freed from the (soft)interrupt context and
> that should be a very rare event. Does the test really generate a lot of
> those?
>
Yes, I have the same question. I was not expecting to see any
performance impact.

Cheers,
Longman

