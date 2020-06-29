Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C325DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26AF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hW0bjXJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbgF2Uwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbgF2TNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BB7C00877F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:30:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so12300989qtf.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UWVs7He7VNIcTh2C2GcW0olT9jljSKgU/1oAwOuPtj8=;
        b=hW0bjXJ0rtdgLiAay3FdknLQeHjtZqzeYHE69L5wxoXNmFXvK+g5OpTMUhJwRHwb7q
         bvbox0QHDiD0SWD3kx0HYahntB4q1cNXNRlDC0/R9t7yEOw5ekE67FmcALSsiLzjg3+f
         VL/UgX+94SeirX9eASNqOzglpF/GB/ckHbGUEubGz6b0wAx0SKVBnANLxN/gaYoMo2Yc
         X6pSS5Lirm3fN4cisNuiLIMKseewP65b30sMVYmnNDQwpy+Yd8O8q/HJ/TxZAZcgU9Bh
         Do9DkbjBCxyJAw9Q953X/t9ZOnwnvkOC5h6FffoGecyxugFrYB5FmJHH2EO9vzhEErtB
         s/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UWVs7He7VNIcTh2C2GcW0olT9jljSKgU/1oAwOuPtj8=;
        b=RXAd/lXTPAjLgMwLjSa+mMx7h6VAM6xNv3btNYcjSm2TOPcWnUWVBpnSMQ/AV5KBuR
         YnORPVzQcTknjT1zCJoLqDDRZrkoN+7DLO+dC7L0QTXXqrauDQHd7my9z3VvND+TLfjR
         DXPqoM90+iTWxU/M2AzS+5HObFgaHioPTVQgMtT5rV/p+m3vvJij3fN9QuKvh5Idr7n/
         eTJDFCsLjDzDvEaSNlwQ6sFsJb6PKTSnsY2fgYPR3qFd6Nq0WKAkCi5BhXFTULG6xJpI
         9MCuS7LXUFt83+TwGRudh0I0RgE+/ciQV8TcbjZJJpzZnP/iyPoTMNnWJBJZlO1pu6ZT
         wR9Q==
X-Gm-Message-State: AOAM533/Msp56ODdvi//2EzYSOW5MadcRyK4zWCv9k1ju9MqAl5cdqTk
        AQO25qCZjI20rSpqD7ArCXh05t3N6w7922w4ekKjiQ==
X-Google-Smtp-Source: ABdhPJypLWJGj9IRMTQXEPocCDXObCcTTrMC0Y9v+HHaQ4Ic+KR82mGBzixOF6s8j9FAdyeyxr4vPoEu5a71J2jx/OI=
X-Received: by 2002:ac8:3470:: with SMTP id v45mr15134731qtb.51.1593423029840;
 Mon, 29 Jun 2020 02:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 29 Jun 2020 17:30:18 +0800
Message-ID: <CAHCEeh+X+0m_oprdS+frRkfbmW7EvWF63xWeJFcQB4_Zc_RUgw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, robh+dt@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, lollivier@baylibre.com,
        Green Wan <green.wan@sifive.com>,
        Atish Patra <atish.patra@wdc.com>, alistair.francis@wdc.com,
        deepa.kernel@gmail.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yash Shah <yash.shah@sifive.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8816=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The patch series adds the support for dynamic CPU frequency switching
> for FU540-C000 SoC on the HiFive Unleashed board. All the patches are
> based on Paul Walmsley's work.
>
> This series is based on Linux v5.7 and tested on HiFive unleashed board.
>
> Yash Shah (3):
>   riscv: defconfig, Kconfig: enable CPU power management
>   riscv: dts: fu540-c000: define hart clocks
>   riscv: dts: HiFive Unleashed: define a default set of CPU OPPs
>
>  arch/riscv/Kconfig                                 |  8 +++++
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |  5 +++
>  .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 38 ++++++++++++++++=
++++++
>  arch/riscv/configs/defconfig                       |  5 +++
>  4 files changed, 56 insertions(+)
>

Hi Yash,

Thank you for the patch. It works for me to test with cpufreq-ljt-stress-te=
st.
Here is my log.

CPU stress test, which is doing JPEG decoding by libjpeg-turbo
at different cpufreq operating points.

Testing CPU 0
 1400 MHz ............................................................ OK
  999 MHz ............................................................ OK
  700 MHz ............................................................ OK
  350 MHz ............................................................ OK

Testing CPU 1
 1400 MHz ............................................................ OK
  999 MHz ............................................................ OK
  700 MHz ............................................................ OK
  350 MHz ............................................................ OK

Testing CPU 2
 1400 MHz ............................................................ OK
  999 MHz ............................................................ OK
  700 MHz ............................................................ OK
  350 MHz ............................................................ OK

Testing CPU 3
 1400 MHz ............................................................ OK
  999 MHz ............................................................ OK
  700 MHz ............................................................ OK
  350 MHz ............................................................ OK

Overall result : PASSED

Tested-by: Greentime Hu <greentime.hu@sifive.com>
