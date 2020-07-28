Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE42C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA34720A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="i+nhUpib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgG1JvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgG1JvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:51:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:51:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so17658837wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Znk80EAJWe03G2pyNc40Xve7p+xFAYQ6xUkMqBZJbRw=;
        b=i+nhUpib92cG7Dt3A5EEey478owxGiRXhqyIfM1QuUGzZn8TiA+akEqhLAZ5Eqv4zc
         yyuP77VUnuRGZToDKL7OeD98rTbEXu3aXgJqMH3TgpTxnmzsdtl2yf2ZP2XHwLyYunFt
         vXjbinN4jflyJbhHH7x5J2skDMDYjbOZ0vKjRkQibcgO0wPORWOBjJbD5hNW+4d85ijz
         xJSZFIebamoyAvtnJ37gqqZP61bF0wGTplxSyLoHzhFCQGUdTBRrtrZgbBrlkVdr34wC
         06LY0T6GQaw2cru12tQ43EYL5MN1RkE/jg7eXP/DleD6otrMesDarNDKMLAKsSNrCnVF
         /N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Znk80EAJWe03G2pyNc40Xve7p+xFAYQ6xUkMqBZJbRw=;
        b=SvMJ88Z5/XVZIzmqYVWGaGOCC76ebDF3/gHKE4tiPFYHOBhCHuXGztyL+tidSW2ANJ
         ZAepZ4Osb00AWkj966WRXTvur6NzfEE4/i/HfI085W5AxBHt62V6qvtYb6zqjmuSicFm
         vde6K1dq0h3qUHjFj3ZtgAyrhWqKHncUZ4PKgW520G0B4HcqSnC3sy/brQcSSmqcMZtr
         JTM9jQlAzY0uztzYZMbBTtjrscclUHnXZXY1mQoiMXquP7YQ8wQKJlcJfdejeM6z6WHa
         dZp2WnIXFFVJ2hQvNx6ePr2NAL6JBsCow/GqdO6AsTGRlyR1HlX2SFE5ta/Fr1ZL80Oc
         PqDw==
X-Gm-Message-State: AOAM533SfcglS88dbaE+DE9sHvIsWCd/Tl7JUUCCq0aGclHpbs8Zn8pq
        WFskib+RGG9MeeArboNTi/IIx26ikBqgfC5mBAWfGg==
X-Google-Smtp-Source: ABdhPJz3YAjU9S+NHPtVDvPte3f9GOfaHQiDoSCKgiMmkss0RaJxXVQ9k9KgI/GbemDggIXSiz1Z354U4LyqP/tG0yU=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr6783158wrs.27.1595929859449;
 Tue, 28 Jul 2020 02:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <0f6b7375a07b70353336dd7c9420138186d62936.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <0f6b7375a07b70353336dd7c9420138186d62936.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 10:50:42 +0100
Message-ID: <CAPY8ntC3Smw+pH6Dbyob_voO_+Huw9Mzpv+F_FHnrOERLfS1hA@mail.gmail.com>
Subject: Re: [PATCH v4 11/78] drm/vc4: crtc: Use local chan variable
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
> The vc4_crtc_handle_page_flip already has a local variable holding the
> value of vc4_crtc->channel, so let's use it instead.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index d3126fe04d9a..cdeaa0cd981f 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -533,7 +533,7 @@ static void vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
>                  * the CRTC and encoder already reconfigured, leading to
>                  * underruns. This can be seen when reconfiguring the CRTC.
>                  */
> -               vc4_hvs_unmask_underrun(dev, vc4_crtc->channel);
> +               vc4_hvs_unmask_underrun(dev, chan);
>         }
>         spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
> --
> git-series 0.9.1
