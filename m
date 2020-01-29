Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B3C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020BE2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="doI1v6YM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgA2K4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:56:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39059 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2K4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:56:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id w15so14820061qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R2GfLE1YBPy2zxLc6xgpWp5jwd9zTP6iHYDWoWRsFu0=;
        b=doI1v6YMwfdi9cRvhIFdzf7HUa1YU4MrhdiNjQCdEPbWbLksGPj2h+Rc0l6/VQ1pGV
         hmYV6/b8jlR/u5kQkTsh5Eohr5oXCQTGPY0xbBECFnAR56vZYd2SzfkFpbDcHmo8dZHy
         GV9SJGYOEj9lNdahm6/dTl478+a9XSkBTnIwQLyrO7B0PUC5gcGLRmgHxMvvvBitp5ca
         l8Zkfk9UQPTmN2h29+lLwxxr4L61h9rSK7Yu7o0PrjzRKuYt7YIGZAva4Z64ATrmpUj5
         OaF19XHq1cwdmR7gWqqtngPNYHPWQ+j7Rii4Ps0/jCVZbMnOzVPkBlI6vUgJtoX7NK3y
         5R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2GfLE1YBPy2zxLc6xgpWp5jwd9zTP6iHYDWoWRsFu0=;
        b=dvUWMJJUR2DF8k9m+OO9xVWxmxfOq0ZRGVboF3vuA9qbNny743sPVfjUKQP9V5OgiW
         I6BwZXujIrFoKjgyKp4jbLueMuXE/MwGjnxHAeaAgh3l4JOo29xitzk0aqazAoPtNv1T
         M+CNloqTt7zlpMJGfRkm7qHbX3C93/srOoe56DPxJG0fIPB7g/qp+m5lcf6ZMIrZ4kkU
         TNwKd5XpZNRIxoTJ3iTS3/I0OtGHRfXZGLboxZUkqz81NvRqdP7H7WqyutYH4ZkjCRa4
         U2oFZcA5opchOvCL2zSurGJz39MVCqyQw9TCq31N7DPiHCs11bbP/ImiEaUM0Mpvqg7P
         CmLw==
X-Gm-Message-State: APjAAAW/tYz11EhLEWc1TDXMI+KkDU19W0C6wWPFgMX2Eom4tpKHxVLD
        O7/2bU1AvlTgHAH4raYS1ydiuBhcS955z1YtLSwf5A==
X-Google-Smtp-Source: APXvYqxjw5pzYeGQTcVIqA7M2WTCWfxESWh8wOs2gTBNL2Ml2I9qClgT2H4h8+alnweWKSpamykEjDKmbAS29n/vhj8=
X-Received: by 2002:a05:620a:12cf:: with SMTP id e15mr27629723qkl.120.1580295360011;
 Wed, 29 Jan 2020 02:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20200120104626.30518-1-warthog618@gmail.com>
In-Reply-To: <20200120104626.30518-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 29 Jan 2020 11:55:49 +0100
Message-ID: <CAMpxmJWCwtnuB4T3_no59cVvPS5gy6QwOBV3i4FU4N6hmYugEw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: remove unnecessary argument from set_config call
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 20 sty 2020 o 11:46 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a=
):
>
> Remove unnecessary argument when setting PIN_CONFIG_BIAS_DISABLE.
>
> Fixes: 2148ad7790ea ("gpiolib: add support for disabling line bias")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> No argument is expected by pinctrl, so removing it should be harmless.
>

This doesn't really fix any bug, does it? If not, then I'll just take
it for v5.7 after the merge window.

Bart
