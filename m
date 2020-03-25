Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URG_BIZ,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BDF20771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAlKDkJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYLQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:16:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44811 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgCYLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:16:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so1949775lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ByYYkQkX4e+La3B895nfCGfrVXv0LtwE0DAHSJeDkl4=;
        b=mAlKDkJWDSPYgt33/yqh4jr8oQ5FIBpIP9q6VV01ZKgGMGbc9wzj1sjvF6U6ng8FVt
         iVkQ9955nL0bTQtOFpfBZnu2ir9V5TiBgTOby5FPVIQv2ZVLwF1I66SKKl0c0uZNNiph
         2xam+zHgSyhCzCdNMZyyJYvup7LRRV5foF7q5Ee0DR5yzA1Ww+znFTpsu9Pt45xLFfr4
         0qroiqy9+sh2zb/ygsQFjQhA/1hf6wvFqo0LoYoL0OHf0NtIQAkvSz8oxvSn0mJuIUYh
         p/9gztExAYRiu/+l7fmoRLQ8Cb8dIfVx+a1LkTuKKoF05uStErBD6ppSEmsyap9XRUjG
         m2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByYYkQkX4e+La3B895nfCGfrVXv0LtwE0DAHSJeDkl4=;
        b=JCnIX7dxlC8ch16qocpgdu5FMa4JHvBZ7Fdo04jhu8iEIK3zYFaQVmPHclHFa+Cb+e
         naTdJb3DXXWjgcr+5svnXzgWh/Cp7JQGrxC1AKvB0hS5b/wN98YGXxzFPwDEdkYyMVUb
         sifg1AwDutPSj8HtsD8ugMyaGpf+GxxDb819293qEy97ffnPvqPw+Gs7r3cUTsVlC1fv
         PWR50IteLWS3zVlogXzwu6KLNt73iUK5K6yA0W6mNMP/JYLbdMz/ktCwu+C+7X4f2D7a
         TwMPxBZjTwMDTZhG/ru6+u2J8sc77ftdCEFBUW+kY8leFcjqWEqv8gYombUwAmCc8kKN
         +QHA==
X-Gm-Message-State: AGi0Pub1+yLg1lYy9y/pScTg1C2oMC5V3VhvaRzy8hVEBNrr4PhH5JiF
        JqnqFkbqybBNg6imIxkz02+QuL3uL5vVXcm2FSEf8A==
X-Google-Smtp-Source: ADFU+vuujs/pw3YyZfWBg23PhzvaUqCrIr0VSH3VGvQvcvwTn/DRb85RcnlKPndnNXs6oF36y2fKPgZVUEIONdXJ5l0=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr1610818ljh.258.1585134993207;
 Wed, 25 Mar 2020 04:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
 <CAMRc=MdbvwQ3Exa2gmY-J0p8UeB-_dKrgqHEBo=S08yU4Uth=A@mail.gmail.com>
 <CACRpkdbBCihyayQ=hPVLY8z4G=n5cxLnUmaPpHRuKedDQPVUyQ@mail.gmail.com>
 <CAMpxmJX_Jqz97bp-nKtJp7_CgJ=72ZxWkEPN4Y-dpNpqEwa_Mg@mail.gmail.com>
 <CACRpkdYpers8Zzh9A3T0mFSyZYDcrjfn9iaQn92RkVHWE+GinQ@mail.gmail.com>
 <CAMRc=MdLYD3CeFtp4jF+-P+4kSmt1sAezrkPFk5rK4=whNEWuA@mail.gmail.com> <CAMRc=MfEo6=im5EPHYtht3xN83k+rcRgQDSOB=Ucs52M8RWirg@mail.gmail.com>
In-Reply-To: <CAMRc=MfEo6=im5EPHYtht3xN83k+rcRgQDSOB=Ucs52M8RWirg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Mar 2020 12:16:22 +0100
Message-ID: <CACRpkdY1u2xEFzJPrat73me11wdY9uGCK=FWWWzLkBY505JrUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Khouloud Touil <ktouil@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 9:44 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Hi Linus,
>
> what is your decision on this? Because if we don't merge this, then we
> need to make sure nvmem doesn't call gpiod_put() for descriptors it
> didn't obtain itself and we should probably fix it this week.

I'm simply just overloaded right now, things related to how the world
looks etc. Also Torvalds writes in Documentation/process/management-style.rst
that if someone ask you to make a decision, you are screwed :/

Your decision is as good as mine, I'm not smarter in any
way so if it is urgent send me a pull request for the solution that seems best
to you, I trust you on this.

Yours,
Linus Walleij
