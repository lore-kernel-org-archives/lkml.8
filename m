Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B6C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2426E22204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgIKQiA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIKPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:12:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F033C061350
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:26:44 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kGk0a-0003r9-8y; Fri, 11 Sep 2020 16:26:36 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kGk0Y-0003Gl-Ik; Fri, 11 Sep 2020 16:26:34 +0200
Message-ID: <dae4ab91ec20e72963f2658efca4874a35dd739e.camel@pengutronix.de>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Crystal Guo <crystal.guo@mediatek.com>, Suman Anna <s-anna@ti.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>
Date:   Fri, 11 Sep 2020 16:26:34 +0200
In-Reply-To: <1599804422.14806.27.camel@mhfsdcap03>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-4-crystal.guo@mediatek.com>
         <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
         <1599620279.14806.18.camel@mhfsdcap03>
         <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
         <1599792140.14806.22.camel@mhfsdcap03>
         <9d72aaef-49fe-ebb6-215d-05ad3ab27af4@ti.com>
         <1599804422.14806.27.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crystal,

On Fri, 2020-09-11 at 14:07 +0800, Crystal Guo wrote:
[...]
> Should I add the SoC-specific data as follows?
> This may also modify the ti original code, is it OK?
> 
> +       data->reset_data = of_device_get_match_data(&pdev->dev);
> +
> +       list = of_get_property(np, data->reset_data->reset_bits, &size);
> 
> +static const struct common_reset_data ti_reset_data = {
> +       .reset_op_available = false,
> +       .reset_bits = "ti, reset-bits",
                            ^
That space doesn't belong there.

> +};
> +
> +static const struct common_reset_data mediatek_reset_data = {
> +       .reset_op_available = true,
> +       .reset_bits = "mediatek, reset-bits",
> +};

I understand Robs comments as meaning "ti,reset-bits" should have been
called "reset-bits" in the first place, and you shouldn't repeat adding
the vendor prefix, as that is implied by the compatible. So this should
probably be just "reset-bits".

Otherwise this looks like it should work.

regards
Philipp
