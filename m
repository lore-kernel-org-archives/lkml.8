Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E584C206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHKHyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:54:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728133AbgHKHyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:54:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D23CB3EBB3893400E5D;
        Tue, 11 Aug 2020 15:54:40 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 11 Aug
 2020 15:54:35 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
To:     Daeho Jeong <daeho43@gmail.com>
CC:     Gao Xiang <hsiangkao@redhat.com>,
        Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200811033753.783276-1-daeho43@gmail.com>
 <20200811071552.GA8365@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com>
Date:   Tue, 11 Aug 2020 15:54:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200811071552.GA8365@xiangao.remote.csb>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/11 15:15, Gao Xiang wrote:
> On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> By profiling f2fs compression works, I've found vmap() callings are
>> bottlenecks of f2fs decompression path. Changing these with
>> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
>>
>> [Verification]
>> dd if=/dev/zero of=dummy bs=1m count=1000
>> echo 3 > /proc/sys/vm/drop_caches
>> dd if=dummy of=/dev/zero bs=512k
>>
>> - w/o compression -
>> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
>> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
>> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
>>
>> - before patch -
>> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
>> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
>> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
>>
>> - after patch -
>> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
>> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
>> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> 
> Indeed, vmap() approach has some impact on the whole
> workflow. But I don't think the gap is such significant,
> maybe it relates to unlocked cpufreq (and big little
> core difference if it's on some arm64 board).

Agreed,

I guess there should be other reason causing the large performance
gap, scheduling, frequency, or something else.

> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
