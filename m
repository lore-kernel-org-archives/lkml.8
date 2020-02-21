Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B3C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8020656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inQU1Tfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgBUOoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:44:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34740 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgBUOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:44:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so2463941ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxyoG6nAOs3iDcNS4Z1SWTTrzy8IIEIHsRCmOX+8xu8=;
        b=inQU1TfpUZ0CBu0amQil1sCPaEvQ1X8UG63hrSvoCXKC9OkJUw4NMr6UZu1quhG+L9
         m8YCxsLYKkVSCb89IEHwGlTUj0tH/crnSogq6yuDyx0qPbP6ihLIMc/zM/wz7Jd5bfZX
         xqdCioCkyRNOG+0cX3werPRMLlItgEq+fIuGgib/XzcQgBpWVVecshjDu2aNJLc1l4yi
         TTCnHBUb9eqLDB5NnruRQGWv0DiUiWCHYv1y6fdAC6syv9Ba0POKaArPytKmQVSZhyHN
         9/f92rq53NN4462mByG3m2loQLus9vC/HY17sDr+Eczq05z38i4HtQGxUAhrVtZtf5sz
         50tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxyoG6nAOs3iDcNS4Z1SWTTrzy8IIEIHsRCmOX+8xu8=;
        b=EEzIzRfDAAatQdKcnmrwE69RqK8oU96W20Lvl42ffit2019MobKPePKVXqTb2p3iPq
         yi4wFQbmPIWGzw3o53ElBgA6HTUm9YZ8teVQtXnwgj3HvSE2rX8XTl5VUZJLfFTPkYJv
         ntKVnPNbV8LVf1+qwzQKizixcyif5XfEvjkyGsgc7XZySSQFnm8g91A996Tzyzn/CFG2
         ibb/n4CO/MyvPQmb5qh//W/HQfOAvcwtyHxthAbOotconIFtvAfrZQdy31cNqkdLOslk
         jxZ7v1F1SjO5JNTWmqqU7nNtGxKMafPm/ZJu8tV48JtykoY4E4wyh1nbRUXVxyU2Hldf
         fy+w==
X-Gm-Message-State: APjAAAV0BXrsMvLlY5exBuN0E0yNOyUSOVeSEBhJuu/89nywii+hmKaS
        euXhOX9T2RNryxixO4/kUBs7wJxNcf1Re3wMzWjUIw==
X-Google-Smtp-Source: APXvYqyb3t85xjKPwhD4gyHOTimxwHuO6OJKXBDhsaLSjnAYbEB8tiQngZaDfestVaUMXo0GwsmKGj6lvPD5AwNsoeE=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr23189523ljc.39.1582296238375;
 Fri, 21 Feb 2020 06:43:58 -0800 (PST)
MIME-Version: 1.0
References: <1582012300-30260-1-git-send-email-Anson.Huang@nxp.com> <1582012300-30260-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1582012300-30260-2-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:43:47 +0100
Message-ID: <CACRpkdYuC4iiuKrRWnH6Rrr_AV+F54_AT9X9BdktPaaie5zy3w@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] dt-bindings: pinctrl: Convert i.MX8MM to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 8:57 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Convert the i.MX8MM pinctrl binding to DT schema format using json-schema
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
>         - use uint32-matrix instead of uint32-array for fsl,pins.

Patch applied with Rob's Review tag.

Yours,
Linus Walleij
