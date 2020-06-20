Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E17BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E220836
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWmHf50g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgFTVfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:35:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46823 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgFTVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:35:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26so7511994lfo.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+9QHb9ghdIy3+7pfNpTLxO6P2BWg5e6MpFuHAr7gQA=;
        b=yWmHf50gZlST9gXFNybUAWe6FVywTFE5PUaafxbJ/1epTV0n+Lv+CpSwKOg1RuQf4K
         BwifKjuxExz1QXAUp6i3sPeIKKMCw416sYVuOUHMGy/29//ZZq15vrTSJxbnc6bKNJ0G
         QTyaGW0UrCqFXq8mLHTGFcRsQVmZW6+Dc0JjPBzPXys4RgobptufQsi0EgpjQvWRi12Q
         ICJ84NCYkJ4XYldpNVIEac1hE4h/aaHAj9d7fQEPIbyjB7FEApSRhFREVIbIEThtDTEh
         Pv3+NilD68wnMWf8PaAVKjjJDpgjze5uj2cfQmrVmqkVbxAbNSDe+OAOnxGyWU5MAsv4
         OZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+9QHb9ghdIy3+7pfNpTLxO6P2BWg5e6MpFuHAr7gQA=;
        b=pTonz2fOtxRBIAOY8G/zZNsLMDg71TZ+ke9hm19OFuRxRLEU7Ikn1E8cRKwmb1TbuD
         2QhnL1Nt/GXjPofXSltP1xI2mqMsuXdu0XCxF/WLaAqyTmyfHZOe32H6zsSCB7efnxs6
         f6mxklYtiQu72c8DGIbEOXGkQhiU7oHiEvvQY08Tu0HaveYaxroC6N9troH0NEKMxsKO
         yrWlfUSIq+oALE8qZCrCtc7lZ0FStQQZsVM0cglCQEve7Dy8J3QM/khqTmBxVXYObNqy
         9jdTSw4655pdo11l+k9NbjUvZy3GSUe8+5T7noOqsxfv+kamSLXBAE8ZxjDavbezi2Op
         3cpA==
X-Gm-Message-State: AOAM531RP2f5y9g7azD4hXidOk3kBUpISSJUsofcqmb3sLg/h7TTiMyd
        wdRcuwoUkxTocNzuoOvVxApcQl57qAFxed6Q6LyGEQ==
X-Google-Smtp-Source: ABdhPJymDZLDq9jqFxfQFsgfJoOmYGGWijE0qWUIwgm6/kOFKN6HrfPAS9IzTxrDiH+cm72wLGp2koofZY5WkcS99zg=
X-Received: by 2002:a19:7407:: with SMTP id v7mr5202141lfe.4.1592688874285;
 Sat, 20 Jun 2020 14:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200618073331.GA9403@localhost.localdomain>
In-Reply-To: <20200618073331.GA9403@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:34:23 +0200
Message-ID: <CACRpkdZm2978CG0z=9eZMWk3RpOYzjtgFZ8REj1hZDBE7gwHZA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add entry for ROHM power management ICs
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-power@fi.rohmeurope.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 9:33 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Add entry for maintaining power management IC drivers for ROHM
> BD71837, BD71847, BD71850, BD71828, BD71878, BD70528 and BD99954.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
