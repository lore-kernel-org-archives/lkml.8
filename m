Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDCC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CE822522
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0hPrtDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAQOFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:05:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51590 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728600AbgAQOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579269935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kl1x70pKGGUA6E1oFz3MQgXzpA7N/510hb+vBFFN4JE=;
        b=A0hPrtDoi+v1Yl8jGrT0+Vmt6QyluQw01r3EAyHou58GwkpSlon117S5gq8xu7yAHnJ3fd
        6aY6+B0pHFixxCJa+cugIS3xMj2jOtsUf7TynMKGBpQKsrlpAIEchBy1cMXNnOKjnpB/ij
        pwxymrVWkA02+na7Y+w8jfzUtPyf/RU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-XKgm1uMuNBKGXmyXGp49_g-1; Fri, 17 Jan 2020 09:05:31 -0500
X-MC-Unique: XKgm1uMuNBKGXmyXGp49_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D9BA1084426;
        Fri, 17 Jan 2020 14:05:29 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2749283866;
        Fri, 17 Jan 2020 14:05:28 +0000 (UTC)
Subject: Re: [LKP] Re: [mm/hugetlb] c77c0a8ac4: will-it-scale.per_process_ops
 15.9% improvement
To:     Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
 <bd474ca4-9f47-0ab1-f461-513789fc074d@redhat.com>
 <20200117065628.GC86012@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <48f750d3-92b4-98d3-5cab-531304bf9fa1@redhat.com>
Date:   Fri, 17 Jan 2020 09:05:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200117065628.GC86012@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 1:56 AM, Feng Tang wrote:
> Hi Waiman and Michal,
>
> On Tue, Jan 14, 2020 at 09:57:14AM -0500, Waiman Long wrote:
>> On 1/14/20 4:12 AM, Michal Hocko wrote:
>>> On Tue 14-01-20 16:56:37, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed a 15.9% improvement of will-it-scale.per_process_ops due to commit:
>>>>
>>>>
>>>> commit: c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d ("mm/hugetlb: defer freeing of huge pages if in non-task context")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>> This is more than surprising because the patch has only changed the
>>> behavior for hugetlb pages freed from the (soft)interrupt context and
>>> that should be a very rare event. Does the test really generate a lot of
>>> those?
>>>
>> Yes, I have the same question. I was not expecting to see any
>> performance impact.
> We have the same question and did some further check.
>
> This is the "pagefault3" test case of will-it-scale, and is  
> mmap/get_page/munmap test. The source code is: 
> https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault3.c 
>
> And its running on LKP does NOT involve any hugetlb actions, as
> could be checking HugePages_* in /proc/meminfo.
>
> We also did another check, reverted c77c0a8ac4c5 and simply added
> some printk inside free_huge_page(), which can also bring 15%
> improvement.
>
> So one possible reason could be the commit changes the cache
> alignment of other kernel codes in final bzImage, which happens
> to hugely affect this test case.
>
> Thanks,
> Feng
>
That sounds reasonable to me. Thanks for the investigation.

Cheers,
Longman

