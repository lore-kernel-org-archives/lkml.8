Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B63C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79E22192A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVQ5osqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgD2MQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2MQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:16:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A6C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:16:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so2394928ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4hDIJCDKgb4QJRH77lrv/BKKESfMFPpw/eu45ndVLk=;
        b=jVQ5osqfPhLb6kqXlke+Yq5O5jpAUgnjip18N6tStX3o84+RcoTxisglPe4PdlIC42
         YsygTr5CONv4uSYE44kUtuerR+Zz/kyRN3uGKGmUBUvigC9t5umI4z5T44PBdVtR+AVx
         PGoCNKCQ92iEaFj44zvVjG9i+DQK0lsFDK1Ggv0J6e2qZUbG9ZsKqbe7eEKtCLIM85Bv
         bkDNlR+QiEj8SXBiWDEfclrL2PGfRrgP3jZ0sC2yuX7AFttD/xdJirC0qaq+oF2aYukF
         moWBReBCc/T734CNF89iyQnZ3TB69Q09w2FyCmBbD+37GZ+U5HMQFvfC1cewRuraY73n
         a7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4hDIJCDKgb4QJRH77lrv/BKKESfMFPpw/eu45ndVLk=;
        b=FusjQ8caXWpXEvY/HSyjW8E9wfaFZdhr/fN+RS2nwa60loOJq1O41ZfAsNd6Ozq3vL
         dKqIWexd8NWAxnO80wHc88H5cIZ+wPI1oopIwydAz9yL/3bdS6pGOyLVFKmQR0quzgg0
         FMkTLFJIUmN36rWHbNsTuk/RaiiQStxng92eOOAdEPVjl9J2tXl86Rios/5Tg+GJvw89
         fsFKrY+JtS+WD+f/0WTbSbEqz52BTh0mOAB4rCGNvXsltWD9cmrwcbCXYBu3EvgxmJdD
         lcu+Zhz9wUzsGmyqCKOVPwxR3NZO8DsQO2K89XKClLOgB6sdeurPUH4K1VU3kIiBQkIf
         9x0Q==
X-Gm-Message-State: AGi0PubnjqDzdSc4dp1XbNNoebpa27sSRszVpL1If4R76dP0Vbqs/r95
        fKSwUBPRwKGGX2Qbk//ZcOQfmGKthzi2/otdDFVaUQ==
X-Google-Smtp-Source: APiQypIGpYmRMV8dUpi/6uObL1nzzISH+8h5QWHeAlSd8ihzU1MAcUwAWx4wnOAGosmYDQxx8rxVeYSPGbyBjrReLSg=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr20188195ljo.168.1588162577327;
 Wed, 29 Apr 2020 05:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
In-Reply-To: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Apr 2020 14:16:05 +0200
Message-ID: <CACRpkdbHAFiarn8Gn618cuMZpyEkPBkzDZO4-xR4hYd_jNXKdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: Document proper return value for gpio drivers
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:24 AM Douglas Anderson <dianders@chromium.org> wrote:

> The legacy defines GPIOF_DIR_XXX are only for consumers. Document the
> proper ones.  Also: don't use "_XXX" since that's harder to find with
> "git grep".  Just list both of the values.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied! Sorry for the historical confusion.

Yours,
Linus Walleij
