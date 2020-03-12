Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB1B20578
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqgVBDNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbgCLHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:35:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbgCLHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:35:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so6061497wrl.1;
        Thu, 12 Mar 2020 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0f21W2MrGo2hnLGv+BYSYakn/7LmxxEYohimXgzgbU=;
        b=mqgVBDNoyPwzx26l3YyvRztYlv7veET1q91Qs6uvdXK1wSOdeKTfLscfXenX06M0y7
         7FFfCZ5mBgM5r2YnS+OKPbWwYmFdea35m73kxe5XwScoD2gU2VvYnOGs0EAGNhhfdzKS
         fdsJIpXXzvSZSTY7XG7gMNGi9BHCO4UWFOYWuersbic+PElUPFhjelKk7GJW6ukjcw6o
         HksCvWVZ6CgKf2C90+g07K4SVW1CFZ4cMVwWNaXhEOybjjvD0e2L66zrnBGTWFID9Iyz
         0+uesIA30OzycOj9UE6+Wz7BiGrUGQrCL7UneHXd99WWmeGTAHD6eeib5jWXnMCZChEV
         fjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0f21W2MrGo2hnLGv+BYSYakn/7LmxxEYohimXgzgbU=;
        b=jI9NxoSr/j57IODwxifdkHiwOptf8lc5/ouoJORoPr4I5aSIUdKq/aBSAZPPdbVoz5
         W+7Hxbf6Ff/fuS6s7yen7LYV76oQ7v7BUsKU0SAbQJtHB6Hig05d9ZOyDbTWf/dj+CB7
         6VHEl6CxkXijw1C1OdiPbIidEHy+bxm+A7baKk2E5b87im/us8k3Gb25/YUxFifHL2A+
         mxClpuI7hbJ0RGU6BdLpqq3sm1thGq1E9trTYobPmwrjZIsPp0TpF4ujs5Tb0SZmzPYK
         QiJzHv44lP8fAw3HgpqIxQlBXEC82D2HFOevk2qZZz0Bv6pyqMq8j0n4EkbTQNkD2iBj
         Fq4Q==
X-Gm-Message-State: ANhLgQ3sdJPKZ0yJSylV3hyt1BaHWJJOEZ0HRltHkaUoMtNpn1r2X9ar
        pU+RTbpt0wr1HFh0hVLNyZ+oAZPCSA8sj5xwB0XHoi6n
X-Google-Smtp-Source: ADFU+vuUfBEm9U7m7o5XDIh7wvf1mmCaP8c6aaiAk4xIQ9k7165uWsz6meLkY8e9N2xr6w37az8DgpKcFA4dIE3rpwg=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr9220480wrj.196.1583998510514;
 Thu, 12 Mar 2020 00:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112120.30890-1-zhang.lyra@gmail.com> <CAK8P3a12iN4HzN3HsRSBJPLpwJzdVwhrK7Mje0V6eW3Lvd77iw@mail.gmail.com>
In-Reply-To: <CAK8P3a12iN4HzN3HsRSBJPLpwJzdVwhrK7Mje0V6eW3Lvd77iw@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 12 Mar 2020 15:34:34 +0800
Message-ID: <CAAfSe-sKXT5K_m8f0vhCqSVsH1Sma1cSfiidiCFAGKS6eKFMkg@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: specify console via command line
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 11 Mar 2020 at 22:31, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 11, 2020 at 12:21 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
>
> > diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > index 2047f7a74265..510f65f4d8b8 100644
> > --- a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > +++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
> > @@ -28,7 +28,7 @@
> >
> >         chosen {
> >                 stdout-path = "serial1:115200n8";
> > -               bootargs = "earlycon";
> > +               bootargs = "earlycon console=ttyS1";
> >         };
> >  };
>
> Hi Chunyan,
>
> I would expect that you need to either specify the stdout-path, or the console=
> kernel parameter, but not both.
>

Ok, now I know how to fix the problem without adding 'console=' :)
of_console_check() [1] can tell if a given port is the console by
reading 'stdout-path'.
I will address this issue in serial driver.

Thanks for your reminder,
Chunyan

[1] https://elixir.bootlin.com/linux/v5.6-rc5/source/drivers/of/base.c#L2135

> If earlycon was used, shouldn't the driver know which port is the console?
>
>       Arnd
