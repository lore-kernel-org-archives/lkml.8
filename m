Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E81205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLKqSYSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgEMQFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:05:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179AAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:05:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so14144992lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yS65XV/YtISiDaptac0FJiXD3Tn4ArFGdgQXRHd/aM=;
        b=PLKqSYSNicC0BUQNdjEBXIczUU2Ubmi9uxrakyohfeKedUu5pEjNXH3weTM/WNFlZM
         J0X0KiO9Umy3eAbZ6TSsOuO7vFxuUSITJmODaZj5uHx1byuQUI1JEpqZPhSadkgdJarR
         G82gO3AHOnSB1JJqvwQCpqXLG0u2HJHiRbmKYZ4qIqOmuO5YD4fM7cbjOKZifuhJ6kgB
         hBNPxWc05yFQjfYr36j97EXsX3A/3qHd/kwTB0qw4RjH/x09QeLmHlexCET4l5UZ3Hdq
         t9P2Ttw4nmH7TsI/0i0jzkM7qHcffz0O8Xh8NoHN8f9eamzTWS80bAo82wIrvz2gcFJm
         rhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yS65XV/YtISiDaptac0FJiXD3Tn4ArFGdgQXRHd/aM=;
        b=JgWNtgTH5P7Z16Y6AfckCxAUcihYohgYiHr75G1iFVvvlpZ6QqRXsI/VWX6FEn3KqN
         h1eCbp+fRNyfDvwFg6SYx6keJSNaxkjhbMntb2LxAqdTb3PRaH4lmCN7z9pVPZM7s/qZ
         86ln84D0tGzL5l6i7aLr/Oj0RtK1y8WE8SmSHE3cdFU8lyDr+ynjfhEd4XLA12HvgFF1
         4EwQkIrs314ZHZw4qQBGnIHVy3Rxm0KyXGeyL6qhzJG67WaGq9subGymH7Nrih5P9zxp
         rCql5vi27842i9b0HUWdYJpR5OtDWI3Bpj36tPR+/hLg88jHrf5spQS6GkijjgaKRfMz
         jV3w==
X-Gm-Message-State: AOAM530unKeHLWDRFxzMRsQ4XDU6KNCm74RGn+i17kx0KAGEW4pdpKYs
        6D4ci4JyA5Ldd3zUI4qdE4ZzpdgGyhq9efMH7N4=
X-Google-Smtp-Source: ABdhPJy16wWQDPJNS54OlcDRfVMpoO17uW3oqhASyCtXCLRYCkdn+EsWQCegAtv+YMXArpzHEQO/EEfoyLKS/V25tiw=
X-Received: by 2002:a19:4a97:: with SMTP id x145mr169435lfa.66.1589385952502;
 Wed, 13 May 2020 09:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513150007.1315395-1-lkundrak@v3.sk> <20200513150007.1315395-3-lkundrak@v3.sk>
In-Reply-To: <20200513150007.1315395-3-lkundrak@v3.sk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 May 2020 13:07:06 -0300
Message-ID: <CAOMZO5CfPC_awoo4RRgOabWYk8WaAKJUypG8A=XeuThuCZHqDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Wed, May 13, 2020 at 12:08 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

>         /* Get Clocks: */
> -       gpu->clk_reg = devm_clk_get(&pdev->dev, "reg");
> +       gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
>         DBG("clk_reg: %p", gpu->clk_reg);
>         if (IS_ERR(gpu->clk_reg))
> -               gpu->clk_reg = NULL;
> +               return err;

You should return PTR_ERR(gpu->clk_reg) instead.
