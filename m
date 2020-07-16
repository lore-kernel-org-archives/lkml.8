Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A67C433FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005BF2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuSLav+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGPMtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgGPMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:49:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A82C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j11so6983122ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=vuSLav+Cii51LYAbUmO1o2Rs7yss7EnlSKUR20VVaxbbxAYlCtWHJRMDU2Py8c8JTY
         WKhP3yKme72urB8ucBIKLAPShsPH9qJuaUcriEuBK9Wjv8FMrcnFMZbgbhNpHDLpfeb1
         2ZUxDC9TUvSLcWYF1QnnLlRGGq+l5vEZ5VQHiE2Ik+JiWFkWFqZ86Wsve2eOzvhGL+9K
         ihffOk/HZOePmw9cpO/AebqqXNtNfd7wNPftBpKcRDP4/lSsTY8DAa+BNuR8dIOnpM5y
         thFQEosZBhaeERRBEgpmtYGFLXBddwyP7XPHXPSRBypnXeSA/gggCvyS+NkEQJv0Cvb7
         IUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=Y7f9wzarolLROu+PitR2jQiKkGuogzLFXHgZ+dhphd6x48+9MjXLBde8RWjtKBpSqZ
         Zzfq2/fKFECFtpjRn7Ociw+W9CcvRG2xEXLb+zW240pJD9LsoUfqoQYNKpBrWuukn7CJ
         bkJlTscLEeLLHjamlbhwK0XS5Zt1OT2JAA0zedE7mmmpEt2OLuX3eptSVn9gbmgH1Hek
         t+HFp2NSCbwlODuMw/VV8bwNNvahR5Glp3x+mTQlm1sEjYGoTAJCV4dBwOayrOnqDBeg
         X6SiSBwN74AV76x8HHHnuuuxB2smacWEmmTwtbQ3uyZ7VhiPGhSVvX67p2r5loJYINZF
         MluA==
X-Gm-Message-State: AOAM531WPeImoG6PRRyud8s58mSK3WnLerR4tsKKni7o52uNmsuoxgC+
        bHGlLLAP0+zM+e56Gl2P66w8ywgjWqayCZgQ9u6sMA==
X-Google-Smtp-Source: ABdhPJzZjvVBo25Dqxum0154FLbEBUp91nFV11Hp0xSDYrsQ5aSM1HddHJViEwuAP/BPFZwNurh2InaBi7wl7mxu/zE=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr1887718ljc.104.1594903786614;
 Thu, 16 Jul 2020 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com>
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:49:35 +0200
Message-ID: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Syed,

sorry for taking so long. I was on vacation and a bit snowed
under by work.

On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

I have applied the patches to an immutable branch and pushed
to kernelorg for testing (autobuilders will play with it I hope).

If all works fine I will merge this into my devel branch for v5.9.

It would be desirable if Andrew gave his explicit ACK on it too.

Yours,
Linus Walleij
