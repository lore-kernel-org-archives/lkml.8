Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46708C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253A3206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VAmyMGyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFJJO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFJJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:14:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F16C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:14:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so1142827qte.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SBtPGgE9qdJflgn4DQLaNFra5KvxmwclfVQj0PL/4CA=;
        b=VAmyMGyv6H8k03ivOtSyLiLRExv8+vgAAFSoG3XPB2+vhh09y9s8jfY8L0On0lxZGm
         5A9xjWH8raLRG680PoG2RnWEHdFAwt5aaOD92sLTLE4CiUEjlDAzQR1uzTbTLSiyoyif
         2fAgslFZH3viPUHk4jX2mS+3q0E8nA8fKmcBPqe5EWTRDiPkRAl68UdSBqXznu6sbZm5
         qcQLxD+rX+kKz+dVA4tV5IDpV0Lg9MYvWEgEmvb7i7ZGu2h8Dr0U8AYCiYDEaN71RiS6
         PxBhillZXGqttN3j8iqK7k3GTTe94J/7nlDUQqL6j7MWTUYVjJ8OAb9ChpXiKmNhYA8E
         vJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SBtPGgE9qdJflgn4DQLaNFra5KvxmwclfVQj0PL/4CA=;
        b=nnsarDHv/kZSkPQk7x/E2ctvlkb5LYBArF0wR7YRa3V/ZatGNArTIRJjyNc0yJ7Qi/
         ihub7Xcs5GB0L7p+Wb6kqR5fofbOaibe67naHFv2IxQTZro9SEE/I6LxnBd0LC/KmNHM
         9qeZDZaZg52wnr7xyKPJi41Rj7/REowQBspmpn3DvqwvTVHqSHdaUQsZ3o6aXw+MK0/t
         FxFTVXk+k4Lt1k8m+DdZz0vYnu0eRshVsZqiCzMbTwoo3Tm3BRCirfjsK9LTqspGIgOf
         ko0L7RfkS1qfiSUOZWmt58Lw/uhO0yUIHaAgcSJHwddNMN5PhTbrUMW3BTtUA9tSd8/1
         tQbg==
X-Gm-Message-State: AOAM532Ptp5aXyas72VBjxU6xtaj9iTaNQCmIbnaerKj7NYrsgzYOdp3
        M7Xl/wICC3a2nuA0Z/Trmt2vihvYLt/7bnT69MCBGA==
X-Google-Smtp-Source: ABdhPJwdaN2HPQUAqzmLFFlf3iVbSsUplE5LPCnjLu9JEIi+ixsonGl+1PLeI3HL+RAB3dEgno/+OPRqatLmRrBnwXc=
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr2135833qtr.197.1591780496712;
 Wed, 10 Jun 2020 02:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141048.1995-1-warthog618@gmail.com> <CACRpkdbVmrjgqXHvav3JWmncrKhNnroJKvTYm57dgKu1VrVfUQ@mail.gmail.com>
In-Reply-To: <CACRpkdbVmrjgqXHvav3JWmncrKhNnroJKvTYm57dgKu1VrVfUQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 10 Jun 2020 11:14:45 +0200
Message-ID: <CAMpxmJVe=YqTmLyW28-uc=qfUauT-kHQ6psMbsMRXF=v7b8B3g@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: split character device into gpiolib-cdev
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 10 cze 2020 o 11:13 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
>
> On Tue, Jun 2, 2020 at 4:11 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> > Split the cdev specific functionality out of gpiolib.c and into
> > gpiolib-cdev.c. This improves the readability and maintainability of bo=
th
> > the cdev and core gpiolib code.
> >
> > Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> Patch applied as early v5.9 development.
>
> I will include it into linux-next after v5.8-rc1 is out.
>

Hi Linus,

FYI there's a v3 already on the list with a minor fix.

Bart
