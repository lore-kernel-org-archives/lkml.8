Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2932206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="df7cZt6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgG1LmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgG1LmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:42:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCFEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:42:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so17875914wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TT24vZnC4xOCdUpOmIAerDESvJeTmO8+8fod85enhmw=;
        b=df7cZt6I8hQuIl1XU7ttHu4TN5PR1P69UXn6jcfq0mJeliTervs8ge8M8D2wbyi4+u
         f3u21AIP4rNKufXo9ROZqH8Lj8kVdEnlNLO8ve9kHB6JBq1uwujo0fUL4um3GqE/sYUQ
         8NvDtgJwDEbbFZcceKLKEQA2bGi3QvT2WZYzU0t+Tzj4hFnYG5NFCt+w4hi8zqMccP5D
         CQln4XVfU+gkL44eP7GRwnvZmGGhz/E2HJTucxx4+1Y7sE0U9C8HJ/9KJV7DeRNQz10m
         XBb0/rgDKA+nA7fNo4M7DnBaWbBEooj+JLGxEuLc6cEyTFwvp89apJctgBuPRR85vBdP
         VcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT24vZnC4xOCdUpOmIAerDESvJeTmO8+8fod85enhmw=;
        b=Kf7V3rNN+dxFZs6vLmtAvKYZQFA59hUofYiWDerHAlgGVxvbtJRtZM7FJhv5AOBlCl
         YDwGIoz0puWvo4xJo53lN9J3VFDXBKjMJ9XpKFk60MdicoZTloyq5nJXSS9UQeQXE5oM
         tGkUIhXuhrCG4w5cxBlAxNv6tPTb8WfPxE5MiuVhGuQFgY4SFRZPwjXBMkiaLGPqVxyr
         D9Qkb/vuK/95WMpxJH++qmhnlXezo/a4inORbt3QLNd1vi5a/BYRuESzkkomfP/yYqk/
         1U5fHJGTOEKl3dHTTCBI5vKLJI3VDnkp921a/cP7B+fh25Nebi4Z0QLYKnCvkUD/oNAj
         IO5A==
X-Gm-Message-State: AOAM533icX136z7gQl+/xhYF5O3Jk7Y5w1mRnWILQXQp/OVpvGoa2wMi
        tUE/oyOfzZtLQO09LhDz6ad0qAdoJqZnvbN7aySc3g==
X-Google-Smtp-Source: ABdhPJz8AUHazoZwcaZZ9jNUzaMz3ho5hqMfyeOSaPMimnzYiaStb9+h5tEC/aggQScQWwU+fwuhtNmhcjK0dfIEvn0=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr1167435wmd.82.1595936535673;
 Tue, 28 Jul 2020 04:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <596dac201108233446694a1014726c51843172c5.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <596dac201108233446694a1014726c51843172c5.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 12:41:56 +0100
Message-ID: <CAPY8ntDK76+3PR8kbi8gzb8n4zryDhZvhwKyGsdPb_J3Uf-ASQ@mail.gmail.com>
Subject: Re: [PATCH v4 31/78] drm/vc4: crtc: Clear the PixelValve FIFO during configuration
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
> Even though it's not really clear why we need to flush the PV FIFO during
> the configuration even though we started by flushing it, experience shows
> that without it we get a stale pixel stuck in the FIFO between the HVS and
> the PV.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 13fe0e370fb3..25a77cd46b28 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -358,7 +358,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>         if (is_dsi)
>                 CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
>
> -       CRTC_WRITE(PV_CONTROL,
> +       CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
>                    vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
>                    VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
>                    VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
> --
> git-series 0.9.1
