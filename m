Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C38206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLBvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:51:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbgHLBvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:51:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F1BC595C8752D438AE5;
        Wed, 12 Aug 2020 09:51:08 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 12 Aug
 2020 09:51:03 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
To:     Daeho Jeong <daeho43@gmail.com>, Gao Xiang <hsiangkao@redhat.com>
CC:     Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200811033753.783276-1-daeho43@gmail.com>
 <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com>
 <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
 <CACOAw_wi3C0iyTVYc3075d4K27NT7BGMGzsKFDDozf=98vWMcA@mail.gmail.com>
 <20200811101827.GA7870@xiangao.remote.csb>
 <CACOAw_zRPeGzHyc_siLqBRjURWTE61G5rGCwk7bnbcOnADGRpg@mail.gmail.com>
 <20200811112912.GB7870@xiangao.remote.csb>
 <CACOAw_zAbTf+hEW0XVyL-aUw7oxCFTm_jRXLM8eiaOEdDWc0Qw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7808b204-b0a4-400c-9ccc-07bc7aea194d@huawei.com>
Date:   Wed, 12 Aug 2020 09:51:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_zAbTf+hEW0XVyL-aUw7oxCFTm_jRXLM8eiaOEdDWc0Qw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/11 19:31, Daeho Jeong wrote:
> Plus, differently from your testbed, in my pixel device, there seems
> to be much more contention in vmap() operation.
> If it's not there, I agree that there might not be a big difference
> between vmap() and vm_map_ram().
> 
> 2020년 8월 11일 (화) 오후 8:29, Gao Xiang <hsiangkao@redhat.com>님이 작성:
>>
>> On Tue, Aug 11, 2020 at 08:21:23PM +0900, Daeho Jeong wrote:
>>> Sure, I'll update the test condition as you said in the commit message.
>>> FYI, the test is done with 16kb chunk and Pixel 3 (arm64) device.
>>
>> Yeah, anyway, it'd better to lock the freq and offline the little
>> cores in your test as well (it'd make more sense). e.g. if 16k cluster

I'm not against this commit, but could you please try to adjust cpufreq to
fixed value and offline little or big core, so that we can supply fair test
environment during test, I just wonder that in such environment, how much we
can improve the performance with vm_map_ram().

>> is applied, even all data is zeroed, the count of vmap/vm_map_ram
>> isn't hugeous (and as you said, "sometimes, it has a very long delay",
>> it's much like another scheduling concern as well).
>>
>> Anyway, I'm not against your commit but the commit message is a bit
>> of unclear. At least, if you think that is really the case, I'm ok
>> with that.
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>>
>>> 2020ë…„ 8ì›” 11ì�¼ (í™”) ì˜¤í›„ 7:18, Gao Xiang <hsiangkao@redhat.com>ë‹˜ì�´ ìž‘ì„±:
>>>>
>>>> On Tue, Aug 11, 2020 at 06:33:26PM +0900, Daeho Jeong wrote:
>>>>> Plus, when we use vmap(), vmap() normally executes in a short time
>>>>> like vm_map_ram().
>>>>> But, sometimes, it has a very long delay.
>>>>>
>>>>> 2020Ã«â€¦â€ž 8Ã¬â€ºâ€� 11Ã¬ï¿½Â¼ (Ã­â„¢â€�) Ã¬ËœÂ¤Ã­â€ºâ€ž 6:28, Daeho Jeong <daeho43@gmail.com>Ã«â€¹ËœÃ¬ï¿½Â´ Ã¬Å¾â€˜Ã¬â€žÂ±:
>>>>>>
>>>>>> Actually, as you can see, I use the whole zero data blocks in the test file.
>>>>>> It can maximize the effect of changing virtual mapping.
>>>>>> When I use normal files which can be compressed about 70% from the
>>>>>> original file,
>>>>>> The vm_map_ram() version is about 2x faster than vmap() version.
>>>>
>>>> What f2fs does is much similar to btrfs compression. Even if these
>>>> blocks are all zeroed. In principle, the maximum compression ratio
>>>> is determined (cluster sized blocks into one compressed block, e.g
>>>> 16k cluster into one compressed block).
>>>>
>>>> So it'd be better to describe your configured cluster size (16k or
>>>> 128k) and your hardware information in the commit message as well.
>>>>
>>>> Actually, I also tried with this patch as well on my x86 laptop just
>>>> now with FIO (I didn't use zeroed block though), and I didn't notice
>>>> much difference with turbo boost off and maxfreq.
>>>>
>>>> I'm not arguing this commit, just a note about this commit message.
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
>>>>
>>>> IMHO, the above number is much like decompressing in the arm64 little cores.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>
>>>>>>
>>>>>> 2020Ã«â€¦â€ž 8Ã¬â€ºâ€� 11Ã¬ï¿½Â¼ (Ã­â„¢â€�) Ã¬ËœÂ¤Ã­â€ºâ€ž 4:55, Chao Yu <yuchao0@huawei.com>Ã«â€¹ËœÃ¬ï¿½Â´ Ã¬Å¾â€˜Ã¬â€žÂ±:
>>>>>>>
>>>>>>> On 2020/8/11 15:15, Gao Xiang wrote:
>>>>>>>> On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
>>>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>>>
>>>>>>>>> By profiling f2fs compression works, I've found vmap() callings are
>>>>>>>>> bottlenecks of f2fs decompression path. Changing these with
>>>>>>>>> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
>>>>>>>>>
>>>>>>>>> [Verification]
>>>>>>>>> dd if=/dev/zero of=dummy bs=1m count=1000
>>>>>>>>> echo 3 > /proc/sys/vm/drop_caches
>>>>>>>>> dd if=dummy of=/dev/zero bs=512k
>>>>>>>>>
>>>>>>>>> - w/o compression -
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
>>>>>>>>>
>>>>>>>>> - before patch -
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
>>>>>>>>>
>>>>>>>>> - after patch -
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
>>>>>>>>> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
>>>>>>>>
>>>>>>>> Indeed, vmap() approach has some impact on the whole
>>>>>>>> workflow. But I don't think the gap is such significant,
>>>>>>>> maybe it relates to unlocked cpufreq (and big little
>>>>>>>> core difference if it's on some arm64 board).
>>>>>>>
>>>>>>> Agreed,
>>>>>>>
>>>>>>> I guess there should be other reason causing the large performance
>>>>>>> gap, scheduling, frequency, or something else.
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> Linux-f2fs-devel mailing list
>>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>>>> .
>>>>>>>>
>>>>>
>>>>
>>>
>>
> .
> 
