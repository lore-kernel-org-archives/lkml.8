Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E1CC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 03:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E543820708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 03:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDKDpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 23:45:07 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:40692 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbgDKDpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 23:45:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1D1A1182CCCD0;
        Sat, 11 Apr 2020 03:45:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: talk45_669e7c599bf44
X-Filterd-Recvd-Size: 2138
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 03:45:05 +0000 (UTC)
Message-ID: <78e966cacffbab8c43be6a02aa3f5af2478917d0.camel@perches.com>
Subject: Re: [PATCH] drm/hisilicon: Code refactoring for hibmc_drv_vdac
From:   Joe Perches <joe@perches.com>
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
Date:   Fri, 10 Apr 2020 20:43:02 -0700
In-Reply-To: <1586573387-42003-1-git-send-email-tiantao6@hisilicon.com>
References: <1586573387-42003-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 10:49 +0800, Tian Tao wrote:
> code refactoring for hibmc_drv_vdac.c, no actual function changes.

Seems sensible.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
[]
> @@ -109,13 +83,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  	struct drm_connector *connector;
>  	int ret;
>  
> -	connector = hibmc_connector_init(priv);
> -	if (IS_ERR(connector)) {
> -		DRM_ERROR("failed to create connector: %ld\n",
> -			  PTR_ERR(connector));
> -		return PTR_ERR(connector);
> -	}
> -
>  	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>  	if (!encoder) {
>  		DRM_ERROR("failed to alloc memory when init encoder\n");

The alloc error messages could be removed.

> @@ -131,6 +98,21 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  	}
>  
>  	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
> +
> +	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
> +	if (!connector) {
> +		DRM_ERROR("failed to alloc memory when init connector\n");

and here.


