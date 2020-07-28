Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060CD206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="GsITKGrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgG1NVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgG1NVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:21:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC91C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:21:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so15313175wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n7DC2RwRJQwcE3VDCvW7mDTNfAGJnE5gpDIWkLHcHw=;
        b=GsITKGrgFlyLR97hy7qSX3O8Co7FNy9dMUDvmOGSRjPorVty+c45ZRw/XZ0eEDe8C0
         vWU6JQ7z1Tiym2j3xkg2UynLMNgXv79lJgFwCTrnS6Xy7cA4kXAc3VyBxKOtHioes8m2
         guw5IbXE5e1Wk/+Wor+TvQQpX6RMldYQ02Xv2Z3emyBRMvhwl1n+id0xBKBk2cW4QLlr
         BXXI5OsUgnByTZVxDqxmsZ4+qyZ1OTwX2pzEGBrNiFsZBYEe0AQZJGIp08xws/xeKqON
         pM9sUrXZPm1LmOqaNMEdfyeTz7ghhFpO3Ylzow4BQPRwD8vE9QGYgsGUrca5dBYrpPVT
         LByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n7DC2RwRJQwcE3VDCvW7mDTNfAGJnE5gpDIWkLHcHw=;
        b=SXSIwl937jJJpuvbzJMra6o5khN64QlrVGsdiVN0fI5naXjmC8gQxuXQfWHqHDP5Vl
         d7uuMIYQQ0FW6K1H+3cJ553iAtSplpyQsyAYKdgDQycucvwe9whe+jvs2L8ewDHek8Yv
         uUUROckIdc8WWDoeDnxedmMsMwSz8vCVaYo0sRlBZPj4MmjbuWFNHPZSVAaY171v47Go
         9pGsDasU1LA00SznT48BYFlywFlj0qzbFRJkt9x6ZpAvKjAY7W5ugambTtsNxVgrj4Rg
         MIXvyj2iYqRHBM6eMk6zjdpEVBPtNF5KlaQR+tDB/5dHsP1PXyNJFow8nS6YsDEZ5wiq
         UUTg==
X-Gm-Message-State: AOAM5317rG/AjdT4sqW2rv6FYj8pONfjG0tUkCSfDBplUZGaWEss0cmf
        RmqoOgD2C2rerjVmKDA+tCxPEe1PMi81TOSd6KAaYw==
X-Google-Smtp-Source: ABdhPJyyFkEDXEXxLhznZOoaqtO4ee8p0QDWx6NpzQMmslsbVMu07smR/TO0PQQl4GG+0CnCPXsjcsJapJLgfuC53/g=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr19660461wrs.273.1595942468291;
 Tue, 28 Jul 2020 06:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <9085677c3adf4a84c5ba5f8cdf4f3aff34e3e5a3.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <9085677c3adf4a84c5ba5f8cdf4f3aff34e3e5a3.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:20:50 +0100
Message-ID: <CAPY8ntAmDtbofNQ-V-UjWjGupN=MG03tOzVG9F1=hG5T4HTsJg@mail.gmail.com>
Subject: Re: [PATCH v4 57/78] drm/vc4: hdmi: Deal with multiple debugfs files
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The HDMI driver was registering a single debugfs file so far with the name
> hdmi_regs.
>
> Obviously, this is not going to work anymore when will have multiple HDMI
> controllers since we will end up trying to register two files with the same
> name.
>
> Let's use the variant to avoid that name conflict.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++++-
>  drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c50241170d7e..ef51eedaf75a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1370,7 +1370,9 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         if (ret)
>                 goto err_destroy_encoder;
>
> -       vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, vc4_hdmi);
> +       vc4_debugfs_add_file(drm, variant->debugfs_name,
> +                            vc4_hdmi_debugfs_regs,
> +                            vc4_hdmi);
>
>         return 0;
>
> @@ -1448,6 +1450,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
>
>  static const struct vc4_hdmi_variant bcm2835_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
> +       .debugfs_name           = "hdmi_regs",
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 0d529db4b3ab..794216f3228d 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
>         /* Encoder Type for that controller */
>         enum vc4_encoder_type encoder_type;
>
> +       /* Filename to expose the registers in debugfs */
> +       const char *debugfs_name;
> +
>         /* List of the registers available on that variant */
>         const struct vc4_hdmi_register *registers;
>
> --
> git-series 0.9.1
