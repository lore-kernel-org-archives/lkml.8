Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88135C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0202082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nhpCMmzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBXPkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:40:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44357 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBXPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:40:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so6802956qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47iOhlCxIvZW9+7in9WkfHrD8gQa04rmWy1vaJpQmm8=;
        b=nhpCMmzXTP06oIMPXsOHP8cFVxa1GG8y12r+Ag708ugAvcaNc1HNpRByNhzKiKtz25
         iqtHyBrf4+Mq+54u/EILLssOQ0vRy0IHvGnFZ8b3DBoxnMzpEJIIpq8ppa80poQOQIvi
         P2aDlp5bc9yP07NnbS/vldnoi0BlVPSMNx9c/9Cvs6fmmtwjaXzZp4ON6f2EyNs678YX
         BvJDQTD7rAmAjLiBcsI+ofRB9N0wS57qObL0bDOzIpp+nnPxia9Nm/CZabjRasZ1GvGC
         LCPxSLehfHOuhzEfRrFWXew7AH+v6Vc+bvlzpf9AKt/TpssJN8F4MlK02CUo76ITop7p
         DUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47iOhlCxIvZW9+7in9WkfHrD8gQa04rmWy1vaJpQmm8=;
        b=jj1FTfcGjpePpkkvFPn5dvAQkg2rbIV7jw3K8eY7pl5rM/jtsKFHF4B8wdNUATTQHc
         gnzShFS7/wZPAxVBvnYoNxiS75p+UP168suKILhEK73sDmwxN3FLmjOAl1QadDT6GbSm
         Q1xKlTk/aB70YRJgXOW2P5J8bR2skTZHm049nkCuFfBhy8djiBF8PCVxt3NPjphUoerk
         QH0jWrqAIMHEjm/wPxy1Iw1+UN76e+bAI5y7jFgV64GcsFxDKicQJX4FkEbOd3qTUqq7
         sCpHj6vttm1OPKnKXAqrSTmYu0CVep6T9XbAxWmODH2JD+RcbhoJ0/4oIuAw/dQgzaBW
         4spQ==
X-Gm-Message-State: APjAAAVh2XO6hgqb8Nl+IA/bytui09t5lSY0qH7v1kRLARIu5rpVY1Vj
        B8QuZIHAO+EeuOpSRtm7ViYiURhvpSOsWsvAb20afw==
X-Google-Smtp-Source: APXvYqypr/EHRObXYlvHETGtzj9Nrz0S5jxVaSq/bq+nfO+UkQmRqi7ndvJs/03ecGTxNZWDkmiAir9tfqItTHtW58I=
X-Received: by 2002:aed:36a5:: with SMTP id f34mr47141247qtb.57.1582558823797;
 Mon, 24 Feb 2020 07:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20200221222711.15973-1-robh@kernel.org>
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 24 Feb 2020 16:40:13 +0100
Message-ID: <CAMpxmJWzPu2DWmVK4e08+0o9HwyXqpQ_i=i0MxAo+6v3-q0YAg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 21 lut 2020 o 23:27 Rob Herring <robh@kernel.org> napisa=C5=82(a):
>
> Fix all the warnings in the DT binding schema examples when built with
> 'W=3D1'. This is in preparation to make that the default for examples.
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

For MAX77650:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
