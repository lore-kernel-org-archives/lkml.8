Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE139C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD39D206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdKMJfCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGGMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:02:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69379C08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:02:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so15295530ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUQcmH93QTvDmQbJjZbeKzTAZa2pMU0UcSehpTBZctg=;
        b=jdKMJfClPxp5TF9uXx+oqo8TzEc6Evdih7SMSA2I6rJNR+F1Acvu8jU0XFIM9eVqUp
         KqgqVb0skcKLFN0doaEQp/ez3Gidgorz3AAS+62/U6IcGKh4vMPslYNvWJuxZ12L0HH3
         xv3iA6BcyUUcAUzwdMT4W+Bu7AnjghaDV8T4XEjCIsIUZZKe9/GYmnQwKLjVqEc8cUNi
         YMZv0gKiJTEHFkj2K7KluUEt4HnY9MkunhOZzK9ReG69NloWB5yu6VgYs9cPctmcT16H
         9xbQsU46cV7Jw6OQNDnVE7KDRdED8PO1EU3/hGeLuImjfg7Hylsa3OhgyLksRcloKCH2
         yXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUQcmH93QTvDmQbJjZbeKzTAZa2pMU0UcSehpTBZctg=;
        b=ZiMbClsl8qr/sQuzYKXAtsgxnK/SjJcrJlZrCMswS7dLOxwlELBuLj6NrKPbe4rmQc
         TZPAg9uAToG6xrJSpsGIPSLtL8gHzqtyElbPvfUdSFE3z9qEkb/aDgzQlvb4A3fVv7iE
         6PPx2eBdr5blRwg7BScTiktPqMElvwPeXsci02O8KXoiyqehIjWvLjQhK45WKNs7gVwz
         1FzIOu72G6wEzs9MwfLMxsKQ4B5uVq3DkNT6i6qFTJS2A2sCtcluBHRN+wmKJW/8JsiC
         EMCFdhnChPL480x3cWXXDY5D+Yh1rmTvZoC+A8+atAb4CUTcN5l9Ya2U0YgaIpgT3Shw
         Sz1w==
X-Gm-Message-State: AOAM532orfmydGMn4wN5YWyjCgvQOzcCdVkupRndh0Aa5VslTgzy8pIo
        IZb4bZcpyVIbQNNUCqtkSOHm68IvjTV5dcDSz53IWA==
X-Google-Smtp-Source: ABdhPJyoQQmnEXRQsOssY6B//fc0bqu3rkaC2C2dVvGuSLi6c/sP2pXenL4tDe7adDzLmfda5EnD2c4fWXfZBhH7QeI=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr14058132ljc.104.1594123356768;
 Tue, 07 Jul 2020 05:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200622192558.152828-1-konradybcio@gmail.com> <20200622192558.152828-2-konradybcio@gmail.com>
In-Reply-To: <20200622192558.152828-2-konradybcio@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:02:25 +0200
Message-ID: <CACRpkdaBxYWKcm6b7HGL5XuyfjSVtV3ck4KE2q78mdSixqC6qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] pinctrl: qcom: spmi-gpio: Add pm660(l) compatibility
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 9:26 PM Konrad Dybcio <konradybcio@gmail.com> wrote:

> Add support for pm660(l) SPMI GPIOs. The PMICs feature
> 13 and 12 GPIOs respectively, though with a lot of
> holes inbetween.
>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Patch applied.

Yours,
Linus Walleij
