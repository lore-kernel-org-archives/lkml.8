Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8101CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5990420870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCCGNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:13:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgCCGNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:13:12 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3C0997EDCB890DB2F6A6;
        Tue,  3 Mar 2020 14:13:09 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.98) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 14:13:00 +0800
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
 <58b11ca2-6b91-52b3-bc75-d44abb202cfb@huawei.com>
 <CAFLxGvyYFEiEe108Hf_TO7q0ZsiLPswVsgPBQOU29aFqebD4XA@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ee6578cf-a4be-a4eb-30d9-379926e3ed1e@huawei.com>
Date:   Tue, 3 Mar 2020 14:13:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyYFEiEe108Hf_TO7q0ZsiLPswVsgPBQOU29aFqebD4XA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.98]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/3/3 5:14, Richard Weinberger 写道:
> On Mon, Mar 2, 2020 at 4:58 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> I mean, the uncorrectable ECC error is caused by hardware which may lead
>> to corrupted nodes detected in UBIFS. I found uncorretable ECC errors on
>> my NAND, in the environment of high temperature and humidity.
>>
>> At present, UBIFS ignores all EBADMSG errors, so the corrupted node is
>> only considered in being caused by unfinished writing. I think UBIFS
>> should consider the corrupted area caused by ECC errors in process
>> ubifs_recover_leb(). no_more_nodes() will skip a read-write unit. Maybe
>> the corrupted area is skipped.
> Well, if your NAND data is corrupted by your environment UBIFS cannot
> do much. Sure, we can paper over some places but at the end of the day
> you will always lose.
>
> What if the UBI VID header becomes unreadable or the root node of the
> index tree?
>
Agree, thanks for reminding.


