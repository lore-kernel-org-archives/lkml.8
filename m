Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D1A21D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLKc2dHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506452AbgDPLh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633421AbgDPLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:37:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2FC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:37:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so7463410ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRORy/jxNGUk5NEraICWvT2sGWL870gmeryOxUpsqYM=;
        b=yLKc2dHtJq1RomNZo4JS43LGkdULXAdQGKsqeIGHV3U/JTCec/GbOwtDu0Rl+Hoa8k
         Wh/vbqtVE+RvHyWWG7GpECyckOvUWNExQMOYud2YqKBxAr9IdfvVPFwHh2rkXoiY/Xaj
         JGPUlPbWM5DLFjRWUQkbOahA4yGSXVAsqLQz4pBrb6MCoCSwXExVHpUv4VC/P/ItH/Sd
         Xkql6vBAXyL8KU596I/EQiQj9Tal1Va7CpoHVlwX/hGW94E+jqeaM2DfTs0D4dyW/2+4
         jm5bZPE4Q4rRzePBfLDgrcmhEFYipWBRIWmouM2ZcT1/JaWjmLK+7FGD8NrYaSUfb5+8
         +NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRORy/jxNGUk5NEraICWvT2sGWL870gmeryOxUpsqYM=;
        b=JS9H2AtU8yI7aj+82HIVXBtxaCMHIbzoU/1KaPOaoRDpHb0q0JZKMpZiiCzNllyIH9
         3U1Af0jvrygy9PdTmsS2sj3XShLS2USnmnG95UN9rnNyIjl95HuntbNdLAiLbEKntS/0
         YTwgeqhY28dl4SLG5NCsbrGXhO4lYzCO3npGsRFPi+cO4kD2PkJjMhshfHiy9SAed61X
         YbagAFTH5dwAjB93s80DRW2xP5cCMi9XE963/M86j8eDs7IzhTmhmaxnSfaOavc+mtor
         k2vLdJ6gB2ANAaKQTJNrZLDgqqnn4NlGJ/S+7WYYo+yMvsH7vQKZ7+MJJ9EjOShLPT72
         WWdA==
X-Gm-Message-State: AGi0PuZmRNA672cAahtNieN8uKkTqrPzWSAh4zMA7CvEB4BJj183/S/s
        y60ndGdkL+25/d/j4o/Gf2y4hv+fyxPrxna4by6WWg==
X-Google-Smtp-Source: APiQypIdB7RtMtXusxNoGoP2YKrzJf+ZTGr3IFcncIO4Mig1DvRIRaXB5y+uXjqf1BQKyDOw5rGkPpeU5JeHSa+MQRY=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr5960293ljn.125.1587037033020;
 Thu, 16 Apr 2020 04:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200415082359.22152-1-brgl@bgdev.pl>
In-Reply-To: <20200415082359.22152-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:37:01 +0200
Message-ID: <CACRpkda_3CPy86Xm5TG37cYu6bDzLjeHPkbX_QSet8DUbJBhwQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: improve the robustness of watch/unwatch ioctl()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:24 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This makes the new ioctl() a bit more robust - we now check if a line
> is already being watched and return -EBUSY if the user-space tries to
> start watching it again. Same for unwatch - return -EBUSY if user-space
> tries to unwatch a line that's not being watched.
>
> Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect that you send me a pull request with some GPIO fixes
when you feel you have some stuff including this I should send
upstream, thanks!

Yours,
Linus Walleij
