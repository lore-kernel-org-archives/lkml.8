Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D502C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D692F2076A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrH+loPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGSCxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGSCxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:53:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0EC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:53:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so14691470wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=O5W9bBIaSXw0wY6EC2n0SEJT3neXg6OZEcQ6GpBeLoY=;
        b=JrH+loPfN5OfjBmTfNUtN2dbhNK0VTgsAsyNTnF0JOcCVTjZIkUlcHt9+YEFEk96rA
         a2RCCG7noTwp/tHqYXtq6LbtCHWKeis+xFPpkeWQ1N4oudScxMTbopBm0X0XO1gcqPoB
         HaLlJO7m7ZnQeTVCek6mqX404tQSIO1GktFoBhDybvaLqBL0HmB1TkBMwWlco8YbvpWY
         Jeq4D9VUUYjvTcCxfYZjMVTf1/DPMafre2Z+YeUhR+d+6NgNw5FXrxgMJ4KsXwwT5kj4
         4tuVFQJ73BaUZa1uy0aX+tKcG8iQmZqzFzvKLVXwbu6qQJ4YcECY56kgTeI4xPfVVH+b
         Oh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=O5W9bBIaSXw0wY6EC2n0SEJT3neXg6OZEcQ6GpBeLoY=;
        b=ILu8/hrE1Zzm/hce4IucH7sI+JvY/hKuIViC0m1Lkb8iE5tznLhfIkaMXBR70jnqqP
         pXtj9Xupr2bF9ibbJCzh2iHPRLIkQSXusDqzUAxIdwYC0pQkkMtN+zOXF96rQk0AYOm+
         2shaWqhC2BjL49+sW8s7D9e78/tmYDr3qMykiUP2WTMveqhLcnvuIkD3BCtO6AoCLMgu
         xK2sbx4GlUktgZlm6XyyXCP2+/zd4lYit3H0ssLF8ZULoBbRK/s2CgWPOsm+LHAlKrPg
         2Cxw1Dtw/+sIhgmG0beFbyt6vUR3/IeRfYkq9UKh/d+3lAWzIbByMEjgNBz/kPQ8w95f
         Q5Pw==
X-Gm-Message-State: AOAM532gOuYxgs7srnoymoJgj3o9jRT5qZ2C5+DsJC1cpyj2Qc6KrW3m
        PDBb1maibOXgCPEurQFZUGU24aFb5c916kkHOGo=
X-Google-Smtp-Source: ABdhPJzVnVzX1NZLH+r/GPPA38l3J7Xp5tSHja15vP4JUQbSnu3rEeoCEgnYy6SHo1q2jhN5ovtnfX1XLfmxROfLNjc=
X-Received: by 2002:adf:f60a:: with SMTP id t10mr17378393wrp.64.1595127179650;
 Sat, 18 Jul 2020 19:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_2D17145034BA02B43C169473C02C4257AF06@qq.com>
In-Reply-To: <tencent_2D17145034BA02B43C169473C02C4257AF06@qq.com>
From:   mnlife qiao <mnlife.qiao@gmail.com>
Date:   Sun, 19 Jul 2020 10:52:48 +0800
Message-ID: <CAGjHXR3kE00vcr04YOp1BYEHEzO-Ppdzs8qnF7_f06rNG1uxaA@mail.gmail.com>
Subject: [PATCH] ASoC: soc-jack: calling snd_soc_jack_report causes a null
 pointer access
To:     lgirdwood@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, mnlife <mnlife@foxmail.com>,
        mnlife qiao <mnlife.qiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: mnlife <mnlife@foxmail.com>
>
> When snd_soc_card_jack_new is not called or the call fails,
> calling this function causes a null pointer access
>
> Signed-off-by: mnlife <mnlife@foxmail.com>
> ---
>  sound/soc/soc-jack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
> index 0f1820f36b4d..51b799ee98b7 100644
> --- a/sound/soc/soc-jack.c
> +++ b/sound/soc/soc-jack.c
> @@ -44,7 +44,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
>         unsigned int sync = 0;
>         int enable;
>
> -       if (!jack)
> +       if (!jack || !jack->jack)
>                 return;
>         trace_snd_soc_jack_report(jack, mask, status);
>
> --
> 2.17.1
>
>
