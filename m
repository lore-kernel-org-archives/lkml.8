Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F356EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgF2TEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgF2TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98BFC031C60
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:46:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so3759781oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXZjRYcRp1enhRfaVMMTyrrWH/jGCZPRKg2TKcHBnuA=;
        b=H3qVc52WVQEUeoXLN3rE9pwFLYAScFUTJuhBR0sxZeYo8bLGoFttSU2Z2r25amPd1k
         V9CGjc45aXPn9uSgvJyS9BTaDSNljry58luXk3PEfSD/Yg07aT1QDCjz6ooBUZ/6jV6U
         s+D9WuCpnwL+OYW74nRgH4iwVJzmlD8GzgxMi62P7CS1yJWlQLSBe5zZ195P7QMSrRSs
         E34HSDYu5lgILDGzZL5y7QN3c1+eIHWAHQUi8bJsK9uNDF/A3ZTtS9e8+R23mIniR6cY
         7hrb2sXbZC0rHlvzZf9Zxk2o23BNJzCTjNFYNDQ9qG8p4zkmhrTU0udb9xS3naTgGJRu
         LQiA==
X-Gm-Message-State: AOAM530fQjW2Tup3cGA1PsB2kMo0aWuk9/ZQZYupds2xChWPLay2c5r7
        4WN7BnmTiyDiKkfacF9wPA7Q1jqXZfQo18mp3Xg=
X-Google-Smtp-Source: ABdhPJz5R1/r22wA77e3/DxOJlYYNx4t//zm3fzuCSVrXONQDwgcOpwVsPMEGp3aAxMf0let8fQxMOpDikH5L45SG+s=
X-Received: by 2002:aca:849:: with SMTP id 70mr12465681oii.153.1593452797949;
 Mon, 29 Jun 2020 10:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200526123810.301667-1-masahiroy@kernel.org> <20200526123810.301667-2-masahiroy@kernel.org>
In-Reply-To: <20200526123810.301667-2-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 19:46:27 +0200
Message-ID: <CAMuHMdWq9iYMzB1=mtdSEoDjaOZVYzE49Nx4J4N9Sco_zRnWog@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: descend to prom from arch/m68k/sun3
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:38 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Move prom/ to the more relevant Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.9 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
