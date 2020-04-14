Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58169C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3692220656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PIrTpU7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505124AbgDNTnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:43:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1180 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504949AbgDNTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:43:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96120e0001>; Tue, 14 Apr 2020 12:42:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Apr 2020 12:43:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Apr 2020 12:43:04 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Apr
 2020 19:43:04 +0000
Received: from [10.26.73.15] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Apr
 2020 19:43:01 +0000
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Rob Herring <robh@kernel.org>, Karol Herbst <karolherbst@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Segher Boessenkool" <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20191211232345.24810-1-robh@kernel.org>
 <5386e959-f9c4-2748-ed08-34ab361aee2c@nvidia.com>
 <CAL_JsqLmth0bYcG2VnxU-jk_VoC4TgvWD8_e6r1_8WqVwYGq0g@mail.gmail.com>
 <93314ff5-aa89-cd99-393c-f75f31d9d6e5@nvidia.com>
 <CAL_JsqL84LvUrNy095E_sC2UJnB3SFBgsw6wjOKmFM249BHMOA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <97c0d1f4-f73e-98bd-380b-d1b8658b965a@nvidia.com>
Date:   Tue, 14 Apr 2020 20:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL84LvUrNy095E_sC2UJnB3SFBgsw6wjOKmFM249BHMOA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586893326; bh=5SeSWnlnNXu3ix6j1SQBL1b0Wj2Lu1/GlzCZkTlRGbk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PIrTpU7mjRDGrDY2LHI80qDLR80IqS9UwjwB7/Mx/Nyz4Z0eS028r3+i078Vbz/gY
         y/iSQGye3+oAJjdeHO0nuxzCeotZHg9iy0DNYjdFvxGnAc66VqMQFu9QE74mg5ocMu
         Mt6TNg7rdTpiUG8ghbG4/cCSgRSiF5cnTYBMu0GTIPBzolQZD3u2ixvaBkHJU/S2iJ
         rNDlFHEK2iLFNx+ZVxn00cE+wGlIAFl96BIKhYf9tfzfPcupAFUtqcGCM113Khuk7b
         dbxELKjTprzhvrIjFTN86kU3ymrbvEQxMQzak4rbmsX8fBxaMXEhlLGwwgKgZLwYIX
         BE4n4sjftafAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 16:00, Rob Herring wrote:
> +Karol
> 
> On Mon, Jan 13, 2020 at 5:12 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 10/01/2020 23:50, Rob Herring wrote:
>>> On Tue, Jan 7, 2020 at 4:22 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 11/12/2019 23:23, Rob Herring wrote:
>>>>> The phandle cache was added to speed up of_find_node_by_phandle() by
>>>>> avoiding walking the whole DT to find a matching phandle. The
>>>>> implementation has several shortcomings:
>>>>>
>>>>>   - The cache is designed to work on a linear set of phandle values.
>>>>>     This is true for dtc generated DTs, but not for other cases such as
>>>>>     Power.
>>>>>   - The cache isn't enabled until of_core_init() and a typical system
>>>>>     may see hundreds of calls to of_find_node_by_phandle() before that
>>>>>     point.
>>>>>   - The cache is freed and re-allocated when the number of phandles
>>>>>     changes.
>>>>>   - It takes a raw spinlock around a memory allocation which breaks on
>>>>>     RT.
>>>>>
>>>>> Change the implementation to a fixed size and use hash_32() as the
>>>>> cache index. This greatly simplifies the implementation. It avoids
>>>>> the need for any re-alloc of the cache and taking a reference on nodes
>>>>> in the cache. We only have a single source of removing cache entries
>>>>> which is of_detach_node().
>>>>>
>>>>> Using hash_32() removes any assumption on phandle values improving
>>>>> the hit rate for non-linear phandle values. The effect on linear values
>>>>> using hash_32() is about a 10% collision. The chances of thrashing on
>>>>> colliding values seems to be low.
>>>>>
>>>>> To compare performance, I used a RK3399 board which is a pretty typical
>>>>> system. I found that just measuring boot time as done previously is
>>>>> noisy and may be impacted by other things. Also bringing up secondary
>>>>> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
>>>>> With no caching, calls to of_find_node_by_phandle() take about 20124 us
>>>>> for 1248 calls. There's an additional 288 calls before time keeping is
>>>>> up. Using the average time per hit/miss with the cache, we can calculate
>>>>> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
>>>>> and 13319 us with no cache or an uninitialized cache.
>>>>>
>>>>> Comparing the 3 implementations the time spent in
>>>>> of_find_node_by_phandle() is:
>>>>>
>>>>> no cache:        20124 us (+ 13319 us)
>>>>> 128 entry cache:  5134 us (+ 690 us)
>>>>> current cache:     819 us (+ 13319 us)
>>>>>
>>>>> We could move the allocation of the cache earlier to improve the
>>>>> current cache, but that just further complicates the situation as it
>>>>> needs to be after slab is up, so we can't do it when unflattening (which
>>>>> uses memblock).
>>>>>
>>>>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>
>>>> With next-20200106 I have noticed a regression on Tegra210 where it
>>>> appears that only one of the eMMC devices is being registered. Bisect is
>>>> pointing to this patch and reverting on top of next fixes the problem.
>>>> That is as far as I have got so far, so if you have any ideas, please
>>>> let me know. Unfortunately, there do not appear to be any obvious errors
>>>> from the bootlog.
>>>
>>> I guess that's tegra210-p2371-2180.dts because none of the others have
>>> 2 SD hosts enabled. I don't see anything obvious though. Are you doing
>>> any runtime mods to the DT?
>>
>> I have noticed that the bootloader is doing some runtime mods and so
>> checking if this is the cause. I will let you know, but most likely,
>> seeing as I cannot find anything wrong with this change itself.
> 
> Did you figure out the problem here? Karol sees a similar problem on
> Tegra210 with the gpu node regulator.
> 
> It looks like /external-memory-controller@7001b000 has a duplicate
> phandle. Comparing the dtb in the filesystem with what the kernel
> gets, that node is added by the bootloader. So the bootloader is
> definitely creating a broken dtb.

Yes it was caused by the bootloader, u-boot, incorrectly copying some
nodes. After preventing u-boot from doing that, it was fine. There are
some u-boot environment variables [0] that you can try clearing to
prevent this. Alternatively, if you use a upstream u-boot that should
also work.

Cheers
Jon

[0] https://elinux.org/Jetson/TX1_Upstream_Kernel#Upstream_Linux_kernel

-- 
nvpublic
