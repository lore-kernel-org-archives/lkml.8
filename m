Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69987C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C320BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Od/BNOuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIIV2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:28:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CBCC061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:28:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j3so2247195vsm.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0B+f5EUKKQ2J3MpI4Sx58UmBuViiwCjCr/4VdaizHMc=;
        b=Od/BNOuqJin26VSVXto0zQ70I2i+1D5m+tF7dZbpoRgrpYD5zTa7oruoZe3TuKSCLz
         +aUkSlno/mybqvqL8n+NfX4gMH32Ehppe6USW20WWON0ETf3fGPnshIcG2KWRKNTuoUs
         cF19615mLBHP7cf55krv2gokojiDSN22luOIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B+f5EUKKQ2J3MpI4Sx58UmBuViiwCjCr/4VdaizHMc=;
        b=Wv5pYdstvELmxXTk3jyzuPwph+va1W0oVOmej+wd5TW8G49tOCUskagONOZBxgd/1Q
         rhxtBkorLw6yoqb7S/FITzpqo34/xvRoNHq7e24IIkZfFnUHFm2c9DsjF1sP4yMV1Y5H
         D6nsXACXvGW+Ep1XoIiPpFhufQ5JQ2WnLtZp6st4DaNx4wrVGSvST7ixBd6ahO0fDNGh
         vCqag1tBe90ttvTQchjAoLwAd8nWX3rZ0vXaatAaI5465CsYrZzh+jhFncAsKlOzVHLS
         2GULZaI4yYC046D5CNAMgQ9wRe4TzDBWJqMk4eJofAAy00oxls609XcurwtviXhi4NBS
         vIcw==
X-Gm-Message-State: AOAM533jvDKsUf76iYNfAEctxLEtWKUrlZ0Tf4HGJCEzzGAXdGe3V+q8
        T6xPn37Dpbu1F/zSig4v9asNjqOwHuu8fg==
X-Google-Smtp-Source: ABdhPJxKlzKJ++/IpvXvySE5XEezGW0xJiQduYq32KkObMFS6vSANEk48z0QJt9ShHJ4jt6LJzrj5Q==
X-Received: by 2002:a67:3054:: with SMTP id w81mr2042189vsw.112.1599686896276;
        Wed, 09 Sep 2020 14:28:16 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id s70sm509657vss.9.2020.09.09.14.28.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:28:14 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id v5so1323205uau.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:28:14 -0700 (PDT)
X-Received: by 2002:ab0:1584:: with SMTP id i4mr1985606uae.64.1599686893792;
 Wed, 09 Sep 2020 14:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <1599145498-20707-1-git-send-email-skakit@codeaurora.org> <1599145498-20707-3-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1599145498-20707-3-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Sep 2020 14:28:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZgmQXCzVx3CdeOkAWC6zz8bNW+f6Qt1=O9ZSaGUr75g@mail.gmail.com>
Message-ID: <CAD=FV=XZgmQXCzVx3CdeOkAWC6zz8bNW+f6Qt1=O9ZSaGUr75g@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] arm64: dts: qcom: sc7180: Improve the pin config
 settings for CTS and TX
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 8:07 AM satya priya <skakit@codeaurora.org> wrote:
>
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -474,32 +474,30 @@
>  &qup_uart3_default {
>         pinconf-cts {
>                 /*
> -                * Configure a pull-down on 38 (CTS) to match the pull of
> -                * the Bluetooth module.
> +                * Configure no-pull on CTS. As this is driven by BT, do not
> +                * specify any pull in order to not conflict with BT pulls.
>                  */
>                 pins = "gpio38";
> -               bias-pull-down;
> -               output-high;

Weird, how did that output-high sneak in there?  Glad it's going away.


> +               bias-disable;

I'm not convinced that the removal of the pul is the correct thing
here.  Specifically for the rx line the comment makes the argument
that if we power off the Bluetooth module then it will stop driving
this pin.  In that case if we remove the pull here then the line will
be floating and that can cause some extra power consumption as the
line floats between different logic levels.  Do you really need to
remove this pull?

Same comment for the next patch where you add the sleep settings.


-Doug
