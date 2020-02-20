Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99145C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7088924654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tGoj+zJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBTMva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:51:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36743 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBTMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:51:30 -0500
Received: by mail-qv1-f66.google.com with SMTP id ff2so1809715qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EYcNKr/N3Y8JXsfApAPcA0o8C1pFsDDtiwpZriI6bFA=;
        b=tGoj+zJjCFlZ9bhdUn+7m0AmuqV1txOsHJRJBnEg6KA2fyVq+zz/iELWJgMTM24R+J
         XatNmnPWbmev9wW0oX1X8qPc1uyytzGERnz+7t+htuv8OhQzlaT/mEP180ZemvSlUqTc
         DYtkKQ8qAfkshrVXLAj9HR6UMkjPQus/rQ6ChK8lkcaX0+nrZQ7KoXewU+Nwva72Pl6n
         a7OydZO/RoLaPMPYG7+T5OiQGt4kAWA9AshfOVz3jOURd5D4K1AFFR+Z1JUCkworJiz9
         lvH0Nc5SPZ8m7Ouh9OP1JwUSDVLPgQtH93yYB/x3fQ0DT7dK8OX8QyV/rmWYqfxmNZcJ
         SLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYcNKr/N3Y8JXsfApAPcA0o8C1pFsDDtiwpZriI6bFA=;
        b=Oere2nDMK1Epa3av6anawQwKN0mFzWj2Cj9QGJzYuOB8BeckHpsfVBSRKBFBXtSdah
         B8/m+EmPIdecflwe6Uz8UJ7A66dkkaAmhyP2d6FWGDlzEz0jJGqHK1+VlWbPrhduAX4t
         aEJJFofLRKLX2A2haYVauI16hQHWIS9hfjRo7FawX/CVMcSUhiDTZ3pZVybxRhTuRQli
         76wo0zNls7/7qT1X0/ndpsu4CZ2N3JgXKalmRLILqPsFlLU3LNUOS6LUef2eslb9ZjFb
         T1C2sPxJkAUcJdWJ6QdxuC8gUehwXPg/RSZ2hPzQ/zexYRAHt2G2cN7ARMxdBND+xieL
         FKjQ==
X-Gm-Message-State: APjAAAVcpM0HpmV3yOlqsXnOpPn26yk1m6ZPWGO1pjyyE4kmdVSEXpMH
        CkrkDNNdyEmqvU25BTnoY8oh0goorMwvr5Tt81p90g==
X-Google-Smtp-Source: APXvYqzt3/u4sLm+8a7c12Ru7REntLJGkgoZmt8TgpKEmEX2TJZHyXdbu5hruKsC4N7eHkriHdxricWluVN6/oEXbJs=
X-Received: by 2002:ad4:446b:: with SMTP id s11mr25036775qvt.148.1582203089373;
 Thu, 20 Feb 2020 04:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20200220100141.5905-1-brgl@bgdev.pl> <20200220100141.5905-3-brgl@bgdev.pl>
 <5970b17a-b29b-154f-033e-6da007d6a289@linaro.org>
In-Reply-To: <5970b17a-b29b-154f-033e-6da007d6a289@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 Feb 2020 13:51:18 +0100
Message-ID: <CAMpxmJX5673AmGDwrb=DMUu7=8Xi2VTtWE72F2hgitK9QUt-RA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gpiolib: use kref in gpio_desc
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 20 lut 2020 o 13:05 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 20/02/2020 10:01, Bartosz Golaszewski wrote:
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2798,6 +2798,8 @@ static int gpiod_request_commit(struct gpio_desc =
*desc, const char *label)
> >               goto done;
> >       }
> >
> > +     kref_init(&desc->ref);
> > +
>
> Should we not decrement refcount on the error path of this function?
>

On error the descriptor will still be unrequested so there's no point
in potentially calling gpiod_free(). Also: the next time someone
requests it and succeeds, we'll set it back to 1.

Bartosz
