Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD53C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA88206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNJoSElR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGWNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGWNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:05:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A5C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:05:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so6237885lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FpACHDz7a5nGjx+ioBPQb3KC4um/vnAQ0sQ8picRFg=;
        b=jNJoSElRtW6TRlUUAFLNiJvnE4zx/7OVBF8askmtfvQai1P2CRuqKVL3nnvucgi+5H
         HFVnsBZ/G6+iTn37mqkSI0eMY6EdEbdMLlapOTRqEIS6Of3vUMx/DDQV8yFX+sdTrRTF
         pd5MdqyhstCYcD12CgoaEIYQqe4uvK3pdUeJ3SG8SjKiS8mm/Vwip41YPCPzU/VBaQJA
         IFDNqD4Hidhu1QyWhwZVUXvW3v46OWczFvre3KRVyMM424JwG/kuzXg7BOjwHaG9cANk
         fFGsKPUjcEiE2w/FBMPE8awwpczCqy2L9obZ7CVgOKEKMA+jBmrJIkwNmgRwyQAQtZYE
         oCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FpACHDz7a5nGjx+ioBPQb3KC4um/vnAQ0sQ8picRFg=;
        b=h/mAM7YH9N3JXkdFhrh6ZLhYJDEKjs6tqRdwmqULnWMgKHAjm7dwRhD11hT2bRvDLL
         286BWNvfvjbk9PHXB8IatOr2rznCbwBep4F9wYxEz8yZWvs5IBkZY2qi/U4FsNpx5E6R
         F4OH6oUz/ZvFRjhtUeZbYntCWlwTESv4s78ZELpkLlsqYg7L/342YIEFCkoEOBamGO6+
         gHJoyWAEtVMojtSBQntqk7Wo6DIavdnrUHSn7J7RwKlWMWgk8LtJJlWO/iaMy9sOedFu
         vV1dBaxhhJUDY62VXIGcNNQ53EMTUcnHXkhFsCLkslPPE2yDQmhLKdIXUHJgkvguXUYw
         7yiA==
X-Gm-Message-State: AOAM532BuSFAOipHSXcHILe3nbhFubz2sNV44d6JeOXZFIShlBoEqMrg
        VP/Qu6z6xbXz2rHcRsUl010+hoSglGf+tc1PxNhi5A==
X-Google-Smtp-Source: ABdhPJxfHkQizZ37pEG7DjUxGsmLG10G2QP4JxXEoZC9O52R1JG/5dcJH9zenEjR2Bk7BSxv3j8ALDBTNQ4lV7d6Kf0=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1802676lji.338.1595509553155;
 Thu, 23 Jul 2020 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200722120755.230741-1-drew@beagleboard.org>
In-Reply-To: <20200722120755.230741-1-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jul 2020 15:05:42 +0200
Message-ID: <CACRpkdbqW4FkHx0sBrYEyvpUwrDnyEaMHT7hBbKzSa6URKhA8w@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: improve coding style for pin config flags
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:09 PM Drew Fustini <drew@beagleboard.org> wrote:

> Change the handling of pin config flags from if/else to switch
> statement to make the code more readable and cleaner.
>
> Suggested-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Patch applied!

Yours,
Linus Walleij
