Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A102E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="BIlUz2QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgG1Lkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgG1Lkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:40:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:40:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so14404553wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TarT8FJy4xxh1Gu95tM1MOrQBSTLu+L0cNKerMl6tuM=;
        b=BIlUz2QYxFWzzF/PGXouifAVShEdvViFuBcAvy11rSq1/UB3TPjN7cDoyPiYLXMGbE
         wMbfEszWmq6MQz43NGegaGCTgKkNGFFlEd8U7O868CP4tprwvtl5q9N3//jweqWAoxxc
         ViHZhLSVULlg1K/JYXV3GQJnuOpvZ5ihctOpovBbCRV+fC2WP5VRqheKMrgizTs8AaEm
         TKpDzIjehfn+zwRq/MR79ctzf0Bpb6beoozBqRgNhS1l1GCds1QqS4WVVolNx+gvcyUk
         p5KoK5+g+A4xIfsgxbPDcFl5QtWVgix3eV/Y5LTJ9A/Od5o+TRrdAyC2L/e9YgXNazw7
         XlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TarT8FJy4xxh1Gu95tM1MOrQBSTLu+L0cNKerMl6tuM=;
        b=KB3mJ25yVOQjBkLr1pH01KlwiWrKA2U+vwixMWefjgUuJkjr6ssaXgs6g2BW7T5H6D
         57wHwjdMcbJ03timEvGt0yvQ+rdSrcaAxnOZRCvjgRSlMReYSFzu7HN/Mltu/xMfKqdS
         KcgVDcVMpqXn3cMgyG57+obd4Mo71z0uqjbKJ9Xqt0GJ8MTIE84Ozs7S1KAb6XWg1bpj
         y9GepMl/1aE4jAMNlLnq5xf2nbuscvEUMhujjEhzZOCAcHdUk58rIN4kVMeL7MY/BKPM
         MMVG5uvgYwhQhfTg+TllifPrYFq5OFE54SLij6/auzv5RnZl/ZuyytozgfbDv+I4Ufps
         9P1g==
X-Gm-Message-State: AOAM531PcDN3InuiyIFncYF45XarmSS3g2EjcIfYho7O7c6Ks5Z6OURv
        TvEtBDF679oOz1JMalNIoSfJqgNmD3s5NU1W7bjeyA==
X-Google-Smtp-Source: ABdhPJyAsLE0Fke7ELR7oeZm8VYO8/GGUEGfQKuUxFj/9hE+upxSUPAEcs2CfEI7Hs0Jh3gu2ANZ6pBVtbr+FcTlaC4=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr23497356wru.47.1595936441188;
 Tue, 28 Jul 2020 04:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <dd3c4cdda7252e9d40bdbef236d9aaa93af512c5.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <dd3c4cdda7252e9d40bdbef236d9aaa93af512c5.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 12:40:23 +0100
Message-ID: <CAPY8ntARSJHkUvkTs19jk2JFf9qpxuGMaSRCtmO-dcphvDeu=A@mail.gmail.com>
Subject: Re: [PATCH v4 30/78] drm/vc4: crtc: Clear the PixelValve FIFO on disable
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
> In order to avoid a stale pixel getting stuck on mode change or a disable
> / enable cycle, we need to make sure to flush the PV FIFO on disable.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 7b178d67187f..13fe0e370fb3 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -408,8 +408,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>         if (vc4_encoder->post_crtc_disable)
>                 vc4_encoder->post_crtc_disable(encoder);
>
> -       CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
> -
> +       vc4_crtc_pixelvalve_reset(crtc);
>         vc4_hvs_atomic_disable(crtc, old_state);
>
>         if (vc4_encoder->post_crtc_powerdown)
> --
> git-series 0.9.1
