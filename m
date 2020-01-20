Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39D9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4A2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgATLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:40:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgATLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:40:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 058866AFF2DBAE7FB670;
        Mon, 20 Jan 2020 19:40:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 19:40:38 +0800
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
References: <20200119122202.14502-1-yukuai3@huawei.com>
 <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
Date:   Mon, 20 Jan 2020 19:40:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/20 15:34, Uwe Kleine-König wrote:
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")

Thank you for your advise! I'll add 'Fixes' in a V2 patch.

> Did you check that dropping the locking is save? (I didn't)
> 
> I'd assume that no harm is introduced, but mentioning that in the commit
> log would be good.

I think dropping the lock is safe since there is nothing to be done
inside the lock. However, I didn't run a full test. By the way, I'll
mentioning it in a V2 patch.

Thanks!
Yu Kuai

