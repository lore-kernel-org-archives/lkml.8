Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A89205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCIBjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:39:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbgCIBjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:39:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0F5A86CFCDB6777D99F;
        Mon,  9 Mar 2020 09:39:18 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 09:39:10 +0800
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Jeff Moyer <jmoyer@redhat.com>, <linux-aio@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcrl@kvack.org>, <wangkefeng.wang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
 <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
 <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
 <20190729154720.GS1131@ZenIV.linux.org.uk>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <2c44dc0f-6030-dfff-a7f2-41418f0c06a6@huawei.com>
Date:   Mon, 9 Mar 2020 09:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20190729154720.GS1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Al, could you please consider applying this patch ?

Thanks,
Yi.

On 2019/7/29 23:47, Al Viro wrote:
> On Mon, Jul 29, 2019 at 10:57:41AM -0400, Jeff Moyer wrote:
>> Al, can you take this through your tree?
> 
> Umm...  Can do, but I had an impression that Arnd and Deepa
> had a tree for timespec-related work.  OTOH, it had been
> relatively quiet last cycle, so...  If they have nothing
> in the area, I can take it through vfs.git.
> 
> .
> 

