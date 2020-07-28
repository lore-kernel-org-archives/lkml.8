Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C0FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310802070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NDCu7Qgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgG1WCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1WCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:02:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:02:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so16737556wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vqnKMLXqTkEdIlwdpguJGd/nIpB4YeuwS5l62z63FMw=;
        b=NDCu7QgcAq7+TW7f+5/b58wRYuFOxNU7md4Tk+HGctDkj+yK8BZE5ZExbD/h1lASPV
         hFurpdD9fO1Rj8h0Qbz33aWC27fLh7LVJNdqfbAJo6RTpRnc+FDhdre6+7FNB3lCsHjd
         cdLJ4W2jhZqC3T9bPV1wJPOW01YhcQvP8NgJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vqnKMLXqTkEdIlwdpguJGd/nIpB4YeuwS5l62z63FMw=;
        b=fziEShFsciBnKGAg0YRlY4uTeG4gt788p5FHa0TlzPXv1tg1FMdBab5Nnb5HUNQmRm
         pFjIAH5b6QzB9gqeidd/IFdl2st0FdQsJAAEB6OsxBDk50tCPydb/QZCeW9ieKgLMemP
         J4e2qqBSDd+ugZcdJaIWgJc9V6hRFxBm7eNUvN6XrE2ySql310CY0SkRWK4fp4rYCYxW
         Kk+tXgSbpMYA7uTZRYUSZB2FTqkDm2zsYtXQxWG4LQm5/gJ76Uexp/Ucha7zsw++kH1d
         6iOtRWPfykx3gK2RoLLurfQbaKv4BGE42d1xF/o74JiZiYoQC2de/DlkJC6rzg8/6xP2
         yDHg==
X-Gm-Message-State: AOAM531qqv2+S92bUrN3EHOP4+g/H8wzCiLcudijS9UAzAN3pe/m09ZM
        FEM5XEbFKusNdGx1m/AY7+6p6A==
X-Google-Smtp-Source: ABdhPJxRQsWjsGbojKh939WX9+AjyfoL6oRNBjWQkv5BgfV9n7qdpTPTlymdET8fHHeG8IvyVPgXZg==
X-Received: by 2002:adf:de09:: with SMTP id b9mr14191027wrm.409.1595973728531;
        Tue, 28 Jul 2020 15:02:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u1sm364997wrb.78.2020.07.28.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:02:07 -0700 (PDT)
Date:   Wed, 29 Jul 2020 00:02:05 +0200
From:   daniel@ffwll.ch
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] drm: xlnx: Fix typo in parameter description
Message-ID: <20200728220205.GJ6419@phenom.ffwll.local>
Mail-Followup-To: Wei Yongjun <weiyongjun1@huawei.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200725063429.172139-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725063429.172139-1-weiyongjun1@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyun Kwon,

Are you all sorted with drm-misc commit rights so you can push the 3
(maybe there's more) xlnx fixup patches to drm-misc-next-fixes?

Cheers, Daniel

On Sat, Jul 25, 2020 at 06:34:29AM +0000, Wei Yongjun wrote:
> Fix typo in parameter description.
> 
> Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 821f7a71e182..3d53638ab15e 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -44,7 +44,7 @@ MODULE_PARM_DESC(aux_timeout_ms, "DP aux timeout value in msec (default: 50)");
>   */
>  static uint zynqmp_dp_power_on_delay_ms = 4;
>  module_param_named(power_on_delay_ms, zynqmp_dp_power_on_delay_ms, uint, 0444);
> -MODULE_PARM_DESC(aux_timeout_ms, "DP power on delay in msec (default: 4)");
> +MODULE_PARM_DESC(power_on_delay_ms, "DP power on delay in msec (default: 4)");
>  
>  /* Link configuration registers */
>  #define ZYNQMP_DP_LINK_BW_SET				0x0
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
