Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289FC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB3F20735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHUURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:17:38 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:45668 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgHUURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:17:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 339D61DE3;
        Fri, 21 Aug 2020 20:17:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hall57_5807ae72703c
X-Filterd-Recvd-Size: 3078
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 20:17:33 +0000 (UTC)
Message-ID: <d466e1163c73b144a0501b61f6221de8e9a67a48.camel@perches.com>
Subject: Re: [PATCH 10/49] staging: hikey9xx/gpu: add debug prints for this
 driver
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Rob Clark <robdclark@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Aug 2020 13:17:32 -0700
In-Reply-To: <71e74aa8ff84a2f0b879c46a63d5f51f6d808348.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
         <71e74aa8ff84a2f0b879c46a63d5f51f6d808348.1597833138.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 13:45 +0200, Mauro Carvalho Chehab wrote:
> From: Xiubin Zhang <zhangxiubin1@huawei.com>
> 
> Add some debug prints on adv7535 and kirin_drm_drv.

bikeshed:

> diff --git a/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c b/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
[]
> @@ -785,19 +786,25 @@ adv7511_detect(struct adv7511 *adv7511,
>  {
>  	enum drm_connector_status status;
>  	unsigned int val;
> +	unsigned int time = 0;

time is not a good name.  Maybe rename to loops

> @@ -820,7 +827,32 @@ adv7511_detect(struct adv7511 *adv7511,
>  	}
>  #endif
>  
> +	if (status == connector_status_disconnected) {
> +		do {
> +			ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
> +			if (ret < 0) {
> +				DRM_ERROR("regmap_read fail, ret = %d \n", ret);
> +				return connector_status_disconnected;
> +			}
> +
> +			if (val & ADV7511_STATUS_HPD) {
> +				DRM_INFO("connected : regmap_read val = 0x%x \n", val);
> +				status = connector_status_connected;
> +			} else {
> +				DRM_INFO("disconnected : regmap_read val = 0x%x \n", val);
> +				status = connector_status_disconnected;
> +			}
> +			time ++;
> +			mdelay(20);
> +		} while (status == connector_status_disconnected && time < 10);
> +	}
> +
> +	if (time >= 10)
> +		DRM_ERROR("Read connector status timout, time = %d \n", time);

No space necessary before ++

s/timout/timeout/

No space before the newline please in any of the DRM_ERROR
output messages.


