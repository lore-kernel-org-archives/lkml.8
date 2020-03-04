Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A765C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A7320726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="krmkkN4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbgCDDpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:45:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbgCDDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:45:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so557979wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 19:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dl4yIvdbNV8zUEZF0iJKHHNN3Cn7sHrjK08gaKgENUM=;
        b=krmkkN4V5zPIpMl1EPpZRD1webC/631MVKogbzCnK4d3YjLOrLOZDWnsNmM0IRwePB
         u5+remgX6B5Eyqy3000CS47e+Kuyh/oI4sNBIieCN5H+74G63bcAhvFyKLz5Diq/791C
         YGVGx3dST5jJ25lsJomJdOvOkADYQmUdBo5j3cDRmtGuXZZ4i8bdxBean3nmBoigyKHL
         avDmfaDxbG0Zf8KtISwZmadDC0AbpK5ft/vqa+VAqW1axj3EdTP+g7B9C8VgaOhwQvfI
         WWiwk7Y1or5Hmq42pVli4ci+9t82SN0Y5T0gz2/GbLHlS1Ao2uggNWioPKIkx/A/7OG6
         BfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dl4yIvdbNV8zUEZF0iJKHHNN3Cn7sHrjK08gaKgENUM=;
        b=sVnef/RtGYYA3+d67nQs2k+P02B0EbtjGVb8SjXpgf5Gdbp41I1iMCw5QHsZufMUuB
         tAI+k/7E1FgEnPIFUWLhEpm1LBOjPax95Dg6s6JRZKP+QCx5DEZYU17eApvmvBt0wVnF
         O4M4libBKpc4AhWuIYC10qo3ulWe+Yja2gsLCrh0tTSEzEOBj6ErpeNdpbuS/1aI+dqs
         NfoHerYxEmPqR7xbWP9znBLiUviPUFXCaLBR5Mscsc4rB7qgV8xBXpQ/OKanscafPQgA
         HLgPmRVyXq9kHk6aTZISPaCQc8UqWmM3zdRuZBXogvGTzaY+eW2KmHifQTIKYdNk6LIg
         vYeg==
X-Gm-Message-State: ANhLgQ1t9PQZUEHTJfhA/hlS6CpgYrxk5bxHyhcmIx5h9hH7wfqrwuoH
        DNMCltquNoOHijaOFDEJIXzF+Dxpf9iMeqUFxjJODA==
X-Google-Smtp-Source: ADFU+vvJT3jupIF+x5Oj1qF5HLpZyr9Rp5nN4jMR5lQXgXCYyIIUg56PeBlrGlO8WTISClOKWSw3x4YkD0iH1eNa1gA=
X-Received: by 2002:adf:e90d:: with SMTP id f13mr1649750wrm.0.1583293549186;
 Tue, 03 Mar 2020 19:45:49 -0800 (PST)
MIME-Version: 1.0
References: <1582084147-24516-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1582084147-24516-1-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 4 Mar 2020 09:15:38 +0530
Message-ID: <CAAhSdy0jGQ+PZnwjb63Wpu-pyhUWCJdnspNJOwMbYyOxBTnJfQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: Add GPIO reboot method to HiFive Unleashed
 DTS file
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:19 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> Add the ability to reboot the HiFive Unleashed board via GPIO.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 609198c..4a2729f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2018-2019 SiFive, Inc */
>
>  #include "fu540-c000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>
>  /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
>  #define RTCCLK_FREQ            1000000
> @@ -41,6 +42,10 @@
>                 clock-frequency = <RTCCLK_FREQ>;
>                 clock-output-names = "rtcclk";
>         };
> +       gpio-restart {
> +               compatible = "gpio-restart";
> +               gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +       };
>  };
>
>  &uart0 {
> --
> 2.7.4
>
