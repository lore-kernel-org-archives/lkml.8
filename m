Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA42520714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 09:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkJFC3z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFNJsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 05:48:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3FC03E969
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:48:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so6473709pfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvxXGWImKK0idVHDWiFzUpEVLlobMFbDY9vn//eI/9A=;
        b=nkJFC3z1IN6j1mHX2gbfdoVRUMFSXotIgLCRLgLxMSbaFtMSnRF9i6kPNYaLn0QY2e
         KWLSX5yWkn1H57pNir1VZyy69tP0B4cvfNrKqFk6IJJaoGiGxCLEbdaUkHe7qtvhd5DS
         vFsOyE+pK3shQ4G6+mAqNeZB0SEsE0vMc5xF8nAZgp01m5YYzqNOQqTpASlB+soZECmh
         GCIwNbUjkKVjQQRMUQnKOoHbCaMpw1wgHqGMsth8ybEFjzjAARbMFCP8BZmrDFx3Jy5J
         VoaROYENiQjg/qd/8KN/cIwZBaqSUczlgK4XHzX5xEcjnEBXf5YTQb1DorH79/IvM/NU
         KR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvxXGWImKK0idVHDWiFzUpEVLlobMFbDY9vn//eI/9A=;
        b=of9oVzw3X4Iq6n220/N7RCu281snpyU6VMn/W+IimfjUSIM5fat3U8D2LPCBbI/ZFL
         REPVqhQ+0ul4MLRbqPSWFu2nbgMnvS82txHRufOz5q9mxuturc1it5vjvQKLnkzCsDhJ
         rTb1U8BYBQ6We44ojW3FK1ersFIs29BmYmzqWTr8GRPmFEwrot9Q+Ju8qJMy9X1XGFI4
         bxWd9Md0pK3xFScrTh1rpckWtKnpKQYCmNzpxiZ+LiuAzhtR/towVFzMiph4GXCzSv4h
         oxS8T+WdDbm6p/xcdin14VSYyWJKi2/9ohSejBU5TRWPxOsEhdvOlttiJAVakqdAErhZ
         t6/g==
X-Gm-Message-State: AOAM532jpDd8nhCViqYbEfYUJFBHYICql6xS6efr1U6yOVb+r7MwGcSf
        QfSdc3HueHcfczfVzFKUKhXm4OD8QAIXiPqB1fg=
X-Google-Smtp-Source: ABdhPJwYZavEWvdA0J1yrGBUxY/uYHKnkxZs2SsvB+9yof058vomrhWPnHEJZKAb221T+W5zWfJi7OS9ca5pfxCA65s=
X-Received: by 2002:a62:5284:: with SMTP id g126mr12644494pfb.36.1592128103604;
 Sun, 14 Jun 2020 02:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200614064601.7872-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200614064601.7872-1-navid.emamdoost@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Jun 2020 12:48:06 +0300
Message-ID: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 9:48 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:

...

> +               if (ret < 0) {

> +                       pm_runtime_put(gpu->dev);

Please, in all your patches fix this to be _put_noidle(). We wouldn't
bear the flag day of fixing these parts again.
Yes, I know that *now* behaviour is the same, but calling put here is
slightly inconsistent.

...

> +               pm_runtime_put(gpu->dev);

-- 
With Best Regards,
Andy Shevchenko
