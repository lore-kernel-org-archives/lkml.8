Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DFC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9004121734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTT6SXhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBLKtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:49:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39559 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgBLKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:49:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so1256109lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0TeS2zfvRk35tG8WU847z+I2PJ7ZIUmWpoNJniHHpk=;
        b=uTT6SXhPQOATzbU2laTg5XgknbfixaAFUhPiS5Db1hVmRYSGlw6QFiK15m46cn64ug
         rhNQod9kPXcalmENQQJZxQQxdbMhfFx60l3Z/P9Q5LeLrffqXHSF5CwrdSxi1Yx1G4UM
         iu4+3qs92C3FKHCGjDFAMnItO7ubJJyaP6LXkLrs28tXwk3N2+O/vSpC0Avq88muQ2Hq
         eAY6sYdWobiaJaQfmu5htD14aDZ7H93f8YWAfOEvs0dS/JJRVMqIsFM1TO+39/n61PD+
         hn/dz8gxd1H3a9mmvjlhgqpAuOhN3KpxW86G+ne2j6ooctn5ziZ6/U00BgEfOpx72R0S
         fB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0TeS2zfvRk35tG8WU847z+I2PJ7ZIUmWpoNJniHHpk=;
        b=VtGLfgKuI+if6b3sQE5Qmj4PVGxCt58NtGW94vJtQIEi3IK/QtSFMROkwUn5LPoJKc
         yXPnSPThsVDoX9gs15Iv04rHTeaeHe2xsF/dTWmYJxHRZ054QTxBeO3Ti2lEUTlMI6kf
         ydyrhSubwq6srI516p0zT8zR+uTZRemRT2fjASmAl4XAVy95jOfRXktFIDMZtx8tH6j5
         ctxQ6oe+nf/MjDlW4FuTRk2zECRa9/iTQZPGApLGPmuxCj34D7KDiDFa1Uen+6v2EYT8
         HZY90JEyQR9OC8XjBTaLU42axgCejn8LmKUrEWlrYMMuLhpfbzwQmHUv+IxSO0cnQiEG
         Y95Q==
X-Gm-Message-State: APjAAAVQljkTTFqzay0IS3G1IGDdb3mj9KK18f9KwMRznhieRv2DChpi
        e3KbbGjmZ+A9v3HXFwXSkiNxGPjb1Iu8UJN16i4Kqsr/ESE=
X-Google-Smtp-Source: APXvYqz2rRuaqT3tJiOfxESNRIkjs6Uc7SYMQNr2EDOW/VHVelbskwwm6KbE431dhr+gJ1Ygk840ZhCa1gAddAh84a8=
X-Received: by 2002:a19:850a:: with SMTP id h10mr6420997lfd.89.1581504556953;
 Wed, 12 Feb 2020 02:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20200211091937.29558-1-brgl@bgdev.pl>
In-Reply-To: <20200211091937.29558-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Feb 2020 11:49:05 +0100
Message-ID: <CACRpkdZoRUzhPW+WbhV7RKt6x4zj=ihcM5Vm1JUgXiHiW2+ySQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 0/7] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

I'm very happy with this version and any remaining nits can surely
be ironed out in-tree.

Since we have ACKs from the kfifo maintainer, can you send me a
pull request for this so we get it into -next early?

Yours,
Linus Walleij
