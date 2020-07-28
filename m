Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3A4C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0576920829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="XQQ7EDR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgG1Kj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgG1Kj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:39:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:39:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so17777577wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fu6+ncNlNVIIhV52Pfsl1d0V+5R59UwNZjOPfJC9HM=;
        b=XQQ7EDR7HuZMZJD3WjJJq7nWRd8Z2P7j9S9A0T2jqccFCWRLfpLO9Jz8Hy5yWwQaG8
         tjE9TaD2veaP8JDdULyGLtJa65N/TH5JH+v2UHtNzpk6ZvuzWfi85HwCnoFbr8LTTWdp
         tf2cwFRT/pNC2r0cw85SJAeOEhgir+QswQ9ZJO7dWOiwlzzY9IHOwSe1ANodg8laYiGM
         hCoF8UY+ZieRs6JRtRLKoHMgbYfQTXgpub+Yf2tjFMD7fV9CLAI9qdRfJLCa8b6ELNxK
         PgqJRuCC2svrJQ6VNuCS9o7I73NPLNOVV66k5Zmc4KkESD8Q0VT/AkuwJTXqr6GlMxm2
         5UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fu6+ncNlNVIIhV52Pfsl1d0V+5R59UwNZjOPfJC9HM=;
        b=KZw05sdYzCw/AHzNVwWULd3IYXs9slntr8m0hJ+oURh0ZNOsUqy/0mY6I5pfKvrhxQ
         sNQA/tcsBRl8vgLDKAjVp0ZqiVv2aiummPrVDR7AqiLV170GRldLrKmQ5QhKr5id0+0T
         4I6aSCEndnHBzWr3qTlDb9kJV0QI3wLGHnaIrD9pYreGuber1xMEr+ilBIzKQNkyvTAK
         Ty6yHUgye2L+a9oYVJfK/9ZuiASALIWfaa92G/VowJ9c4xNPfgiA8FA4Gai5mBR/38MN
         NugOY0V652yCIc3Jye6vt+4yRgEYAoCJO9KYuFIdXUYVEJHSWQTXxv5qA7u57FqfEfhW
         niJg==
X-Gm-Message-State: AOAM533Ken8DqT5lgaM+hVY0uuTqOECTJydrhwR559tJJO2BFA01PGjM
        jLbxVSHLRph4LL9GOzexTvq7Xvn8aMQo1VISSA6Ctw==
X-Google-Smtp-Source: ABdhPJxqveEDF4fD91lIqGjwCXyF+JMIVkyBTc5jthXBrwneUZa2nBo6cUOArXkF5aA9PkKZHsCP0GVYEkw63kCXusk=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr6982944wrs.27.1595932797360;
 Tue, 28 Jul 2020 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <35c955e88914f4d22f5bfba5b060489850b764ba.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <35c955e88914f4d22f5bfba5b060489850b764ba.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:39:39 +0100
Message-ID: <CAPY8ntCgtnSbiaDuY=k+-VXgYb2-A2DeHVN1j=BUw_349MYWbQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/78] drm/vc4: crtc: Remove redundant pixelvalve reset
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
> Since we moved the pixelvalve configuration to atomic_enable, we're now
> first calling the function that resets the pixelvalve and then the one that
> configures it.
>
> However, the first thing the latter is doing is calling the reset function,
> meaning that we reset twice our pixelvalve. Let's remove the first call.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 2eda2e6429ec..2c5ff45dc315 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -427,7 +427,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         require_hvs_enabled(dev);
>
> -       vc4_crtc_pixelvalve_reset(crtc);
>         vc4_crtc_config_pv(crtc);
>
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
> --
> git-series 0.9.1
