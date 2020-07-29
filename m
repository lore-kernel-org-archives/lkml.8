Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FAC207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="orYEuU8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgG2PCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:02:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:02:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so21908987wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGOW+4ED6By0KB5WrYSp9CvcqoKzYJSfhBgGcHuafBg=;
        b=orYEuU8o/GDPhYnOGzfx57QASwqpEIZoDm/xxfftrzRdtI0uqeCC4iHYKn7NFYTV4f
         KeJmDJjL+Rc2grMpL+jqLp4JEoXEcUBt/yYr+8KjrB/As0pJRdj9NkxcpJCh1QgA21/r
         0CzGdw+Uf5iqy8NIQapkdVjptLD8AWiaVxdc9F17evrdOWcSRSrnf7Lb1byyXwV2op26
         ecAwye9TLPD7MWudrrHQvAkNOCM7AJWXZ+r12RUpT0slzlQqHjJkOeYZnefZQX4kv/5c
         lLQWxOHM//odrJUMYt/FIBv1r6qGijXMx23gd1nSetLSZOZbrfPi8Rkk67b+lqzB5NV1
         7cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGOW+4ED6By0KB5WrYSp9CvcqoKzYJSfhBgGcHuafBg=;
        b=OaiGGhrAqNXJRwrFzxKhid+cEYlGLJCqSloYPpdQ/YpZr0dMZ0ZOuIN5vw5WLvoMmJ
         hrDEh65MrXtgZJGpEUYi1KavSd3q/oSXPc/RVNafx/N0iQJ9xJGzUM8zCygo6AEXSjQQ
         bmkpQJnxH28PMv0XSrSS8e0CkadoPDmLmDqhFMdwXj6s6I+TcFjzqJWi+SKZeTSDRvHM
         oN3uJ9aMSpdDalqbegRp68ld89dzTXoqPUIT6M2mB66mKwnbhgT/iRQVKiIvbuv/huNa
         MyH/0ET0ioi9cbhWspHXKW+4Ky7XvVH8IUJXBL/gOMre+txhFRjBfeo5cQTpCwPbQNns
         cJxg==
X-Gm-Message-State: AOAM533I2hGVk1nISiXK++J664RuV7jk7+ADdz2wBRv+M0jwdbFobamE
        gpKs0k9SjrNOCqoRmtbob081vLzxTJ6ZUV6mJ1QP6Q==
X-Google-Smtp-Source: ABdhPJwAhGfe4OeCtpo2EckPieAyN/CBzAB0X9eafg6qiHj37yAK2qTcWVp20qGk1/k6Ulm7rTvD+Z1zdSQwb2lqJ9k=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr24624163wrs.273.1596034942775;
 Wed, 29 Jul 2020 08:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <8af06b31c58ec9745ce13c2aca4e532d6ca340e0.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <8af06b31c58ec9745ce13c2aca4e532d6ca340e0.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 29 Jul 2020 16:02:06 +0100
Message-ID: <CAPY8ntBpGsak=s8tOmmDA-2kE5mp6+TrqyK3930Ypm7Q9gcUJw@mail.gmail.com>
Subject: Re: [PATCH v4 13/78] drm/vc4: kms: Convert to for_each_new_crtc_state
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

On Wed, 8 Jul 2020 at 18:42, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The vc4 atomic commit loop has an handrolled loop that is basically
> identical to for_each_new_crtc_state, let's convert it to that helper.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_kms.c |  9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 210cc2408087..717673b18132 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -152,14 +152,13 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
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
> -                       continue;
> +       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
> +               struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);

for_each_new_crtc_in_state doesn't check !state->crtcs[i].commit as
the hand rolled loop did. Sorry, this is my lack of knowledge, but
does that actually make any real difference?

I see nothing wrong in calling vc4_hvs_mask_underrun multiple times
anyway, so it's most likely going to be harmless anyway, but wanted to
query it.

  Dave

>
> -               vc4_crtc = to_vc4_crtc(state->crtcs[i].ptr);
>                 vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
>         }
>
> --
> git-series 0.9.1
