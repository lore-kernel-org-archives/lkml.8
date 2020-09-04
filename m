Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF010C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B132074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fU31qie4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIDPnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIDPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:42:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A8C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:42:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so6512012wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFt5VYp91zERLEDHeaE+RW9pXHUGaLWnGfwWTh4Sc2U=;
        b=fU31qie4kt2TV9lPfFAfIIE0WAv8mDvUqhU1LLlYfB8UsatCipj8RgKEIFsNAc6ocA
         xG5uup6s1fR/dqAgzERNBs1S+XEZ6SNWmkahGKmG0CN08m2kz4XzOMvv6F0SDvBIT2qC
         wwZZDieY4lzyH3DTqG+DOaZgYgqgdTegIxpjpRBWVbTACjeTaAxRe1XDf4prKT4CyiPR
         S4C6gpk6BSh+GiEs63wlu6eyxtO0I2XXbLJNQXeR0jNlfDzTSir6ah3Adnxf3Z9sMrKC
         RZxxyTWdhtr1be/4hfo8j9Q1RBviQ3jtYMRbW5VWDj+IVf1QVbLFY+ZDb6MlmseawrnF
         r3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFt5VYp91zERLEDHeaE+RW9pXHUGaLWnGfwWTh4Sc2U=;
        b=dpNkOYIqKRETs4hxRlyAIL90RwIz8KgDFJR/CBGk6ETP4OL9dgieA/guJ8zGdQS8Ra
         yuKPV7Hk3Pm9rWwTNauUMcQOejS9gME4E6WKiZ6jfX8iv8Dg9SbKC5VwxCvBeFtN3Gvj
         iVSem5PrDcn10Ms15BlLuoVr2erdLemmBKlXbMROW0x0T88TNxhdG73mWnNuUBVXCJxh
         q4wa5MR0/RhgiQn6VpOTZwVDpC8Z402BQugvF0sqzDXsoqn8igLEDo99DfHgMDx3vB79
         7tQmZ87mOpZ1LMZcGBK9ywfFHbaoiWybGQF7CVshX4conJS+Q/ZVsf0/Qbd1g7E+OK5e
         0QGQ==
X-Gm-Message-State: AOAM533sAiYOfvS8McoAC6dVjN+Le0bd9TkThIkBhXB4onlDoaU/sKgl
        f++eBArW9Oumy2unfMYlJxcEHvcd2jIvwr+7FVTv6g==
X-Google-Smtp-Source: ABdhPJxLkBJqCTGf+urDE22psZ9kQBs7jd5tDjfYTwq0eIZiLv8gjpbdFkfhT1WGAohsQRYRqyhPHhMeA9xiVx5bOPw=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr8761629wmd.82.1599234169816;
 Fri, 04 Sep 2020 08:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <a712d2b70aaee20379cfc52c2141aa2f6e2a9d5b.1599120059.git-series.maxime@cerno.tech>
In-Reply-To: <a712d2b70aaee20379cfc52c2141aa2f6e2a9d5b.1599120059.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 4 Sep 2020 16:42:35 +0100
Message-ID: <CAPY8ntBuPWFU-xEoLwR=C1ccbA5CoxcQ1Gx_zvWf+VQzRg=E1g@mail.gmail.com>
Subject: Re: [PATCH v5 13/80] drm/vc4: kms: Convert to for_each_new_crtc_state
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 3 Sep 2020 at 09:02, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The vc4 atomic commit loop has an handrolled loop that is basically
> identical to for_each_new_crtc_state, let's convert it to that helper.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Based on your comment to the previous revision, I'm happy.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_kms.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 210cc2408087..a41d105d4e3c 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -152,14 +152,16 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
>         struct drm_device *dev = state->dev;
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
>         struct vc4_hvs *hvs = vc4->hvs;
> -       struct vc4_crtc *vc4_crtc;
> +       struct drm_crtc_state *new_crtc_state;
> +       struct drm_crtc *crtc;
>         int i;
>
> -       for (i = 0; i < dev->mode_config.num_crtc; i++) {
> -               if (!state->crtcs[i].ptr || !state->crtcs[i].commit)
> +       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
> +               struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> +
> +               if (!new_crtc_state->commit)
>                         continue;
>
> -               vc4_crtc = to_vc4_crtc(state->crtcs[i].ptr);
>                 vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
>         }
>
> --
> git-series 0.9.1
