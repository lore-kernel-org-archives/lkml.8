Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2662A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHZBE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:04:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgHZBE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:04:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 591FAC58BF69EA375866;
        Wed, 26 Aug 2020 09:04:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 09:04:07 +0800
Subject: Re: [PATCH] drm/sun4i: add missing put_device() call in
 sun8i_r40_tcon_tv_set_mux()
To:     Maxime Ripard <maxime@cerno.tech>
CC:     <wens@csie.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jernej.skrabec@siol.net>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200825114403.1392369-1-yukuai3@huawei.com>
 <20200825133851.scnipngfpm6jyje5@gilmour.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <3eec5382-0aed-ee9a-1ac4-5a56bdeeef09@huawei.com>
Date:   Wed, 26 Aug 2020 09:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200825133851.scnipngfpm6jyje5@gilmour.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/25 21:38, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Aug 25, 2020 at 07:44:03PM +0800, Yu Kuai wrote:
>> If sun8i_r40_tcon_tv_set_mux() succeed, at_dma_xlate() doesn't have a
>> corresponding put_device(). Thus add put_device() to fix the exception
>> handling for this function implementation.
>>
>> Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> That doesn't sound right, we're not using at_dma_xlate at all in that
> driver?
> 

Hi!

sry about that, should be sun8i_r40_tcon_tv_set_mux(), same as the
title said.

Best regards,
Yu Kuai

