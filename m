Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8637C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A023206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM1y7ppA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgELLgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgELLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:36:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:36:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so5651374lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXz/yNpIRm2hDyqmY4LrwoICA7tFRRtqLeIZr1n4hgQ=;
        b=fM1y7ppAF8YttAacroZbaXlkzyGSPLl+OgOaC5PI80aAlq//szCR6WCR+YmEseJHeM
         RCovVooARtxTCuzJxE78pnLkF+rxy+KN66YghG//4UH7qw/lwT+jw8WAD+e1AWN9zLH3
         4/QAM4K0LeAubfe6R6CvOYaR6KEh2FpZyZa/bSvfNA1T0j6wB4RR9mhr/yPym1VeLjaB
         h29YNU2KunEbvBtnCIPwL62rA5gAq4lVMz3dQ5RwApP2OP5utjmpcGTqCxIFo6DRc3sV
         qiqUsFfo4/dl+0q7sToUqEE+EPzz7qT1/LCzAY9MjPRlmZCzc3FN8v+PG4RQAy1phDxU
         9N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXz/yNpIRm2hDyqmY4LrwoICA7tFRRtqLeIZr1n4hgQ=;
        b=GlF9ouGvM6sNKWdOz6c87rMGx54zyxFWjavTcIGnunlPzbBCBZN34Fu4KJoPPuDeCk
         VeP4+IrTHSyc6+rYM5lids28mX+gVGde84bjmTni/zKKc4YnrLjCFkGYwBW8cZOtXSgw
         dP+T9AfPQbolRBkSBYE7Or51aqIyG8FjbPOObo0LOr+9K4bipdVYS3k2jJ7ipDb3/XaW
         P2TE1uph3f30aVL+tvhv8dPjxV/MFi5Q8GhtLn6134wIJox5eoOUY5hlCXjoKZJDR+SI
         1errC0wcrOy/jVQTkasg+QqPeJsIh9QOOgERPQcVmHykQ+A8smSanTEktSiDtcLI5VHB
         vjLw==
X-Gm-Message-State: AOAM533LgfXfzGIK3MJoEFyc/8ymM8TVOCOCIzVon2esq+OKlwoqumM5
        Q7y04ABgnHH/tQ2ETY4gVCpe+tmHtoyUx6vjm8dgQw==
X-Google-Smtp-Source: ABdhPJzU/NpqzyTWWkbOeLhtKKqfDcF5gMlrXxanCv0l4ELQ+8+totfdERv7xwcOZhjDKhUfZqv4J22pNOhf8IEToTg=
X-Received: by 2002:ac2:5588:: with SMTP id v8mr13910730lfg.217.1589283372423;
 Tue, 12 May 2020 04:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200425203813.6442-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200425203813.6442-1-rikard.falkeborn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 13:36:01 +0200
Message-ID: <CACRpkdY0D7sfOW-pvkH1ZeF1O06+TERyO45cc=vrYAN-=kTR1A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rk805: Constify rk805_gpio_cfgs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jianhong Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:38 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:

> Mark pin_cfg as const, allowing the compiler to put the struct in
> .rodata instead of .data.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Patch applied.

Yours,
Linus Walleij
