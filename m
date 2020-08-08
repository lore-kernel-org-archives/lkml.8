Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD962086A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHHD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:26:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgHHD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 23:26:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E1FA45E9A62030277B8;
        Sat,  8 Aug 2020 11:26:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 11:26:05 +0800
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com>
 <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com>
 <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
 <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com>
 <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
 <5f7ae548-350b-cedf-3c8e-25fea06a8377@huawei.com>
 <CAFLxGvy-RRksDvPcB6z8GQUoMFZ_NRGxk9aM2FuTZ22UWU6Knw@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <56435b1e-ffdf-9d4a-5865-f2ce3b36644f@huawei.com>
Date:   Sat, 8 Aug 2020 11:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvy-RRksDvPcB6z8GQUoMFZ_NRGxk9aM2FuTZ22UWU6Knw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/8/8 3:29, Richard Weinberger 写道:
> On Fri, Aug 7, 2020 at 4:18 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:

> Maybe it's just me being dense and in need for a vacation. ;-)
> 
I have quite a few ubi/ubifs patches in pending list, may you 
comment/check them before 5.9 ending please? thanks. ＼(￣▽￣)

For example:

https://patchwork.ozlabs.org/project/linux-mtd/patch/20200601091037.3794172-2-chengzhihao1@huawei.com/

https://patchwork.ozlabs.org/project/linux-mtd/patch/20200602112410.660785-1-chengzhihao1@huawei.com/

https://patchwork.ozlabs.org/project/linux-mtd/cover/20200616071146.2607061-1-chengzhihao1@huawei.com/

