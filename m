Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3518EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E4C20767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzPE1gUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgFPIhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:37:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D8C03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:37:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y13so407715lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RA/a9xgeNIP0kFcRMvVhhdjRGSwULwerogwSj/F+Grs=;
        b=HzPE1gUPc/C6yijBergBKS2BL3NPxjYVkqz5YK+Cp3GLxIQbBpnJUmKfOX8Qnxu/Ev
         xQ4xP7abGcRd0RgEyzqM0HgrgrHjLhWA3J5BcOCKoDg7eZ5YS1BIDe9HRoCTCCGw5h/5
         ZfQC7imXoCRa4KrmcGUZdWnGlzHAf5hMCkedF/OL3lITn44Riia+SNCrn6XoqSBZsoN6
         Se40FgCH6bUFxIDJdr7t04juD9FtznG3+9DoSW0y7VzX5Gm/RJ7yebTjwKc8OEG/4tPW
         DdU0xAlzHcvFO2VIQC/TaqntOAQXeo7faQR5WlLFFdXuYdo328K3ny+FlalgJH++7Hzw
         JDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RA/a9xgeNIP0kFcRMvVhhdjRGSwULwerogwSj/F+Grs=;
        b=fvlL/h3hmZvxvtRD+Lo1Z1endf1ikeq1ysLZvLI5zN3Ry8GoWxV8jruaFNw25FgoAy
         ECt7I6rx4skWdLXD9ULxDJcHfCQQRiZKdDLE6BXBUd3WUeR4m1B5ue+BFrc9hCBAYdrS
         blk3NWbls5wmy4zsiH+ESobcMCs/BApgoCrgJ77Jkc6RLHFNSNkZo6R8ZqiXcm/xDP4F
         PpqXO+O9OS1s4anl51MNWmU//sQPQUilf4EJVAXr7NkC84PuKSsPwKMd7peY5MG0xj7H
         CNfbEyz3VgSDGRL01Xg6QtUPPHsMrFq+G9P91RsozBMFDTbzr3SBlgL78fXWuwruv744
         gHxA==
X-Gm-Message-State: AOAM5320dGXgOoxFllmXbc3y113D0WqW5sOn1Lg2cj1SZENzkX5ZvsP9
        OzUigMYVvX4Y2+SWQgpAsv+gtZsH0I5F2n3vJeVRmw==
X-Google-Smtp-Source: ABdhPJzzerD6xw0Kzs6JVDyTlC9tslnjITcT/1ov4XlDMrheqCSkjc7GIsa5Ps5UpaZ9lk0NPOIH5V95vNTTkup8gLg=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr1144061lfn.21.1592296663758;
 Tue, 16 Jun 2020 01:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200609235135.10414-1-warthog618@gmail.com>
In-Reply-To: <20200609235135.10414-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jun 2020 10:37:32 +0200
Message-ID: <CACRpkdZ9to8LRMFiGNW5gd-v901j2AsKDWKojw=f4dRaJSm4kQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: split character device into gpiolib-cdev
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 1:52 AM Kent Gibson <warthog618@gmail.com> wrote:

> Split the cdev specific functionality out of gpiolib.c and into
> gpiolib-cdev.c. This improves the readability and maintainability of both
> the cdev and core gpiolib code.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> ---
>
> Changes in v3:
>  - updated the gpiolib-cdev.c file comment.
>  - rebased to latest gpio/devel (no changes impacted this patch)
>  - dropped the patch commentary as the points mentioned are mostly
>   resolved - there still remain a couple of commits in gpio/fixes that will
>   conflict...

I rebased my GPIO tree on v5.8-rc1 and the old version of the patch did
not apply and neither did this, could you rebase this patch so I can
apply it? Sorry for the moving target, the merge window times are
a bit bumpy. :/

Yours,
Linus Walleij
