Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE392073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGFIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:25:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7373 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbgGFIZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:25:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4FA6BC70C4CE2936EBA5;
        Mon,  6 Jul 2020 16:25:53 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 6 Jul 2020
 16:25:49 +0800
Subject: Re: [PATCH RFC 5/5] f2fs: support age threshold based garbage
 collection
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200630100428.19105-1-yuchao0@huawei.com>
 <20200630100428.19105-5-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <84332ea5-f7b2-f996-31de-b6189c09f27d@huawei.com>
Date:   Mon, 6 Jul 2020 16:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200630100428.19105-5-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

This is a commercialized feature in huawei products for years, I think
it's time to try to upstream it, could you please take a look at this
idea, to see whether it could be a formal feature of f2fs?

On 2020/6/30 18:04, Chao Yu wrote:
> There are several issues in current background GC algorithm:
> - valid blocks is one of key factors during cost overhead calculation,
> so if segment has less valid block, however even its age is young or
> it locates hot segment, CB algorithm will still choose the segment as
> victim, it's not appropriate.
> - GCed data/node will go to existing logs, no matter in-there datas'
> update frequency is the same or not, it may mix hot and cold data
> again.
> - GC alloctor mainly use LFS type segment, it will cost free segment
> more quickly.
> 
> This patch introduces a new algorithm named age threshold based
> garbage collection to solve above issues, there are three steps
> mainly:
> 
> 1. select a source victim:
> - set an age threshold, and select candidates beased threshold:
> e.g.
>  0 means youngest, 100 means oldest, if we set age threshold to 80
>  then select dirty segments which has age in range of [80, 100] as
>  candiddates;
> - set candidate_ratio threshold, and select candidates based the
> ratio, so that we can shrink candidates to those oldest segments;
> - select target segment with fewest valid blocks in order to
> migrate blocks with minimum cost;
> 
> 2. select a target victim:
> - select candidates beased age threshold;
> - set candidate_radius threshold, search candidates whose age is
> around source victims, searching radius should less than the
> radius threshold.
> - select target segment with most valid blocks in order to avoid
> migrating current target segment.
> 
> 3. merge valid blocks from source victim into target victim with
> SSR alloctor.
> 
> Test steps:
> - create 160 dirty segments:
>  * half of them have 128 valid blocks per segment
>  * left of them have 384 valid blocks per segment
> - run background GC
> 
> Benefit: GC count and block movement count both decrease obviously:
> 
> - Before:
>   - Valid: 86
>   - Dirty: 1
>   - Prefree: 11
>   - Free: 6001 (6001)
> 
> GC calls: 162 (BG: 220)
>   - data segments : 160 (160)
>   - node segments : 2 (2)
> Try to move 41454 blocks (BG: 41454)
>   - data blocks : 40960 (40960)
>   - node blocks : 494 (494)
> 
> IPU: 0 blocks
> SSR: 0 blocks in 0 segments
> LFS: 41364 blocks in 81 segments
> 
> - After:
> 
>   - Valid: 87
>   - Dirty: 0
>   - Prefree: 4
>   - Free: 6008 (6008)
> 
> GC calls: 75 (BG: 76)
>   - data segments : 74 (74)
>   - node segments : 1 (1)
> Try to move 12813 blocks (BG: 12813)
>   - data blocks : 12544 (12544)
>   - node blocks : 269 (269)
> 
> IPU: 0 blocks
> SSR: 12032 blocks in 77 segments
> LFS: 855 blocks in 2 segments
