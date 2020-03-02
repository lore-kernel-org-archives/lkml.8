Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1013C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831EE2468D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBD6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 22:58:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbgCBD6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 22:58:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 138C5119A387DF3CC13B;
        Mon,  2 Mar 2020 11:58:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.98) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 11:58:36 +0800
Subject: Re: [PATCH] ubifs: Don't discard nodes in recovery when ecc err
 detected
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1582293853-136727-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvyJdWcXQt3H2aknTuGhCJpV5YvAbW_wuHfs3m+KcNSjtw@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <58b11ca2-6b91-52b3-bc75-d44abb202cfb@huawei.com>
Date:   Mon, 2 Mar 2020 11:58:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyJdWcXQt3H2aknTuGhCJpV5YvAbW_wuHfs3m+KcNSjtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.98]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/3/2 4:46, Richard Weinberger 写道:
> Zhihao Cheng,
>
> On Fri, Feb 21, 2020 at 2:57 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> The following process will lead TNC to find no corresponding inode node
>> (Reproduce method see Link):
> Please help me to understand what exactly is going on.
>
>>    1. Garbage collection.
>>       1) move valid inode nodes from leb A to leb B
>>          (The leb number of B has been written as GC type bud node in log)
>>       2) unmap leb A, and corresponding peb is erased
>>          (GCed inode nodes exist only on leb B)
> At this point all valid nodes are written to LEB B, right?
Yes.
>
>>    2. Poweroff. A node near the end of the LEB is corrupted before power
>>       on, which is uncorrectable error of ECC.
> If writing nodes to B has finished, these pages should be stable.
> How can a power-cut affect the pages where these valid nodes sit?
I mean, the uncorrectable ECC error is caused by hardware which may lead 
to corrupted nodes detected in UBIFS. I found uncorretable ECC errors on 
my NAND, in the environment of high temperature and humidity.

At present, UBIFS ignores all EBADMSG errors, so the corrupted node is 
only considered in being caused by unfinished writing. I think UBIFS 
should consider the corrupted area caused by ECC errors in process 
ubifs_recover_leb(). no_more_nodes() will skip a read-write unit. Maybe 
the corrupted area is skipped.



