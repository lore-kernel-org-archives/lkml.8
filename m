Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE06C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D80206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSjnfo9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgENMOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:14:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E82C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:14:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so3196733ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXnRTW9/Xaare9cYIycGqJDKjuTFI88F9YjRcgsnR2M=;
        b=rSjnfo9maX8dbNw6zQ8HuA1Jg9YgBoyGE3TXIU120l6p9DcnC7g9hEtcHfdqf44y7w
         I5IPEdYKfWyMsIB0LuOcojVB7NDX4ioX94yEi/YBkendliBPbPe5WhB/LSh3XLt4bAIU
         o+aLxNCyfk1RstPzDMheP1GlhPpU4kTmrVIKrUHAWgs4N2NlLgbYPQgL7z18qkozAlSz
         z9o3rVT9Dszsl3mKjwiQjZWudliNwj5+4DM02itlCJkZBvtouk+guR/cyh42z2Ely6cW
         OUOUza/cOz0vpkHPEvtBEdEakGasJlF+dPmjsTrFwJmNJ57CuRhxtLKI+Y3QyUpTwIvf
         NP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXnRTW9/Xaare9cYIycGqJDKjuTFI88F9YjRcgsnR2M=;
        b=RPfUhCN5y2oyQJni6pyFd+NTLxUVPW+ACOVY6nMvfvVbg4zOZemlXPx1JQZlmYnX4v
         oqGnf8kj7p5cRFgc/U9kcTyWt3vo5ff2hM1U91TYcochGhcG2H28E3i6aZtdG2L3Q8wX
         nqf51TDtIrm2uz50KgtD7fj0xk0lqXNBKBBUPayAaiu4FqCFvjBqOhfg9HkQjSxA0nAT
         UlBq/Lm9CAEECMlZ9gO5VhoG2MyZfZhzWdCbAWbm3poAiGxlgSTHIPNIVXYIIynti9aB
         9ojDSPmfOiWbVlr2BVIQsOCcgDK+4F7x+Q+2k1zb2qOGSYTCWz6+98KVkKQb3U0/6UmS
         GLyw==
X-Gm-Message-State: AOAM530dOx0eMHs7Fjk1i3ALQ9BDZ6nJ5TTKeP/JubhzGGD15Dm+Jsnl
        tAFNKGVW2j7MDjEs1d1qHKBr0Ksj96ftSZ32HCw=
X-Google-Smtp-Source: ABdhPJyZawv5nbT8xSPpRhThQabdohiRc/eQFL5QMSoo/e+x1equc5hDVBrg2F1TBelzbk1g6u268CxTsoBbuWEatbw=
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr2625094ljm.49.1589458458026;
 Thu, 14 May 2020 05:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
 <20200513105144.GC4803@sirena.org.uk> <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
 <20200514101711.GC5127@sirena.org.uk>
In-Reply-To: <20200514101711.GC5127@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Thu, 14 May 2020 21:14:04 +0900
Message-ID: <CABff4NQh8ZtHUfn4KYcXfgbZgiaRQb_5s5e7sq0_jZkp2OMg4Q@mail.gmail.com>
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Tzung-Bi Shih <tzungbi@google.com>, jack.yu@realtek.com,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, nuno.sa@analog.com,
        geert@linux-m68k.org, dmurphy@ti.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        rf@opensource.wolfsonmicro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 7:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 07:58:12PM +0800, Tzung-Bi Shih wrote:
> > On Wed, May 13, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:
>
> > > > Changes since V2:
> > > >       * Removed warn massage in max98390_dsm_calib_get func
> > > >         and add comment.
>
> > > The problem isn't the warning, the problem is that you have an empty
> > > operation.  You should either implement the function (eg, by caching the
> > > value written) or remove it and fix whatever problems you were running
> > > into further up the stack when it's missing.
>
> > The purpose for the mixer control is: to signal max98390 to start to
> > calibrate from userspace.
> > Thus,
> > max98390_dsm_calib_get() -> do nothing.
> > max98390_dsm_calib_put() -> call max98390_dsm_calibrate().
>
> In that case it should probably do something like read back if a
> callibration is currently running.

Thanks for feedback. I will follow this guide.
