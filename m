Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA06C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C814A208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="QN1siCcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgE0SsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE0Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372D7C008638
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:41:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so30182510ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80e9RnD9Ss8eOafGm0SPCkZYoQv72dsa4vHL2CNUsTI=;
        b=QN1siCcUywmiFL5b2l7OO2oJrFZjy0oVoG39jF8U3zH1k9rEEmuBmleEe7rSCXVq9b
         QDK/ZQZSsIFtjtyqvUKUGZpDAKKGE4YXN8HrzpU0lJnDxfXUnAFWPaerCMwA/UkQaGq6
         NV6pwJVvRp8hgN5+JK1UdeoLeCp6e0a+/V5iE7yug/9UO4hqzlfLKMTtQBJjCHMPkpgM
         gSOMNRg8jwdPUo7jOdYjVE95+JviMtUNl2EJK784jiP4U2WAA6mUOgpjejHB3we1xTko
         lpHOf2J4ipaoutCd2b80OURfvWweVQlY47Ga3y1MboXT4o7ZqhvVwpWG0R0EOVn86EpA
         5Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80e9RnD9Ss8eOafGm0SPCkZYoQv72dsa4vHL2CNUsTI=;
        b=ns/m4BkiKYrnzGTrKtqnMUvDWQF/VYfyi47tMQLBWR+KPhw1skNaDrDKkjr3GRCZGJ
         o8IYTRDDo2EZVzihyx3U+yahpmTypgydVecUmiNSpfbBPtjs6PqPcq1sXVwX2ns7KSml
         nDsKBLHlvEW9sTO1cjOKarJV6FCRliMRhgw0eR3iYcWZR0Uy1VxVGep2JLvor0YXfAQF
         07oGbVMCVfHgHlNOudkw0vQX/GN1xIW2khUemgVk0DXypsllk2ewfNCfPYM4qwtV38yj
         8G8M8wjd4eGdSuwqpHaugMLlTM59CzNuA7XKsI7PSyhTir+vgUo3sWSEGnrQBPPFPvSC
         5PoQ==
X-Gm-Message-State: AOAM533TDJ66uzNySvH11JOQTImwvWc4oe6EaKVQIf02b7sQlCzA3f/o
        /2eyxbskulZoCnC+S94eMbF74M9aD5KFJO4yQTpGlQ==
X-Google-Smtp-Source: ABdhPJzW+yK0neVV5ZLXfHZuKdL2m3iIwiXaA8c97nSmT8Xer0u16SBA/+K8iU8H0iefWgDrIbwvO/Ns2eUMghYcqCI=
X-Received: by 2002:a2e:8186:: with SMTP id e6mr3868617ljg.252.1590604895724;
 Wed, 27 May 2020 11:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <020de18840a1075b2671736c6cc2e451030fad74.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <020de18840a1075b2671736c6cc2e451030fad74.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 11:41:24 -0700
Message-ID: <CADaigPXJ0BnMUp=XN6G92Tx=H9j55pmsBAujO2mcpiiTs-RHnQ@mail.gmail.com>
Subject: Re: [PATCH v3 070/105] drm/vc4: hdmi: rework connectors and encoders
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:51 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> the vc4_hdmi driver has some custom structures to hold the data it needs to
> associate with the drm_encoder and drm_connector structures.
>
> However, it allocates them separately from the vc4_hdmi structure which
> makes it more complicated than it needs to be.
>
> Move those structures to be contained by vc4_hdmi and update the code
> accordingly.


> @@ -1220,7 +1219,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         struct drm_device *drm = dev_get_drvdata(master);
>         struct vc4_dev *vc4 = drm->dev_private;
>         struct vc4_hdmi *hdmi;
> -       struct vc4_hdmi_encoder *vc4_hdmi_encoder;
> +       struct drm_encoder *encoder;
>         struct device_node *ddc_node;
>         u32 value;
>         int ret;
> @@ -1229,14 +1228,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         if (!hdmi)
>                 return -ENOMEM;
>
> -       vc4_hdmi_encoder = devm_kzalloc(dev, sizeof(*vc4_hdmi_encoder),
> -                                       GFP_KERNEL);
> -       if (!vc4_hdmi_encoder)
> -               return -ENOMEM;
> -       vc4_hdmi_encoder->base.type = VC4_ENCODER_TYPE_HDMI0;
> -       hdmi->encoder = &vc4_hdmi_encoder->base.base;
> -
>         hdmi->pdev = pdev;
> +       encoder = &hdmi->encoder.base.base;
> +       encoder->base.type = VC4_ENCODER_TYPE_HDMI0;

Wait, does this patch build?  setting struct drm_encoder->base.type =
VC4_* seems very wrong, when previously we were setting struct
vc4_hdmi_encoder->base.type (struct vc4_encoder->type).

Other than this, patch 68-78 r-b.
