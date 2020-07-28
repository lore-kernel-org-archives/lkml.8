Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE718C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF120206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="IkEQ1WD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgG1NZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgG1NZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:25:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:25:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so18281703wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnkqZuh++8Nyz7qDB61TIgg/e9h5HC3HmU88l0fPREc=;
        b=IkEQ1WD+oaOYJMt5V3vCBqnKqZKVOHp8IcfCmTzu+QgfrApn64nxDuQpGAigx7KDcM
         LLcdPwmr1jSXVhKAatNz03GzLs/6Vlh39NC/O6LMa3vzgjAobOFGkZUu6uHjRP7JWYCo
         MCkZ0nbEhKkbR82cTawPX+gM0Pk10AhqCeaKm/m/KXCgWpZh2h2Kej6t/7FaDi+Cm8q/
         lPZwDiS7RXO/UymIExdM6ThIecB8y8005n0nmGVDr9uXishRVOb3iTtgJ2AD/nyJL9hy
         XhKOeGQ71pP32Y5y8Q5rEIQdYxSfzCReD1hBJj+xRGf+EPGkpsaDW52Pnq0Lbfr1sNzl
         lOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnkqZuh++8Nyz7qDB61TIgg/e9h5HC3HmU88l0fPREc=;
        b=kkWxNOjrwtaoV5q0S9yR/HBvbcOe0/UZt5f6HH2pnTtnlOQ/HN9GuxL+Hxcp3c3MT8
         1CTNhfVbQ+Wl16HzebK5HX0O9LhxZ6M5fKN2ZFehEvaHRlMPVWcAgz/OtrD2uAnP5WYF
         AfLnP6y3Uzbd3n3RGt8mtA0kwFKr/jeemECQ5Luh2QCkVNuVVVs21vbVbbPNG0bX9NqH
         smccxcbJm061SmFGfSBdSK0+k8Je9AHl2I5NfpjaAkJH7oX3w52vnxpE2ufaF9ykL3ss
         fO/O1dR1yLzUvlTK3RCjWMKhjP+28vi1j/8LwfDYabyf4L0EOEWAQF1KYcjdbOrV0RmO
         QZcw==
X-Gm-Message-State: AOAM533Z1ILv9jd63qlEtRgBCdXtRgi/drGjxNqjmnb8Zp2FUs67fadE
        NtGQPeDIHKCh7W23qnS5LSjqqIxD4Gc0GB7qAc+rUQ==
X-Google-Smtp-Source: ABdhPJzKZMW4yeHYoMhjbyXIdKK5EP7J/ukIUn/pmswXVcXcrqcKNtmYRDkd8iXjV/fJdX3O+1cYpgFt/HQXuTMKnNc=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr23866783wru.47.1595942718473;
 Tue, 28 Jul 2020 06:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <73684b1e4872a1113f6c3bb5404bc6b4a20f130d.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <73684b1e4872a1113f6c3bb5404bc6b4a20f130d.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:25:02 +0100
Message-ID: <CAPY8ntAtRJYRi6mG19zQEWLjbnVKaQKvTZcP8EB+-csOeSz6rg@mail.gmail.com>
Subject: Re: [PATCH v4 59/78] drm/vc4: hdmi: Add CEC support flag
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
> Similarly to the audio support, CEC support is not there yet for the
> BCM2711, so let's skip entirely the CEC initialization through a variant
> flag.

CEC is sorted now, but it's easier & cleaner to keep this patch and
add a new patchset that enables CEC at a later date.

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++++
>  drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 8cd08b541c14..86e21de6c578 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1179,6 +1179,9 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
>         u32 value;
>         int ret;
>
> +       if (!vc4_hdmi->variant->cec_available)
> +               return 0;
> +
>         vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
>                                                   vc4_hdmi, "vc4",
>                                                   CEC_CAP_DEFAULTS |
> @@ -1477,6 +1480,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
>  static const struct vc4_hdmi_variant bcm2835_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi_regs",
> +       .cec_available          = true,
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 794216f3228d..3f07aebe89f1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -33,6 +33,9 @@ struct vc4_hdmi_variant {
>         /* Filename to expose the registers in debugfs */
>         const char *debugfs_name;
>
> +       /* Set to true when the CEC support is available */
> +       bool cec_available;
> +
>         /* List of the registers available on that variant */
>         const struct vc4_hdmi_register *registers;
>
> --
> git-series 0.9.1
