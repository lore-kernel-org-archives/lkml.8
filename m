Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7B9208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIHBF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:05:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgIHBF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 21:05:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B5548295C3B4781B870;
        Tue,  8 Sep 2020 09:05:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 09:05:15 +0800
Subject: Re: [PATCH] drm/mediatek: add missing put_device() call in
 mtk_ddp_comp_init()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <yt.shen@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        "DRI Development" <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20200905083058.1631726-1-yukuai3@huawei.com>
 <CAAOTY_-BQx0rozw0qoGj1bt4hO2rFmYvKrjQHbA-K04txUWW+w@mail.gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e10c0375-8ef3-a2ba-b23f-f80d082e1ba7@huawei.com>
Date:   Tue, 8 Sep 2020 09:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-BQx0rozw0qoGj1bt4hO2rFmYvKrjQHbA-K04txUWW+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/08 6:56, Chun-Kuang Hu wrote:
> Hi Yu Kuai:
> 
> Yu Kuai <yukuai3@huawei.com> 於 2020年9月5日 週六 下午4:31寫道：
>>
>> if of_find_device_by_node() succeed, mtk_ddp_comp_init() doesn't have
>> a corresponding put_device(). Thus add put_device() to fix the exception
>> handling for this function implementation.
>>
> 
> This patch looks good to me, but I find another thing related to this.
> mtk_ddp_comp_init() is called in a loop in mtk_drm_probe(), when this
> component init fail, I think we should uninitialize previous
> successive init component and put their device. Would you like to make
> this patch more complete?

Hi,

Of course, thank you for your review.

Best regards,
Yu Kuai

