Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF25FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84ED3206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="i5qek+mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgG1NTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgG1NTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:19:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D94C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:19:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so15305869wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWdZpdgjdgvXjLWPPue7If3nshivPXisw0K+933QvvQ=;
        b=i5qek+mODnmUnqV7JmR63SRMMOaIcB7jB7y59U0zxMQc7FUocN/SI7k4RvV2BxbEVu
         lPpJGp4TRbNauLdxSBJ791ROggTWFdev110Tweyvwex0UJmTlBJOJLoOslMU4TrZgJAn
         A+FIo2p2NK/vWCWAvK/mcQAqx/UwuPVPc2Ee5CNZTg9pd4nLluBcsb1ipySPEmYacC7y
         5Wx+aMXyuCAuZ7XR0y0Md1VISQFVSm1WfGt7QK80idI/6rt/WEGRgC9fg3Ei27jKBX6C
         mQ5J2HbeAp4F36kbhfyppx9ps/GzyPwvDfBaYFoCpxqNppwGgrTi7eyA701s1SvnFsZz
         f9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWdZpdgjdgvXjLWPPue7If3nshivPXisw0K+933QvvQ=;
        b=D9NSVJa+xO0eDMstqtGBR14cBirDacyB8f8dVpmWNz2aQihJ07ymbscIyI3dH/BfrL
         PqQXTkFp4NBX08wMzf1aQAx9xnbTOM7hf7YtaExTT4HxtM+6xhpXsSvZ5KFg7NGrSeSh
         5CyL1tygI2W2cthxvnqNV6d1J+sXNCr4D0uiR5cClU9VLOSemp6nawKyrglsEfN8O7Rb
         MZooTU8TM2i1UDpUI8MHfdwvKk/bL1siFprVrB+KZ991cMss8BdR1kV4ev8ZHhFU53xE
         JOEKgAI3p4rplVaf23l3KSmYgnSe6wf6Jc07Kxn3aJKa973FBTrei8RKORhU8YzKoESr
         JSSA==
X-Gm-Message-State: AOAM5327LlkU1xMrzLRVqnmcsGWOiWUtuOQnvxsLGKNk0DQGKEpKXvcR
        dJ+6GSVTfrIn8WneOvkRmbSJgNE0X8eeir61lAJ3sQ==
X-Google-Smtp-Source: ABdhPJxPPlAWGdiN54g5hjhBbtmVCRQfL2EWludJ6TPd30HoCJpLCxU85oDLeJ+AWNIH1EXZ2GCeJwZbFo5davhpXvw=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr7588899wrs.27.1595942342223;
 Tue, 28 Jul 2020 06:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <08b5c574e128bc7c42387867aee11978068c2aa5.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <08b5c574e128bc7c42387867aee11978068c2aa5.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:18:46 +0100
Message-ID: <CAPY8ntCb9j7QpK8aqSryOCbhKc3D6SW-xszOvh4oOCeA5071xA@mail.gmail.com>
Subject: Re: [PATCH v4 56/78] drm/vc4: hdmi: Store the encoder type in the
 variant structure
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
> The vc4 CRTC will use the encoder type to control its output clock
> muxing. However, this will be different from HDMI0 to HDMI1, so let's
> store our type in the variant structure so that we can support multiple
> controllers later on.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
>  drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a50220bfd5dd..c50241170d7e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1268,7 +1268,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>
>         dev_set_drvdata(dev, vc4_hdmi);
>         encoder = &vc4_hdmi->encoder.base.base;
> -       vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
> +       vc4_hdmi->encoder.base.type = variant->encoder_type;
>         vc4_hdmi->pdev = pdev;
>         vc4_hdmi->variant = variant;
>
> @@ -1447,6 +1447,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
>  }
>
>  static const struct vc4_hdmi_variant bcm2835_variant = {
> +       .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 0c32dc46d289..0d529db4b3ab 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -27,6 +27,9 @@ struct vc4_hdmi;
>  struct vc4_hdmi_register;
>
>  struct vc4_hdmi_variant {
> +       /* Encoder Type for that controller */
> +       enum vc4_encoder_type encoder_type;
> +
>         /* List of the registers available on that variant */
>         const struct vc4_hdmi_register *registers;
>
> --
> git-series 0.9.1
