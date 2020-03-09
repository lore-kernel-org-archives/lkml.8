Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD0B20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIIQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:16:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCIIQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:16:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9427C2E1C9510EE52B24;
        Mon,  9 Mar 2020 16:16:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 16:16:32 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <arei.gonglei@huawei.com>, <huangzhichao@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20200305033014.1152-1-longpeng2@huawei.com>
 <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
 <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
 <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
From:   "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <4a544411-43cc-41b3-68eb-1cc3d6af159b@huawei.com>
Date:   Mon, 9 Mar 2020 16:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/3/7 4:12, Mike Kravetz 写道:
> On 3/5/20 10:36 PM, Longpeng (Mike) wrote:
>> 在 2020/3/6 8:09, Mike Kravetz 写道:
>>> On 3/4/20 7:30 PM, Longpeng(Mike) wrote:
>>>> From: Longpeng <longpeng2@huawei.com>
>>
>>> I am thinking we may want to have a more generic solution by allowing
[...]
>>> Of course, another approach would be to simply require ALL architectures
>>> to set up hstates for ALL supported huge page sizes.
>>>
>> I think this is also needed, then we can request all supported size of hugepages
>> by sysfs(e.g. /sys/kernel/mm/hugepages/*) dynamically. Currently, (x86) we can
>> only request 1G-hugepage through sysfs if we boot with 'default_hugepagesz=1G',
>> even with the first approach.
> 
> I 'think' you can use sysfs for 1G huge pages on x86 today.  Just booted a
> system without any hugepage options on the command line.
> 
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 0
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/^Cugepages
> # echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 1
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
> 1
> 
> x86 and riscv will set up hstates for PUD_SIZE hstates by default if
> CONFIG_CONTIG_ALLOC.  This is because of a somewhat recent feature that
> allowed dynamic allocation of gigantic (page order >= MAX_ORDER) pages.
> Before that feature, it made no sense to set up an hstate for gigantic
> pages if they were not allocated at boot time and could not be dynamically
> added later.
> 
Um... maybe my poor English expressing ability to make you misunderstand.
In fact, I want to say that we should allow the user to allocate ALL supported
size of hugepages dynamically by default, so we need require ALL architectures
to set up ALL supported huge page sizes.

> I'll code up a proposal that does the following:
> - Have arch specific code provide a list of supported huge page sizes
> - Arch independent code uses list to create all hstates
> - Move processing of "hugepagesz=" to arch independent code
> - Validate "default_hugepagesz=" when value is read from command line
> 
> It make take a few days.  When ready, I will pull in the architecture
> specific people.
> 
Great! I'm looking forward to your patches. I also have one or two other small
improvements, I hope to discuss with you after you finish these codes.

> 
>> BTW, because it's not easy to discuss with you due to the time difference, I
>> have another question about the default hugepages to consult you here. Why the
>> /proc/meminfo only show the info about the default hugepages, but not others?
>> meminfo is more well know than sysfs, some ordinary users know meminfo but don't
>> know use the sysfs to get the hugepages status(e.g. total, free).
> 
> I believe that is simply history.  In the beginning there was only the
> default huge page size and that was added to meminfo.  People then wrote
> scripts to parse huge page information in meminfo.  When support for
> other huge pages was added, it was not added to meminfo as it could break
> user scripts parsing the file.  Adding information for all potential
> huge page sizes may create lots of entries that are unused.  I was not
> around when these decisions were made, but that is my understanding.
> BTW - A recently added meminfo field 'Hugetlb' displays the amount of
> memory consumed by huge pages of ALL sizes.

I get it, thanks :)

> -- 
> Mike Kravetz
> 


-- 
Regards,
Longpeng(Mike)

