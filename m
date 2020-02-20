Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCDC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE52F20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JbRmvJg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBTK2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:28:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40123 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBTK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:28:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so3036660qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+D+Oguuyj+RUr3A3Lx/J2MyIAXszwuZogb4QISizTY=;
        b=JbRmvJg89oGETca2ebk+jHa32PMmkvyzx4Vp/pxwdvYV1A5Ybt+qcld0w9znyCHot3
         z9lzzT5XaTtnksYFr1npZRvCz16QsXhrfzhRUG2xSRr/MZaC+MQXfrtqotJPuVbm9rFc
         TfWFQN/wPoYNe/Hv2ZOK12WdZsdLZAjoAdV4Ly/9J0BpnNl4D3FBMLbeCWWfsnkHOR9Q
         bfTuyeyaC5y9tZug9cBXCN1jaN0r63vjEcu6YDTl+/ktflr0ov5GPZ9cKLb4swkaJJKI
         +InJc335F84vnbeQGPIAPBv7+sY57/x2lhtjSlA9cbXxMx8M1KD/OHZPhzFg1lGVN6E/
         mzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+D+Oguuyj+RUr3A3Lx/J2MyIAXszwuZogb4QISizTY=;
        b=E4ZJ+leONP0dzdd2CBMYHjMpUHOPT8SflpL7lDMFj/YFTnz2o8NLaUNDZ0/LAHAwQj
         ZShga98ds5QPdXrqNEW22zHUbXDcONsRt35LPfJukUBmWPT8R6J0i5AyGip/pIVSi/uB
         jNsJfQkgt4MqSkYwMEZv3pcZyMRAHX3T6jKNVU2BTxGiVEDgQRAc6+fhB8FgNN7rIezF
         18vArS5nSVgcsCFUot/h7HM0mzK0DMkCLx+/zaR3L+eR3EdqHxHLcDDtT2Lsybmgx9Su
         YuQtlgKfO6pJznGcv4lL7bs6o/tUvXjPtGm21wa+dToEnMLm5fpLt2MDOcD3tWzmNtaQ
         eK7Q==
X-Gm-Message-State: APjAAAUq0T5AsDpE2HvZUYeynwWxd9OGaML3hFGGVbPtiLGp/HmXKJOD
        MpJRKf/62sbbuITBbkqTyDp5wr+/rGt9m+kLHFxclw==
X-Google-Smtp-Source: APXvYqxykPihTXTgrIShZPQYasPSZbasbw4QwcYCWUECJz0hLDszKBzPXxvT3OnTzm3yGMIO8Ev1AxqGbckdQ1v1gYQ=
X-Received: by 2002:a37:4808:: with SMTP id v8mr24745184qka.263.1582194531385;
 Thu, 20 Feb 2020 02:28:51 -0800 (PST)
MIME-Version: 1.0
References: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 Feb 2020 11:28:40 +0100
Message-ID: <CAMpxmJX1zTpeBGdd6DSe_o3mxUW7ObsFbRjptGQBZB1-4YE7UQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] gpio: zynq: Update on gpio-zynq driver
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 lut 2020 o 13:33 Srinivas Neeli <srinivas.neeli@xilinx.com> napisa=
=C5=82(a):
>
> This patch series does the following:
> -protect direction in/out with a spinlock
> -Add binding for Versal gpio
> -Add binding for pmc gpio node
> -Add Versal support
> -Disable the irq if it is not a wakeup source
> -Add pmc gpio support
> -Remove error prints in EPROBE_DEFER
>
> ---
> Changes in V2:
> - In previous series [PATCH 1/8] already applied on "linux-next".
> - Fixed checkpatch warning for spinlock description.
> - Added description for Versal PS_GPIO and PMC_GPIO.
> Changes in V3:
> - Updated commit description for PATCH 4 and 6.
> ---
>
> Glenn Langedock (1):
>   gpio: zynq: protect direction in/out with a spinlock
>
> Shubhrajyoti Datta (6):
>   dt-bindings: gpio: Add binding for Versal gpio
>   devicetree-binding: Add pmc gpio node
>   gpio: zynq: Add Versal support
>   gpio: zynq: Disable the irq if it is not a wakeup source
>   gpio: zynq: Add pmc gpio support
>   gpio: zynq: Remove error prints in EPROBE_DEFER
>
>  .../devicetree/bindings/gpio/gpio-zynq.txt         |  4 +-
>  drivers/gpio/gpio-zynq.c                           | 66 ++++++++++++++++=
+++++-
>  2 files changed, 67 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

Other than the commit messages, the series looks good to me.

Bart
