Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46CD20702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgF2Wjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:39:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgF2Wjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:39:36 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jpt07-0006Yj-Dn
        for linux-kernel@vger.kernel.org; Mon, 29 Jun 2020 12:35:07 +0000
Received: by mail-il1-f200.google.com with SMTP id o2so12193502ilg.14
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3wAD+FwY/apCHMWEbeYwrensmYJ31fzvIHVdi3AjOc=;
        b=VyOG5HndfgGbPATU6G4YYrSiCOgUL9/rCywNeBBuAXXqsMT2Q0h3ce5WJL6BkNaTAQ
         Vkhj6SgPFATzh1qfPaiDxdJingEsO0gK2kSRriM/xwBJPulwmVx3Yo7REPeW8+aEEdfu
         YKR3wQeBMTEn/s2OyijfL2rsM5LYepuVS1pSeGusso6ZwFw5k1GZuiGOZSyrv6KVPWIS
         PJWnkEVPA0yoKPhEah8iOtBy0grNsqyt6E3SyksO4iLh394gzdnWx8V9BQFMQK6zzJUB
         WpEElLtbXYvP6u4YWegJwI7C9uoQVaJpjqnQLPl5zubkKS0wDLy+OmzVUC5CoWY8g8sa
         bg6Q==
X-Gm-Message-State: AOAM531yL8YoNFwCLRWtm41zf9YPMpjiRi+pk+KMAOGtjFZkmrfiV7xk
        rdPDoAu9qz/+6mrgz5+JvtSCKlDGSbipCMoT/RAUzIhbCtGk6QxwnW7/MCawEhEburNEwpqvP4k
        xRkXq5vb68toc0pSGLquY/6VvW4E2xUbhW8Sp1Bja1Q==
X-Received: by 2002:a05:6602:2584:: with SMTP id p4mr17011702ioo.30.1593434106459;
        Mon, 29 Jun 2020 05:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxO+NSoKtLYJDs5amRG3FY0ewjylJLex5PUDsxJbLwE0b+jaD8LtRlSybHl9IyUxFufDoH9Q==
X-Received: by 2002:a05:6602:2584:: with SMTP id p4mr17011678ioo.30.1593434106233;
        Mon, 29 Jun 2020 05:35:06 -0700 (PDT)
Received: from localhost ([136.37.150.243])
        by smtp.gmail.com with ESMTPSA id d18sm351778ils.34.2020.06.29.05.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:35:05 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:35:04 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove obsolete entry after file renaming
Message-ID: <20200629123504.GA10686@ubuntu-x1>
References: <20200628180229.5068-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628180229.5068-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 08:02:29PM +0200, Lukas Bulwahn wrote:
> Commit f16861b12fa0 ("regulator: rename da903x to da903x-regulator") missed
> to adjust the DIALOG SEMICONDUCTOR DRIVERS section in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/regulator/da903x.c
> 
> The da903x-regulator.c file is already covered by the pattern
> drivers/regulator/da9???-regulator.[ch] in the section.
> 
> So, simply remove the non-matching file entry in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I didn't think to check MAINTAINERS when renaming the file. This makes
sense to me.

Acked-by: Seth Forshee <seth.forshee@canonical.com>

> ---
> applies cleanly on next-20200626
> 
> Seth, please ack.
> Mark, please pick this minor non-urgent patch into your -next tree.
> 
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fceaee5200..970136e262c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5021,7 +5021,6 @@ F:	drivers/mfd/da91??-*.c
>  F:	drivers/pinctrl/pinctrl-da90??.c
>  F:	drivers/power/supply/da9052-battery.c
>  F:	drivers/power/supply/da91??-*.c
> -F:	drivers/regulator/da903x.c
>  F:	drivers/regulator/da9???-regulator.[ch]
>  F:	drivers/regulator/slg51000-regulator.[ch]
>  F:	drivers/rtc/rtc-da90??.c
> -- 
> 2.17.1
> 
