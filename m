Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C6FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245124676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+oDtBN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAVV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:29:23 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44345 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgAVV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:29:20 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so374256vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTz0lK4MWaaIUm1zOO05D9tP3L8z6e5/rjhy199CFHA=;
        b=U+oDtBN20djYD2BA6vTb8zmhw0901lDwsc+HsVWuPXXCQLBVtJR/ejKZ8cNJ3WMe4Z
         /CN4krHpVSEHOfAhc3Jk9LW1RRz3N4rTwDvEh+yEa4T56iundLwEjbRdtG2cdSBVC303
         v595x/352B+y2PS70/UoqhIh1JCRGHYwWJfd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTz0lK4MWaaIUm1zOO05D9tP3L8z6e5/rjhy199CFHA=;
        b=fIyYzJL14EI5+9nc29JHXi32QMN6xEbDuM6Fs0ao/k3ZMjov3UavYe1btuHnFhitUY
         r13rSpgv/HZ/Jcvc1pQ/Dp2cSuFi7HguOek+99hVftvreyy1rmElcUGZ4FG1hl/4EapU
         KW/ItcW9yDMZMxX+IFbR9lWHTI5N5W/xH3yfAhs6+lj/rf3KbziBXqaCOzJ7MvhWVclu
         25JfcurSmsCSrDI25ekPKg8bS3v85SnevodQL963Pq2qemuZiv+5WeeD/Hyf+1MZThNv
         leyvZcq1pU5fIhB84Oz7mxS13qONTwJZj9dKUFz4ngUwozPKjKUdT7hP/ZItCK0aUQqn
         rahg==
X-Gm-Message-State: APjAAAWENL/vYTIJNZ7mfpzb/RpDlAFSkNBMRYY5KoXuJ+sxlOiWlwNJ
        Iq6gpoiOi06JLFeMNEtZCqaWluAndtc=
X-Google-Smtp-Source: APXvYqxjbRFvxh2iKsAb+mbLW3QReiNA0ToK3uJmLTNzN7yV8/rBueOPxyMRQRD2Y1AB7U2gdJVJng==
X-Received: by 2002:a67:ec12:: with SMTP id d18mr4074588vso.129.1579728558932;
        Wed, 22 Jan 2020 13:29:18 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id g8sm7170941vso.34.2020.01.22.13.29.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 13:29:17 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id x123so414614vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:29:17 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr4193371vsd.106.1579728557149;
 Wed, 22 Jan 2020 13:29:17 -0800 (PST)
MIME-Version: 1.0
References: <1577421760-1174-1-git-send-email-tdas@codeaurora.org> <1577421760-1174-4-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1577421760-1174-4-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Jan 2020 13:29:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UxTDkwr8Z43TGXjpU6bKRN3ns2BdShKehAga4gkLUpLQ@mail.gmail.com>
Message-ID: <CAD=FV=UxTDkwr8Z43TGXjpU6bKRN3ns2BdShKehAga4gkLUpLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clk: qcom: Add modem clock controller driver for SC7180
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 26, 2019 at 8:43 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add support for the modem clock controller found on SC7180
> based devices. This would allow modem drivers to probe and
> control their clocks.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig      |  9 +++++
>  drivers/clk/qcom/Makefile     |  1 +
>  drivers/clk/qcom/gcc-sc7180.c | 70 ++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/mss-sc7180.c | 94 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 drivers/clk/qcom/mss-sc7180.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3b33ef1..5d4b6e5 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -245,6 +245,15 @@ config SC_GCC_7180
>           Say Y if you want to use peripheral devices such as UART, SPI,
>           I2C, USB, UFS, SDCC, etc.
>
> +config SC_MSS_7180
> +       tristate "SC7180 MSS Clock Controller"
> +       select SC_GCC_7180
> +       help
> +         Support for the MSS clock controller on Qualcomm Technologies, Inc
> +         SC7180 devices.
> +         Say Y if you want to use the MSS branch clocks of the MSS clock
> +         controller to reset the MSS subsystem.

I didn't review your whole patch, but I was skimming through things
and trying to figure out what the heck a "MSS" clock was for a while
before I finally thought to look at the commit message and figured out
that it probably means "modem subsystem".  I assume you're going to
spin this patch somewhat soon.  When you do, can you please expand the
"MSS" acronym somewhere in your KConfig description?

Thanks!

-Doug
