Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F7D20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phqDGApF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGKVMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgGKVMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:12:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E750C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:12:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so10381465ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgHuk3yasiCaHOFp70C3S20yfZ/46i84UF/qS9vnKcc=;
        b=phqDGApFNUiMib/i5ixNCjfscEjoGG9dm6nGYkkuK89crua9hH+Tw7oPeffJC7QngU
         RONlsfsM4KQjjbP4mPDj9QElR/qCsD9yv/qaQpjBCA6/oyONnMwuRKN7BB4cC0vhIiwY
         kyAqCwFYD67vTukOgwi4SAOOJ3y4bWgX75+0NHKHaTOzQU1EfVepNIPR9OmInGdCueXn
         tgKw5T5UbQ3RnhfyKVS6CypNrb7d2z6WvMAaa21KH/66WCySXG/dPzbDMW17AY9luj2q
         ttE93UdvI29dJLsLDydAdDP/Ugx2PXg9S+F1Ay5326VSHypR6iQ4rRYxyLTwY7LgiIuE
         ug/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgHuk3yasiCaHOFp70C3S20yfZ/46i84UF/qS9vnKcc=;
        b=rHsvBAomf0TXUgjuh1/G5DRWHqyFVvz2xlhPKb4xmJQK9jdKcH5rOm426RPZzJ4u1/
         9YvN/smkPT4bj9dlwJlfsehMwlOCejK24jmte+tP1dmdiCInfRuGWC378nB5rDvM4eul
         Dmb8spRIa2XFoz9V1cbffAX42OXAcnc2cYRA8rcYHwywLoaifYqVux/6tKVdrtFeM4iu
         IEGd+P2KCON9JSWgxtcrPWtVrhPPxqUxWmjh9XN9sPTLYJEShcMSwtjxTS7LcWufpQ1Y
         UX2yXI2qug+V2Uz7hJHmVleJdpgJmN0lc+f48/hG+fEAjUYMWyFTyyxjURru7l4ut60J
         aJwg==
X-Gm-Message-State: AOAM530oEyJfXN9uwTV/bF2PC+00GVjfWN77XVP5m+2LwgEGzZyijuLM
        RSEEHcFETSqusFbrhAaSg3lF0Ak/E1x9WrQYq2HjRQ==
X-Google-Smtp-Source: ABdhPJxfLX8yHShpQtjGOPNlAosmEBIPTvGmPBymA5g4mnnwVTGmE0j69am4R1NGfe/2Nhmcd1M6BuIbcIw3m1Dxgdc=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr27868119ljc.104.1594501970063;
 Sat, 11 Jul 2020 14:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200701013320.130441-1-drew@beagleboard.org> <CACRpkdY3mUjczkJhV9BdZhUJGOgrbOMJnciBjOaPg6c9XUt8Ww@mail.gmail.com>
 <CAEf4M_ArGSpN5-7_zt6mQaWm8XkqTcQiOnCbs3_obCipDC1KNA@mail.gmail.com>
In-Reply-To: <CAEf4M_ArGSpN5-7_zt6mQaWm8XkqTcQiOnCbs3_obCipDC1KNA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:12:39 +0200
Message-ID: <CACRpkdZRnS=xt6FKy6pSUQ+itkxoimAAKBc+=kupTXpEGg+b8g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pinctrl: single: support #pinctrl-cells = 2
To:     Drew Fustini <pdp7pdp7@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 1:02 PM Drew Fustini <pdp7pdp7@gmail.com> wrote:

> Which repo/branch is the best for me to use if I am going to be
> posting any further dts patches?

Mine, pinctrl devel branch during this (v5.9) cycle I suppose.

Yours,
Linus Walleij
