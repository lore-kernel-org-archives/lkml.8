Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7040B2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+yIR8l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgEPJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgEPJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:22:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC530C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:22:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so4735453ljk.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4Oz4+ibWWpMydd1arZxA8BX6PM3A8jv5HZMESDsQ9g=;
        b=Y+yIR8l6V8vqgoEYGfFGAFQpJiHWTXKBZUGJ8iMpiV/WiETMqDCSVSF9HK4LnObkIS
         X35ZIKFDNpFJP54x12vBOBDPG8Pgvb+iIKIemhWvRNqpxoAqdTLMaffC4OCOwYxeGJql
         pslmoemCEm1ddSazERV0WkCTNg8+nPc0tmlMCYWTxkNuHsSH65URrJERFcVf1YyXRUuN
         GQC4zXMUi28jg0DqH2gu99eRLBxwE6ntLwX99izfvdii9xidE3DvrV1ijAva1kMZrXp4
         CHpI4Lx0nwDNQu3amTxFkNjBsUV6L0tRHhlrMnPwbVQpOHwUBTVxW3hScEdUyBmWu1iD
         YdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4Oz4+ibWWpMydd1arZxA8BX6PM3A8jv5HZMESDsQ9g=;
        b=Elr0gToqyrHh9JUNg9FHRRmI8sgI2xhYRjrqOwaPPa4KX1w9iNyH2I94LiqZA8kH+Z
         8xgwZU1MnfJgOHfXk+scXu3tw5N7hg5IiktSqA3G/+q7Lamt9nw0dEpZAK6RTBDr2c3g
         8q0qXenq1rojWvBqH6rxo4Fmbas/8nvnKhzBYnYCRbiRUgPU9t8Uh6vKCK9jz+aZMU4O
         Ysn+6V4aQAkY4HaZu1Ur13/w8oMvlgmqqYhxmMwRP2hYNS9bsp1oQyFjfv6EYGG8eYwe
         QCn6OOXUIKxGCyromND9fCtL07LN43S4yEKzw90WA/uCPeimjKJukdE0eCuNWgb7QYfU
         o/qw==
X-Gm-Message-State: AOAM532wfmM4BUSck/iQC4fFw2w37JDW9WIj1Q0h4IapoN61GKHttqyf
        v9nZJh2gXKEpQmFO1bbT3Lih9pQf3A75G/nAbV3RjZMO
X-Google-Smtp-Source: ABdhPJwG2BEQn2epW8eMqmhwN7S5r3f/ZN27Uv3GIAyyylObEvPx2e+gi/d5W08uB6EwXhJraZS9Q5722xnYiYW/lVs=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr4627881ljg.258.1589620973333;
 Sat, 16 May 2020 02:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200507113626.24026-1-geert+renesas@glider.be> <20200507113626.24026-2-geert+renesas@glider.be>
In-Reply-To: <20200507113626.24026-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:22:42 +0200
Message-ID: <CACRpkdbtRWd6+z6oLra7GwAtHOpdNr3aHnkODPP=j0myewVK4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: equilibrium: Add architecture dependency
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 1:36 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The Equilibrium pin controller is only present on Intel Lightning
> Mountain SoCs.  Add an architecture dependency to the
> PINCTRL_EQUILIBRIUM config symbol, to avoid asking the user about it
> when configuring a kernel for a non-x86 architecture.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
