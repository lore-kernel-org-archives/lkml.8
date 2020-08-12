Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4E206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRwaGE62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:06:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C01C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:06:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b22so464467oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbC/xnk+zoIlMr8AR4zX7C8E5HyHt5wuUCG1GuQ26BI=;
        b=hRwaGE62EJNwc8VprIWo2PXefmpSvqiIQ71e1bUZyJmlKFzMCBnlDmvJMTCr053w7Z
         Eq0SMtGmiJocJ/qjUXdNWxaJDGT/SKGCBFQ3I/1sJxQgpkT8wJQ+3s6tJsTq9OH2PQ5e
         rmGgfhGza3n/PNEgW0nbBGZHNH9f95SXLDRWhkKJ+Y0J9a4ouwjE5/762kLRnkbEwfxe
         +eA/xOLBAAdziLo7YsIl3v33kuMgRiCdVF/4ac6PMcB3wnTNC3wseY/E9DIUfp4Hk867
         wBgTPVpRQsuUfO/dwJ1w7Rdfor2DuNzyr+CeyD+ld4g8jwnZnquOdJFr2LgFCIi/aXV2
         ewiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbC/xnk+zoIlMr8AR4zX7C8E5HyHt5wuUCG1GuQ26BI=;
        b=ip/Qv3AITmcqeG9IdvCeIlr8Z9g2IJ77eG6wXKGc0fEnIsLRxNpNybuPWWq36AScIF
         ZhKFQf+ge0Z4EjhCfIIEBcrTDRTWQ7/E8T6bP/am8wjTD4fLS5NkrI5ti/SANk+Bv/nQ
         3ZYM3WROZ/DOwRwK3Vyoop3uiMO/vhW6Y3LzFYNrVDedptemsPnf6DPhYgtJKjFwJC/F
         WjzekYxXNcSuWd4tIu8oZtnV4ZWOL8k/vIWleBcgUETSQmYFjMN+fx8kBXBldyYVQDJy
         yADnmW7PjGFK//IPSvCbt9BUDqSdA9wXqjH2+9iGaX3BF89Aow4teriae9jibWOsVnUp
         UnPg==
X-Gm-Message-State: AOAM533bkihf2mSaqDZ1Udzr2SKC30NLqW9CV3nFBOH8Q2SD0054yED4
        fM6dCOUuLkEJrm3GHzMf6YE6sK5D9cX9oww2mrIjjg==
X-Google-Smtp-Source: ABdhPJx3TRX0Gwz1ar78DLMWbgZMau4UKE7Ax6fe96u9FtrMFQJJlyTadKZitcKb3lkK7CwNTVc3hbZeSHmn8RGqg60=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr6080825oif.10.1597197974841;
 Tue, 11 Aug 2020 19:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 11 Aug 2020 19:06:03 -0700
Message-ID: <CALAqxLUdMpnhHfLDYw-z0QEHdp+UtvdSt-m3+KqMUgcXP+PSNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:02 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Looks like the q6afe-dai dapm widget registers are set as "0",
> which is a not correct.
>
> As this registers will be read by ASoC core during startup
> which will throw up errors, Fix this by making the registers
> as SND_SOC_NOPM as these should be never used.
>
> With recent changes to ASoC core, every register read/write
> failures are reported very verbosely. Prior to this fails to reads
> are totally ignored, so we never saw any error messages.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
>         - replaced reg 0 with SND_SOC_NOPM and removed read callback
>

For both patches:
Tested-by: John Stultz <john.stultz@linaro.org>

thanks!
-john
