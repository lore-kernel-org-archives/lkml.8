Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC47C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE98D207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:36:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgGGMgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:36:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A32FFF6769E724F418DA;
        Tue,  7 Jul 2020 20:36:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 20:36:11 +0800
Subject: Re: [PATCH] ubifs: Fix a potential space leak problem while linking
 tmpfile
To:     Richard Weinberger <richard@nod.at>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
References: <20200701112643.726986-1-chengzhihao1@huawei.com>
 <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com>
 <082f18e0-d6f0-6389-43af-3159edb244cb@huawei.com>
 <1463101229.103384.1594123741187.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <963fa5c8-414f-783f-871e-47e751b54d87@huawei.com>
Date:   Tue, 7 Jul 2020 20:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1463101229.103384.1594123741187.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/7 20:09, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Perhaps I misunderstood what commit 32fe905c17f001 ("ubifs: Fix
>> O_TMPFILE corner case in ubifs_link()") wanted to fix.
>> I think orphan area is used to remind filesystem don't forget to delete
>> inodes (whose nlink is 0) in next unclean rebooting. Generally, the file
>> system is not corrupted caused by replaying orphan nodes.
>> Ralph reported a filesystem corruption in combination with overlayfs.
>> Can you tell me the details about that problem? Thanks.
> On my test bed I didn't see a fs corruption, what I saw was a failing orphan
> self test while playing with O_TMPFILE and linkat().
Do we have a reproducer, or can I get the fail testcase? Is it a xfstest 
case?
>
> When you create a tmpfile it has a link count of 0 and an orphan is
> installed. Such that the tmpfile is gone after a reboot but you can
> still use it prior to that.
> By using linkat() you can raise the link counter to 1 again.
> Thus, the orphan needs to be removed.
> This is pattern overlayfs uses a lot.
>
> Since UBIFS never supported raising the link counter from 0 to 1
> we have many corner cases and fixing all these turned out into a nightmare.
> ...as you can see from the amount broken patches from me :-(.
>
> Thanks,
> //richard
>
> .



