Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D5BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D9320678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/7LouV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgHaRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHaRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:32:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:32:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t9so951955pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoSKkzn43e5mTD+L9xg9lYb40d7kQEj3s97HxKcmRik=;
        b=W/7LouV2XH7MpEjE1hAHe4txTdIgHBWlEGRCsrMM5jTbux+uhjIR7Y/eTOiqA6/WB6
         TzTMA64ru7fUXfJvMn5ib/kOhhUD0bIztDMCuMShy+sgwI9ZA+lfPBS5g/cSLRSSq+GY
         3eVHIDBin4XLb76t/Uz6cku3377fgl8ZfdibJm7dPWPQGW6b7L4symtskBGpgRjSmbnS
         Y52mrhHnhnEUkLPPtFNarHAkqEzrJdqADeQgsGtDXHgkY51f0hniCMHhfWvWsFB1152O
         Vp8b5xFB1Of20Llw5rzks9GVZDZzFAKpYaa152u+YTdykDsKfOG52YeeOEIni5g++x7u
         5pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoSKkzn43e5mTD+L9xg9lYb40d7kQEj3s97HxKcmRik=;
        b=YQdml6CmbP2dAIXl0f1EPzUVF9tDsXbEL4n/DDKdEO4+l2Hihz/w0YNdSyfVGllGwR
         6nQsv88LXcDQ4onut/AwOi84j69a10mWyhqkzE07vH9GPGtaQiOgYtdQuii7FgZqJymV
         WiiuV39QI1+/EP0mdmkRmy8H5cgPCowTxBnnAcyQLWGY+I5EoM/A5K5iRwUfe95GriYY
         E075nnRu4Ik7YsgNFfBeq+vsFzayi01j8rCFfxle0U/Xe8ZLr5N2naDHUnmQtU43oR02
         gwe+bynu4w1stO2RBInIuBjlXXpH/uLIkhJLmtDEHFVb5ej6ZSFNuWbg49Nr3nwjlw6U
         1xog==
X-Gm-Message-State: AOAM530T9KaGdp1/fI2i/bns4e9vvBjJoKOKCEwRpPyzAS9CcdIjgFpZ
        hJoCx6f+q0++NOmc8WcjpzPSZ240T7Lyr5R5Sn3p8w==
X-Google-Smtp-Source: ABdhPJwomTt09QDAQN8Oni666/Eerk5uQrbUgtrj9bUOokhYnsMVMkRIsUFIuJbsvLJvAQVGenyvPr0F3OeF38zfJ0Q=
X-Received: by 2002:a63:9d09:: with SMTP id i9mr1927016pgd.381.1598895126505;
 Mon, 31 Aug 2020 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200830163043.10317-1-trix@redhat.com>
In-Reply-To: <20200830163043.10317-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 10:31:55 -0700
Message-ID: <CAKwvOdkvY62xVKQcVHxMTpskO=bB2sxwiOQb+TGF0-oU2Q6unA@mail.gmail.com>
Subject: Re: [PATCH] media: tc358743: initialize variable
To:     trix@redhat.com
Cc:     matrandg@cisco.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        p.zabel@pengutronix.de, Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 9:30 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis flags this error
>
> tc358743.c:1468:9: warning: Branch condition evaluates
>   to a garbage value
>         return handled ? IRQ_HANDLED : IRQ_NONE;
>                ^~~~~~~
> handled should be initialized to false.
>
> Fixes: d747b806abf4 ("[media] tc358743: add direct interrupt handling")
> Signed-off-by: Tom Rix <trix@redhat.com>

I'm guessing there was more to the report that says that `handled`
isn't necessarily initialized along any of the paths within
tc358743_isr()?  But you should fix this for all callers of
tc358743_isr(), such as tc358743_work_i2c_poll(), not just
tc358743_irq_handler().

> ---
>  drivers/media/i2c/tc358743.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
> index a03dcab5ce61..c724bd1591de 100644
> --- a/drivers/media/i2c/tc358743.c
> +++ b/drivers/media/i2c/tc358743.c
> @@ -1461,7 +1461,7 @@ static int tc358743_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
>  static irqreturn_t tc358743_irq_handler(int irq, void *dev_id)
>  {
>         struct tc358743_state *state = dev_id;
> -       bool handled;
> +       bool handled = false;
>
>         tc358743_isr(&state->sd, 0, &handled);
>
> --
> 2.18.1
>


-- 
Thanks,
~Nick Desaulniers
