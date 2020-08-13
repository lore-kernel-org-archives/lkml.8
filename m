Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4103BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AB820791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:09:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbgHMJJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:09:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9C59BBD47B20F3BD603B;
        Thu, 13 Aug 2020 17:09:48 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 13 Aug
 2020 17:09:47 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change virtual mapping way for
 compression pages
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200812051711.2147716-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b201452d-b1dd-146c-3a1a-c199d9a5974c@huawei.com>
Date:   Thu, 13 Aug 2020 17:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200812051711.2147716-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/12 13:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> By profiling f2fs compression works, I've found vmap() callings have
> unexpected hikes in the execution time in our test environment and
> those are bottlenecks of f2fs decompression path. Changing these with
> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> 
> [Verification]
> Android Pixel 3(ARM64, 6GB RAM, 128GB UFS)
> Turned on only 0-3 little cores(at 1.785GHz)
> 
> dd if=/dev/zero of=dummy bs=1m count=1000
> echo 3 > /proc/sys/vm/drop_caches
> dd if=dummy of=/dev/zero bs=512k
> 
> - w/o compression -
> 1048576000 bytes (0.9 G) copied, 2.082554 s, 480 M/s
> 1048576000 bytes (0.9 G) copied, 2.081634 s, 480 M/s
> 1048576000 bytes (0.9 G) copied, 2.090861 s, 478 M/s
> 
> - before patch -
> 1048576000 bytes (0.9 G) copied, 7.407527 s, 135 M/s
> 1048576000 bytes (0.9 G) copied, 7.283734 s, 137 M/s
> 1048576000 bytes (0.9 G) copied, 7.291508 s, 137 M/s
> 
> - after patch -
> 1048576000 bytes (0.9 G) copied, 1.998959 s, 500 M/s
> 1048576000 bytes (0.9 G) copied, 1.987554 s, 503 M/s
> 1048576000 bytes (0.9 G) copied, 1.986380 s, 503 M/s
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
