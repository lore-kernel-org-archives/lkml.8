Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D150C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ABE20728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DppmAWrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgEPJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgEPJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:38:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0737C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:38:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 202so3856609lfe.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHmw4w5JEiE5ORUUkfCSurvfpTUlqUQrUJG2AzzYQ1M=;
        b=DppmAWrU75NFH2IFxxnS77sqE8wLtGku2N6i3Y/3yUu5EFHK08UmkR22QRrWU58Ngf
         Xv+MUMZH8B/hB4sYuDMMfMwg1cQJNeZRiKgsvpHUpMcY4VGutwkqpjKGpxojnAY6f+GG
         NnrtQ8jBin5gf1yBf+Xf2dEQArLHY5ldTEUaEMd+mRQph9Ulv6ZDyKtSzBgsVqqq2L/A
         kNPlX+XkUtynhKPRhgXXchXfb08k3t6eeJi3I2OoxzmM5fdwaQD24JtzVQ3SOxpXRs6F
         DNNvF8xlkTejQIGceaFFOCh00vrsNj+9o3aq7eD1sQmiKiwT8Fj2hGX1gVxyMCHkUJtj
         BBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHmw4w5JEiE5ORUUkfCSurvfpTUlqUQrUJG2AzzYQ1M=;
        b=d+OppwzKMqeWxDM3BRIgJkauRsVTD4o+Dd7hRaxACSQRIf1uK4FamCHgFbyyf54Ms2
         momM4FNVjfJWcfvZ50Fve9qyZBNH1qBgiiY2YbDLa4YpxOw0EtFDY3GUR77M+1nZLr4l
         AoOMgZA2VmTrokSb2pJxJdw6fl+Ua+IBykaNtRXr9Ce0tDluq7T/IXYVA0aTy1qEsS1c
         MSm8vBhrUKSvZBcx48+9jalZzXmMyqXgEx5TKWfD5XTU3UGAagNU8UFiwIn2pM1Tb4fT
         G3+7t6Z66yO+yh3er5KxukUjkGJzb8Je3A5PRIawgmrJIpBDdc864frhiSvxmpim5PQ9
         C6FA==
X-Gm-Message-State: AOAM533vq37kLrIfAeogl9tjHfNkK7v1WXDn1gdJjL/m2apXasMNt/ml
        NEFe1tT/CLdUrUQs+zzUjYa+o00z24psO+I/U6XFog==
X-Google-Smtp-Source: ABdhPJzvOQYUwSPgJVbH714U6jTmUQp30DtEaiw0gOF4osugn9OIRVGIimHqGxRyFV+DWuX2dXBR2pI1BQ9Fhvlzoqo=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr789130lfn.21.1589621888936;
 Sat, 16 May 2020 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200511101828.30046-1-geert+renesas@glider.be>
In-Reply-To: <20200511101828.30046-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:37:58 +0200
Message-ID: <CACRpkdbEhcF-bGfM=ur-M3eByZ2vPhZqofMwxJ+QQS1Evhs62Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Document that GPIO line names are not globally unique
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> gpiochip_set_desc_names() no longer rejects GPIO line name collisions.
> Hence GPIO line names are not guaranteed to be globally unique.
> In case of multiple GPIO lines with the same name, gpio_name_to_desc()
> will return the first match found.
>
> Update the comments for gpio_name_to_desc() and
> gpiochip_set_desc_names() to match reality.
>
> Fixes: f881bab038c9667d ("gpio: keep the GPIO line names internal")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
