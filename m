Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407F6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E72067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="palUVOfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHXUzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:55:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB609C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:55:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so11263796ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yO3cJzACKVCFpDqahrm90tvJnnQfGEJdekxmCS+jC14=;
        b=palUVOfz4f083Wb4CBtwLz5r4kSdo4QUMzWlVG2x6nFU8t03xiRSyNEgwqW+GSNaCz
         OwqgzKJlmEhxkQevF+3ozevC9dRPTsd0IZkTILRZLAYCGwX1cKwwvhZ26NsG5y/Lbt8N
         x4iMsKUzmBoj49og/XoEe4yJ7NYZtJgFUSl8fVaE9C8QI7ATMxEkfPfeCI7CpBZdFhAv
         Jg1Y+R6zDLQGWaWzG68jSSqCfEiafx/N7MJ9ZHUKHt2BIVqJfbaE4b0yQBZNuN5QB4J8
         psw+uAkb6XPgiVzqv8+TRFYTFkrMP7zfIDuHFZXtIif0mSumEjBjAVDJUeOFcLS4qdtz
         ifXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yO3cJzACKVCFpDqahrm90tvJnnQfGEJdekxmCS+jC14=;
        b=ml6SPyHzjbMFEwvgWDQCJlNbKHIBiln7D/+wYbBms4wuyEKORFnvU4kJsVA22o7d75
         fua0lQIMb3+PuJKUh2DabhQZmjDdFW3RCxBrFs2wmKVoBbNOXD/5SRl7WLmb7ugbOF/4
         gwYrf3N7yza885iLkoOKGwxU3EI8dp0cNJ2jcB88/L/D2ey6/Ek56lKNHlcC/nUtzGyi
         Es6x5K+C3G7RcOqOW+ZvAyRnSKD+tyIc4ld+DP2xjkN8YA9iRoCgbL0L9NUlPaJ+P64Q
         JiKnETMlEaUAMEZVq9/ZfQQiTpsq1sFxnfuXETUrg//sW7Obnn7pgUcyI5m+MUCujsbo
         vuDw==
X-Gm-Message-State: AOAM530WjD1eP/YTNahSJx0zQtE/bSMVvCcXI5g8tWhr1SOeeXJ1+g6N
        WiFXMAD1tGyTgJFloFuhKpLpz9NDtrbKZZoy0U2ZHQ==
X-Google-Smtp-Source: ABdhPJx/GQsMWNe8fX9SQJ5lXrBBnYtA5YY/yrTrZueYlnteT37fsgp+msic8W3g8C5r77mBV89IFKlz3HD3oDrzPX0=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr3595979ljo.286.1598302534630;
 Mon, 24 Aug 2020 13:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200822163250.63664-1-paul@crapouillou.net> <20200822163250.63664-6-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-6-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Aug 2020 22:55:22 +0200
Message-ID: <CACRpkdYHXwUsN8as7dKOvb00Ec4th45FyBV7TyBOfO4sR=78MA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/panel: Add panel driver for NewVision NV3052C
 based LCDs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        od@zcrc.me,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 6:33 PM Paul Cercueil <paul@crapouillou.net> wrote:

> +static const struct nv3052c_reg nv3052c_regs[] = {
> +       { 0xff, 0x30 },
> +       { 0xff, 0x52 },
> +       { 0xff, 0x01 },
> +       { 0xe3, 0x00 },
> +       { 0x40, 0x00 },
(...)

Well that's pretty opaque :D

I suppose no datasheet (why do vendors keep doing this to us...)

In other kernel code I have referred to this as a "jam table", e.g.
drivers/net/dsa/rtl8366rb.c.

I didn't make this up, the name comes from Bunnie Huang's
book on hacking the Xbox, and he says it is common hardware
engineer lingo.
https://www.iacr.org/workshops/ches/ches2002/presentations/Huang.pdf

What about naming it nv3052c_jam_table[] or nv3052c_jam[]?

Yours,
Linus Walleij
