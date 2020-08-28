Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A226C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2436420825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEEhM6bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgH1NEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgH1NEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:04:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1106CC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:04:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e11so1214331ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY6QohH0kHOg+QzN8imLnNqmKHUkcybm8RndPGRcKBY=;
        b=hEEhM6bXCEN77L0tGNTDS6zmOH04mOyuhnqNM5uPZYN0gYXTGXcdFAqeulpAUvxcWh
         DCCXZNQm2W0N8pG5Q4oIUMSHcG+kSdHUexRSjlZzGNpsRL+09rLkUl8e9Ty9YRfA8xg/
         zsviZhnOWi6K/8Se0ecZs49+o1JpUI0ouq1tOYIBK9lk72V2kJL3oTdKTp7G9JLHHmCA
         VJ/Py+m0DYy20mN5LcZ9yqol6X9R+XQ9ZjGCIZvBAxdw3UZj0mnfSalWOQd4EIPK36wE
         c7pd+QX7k2WKJoKBmSKL/j1M50mHmPityogf7HshbDgyYj4WAlQiauK+oot7jpk5Wut7
         R1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY6QohH0kHOg+QzN8imLnNqmKHUkcybm8RndPGRcKBY=;
        b=buuCyD+pwlpyDDq63Fi/Z1l8JPFn2g3t8m59lx84RZ6J9121+1dtc8S77DoS8nYTJT
         JXN9GXo5oiZ4O3i1aplaqs030T1hIuZANok/Ur3+tyzSuT8pKVwzx2yltxgvnOPLGHW6
         YC3mW1hkjxYJDd0laS4msLBctiBqmM+Kqy5/9zM7Ci9CyOCGGrImphbO9skN8kgCXgyI
         bYOVpsNyigKfMksbM2HjF43VRdEuI1L8R8rrWH2FwAJCfQdawKFQnN8P/D6GwiLMH3kr
         ZfXozX+At0Rr1lbl/w5JDbGfBPVdHR9xPsyUDueIlddfn9dhLzGjVpwJvZ9OkPVkCD9s
         UhtQ==
X-Gm-Message-State: AOAM531X1tbz7mTvM8lR5q2bOnXgBsRphWxE3wpaB2re+ZJt5Bc55DUy
        sgSJiClv/i7C3StGL9HIkLmyFVNcxEcB6vAUxZ/jxg==
X-Google-Smtp-Source: ABdhPJwsd1zLLYUQfLBwKIUDzPngm5BPAn1Oi62bpRLI87FQeo/xi46FUBxuYdvnnmkfHALpRVoAob1SKb1fomVrKmQ=
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr772794ljc.338.1598619846247;
 Fri, 28 Aug 2020 06:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145153.10444-1-krzk@kernel.org> <20200826145153.10444-16-krzk@kernel.org>
In-Reply-To: <20200826145153.10444-16-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 15:03:55 +0200
Message-ID: <CACRpkdarHXwpNfVqODTn3ZZ02W5GTfynQDL3=Y+Mg8ytY8SOvA@mail.gmail.com>
Subject: Re: [PATCH 16/16] iio: magnetometer: ak8974: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 4:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
