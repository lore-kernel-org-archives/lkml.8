Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1FA21927
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhrZUQB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1WPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:15:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33949 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1WPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:15:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so5052220ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhEGO5xzz687O7OpJrPZZtUZ34aFCbyFQZbIi5eRnOg=;
        b=RhrZUQB/n4/xhEDYKZ9dObLNzVyQMv93Zmb96K9ZrPnb/piy9b8arXRmKY4RUJcI1H
         UuMsHTFAKAD4UxmEkfEKlM0BY7ZGByBu5rtbWHBo1jL3pak+eixpPiXuw7EJi900hbxs
         u0dsTloY948pjhat8Kf0o9aquRYTZe/cb/lVKFnOfuJvhtYT4QZMSnXHLBaSDPTdfMdx
         AhFmIDcfkff/hWi12MKwuyMS0Ab2+Oja1qDbu1w6LoJ1rheGZJeN1N1BTKJFXX4Rp04d
         A5MRyCKvvjQg7VePnAWCuciYr9WB36nv5h+tN40F/qMmyAfDKMTgkSnj/HobJ0ydE44M
         vqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhEGO5xzz687O7OpJrPZZtUZ34aFCbyFQZbIi5eRnOg=;
        b=mc1QBEG5kBfE2LjfiTQmI8QdwGqr+hYumJzNemRd+ZRB+H6MV5/dy74Zy3ZPjjYCS/
         ByJTPL9XlCCOMGJtEMHHikSjFiwHjTpln3ClXfwckiuCkLmzBrqK4EFRxfWbUctexoxC
         Dff1LigyaeQvdNBhxuVNSYOeEuzVjhKObXTi8wDzptfn5TenIK9NLwIHoWHGtgjI0Co6
         nJVN9bJMI6iIg5t5g86SttAS36gLsRCcVRszkzLuBMQBOoTQCy+0Nd2wbn9sxGoDXwcQ
         juFepINX8SLo9nX+CyxgtVaj550dE/CJotgNfFH/M3V/1tv+tfxjkw5r2CtOaq2D4EZz
         eA7A==
X-Gm-Message-State: ANhLgQ1dJETyqLAOTPEq0DjEryO/KFASDYcx//xlvTcYjdpht1tOERsl
        oqpmjHUoXRa3fjUGrCw+y/nzrrZ2cHQmZPoTKQu/YQ==
X-Google-Smtp-Source: ADFU+vumXbpYRw8pi5KZznuwB2DpEkpHep4+FFPY+f32ZJX7gumByIl0+yGYcQjfYmqBjEmuN5lRRQlCJxgL1XIa+gc=
X-Received: by 2002:a05:651c:216:: with SMTP id y22mr4331743ljn.277.1582928151417;
 Fri, 28 Feb 2020 14:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221154837.18845-1-brgl@bgdev.pl> <20200221154837.18845-3-brgl@bgdev.pl>
In-Reply-To: <20200221154837.18845-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 23:15:40 +0100
Message-ID: <CACRpkdZQCtF9YimCD7U7b207XNEyR-mvNntcqCSRgORsHuUfZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpiolib: provide VALIDATE_DESC_PTR() macro
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 4:48 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We're about to add a public GPIO function that takes a descriptor as
> argument and returns a pointer. Add a corresponding macro wrapping the
> validate_desc() function that returns an ERR_PTR() on error.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
(I expect to get this back as a pull request or something later.)

Yours,
Linus Walleij
