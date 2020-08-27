Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E1C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15F620848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8WUm2uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgH0W6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0W6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:58:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D902BC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:58:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e11so232012ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCzQ+/wqUikD+aAl1YCGu3tQueIna1hb5C2fVP7BNbI=;
        b=Y8WUm2uDoCL7HpKSQPP7HHTEM/UxNU6XPbQU7wOQD0rYehdyN0NcZxd89TVTeL8/tQ
         O6knIodyMnqPlNkhEcEgJMS0NswYyXYpAX5SZ9oh7sWc6eJXKK/1Ui2SZLbpuGhzlEL5
         Lfz2Lqb6wwCfI+qbzGRoJlAv/NdYlII4qR2a+BQrH2qMksXam9K2Nb4EpBO9kGLTJyzL
         puWHKvjt4HX1ZQ5PDXBFdwD96dhbzvOdNU5kFTP08+PLNzCnsi/V84ilmmHZ1mOnLFoC
         SIjewu3Vovoni2EMSZSYka8Jy3EjJj+19aZwx9YJKgeHTEIa9jHEqb3gr3J2YUya8gsp
         AxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCzQ+/wqUikD+aAl1YCGu3tQueIna1hb5C2fVP7BNbI=;
        b=NGAAKP/2lMLg1R4u5f0/6HEv08j51gzatQJD4rjGwBSdH1lDDr0zddoSU9ABH/TRQr
         HZLSHShOIcGSDPZAQ4IIoYBE1Ri2Y+rjmmK4pUw1lCBEC/RpGi4j9yHi6OtnyI4aI//H
         F3xvU88M1Qv9AeR5KhEDoP/wlbrBxRlKW+prXkjOMW9YwNVNkBOc0mj8/4PgEkYJNNHT
         bmQhNZSZl+cWtcFMPv8LwGtq7UHFfytTn3G6oZoI9aaGuhV6B+2Y6wiMUB5pLDcwOHtq
         jpukHxsqQBVi4IXB2T4Kucqyav4iujyhMZLJuZw+cLde6lIh+Bw3Qfm2h229/44ok27x
         5uNQ==
X-Gm-Message-State: AOAM531rp2wTtQiYgFSJHAODkBVChclVNw5x+55R0a2MuLrs8WCkuErt
        hCvv9TPJkN5EfvI7DJKddu81OFgi47SPQst9ejW60JkSG18=
X-Google-Smtp-Source: ABdhPJz1AxU61I8U3K9H6NnKFR2hKoTTR/TjK+UC3pD/9X+pK6Kc4nN8lO1KSarHy0CMR1IU4DoNa1V7WmiMy5TpZW4=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr11119691ljb.283.1598569113336;
 Thu, 27 Aug 2020 15:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200812195020.13568-1-dmurphy@ti.com> <20200812195020.13568-7-dmurphy@ti.com>
In-Reply-To: <20200812195020.13568-7-dmurphy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 00:58:22 +0200
Message-ID: <CACRpkdY1pCcUONFhEXeyXa3f+JFB=Wg1nSB-qRJF5njM=L+CVw@mail.gmail.com>
Subject: Re: [PATCH v33 6/6] ARM: dts: ste-href: Add reg property to the
 LP5521 channel nodes
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 9:50 PM Dan Murphy <dmurphy@ti.com> wrote:

> Add the reg property to each channel node.  This update is
> to accommodate the multicolor framework.  In addition to the
> accommodation this allows the LEDs to be placed on any channel
> and allow designs to skip channels as opposed to requiring
> sequential order.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I don't knof if I should just apply these two patches or if there are
dependencies that need to go in first. I guess yes?

Yours,
Linus Walleij
