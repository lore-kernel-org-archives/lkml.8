Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A1C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387842173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581562811;
	bh=bEUCJ51341gKqTxiLz94EDfj7Gx9Fxu21fmsHyNKvqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lNgP2XgH6P2G5xGh4+v1MUnBF2gP2lR12H6emiMAnAWfeypmVXqp7q04CpkxQnwDA
	 xznC7TpT1uFLLvDsVVDZcXwkHHSF1lEwYeFs4oRJ1Jz5tJEPsy5zPRuT5bjaXFXcIr
	 Pl3NkYzm7rWLAoz9ZqYjZ1EVVlWfa1palLpbLxjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBMDAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgBMDAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:00:10 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F0A2168B;
        Thu, 13 Feb 2020 03:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581562809;
        bh=bEUCJ51341gKqTxiLz94EDfj7Gx9Fxu21fmsHyNKvqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JTfi8r/UtJa+bQ4VBB6ewyRs/2knS2KXu4RIeB1svAMxEvYjQe4DAs19CK+jh9gwi
         9wH4H1Rd6CAOWyxnDZiRKrN5nLvNVxNdDp86I1Jdb/bhjipyRS3y1Wtu7w/g+NFmad
         WAnKjCno3wCZEC13YxNOb8y/1bjAN65j5lrNJEQI=
Received: by mail-lj1-f180.google.com with SMTP id a13so4795241ljm.10;
        Wed, 12 Feb 2020 19:00:08 -0800 (PST)
X-Gm-Message-State: APjAAAUHDKC6NzxTSnCbp7lgYM22pYOSFjXADjqmuXMPc3u+vgArmm7D
        KMAP+KbS92nurk1YxwN1eTHK44vRumtoLTICnGM=
X-Google-Smtp-Source: APXvYqx4QJ151ZSVZZYDzSV68CPCkkmLByiZCLmn3opEG8UQq5gfjm5gqOI3pgNl48gbF4FHirrs7XMbh85ePpdmWCI=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr9641570ljm.53.1581562807106;
 Wed, 12 Feb 2020 19:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20200212101058.11785-1-geert+renesas@glider.be>
In-Reply-To: <20200212101058.11785-1-geert+renesas@glider.be>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 13 Feb 2020 10:59:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTUArYx_aWwMZQ=VGJhvn8zjtbL_4ubTnmr8+VQ3Gu9kA@mail.gmail.com>
Message-ID: <CAJF2gTTUArYx_aWwMZQ=VGJhvn8zjtbL_4ubTnmr8+VQ3Gu9kA@mail.gmail.com>
Subject: Re: [PATCH] csky: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Feb 12, 2020 at 6:11 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The C-Sky platform code is not a clock provider, and just needs to call
> of_clk_init().
>
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/csky/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/time.c b/arch/csky/kernel/time.c
> index b5fc9447d93f2307..52379d866fe45f28 100644
> --- a/arch/csky/kernel/time.c
> +++ b/arch/csky/kernel/time.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>
> -#include <linux/clk-provider.h>
>  #include <linux/clocksource.h>
> +#include <linux/of_clk.h>
>
>  void __init time_init(void)
>  {
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
