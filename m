Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FE5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEBE2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKzltRWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgH1OHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH1OHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:07:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF399C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:07:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1437325ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXw6jts2nsYSAhAF2pX/V5F5FIEIJGBdwNqcoUzNLi0=;
        b=bKzltRWz0IbvUHKtrIJh/h/7tq/4EAfisXj8cgUQ8RM52S9V2Uo/kdjK0Da6jwzPUn
         aGTjhk+C+VS6RtNFKe2Py1DbaJKDBg+w3ntY8w1cPZoQvaws69eE4wcahbfqg7c1WWNC
         E9XkAg8oJBlMNHyuuJW+h3EG1uF/GjeycEomTAmUgcL7VEZFFVqN2cJr02jQnLArUFKK
         J92VjrcirmzfT2LsrORFVRFkZWOGMLwA9tLJHriZoMmk9LUf3recjeSWZ6QTyGtgOSJc
         KqryynlnCuFVYrylXw++CWGiHlpnFICSb7q5xX3P1B3k5XObSKlLKSKSaz1ekI93SPat
         YlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXw6jts2nsYSAhAF2pX/V5F5FIEIJGBdwNqcoUzNLi0=;
        b=N9My2z5sQF1DHiR4lNzuS1WYJN4d5SL1yydNQM3Hvbd5epAhYAvnk8WblSQmQQR4+m
         i7usHKcQ7WazJURYwrCdfsVUnMvn/y8lx53ttC0Ox5yuA2gSfQyw08cCi1ahe4e0XsXr
         Pysm8eraGieTZ70sErKCJBV8+oj9zw2976OkwNXoQ40SvsAbcW4OySCsmsWirrQGsEhP
         Z8zrAbTH/GIwrHrpNcIiuqzMZtZlrf5WsYZJeVOyJTIzpzL96mwpccBz1E8dn59XO599
         d0nH9WHmBjNp5ThqibigUgOGy56Frdo+L3tdWUJ9fXjYNuqCrbrKT+/LqLSqivMgfCjQ
         ZPeQ==
X-Gm-Message-State: AOAM532ZWzFPJVOohRsDux5Q12ScID2rV4wmTS6OB7CPjVBjDkCesvfH
        63Szy4WkG0H2BJ0qUUEP1IFzGyX81l4zSlo9b/X0XSuJPFg=
X-Google-Smtp-Source: ABdhPJxmfPfdAg/SmdRoxRZDXdikl7Bvgy1DgMT38TnEcNwFaKqtAHmRcVdjjWguMH4j6ynYk0f7GTMzB3He0xiJq2s=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr1010532ljb.283.1598623663298;
 Fri, 28 Aug 2020 07:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200826181706.11098-1-krzk@kernel.org> <20200826181706.11098-12-krzk@kernel.org>
In-Reply-To: <20200826181706.11098-12-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:07:32 +0200
Message-ID: <CACRpkdZaS-GSpDBLXnvhsEV867b99=nh2KPWSK6eORRnKWgoSw@mail.gmail.com>
Subject: Re: [PATCH 12/24] Input: cy8ctma140 - Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:18 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
