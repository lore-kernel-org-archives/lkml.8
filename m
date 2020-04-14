Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBDFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBA206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UcIb0Pcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbgDNOTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389537AbgDNOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:19:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:19:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m67so13272669qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3EraRtfW5RLJEDi4lMBW11PhnefdSMnejhmHO2K18DU=;
        b=UcIb0PcdWiFibmHdGVpYwwWIzuY5kBjjoeQUiF4QHkWxHm/+d1NDgIlJTgKq0acvgc
         q22sdojzXgOovSTEjCTMI12brLIlZntbmMwHWvtb9Z5CoAjChvo6jK3zzV3bB2Fbye5S
         3uV2GKhljThlWre7zOLuafSsAeFcDimgVmf55hLxDXgv5DbX65yyi1cbUZaGXTjoSxzS
         aBf42Jt8J6/9lKIFIhXHMf4977lqnmbEP1ZxRbJeNICIJiKdfU1DF1wzI1SefbsaYS+C
         ExIdgm1vfcefLkQ0jAFQblATMmZUW3pK7j9qV9+t2hxzeOBG8LDNEdXVB8v8dgBpQSF/
         vVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3EraRtfW5RLJEDi4lMBW11PhnefdSMnejhmHO2K18DU=;
        b=RnkWKFqeMleaO6TNoI9EOx9eAxHm0hFKNqGUzXhHVYBWpDz8GjC2114lmGVrZ93rhv
         cSq3mJtqkVkwbYEpx8uWWTJ8g1xpw5tlo6G/l1JruUhb5T2sCsFKF8Eb/wxMb0oFDlZ3
         /ft9WpkDKciFbrjwUFmZXDWq4VlBnVsjR+jEWMJoNcDxDV1CPcOgkp5pcxkn4b+ovwql
         nB4Dvdgh7mGi8i4R6OKg6FS96MmaeiW+FPlSMjbBXo1XUyEhWybv4s/yYFK4dfzKvguZ
         /xn8lnoU4hYTIHfzaLhgXBNxBHx628BB1YS537JH22tqIPXsz+77UcD92JiGg4nZZdyR
         lrug==
X-Gm-Message-State: AGi0PubgAxv3EF9j9nIKsuRxj5Qd0lZJx6HjuQppssWt0ZAzBTAlCsj9
        y4maZO33bCY6R+5k3Xusm1OpTO9/O5oI7wo7AqakAQ==
X-Google-Smtp-Source: APiQypJ45n/aqPRRRlmXJ+LAlmliigwfL2fjEIEMVDsr+Acnlac4ie5oYjgyJ5a4H0HbKUrpS04udcBWMdnHrHvqZwo=
X-Received: by 2002:a05:620a:1259:: with SMTP id a25mr10285006qkl.323.1586873942074;
 Tue, 14 Apr 2020 07:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200406165115.25586-1-pthomas8589@gmail.com>
In-Reply-To: <20200406165115.25586-1-pthomas8589@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 14 Apr 2020 16:18:50 +0200
Message-ID: <CAMpxmJUUp5whscqBX2CU9--4zrh_+LUQOwVt1yUpffJQdPftkw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-pca953x, Add get_multiple function
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 6 kwi 2020 o 18:53 Paul Thomas <pthomas8589@gmail.com> napisa=C5=82(a=
):
>
> Implement a get_multiple function for gpio-pca953x. If a driver
> leaves get_multiple unimplemented then gpio_chip_get_multiple()
> in gpiolib.c takes care of it by calling chip->get() as needed.
> For i2c chips this is very inefficient. For example if you do an
> 8-bit read then instead of a single i2c transaction there are
> 8 transactions reading the same byte!
>
> This has been tested with max7312 chips on a 5.2 kernel.
>
> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
> ---

Hi, this doesn't apply on top of current master. Can you rebase it on
top of v5.7-rc1 and resend?

Bart
