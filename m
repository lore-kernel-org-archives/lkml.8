Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AE420787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHURO0ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE0FtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0FtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:49:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k5so27343190lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ey3RUpCGa5Aox52KZ5G497GPuu8CFMaGOEj0YfbRCE=;
        b=IHURO0exP8ThsysvtvUVDN5cTBjZW1A5ogekeUUqLNeYB2FGz4d/s/pWf9IREZvWh9
         6f3oUSCkM5uanpvYDqHX3Mm1dW6YEvprJ2NdjOmDgkcMox49wszIokbgRyhNb/ash0mu
         qYG2m30mWdIbE6HauFvsy7lUAeG0MY1Cm+vBQsDVjJpR9COGe8J5mWSqMVoOZlsvr2IP
         oU15BvzZaVmPzyM5p78RnO4P8b+XQ8wJv69PMeJ0ggxtY8eq28DwZ3LeT+ptx8vU9z0A
         KVTOsFtyrGmTzfq1xSBTHeSDuo80Ah7EpSzJJflNND68IyDuCgHx9iUdQKy9CgFuAM0I
         +6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ey3RUpCGa5Aox52KZ5G497GPuu8CFMaGOEj0YfbRCE=;
        b=UP8/COzWU4/j6IZqj3s44hjOip4Uqro5WUP3xTbn5QjP8i4muN6HOTO8YOPivOWPB7
         Kneian+ZvyX8Fqdy/NgLYn1qkv/rKDASkLHHRxBheTv8CY+3EUi9Ds113K8UZsHSAp5V
         fTJDf6TXSzlCjaOY5C1cGEN7tS6ivYsbSS6FKrGDwTR+V4OarhEbneBWrkT/z3ob+svf
         qg1vXCcjXuV2GZPZ2Qfq+OEmGndN18shQgoybyvUn1VbH7Uno4Ld0lSmWvvZQ4Kw9BA3
         A2aw+aOlnbfaRJI6CAJ4UzyR7GAw+uKQYA+sHceDVenlXhpg1gS+EPOGz1K78wf3JYB3
         WTmw==
X-Gm-Message-State: AOAM532/xIBvjmM/9Cu3kat6zOXr0dlmYKvoip2FYC1oB5DJjU3kWqKJ
        3s2zbWM2kfT65wzAxDB5VDG3PuWq/iG/5e9N8KlV9Q==
X-Google-Smtp-Source: ABdhPJwnO7GDTOtyL2kiFe3jVfkqBAg7nq2J7SDhBgiLgtUefNePgtYaoje9dfB2Zk33EfyfNamq1jgS7Fz6Jg4SKys=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr2117948ljk.144.1590558559281;
 Tue, 26 May 2020 22:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200526224116.63549-1-colin.king@canonical.com>
In-Reply-To: <20200526224116.63549-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 07:49:08 +0200
Message-ID: <CACRpkdb7s77aOnQxMQ=Gi9zcy_fz37PZ5E3+vk0=P5N8wjA6sw@mail.gmail.com>
Subject: Re: [PATCH] clk: versatile: remove redundant assignment to pointer clk
To:     Colin King <colin.king@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:41 AM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer clk is being initialized with a value that is never read
> and is being updated with a new value later on. The initialization
> is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
