Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0CC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFC6206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5Udw9bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgD1Nt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgD1Nt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:49:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DACC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:49:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so21523441ljl.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8+fuPYkH+puLBJZrUcKcisDj7x840mOx2H/AXTSfXc=;
        b=p5Udw9bpsNiJSRMg3b5y5IhL8YEuFQwO5OsVib3uyjXzhkWGcTlaHtkl3R1HGV4DQ3
         rJl/fnDPJTNEAhDESkXnBYSglWuOOHsQJj6dnYzUkWY2FxQp1kgpJr7VsAPEuQPO+m8a
         0hZvMw8Wf9iE8FQ/CNrOYlPIiDkUjzm37NJ9yJGMQ63KBIcaM3FU+xbGGyw6N+TMOcKj
         CLWt/ZVZdFOpw1VOaM8dUExw/MT6GYZ7Rve+ZabI71dn/3Ryx6XJtAb96ekMVBUdQX6m
         nMlX3tlmq0zGcOHTw77PvFxF7F6NggrItFv/aSZVtFp9D88403vwRShnXvCTKMsSRwEA
         vVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8+fuPYkH+puLBJZrUcKcisDj7x840mOx2H/AXTSfXc=;
        b=E18yMoiFDoxqzVQokIC7Kq8ake6TkJ3O+Y1/LDMHZrUBa3nUxHlJkbajZTGBDa0HF9
         0kI03D6PpuulsXO/xyckvlof3BuZxvK0rJ81/lNzZDH1QXiRymQ28yyO0PqiMT3ZSBcg
         6l5sR/f+nPr1jwE2D42jy0p8LxZ0oj7Kn0UePpWg0v+ybrhBtI9C75zykvhB6Sx6nhEc
         8elVZNe8qA6WvPOrbqCGMk365PAWnWLcvpBkslz5+Dw3X51Av+suxFRfS5Cbk+aTFMI/
         9XWn5pbBUJF1H/Yene8MVqcm3FrHvAgPjYBvy5r72jWeMZHpcFEcT/0dN/dDlYXLpVDF
         8Img==
X-Gm-Message-State: AGi0Pub1r33O0aaOZ6p8oMP0OVMTSdNqKPVB/FIY293cjOb+VUD+BLot
        dIewiYwaYRiIobCUQH9QXkwzZmYZRiY+7Dl0dFRvYw==
X-Google-Smtp-Source: APiQypIc/HQesVeDmCFc8wG0wY/Ggva2NZkJMawXfsozJERv7QuSkzZDCvjIox+R6iueMRpnA9xGQJce2qF7OX0/rpQ=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr17807230ljp.277.1588081795589;
 Tue, 28 Apr 2020 06:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200424141517.11582-1-geert+renesas@glider.be>
In-Reply-To: <20200424141517.11582-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 15:49:44 +0200
Message-ID: <CACRpkdah7D7b+-DBnMnh9_WmCK9qXGaA9usK-1jSJ+0nihWC6g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Rename "chip" variables to "gc" in core header file
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 4:15 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Consistently use "gc" for "struct gpio *" variables.
>
> This follows the spirit of commit a0b66a73785ccc8f ("gpio: Rename
> variable in core APIs").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
