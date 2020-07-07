Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B43C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3548620720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bou7iSLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGGSX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgGGSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:23:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D81C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:23:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so100919wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZsyQ8jMmYQ+//eOLMX7VRN1oDXj4f3bVCThH0/4XXdI=;
        b=bou7iSLdxedN67z05Kvhn0bs7V/62M4RXxRpMjNmYppJ6OiFUT3bFt+dlqI9wxOoFd
         ziojgyBhqT6sjphLhpJOXanj/zqXQY0Nmw+RmdXwtetXmbWNgFKsPf2+2lCda8LhjDlH
         vweKLhivpqVwBDGPKb+MLxvg+0fGKKu3X3RGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZsyQ8jMmYQ+//eOLMX7VRN1oDXj4f3bVCThH0/4XXdI=;
        b=Mtdr7RFlR2uVQeah0DhMEtFEA8lCTAih9TUUARX5O6X5JhcOO16BdCXZO3EHwKSijG
         5oWSG36neqyC502nw+qSaP4wwOs+5/8FvLNqqE2p5qCg0BqB/MsREAaBFaD7prvaxZm6
         jDkY5NSRZ3MwThpSVbYL28BCqdLqbAsWTir+p0e6F8EIaC3BBJr7iims0nbzGJfYhbZG
         z88eX1oUxFcv3aNy9LN/13hnA8FrBCpTT/zTAE1JloYTw6U0OCLGD759CNCrgpq8E4ND
         geBLu+Iwo1ZXWhw0o8uPkAjNv3spAf0Og46VPKmeB56KgGkeveNeU2rDcbH2iSbg/0oy
         QqRw==
X-Gm-Message-State: AOAM533H1FSYaNPqUKohx1HBn5M5YhJ52XHudvVwmcO5ms56qOrGcwVA
        iZ6NsEzCHtmOU1qtdp0t+L/ABQ==
X-Google-Smtp-Source: ABdhPJyjT0eHd4DtTyp0akzx5TjoI2cPq4orG1mC4OS1LTjXrelYXyIhn6aUWELC3RkHTK1QvI9Tpg==
X-Received: by 2002:a1c:9e06:: with SMTP id h6mr5160615wme.45.1594146204616;
        Tue, 07 Jul 2020 11:23:24 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id p17sm1849785wma.47.2020.07.07.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:23:24 -0700 (PDT)
Date:   Tue, 7 Jul 2020 18:23:22 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] media: exynos4-is: Properly set JPEG options when
 not using CSIS
Message-ID: <20200707182322.GF2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB06606F63C7ACE765B57331A1A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06606F63C7ACE765B57331A1A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 25, 2020 at 07:26:45PM -0700, Jonathan Bakker wrote:
> Commit ee7160e57c98 ("[media] s5p-fimc: Add support for JPEG capture")
> added support for JPEG capture, but missed setting a register when the
> CSIS device wasn't in use.

nit: Since this isn't really about using the CSIS device or not, but
rather about the interface that the sensor is connected with, could we
instead say "when a parallel interface is used"?

> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/fimc-reg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/exynos4-is/fimc-reg.c b/drivers/media/platform/exynos4-is/fimc-reg.c
> index 5ce2bdebd424..269a98fca1e8 100644
> --- a/drivers/media/platform/exynos4-is/fimc-reg.c
> +++ b/drivers/media/platform/exynos4-is/fimc-reg.c
> @@ -606,6 +606,11 @@ int fimc_hw_set_camera_source(struct fimc_dev *fimc,
>  	switch (source->fimc_bus_type) {
>  	case FIMC_BUS_TYPE_ITU_601:
>  	case FIMC_BUS_TYPE_ITU_656:
> +		if (fimc_fmt_is_user_defined(f->fmt->color)) {
> +			cfg |= FIMC_REG_CISRCFMT_ITU601_8BIT;
> +			break;
> +		}
> +
>  		for (i = 0; i < ARRAY_SIZE(pix_desc); i++) {
>  			if (vc->ci_fmt.code == pix_desc[i].pixelcode) {
>  				cfg = pix_desc[i].cisrcfmt;
> @@ -707,6 +712,8 @@ int fimc_hw_set_camera_type(struct fimc_dev *fimc,
>  	case FIMC_BUS_TYPE_ITU_601...FIMC_BUS_TYPE_ITU_656:
>  		if (source->mux_id == 0) /* ITU-A, ITU-B: 0, 1 */
>  			cfg |= FIMC_REG_CIGCTRL_SELCAM_ITU_A;
> +		if (vid_cap->ci_fmt.code == MEDIA_BUS_FMT_JPEG_1X8)
> +			cfg |= FIMC_REG_CIGCTRL_CAM_JPEG;

Should we also handle MEDIA_BUS_FMT_S5C_UYVY_JPEG_1X8 as in the CSI
case? The S5C73M3 sensor supports the parallel interface as well.

Best regards,
Tomasz
