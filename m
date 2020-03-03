Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F92BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D320866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9nHQ8bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgCCMel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:34:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42320 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgCCMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:34:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id q19so2396328ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 04:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cd3PuDX7QGlpsLRHSkLqaNlrKLigo/VJS+jTQKxKQ4I=;
        b=Y9nHQ8bhBUHFsRGta95iKneEmmxYzcq36hN1eDHokC2iEnSBusLXp4oraHu4nZ44a1
         PDUL0NPlkSj9R2KiOB/guYeQHSCwsWMKMFUpofbpDnmeIuhCK2v4ZgKWv3wWeT0vU743
         Dym6dRgKsaosD8pNyCJhPyass3LMEOwPWFpoPjQuObMWqL9DenwMCAhhjzvmO/AsHhyX
         fw0zseDzmakF6WleQx56XgB1IR235elHrHqkZWg1JsKGZBFaC7R8p11d3N2ZRXjN48ae
         XtEr+3+tJuqIi3eXzd+pbWklChykz3YNF3fvLsk2K1+i4krGaczU7gfWhng4hbt5ZLKJ
         CtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cd3PuDX7QGlpsLRHSkLqaNlrKLigo/VJS+jTQKxKQ4I=;
        b=mTHM0PSoUWRXUZqd1h6ResQYsjKWPSzMDrdhfMX4ewitu6RjDvDJyhdwy8XbbJTz6/
         +71QcHJIP1addnrjIo3hQlko+Tu3Fe8bV14bLFbSm0gymD0PrX3B6TY7Q8CYLXemAJWu
         j4nwX4F2f1ygbuoq5yT5aGtSQogs8QdUEmWKhskJtJr6RmknAAnfkutLhtNAjmYLA97t
         ld0rnMwKZFeh0RoEVcSmDLlYHCCr4u7NIp6FB9h3PpvfnnHb6xp6N+Y+HlaTn8Tfwvaq
         yMrjUd4TFxi8ZNVQ3g7hkLArcJ23qxrRpz5JYzfaiZn2pqgga2l150WkAACLlDjHZtoe
         AuMA==
X-Gm-Message-State: ANhLgQ2jxFs0GvKSxWbv13hZYbliPTSTF1pn7TAdEwVmD3YVa7Yvqe4I
        LHGwVXB1jz6zjsXLQDn3fDt9TeNtwTwm2gl5Xek9J61S
X-Google-Smtp-Source: ADFU+vsn3QSWuqyWnLpWbybp4u+9gaM0g0ZKJO5jT/H3hFJPpid+emxdoaQ9W2xtLAISDCjngcELgbpKPPFtmrs5BIc=
X-Received: by 2002:a2e:9c8a:: with SMTP id x10mr2417162lji.277.1583238876321;
 Tue, 03 Mar 2020 04:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20200302082448.11795-1-geert+renesas@glider.be>
In-Reply-To: <20200302082448.11795-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Mar 2020 13:34:24 +0100
Message-ID: <CACRpkdZXUVaDFq5TLmQnEMyRH5yv2XKE3au5KbuMCh0j0+Yh3g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix inverted check in gpiochip_remove()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:24 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The optimization to check for requested lines actually optimized for the
> uncomon error case, where one of the GPIO lines is still in use.
> Hence the error message must be printed when the loop is terminated
> early, not when it went through all available GPIO lines.
>
> Fixes: 869233f81337bfb3 ("gpiolib: Optimize gpiochip_remove() when check for requested line")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Andy's ACK.

Yours,
Linus Walleij
