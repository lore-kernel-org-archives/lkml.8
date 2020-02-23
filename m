Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D670BC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3413206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBWDjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:39:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgBWDja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:39:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so7553914eds.11;
        Sat, 22 Feb 2020 19:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/A0yvIhucZ8Hkj54s0R1HqAKKYsO/mERBumFFbw1Gu4=;
        b=K8ii9ZU0iZkY0/B1J8yCNQgQRFN1Q/dRICPBOVjsGjPPN4tWUlqehOyOTnHtFYRRGg
         QoxRjWqG5RdRMgjKrXsqHw0+5NcdPBQ9/U+1a5KVLc+9Cb+zddiJKpbSQsIKgGCLY/lI
         M4W5kk9TVMeUvsUQtlHpclomZ6W1l+qLDiTB3ZqQ7l0/VXe8wOPSmSLSock4OyrfDALx
         1DZXGBOcRvpCYg0rWnpUEGdloZxWYgV5C8Otaq+VfVW2chwl9d7L5xXOFBpwBczEj+hb
         wzaLhPiBGchfGXGUNldsU8yKH6m69aaKnAOZRW9XKH4YRc67WByLMeTMzxesFV5hEQg3
         +yPQ==
X-Gm-Message-State: APjAAAU7VgBzhltTmvXFS/Mr1/s8moUTDd1Hd52XMuHw82xVOeSdn3HK
        x6qT896K8qVMBs0GuYkdl7OvsmCzXr4=
X-Google-Smtp-Source: APXvYqwomLoUmZNlwLlKQcJzIuNZ8/lL9VbciuFH74AMa2ghRthadhfqVJBQkjnCeTeuioZiQo76UQ==
X-Received: by 2002:a17:906:b208:: with SMTP id p8mr42701700ejz.191.1582429168416;
        Sat, 22 Feb 2020 19:39:28 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a24sm574964ejt.40.2020.02.22.19.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:39:28 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id w12so6395843wrt.2;
        Sat, 22 Feb 2020 19:39:27 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr59546453wru.64.1582429167621;
 Sat, 22 Feb 2020 19:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20200222223154.221632-1-megous@megous.com> <20200222223154.221632-3-megous@megous.com>
In-Reply-To: <20200222223154.221632-3-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:39:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v67uOXE7_28yn8Q2uo320vE1FsqL-ewG4p1nViim3q0xbw@mail.gmail.com>
Message-ID: <CAGb2v67uOXE7_28yn8Q2uo320vE1FsqL-ewG4p1nViim3q0xbw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/4] ARM: dts: sun8i-a83t-tbs-a711: HM5065
 doesn't like such a high voltage
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 6:32 AM Ondrej Jirman <megous@megous.com> wrote:
>
> Lowering the voltage solves the quick image degradation over time
> (minutes), that was probably caused by overheating.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Makes sense. A lot of camera sensors run their digital parts off 1.8V.
This one is no different.

Acked-by: Chen-Yu Tsai <wens@csie.org>

The whole CSI stuff isn't enabled in the device tree yet though, and
there are a lot of regulators with CSI in their names. Will this get
worked on?

ChenYu

> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index ee5ce3556b2ad..ae1fd2ee3bcce 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -371,8 +371,8 @@ &reg_dldo2 {
>  };
>
>  &reg_dldo3 {
> -       regulator-min-microvolt = <2800000>;
> -       regulator-max-microvolt = <2800000>;
> +       regulator-min-microvolt = <1800000>;
> +       regulator-max-microvolt = <1800000>;
>         regulator-name = "vdd-csi";
>  };
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200222223154.221632-3-megous%40megous.com.
