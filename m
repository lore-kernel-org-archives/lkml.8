Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE1C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B183220873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLUgkHzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBNKML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:12:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33661 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgBNKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:12:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so10101974lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/5McOUUnXkz5TV4IlWVeI1XmlL+DpFYRw0CINAYScQ=;
        b=fLUgkHzOqlwaE3VlTP4Op2nkxi0KRv0MOenWKTh0mQClY+REpbsfoDkuXEZPyqtNrw
         9QIEsaMfX8sPPEtVzv9av3GmwtKM5VFT/SBkztS/hASYB70MCDqzWi/ILc5/AvkJRpVf
         Ejb0xPHtLEvyUHvK9lbz3QXqmS3N4PMlOnekvvfXGRvIDAtiG6542trqEuj/ym779Oq9
         HP2E789FrC2/F9uCc6EHGBU83G+vzvmUPJs1GjZHcLm5rI9wKs0GM68LxlWCSWkK4Uqt
         vTVDViBC0lNe/od8DRCisjs93ESesDeKq5kV+KCn9n1yAsX/hFmQvvoi2btq3/4ddw/J
         0HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/5McOUUnXkz5TV4IlWVeI1XmlL+DpFYRw0CINAYScQ=;
        b=tUwgWh4YG4G9gZczQSKZLWHh/HALyWRDc7yV1AJGTCDVcRBlDrm74jcHuUbQzRu1xx
         Ro954og/NdI2rc5K4ClSG73WmOilT+RYyzmh72dbc50UFu841vc1XQjrUXzWfsioMxMh
         AthA6j43brU+V5sjcqexJ0XBji2Yu7bzjaS5GOCr2+nNxP/n4j/DgRypZJ8iWjU0WZYZ
         z3OYdqpGG3Gb1IjIpZvPvEKCyIry55vMHRrwVUegwfvSwVf0adUAIHIHB668Edj3ZQSQ
         1UWvYnWGTokt20reKWSEY82dYMRC7UqKkH6uaTgI520lz6lUsUXfZ2ub5rXqT9CJQHbu
         t19Q==
X-Gm-Message-State: APjAAAUfY7COtvLrLKTsToNOj5a0aV/FMcNYveb2ATGpLmcXIr+CJAeh
        Bzt4ckoeglurSwwtp5GAEJJOxXjrj3dt5iT9yMt4og==
X-Google-Smtp-Source: APXvYqx5W6d++0Ze23o3nm7N8ujD1PLvR+HH7gGi4r46FL5nZDlL4gXm2GtaZSzkWtQqP2oZDZtjhYbBcC3ys1izZjI=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr1661917ljg.223.1581675128492;
 Fri, 14 Feb 2020 02:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-11-geert+renesas@glider.be>
In-Reply-To: <20200121103722.1781-11-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 11:11:57 +0100
Message-ID: <CACRpkdaKu_QhR9cEuvVRux38wJS8qYt9LA4EqE-XLreoDfCvCQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] ARM: integrator: Drop unneeded select of SPARSE_IRQ
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:37 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Support for ARM Ltd. Integrator systems depends on ARCH_MULTIPLATFORM.
> As the latter selects SPARSE_IRQ, there is no need for ARCH_INTEGRATOR
> to select SPARSE_IRQ.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied!

Yours,
Linus Walleij
