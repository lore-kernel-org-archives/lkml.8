Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B3C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B3820675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tg3njtcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgELXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:03:49 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:49 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y13so2964049vsk.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTcsM0fLVDrxzWXHLJGWWSdSgFbiZZD135BBgo0uSho=;
        b=Tg3njtcQjuJtqGZeJly2iQT+quwxdgtBZH/53y1LGhdRp26K5ygvKnLNAkH5G5FC6F
         zuipKgdNG12g4lX+hx4a6Vp9DgK/TX+Ch9SQJchv+SRyEA9sFaJaE2Z4IeF9xoZ+EwyV
         U0jqpuMjTfDNu/wvfe+NT0dUAC9pEa3r1bv48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTcsM0fLVDrxzWXHLJGWWSdSgFbiZZD135BBgo0uSho=;
        b=sbHU0zgj3WE3JogTQjUXegQXsVavsSyew9WjvZO3NunOYgnDcv0bDvcc+eJXH+Vqpn
         xYtmq6dSdkCUTRCLvvcnaEFvEgXeJHviUlBCUN4EticljW7YqGqDxsZ0wesv/lW71CFY
         ZNUo4oTJoINeZyIS4/sIlgXlDi51LQrFctn2zK6eYGpatkBkodsig+XG+ei5u9Gndebn
         l76zDPZGaoj7DxqLMklZd9+Kxqrrxn4hVIeS/S7qv56hHUye5g2D8cu013Cd6+yKa8I9
         WiA7oVw5QfXlPONmgo3cVv/pUMHhYhB60Bi0Yqu8E3fz7Ew9PKjXIJ/I1TIuv+GONq52
         zKKA==
X-Gm-Message-State: AGi0PuZkD/LnHO1o5YgMTil252bAm+7stU9DDzU2yA9qLMkOeSigOmZ/
        c9kU94Y+gweVeVV9wpjVTZViBz6eyIE=
X-Google-Smtp-Source: APiQypKVsy315HYj1DYgRwSpsk/+4O481Hl9QDmWen2qsHHub7wmiPKJ7TWIcOUlcIWTzIOMS2jEvg==
X-Received: by 2002:a67:7fd1:: with SMTP id a200mr17985470vsd.114.1589324627890;
        Tue, 12 May 2020 16:03:47 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 203sm427071vka.51.2020.05.12.16.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 16:03:47 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id b11so905887vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:46 -0700 (PDT)
X-Received: by 2002:a67:f5d6:: with SMTP id t22mr18485398vso.73.1589324626099;
 Tue, 12 May 2020 16:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 May 2020 16:03:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VReEUiJY0yDgMkegMnKJ-Fc_c=4_f7_K7g-PG0UVjH5g@mail.gmail.com>
Message-ID: <CAD=FV=VReEUiJY0yDgMkegMnKJ-Fc_c=4_f7_K7g-PG0UVjH5g@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Add QTI QFPROM-Efuse driver support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 11:18 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> This patch series adds qfprom-efuse controller driver support.
>
> This driver can access the raw qfprom regions for fuse blowing.
>
> The current existed qfprom driver is only supports for cpufreq, thermal sensors
> drivers by read out calibration data, speed bins..etc which is stored by
> qfprom efuses.

I don't understand the interaction between this driver and the
existing "qcom,qfprom" driver.  Can you please explain?  Are they both
acting on the same values and this one has write access?  Are there
two instances of the same hardware block and you're managing one of
them with this new driver and one with thue old driver?  Something
else?



> Ravi Kumar Bokka (3):
>   dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
>   drivers: nvmem: Add driver for QTI qfprom-efuse support
>   arm64: dts: qcom: sc7180: Add qfprom-efuse
>
>  .../devicetree/bindings/nvmem/qfprom-efuse.yaml    |  40 ++
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   4 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   9 +
>  drivers/nvmem/Kconfig                              |  10 +
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/qfprom-efuse.c                       | 476 +++++++++++++++++++++
>  6 files changed, 541 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
>  create mode 100644 drivers/nvmem/qfprom-efuse.c
>
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
>
