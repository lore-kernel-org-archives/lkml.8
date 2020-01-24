Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CA4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02A020709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xr9b25sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390723AbgAXRkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:40:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51525 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbgAXRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:40:00 -0500
Received: by mail-pj1-f66.google.com with SMTP id d15so136884pjw.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Fl9DtoEGdJPaF6wiMaulBg+k/QaiWHWReTuVYIV7lg=;
        b=Xr9b25sdtL1HdTl6hIooGcqIRd77GjAUtxMUHXNaiCS1iSPex4xjnYaSAa7vjnBSwA
         ugXGLMsg/kU5nG0Z4WxkDnFka5Iy3pai7Wq0DuQKHFoEKsHpqsF3bEH1+L9HK1J+DIGP
         7hu0Q2s9C5Dzf3hM3lR6FOFv/007cTLHNxSogaGt8jC5u1tNAOOqn1ye8RoaQjx6hNJT
         pd1QmxvxE9zCPKaeOwUDAYXlclQbb3JRBsqU3PQdjG3zYTIHiJoMMnBr8t6PaB3AbWux
         8BNJPGoRCzK1reJUQL1aHxGkjnR728wbRC6FCyMaesHxw7p61aM0z6iXQVXJqsj6GTII
         1GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Fl9DtoEGdJPaF6wiMaulBg+k/QaiWHWReTuVYIV7lg=;
        b=K0zMyXxAKSad0GgZ/V645T+X6ngniVTXlWT3v3wqyq9tfAaqI5jvSRIqGuKY4OIyWZ
         /BnU5gtSYaKFE/QjzcxCSJlA5lJ1xgewCu0bjXzoKbcaXiTchMcmvkxTmCLIqydzg6eu
         QIg09uTzU5CM7oFP+zezGOcftbDWnuJpTiQq3UXRtOtDoJGQZvlOzmLx2wwvpSd8S9/s
         8RRrN4mLe2k/9+vodw+8rbAjNxzogqDb/1r6DKnP++heF5RTXoSm4fpsi30kLojILX50
         XYjM9aGfazvajueB941rulXR9POn6QvbVsHzAhzIwWpGuntTczMzixIBT+GT7Fc/9KIU
         L93w==
X-Gm-Message-State: APjAAAWA2+CopxlwicOtOY1/0emdWXmyydytM+kSRq8HTgzjA5WR7TBQ
        TwN6sQX70ErvjviLW+H0K31EIg5qfSnz5QOWzZ3fzg==
X-Google-Smtp-Source: APXvYqw2zvIPa/E8BPtiWkInChMYVaS/82b3KS2QfXEyshMm2NfjWPdDTnav/pt/y77redQAAMi2iysMW3m636r4Ioo=
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr4558881plt.223.1579887599337;
 Fri, 24 Jan 2020 09:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20200124155750.33753-1-natechancellor@gmail.com>
In-Reply-To: <20200124155750.33753-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 24 Jan 2020 09:39:48 -0800
Message-ID: <CAKwvOd=R6NrqAvQWdu3yZHFNPVqAMO=verL6gRDGprMjCDPGcQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt1015: Remove unnecessary const
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 7:58 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../sound/soc/codecs/rt1015.c:392:14: warning: duplicate 'const'
> declaration specifier [-Wduplicate-decl-specifier]
> static const SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
>              ^
> ../include/sound/soc.h:355:2: note: expanded from macro
> 'SOC_ENUM_SINGLE_DECL'
>         SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)
>         ^
> ../include/sound/soc.h:352:2: note: expanded from macro
> 'SOC_ENUM_DOUBLE_DECL'
>         const struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
>         ^
> 1 warning generated.
>
> Remove the const after static to fix it.
>
> Fixes: df31007400c3 ("ASoC: rt1015: add rt1015 amplifier driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/845
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  sound/soc/codecs/rt1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
> index 4a9c5b54008f..6d490e2dbc25 100644
> --- a/sound/soc/codecs/rt1015.c
> +++ b/sound/soc/codecs/rt1015.c
> @@ -389,7 +389,7 @@ static const char * const rt1015_boost_mode[] = {
>         "Bypass", "Adaptive", "Fixed Adaptive"
>  };
>
> -static const SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
> +static SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
>         rt1015_boost_mode);
>
>  static int rt1015_boost_mode_get(struct snd_kcontrol *kcontrol,
> --

-- 
Thanks,
~Nick Desaulniers
