Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544FFC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3041E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCTvAswW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgGPN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgGPN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:57:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA86C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:57:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so3333129lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CikeVXsmSH3xLejOtc64KxmHFqUPdsBn8HUNTfiQdM=;
        b=qCTvAswWd3m3SFChWcBhgjSBV9sXk0iKF+7Njy/yLDzYrxghImOwWXRjF9o8Wtrf/b
         jLJt5mYhaXRH1FURrwzxmUh4LdwSR7X3n4vKK2nzsFmpCbRqoCluigSiSfXJMUFR7aFf
         h+tkfv9tzeI6leN8Z8uGxSHi717r7MI+mxTew9gvnfTy0JC5OSG0bKToY5HAurR9vKfm
         wK0wDBQliaJIptP6i7OGYKHh+rcyiiQqD3mXU/Pf3H4XLmi3xULSHCXqms6zk0Mov4Jg
         x4vXazJcuaZz+UAGy5hsejggtpbZyzZeTWNaWqNHwKwId5M0sDi2mhXEwmmzacTJClMt
         1nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CikeVXsmSH3xLejOtc64KxmHFqUPdsBn8HUNTfiQdM=;
        b=aKX8Hxtefn303+eLHZzaAXbRPZY0sDnNz7sUnZYjXSr6aBPzKo0SHm0vK1aZ3KSo79
         FMma4dr4Wlz9XBSdksQKoBQsrBypWATyYSlXY5C1qPlBedio+4gJDMUkgkEg4b/JKE1J
         tUfiunv6wfmGR3P32tV9rBZAa+hZkSNLA/8GcrGRMbCvsiXWT29h+o3f8WFGD3cTiZAO
         CpK9wmCAdrI6/VMdnhN4iuFM28V0DOxzSIJjin3zh2BJBQUGnG4Xni+OqzZZ6KO6BT2X
         k+6dSal3ILmQXbkqpW3gmA1QkY1yn0vOk88Y7CelK4RcRLBSnI6pk6MoRm41//tsH9OG
         Bqnw==
X-Gm-Message-State: AOAM532Bc3mjIBZQmNE6rhOuAK0fJS1tysnRK59okeSZoMhghWm9oL9a
        4J0QZc04Z4/llqvSE+y5XK268zO306PQZCdA4P7B2Q==
X-Google-Smtp-Source: ABdhPJxVFqXa0LJbvSZZW1t3IXhfBWED/cnhyxm/+4d67HItSPQn+L5o6S2HvAr1UKqianvKT7hJBHSeaZYmBa2iAKE=
X-Received: by 2002:a19:e05d:: with SMTP id g29mr2138883lfj.217.1594907868617;
 Thu, 16 Jul 2020 06:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-21-lee.jones@linaro.org> <CAMuHMdWMUN8sU09J1eSsSJ9sXMhf10GUHeP47UDf6+yp8vnAnw@mail.gmail.com>
In-Reply-To: <CAMuHMdWMUN8sU09J1eSsSJ9sXMhf10GUHeP47UDf6+yp8vnAnw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:57:37 +0200
Message-ID: <CACRpkdYep_r1KsTnU2gVr-DeOf50hRiyTRq=jgeas=fD-qPHVg@mail.gmail.com>
Subject: Re: [PATCH 20/25] pinctrl: pinctrl-rza1: Demote some kerneldoc
 headers and fix others
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 9:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in sh-pfc-for-v5.9.

OK since Geert is queueing this I'll drop this patch from my tree.

Yours,
Linus Walleij
