Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5172145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599682577;
	bh=Tp/Brl85YJODbCurhmfpaIOuEFOQPOuOgKbfOheYgkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M4aVxvLo6nOlDdT5jgs9mNf5baqRGJCRquqXWsmMeDyNth3EdTUJS28E0N1FEiWGC
	 RhcOb+/2U54fYtzbNvSEzV1qIOwXOfphtc4Fa2MrtlybKR31PJa9l3AxFymRAzvVCq
	 iW7+a0bi4NlldUt1uLs5ByswhbPvAer0URSPpuXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIIUQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIIUQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:16:12 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A24921D92;
        Wed,  9 Sep 2020 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599682572;
        bh=Tp/Brl85YJODbCurhmfpaIOuEFOQPOuOgKbfOheYgkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAZvEURvmf4hXlchFMxGuNONIdnuwjGksF7pqSuC/r99glmvIn1q2li+/hqhfkUnu
         Thbo6J0taERQsao0B+9iJithvlXjGPprt5dAciw40/zRQ+K/gvaLJeoFPCSv+tJKfI
         acnvBedj2sRVZFGzHFEbERA4hqsuGOiCJ9Xf4Nr0=
Received: by mail-ot1-f42.google.com with SMTP id m12so3463957otr.0;
        Wed, 09 Sep 2020 13:16:12 -0700 (PDT)
X-Gm-Message-State: AOAM5332k/4apNOr9HQD/Tf4+Xr70w/b9ZmcFEI1qnZtr+mrf8O5GVcS
        372uhTfTworFwfn4fD0yL+WMM1RLgtpwXjveOg==
X-Google-Smtp-Source: ABdhPJzueYmZlmx3b77kzdd9uUT/O6GTT6PM/q2t6jSKsiv/NQsuldsEwZf29rPJL1xtuTp/hD2+m/C3+51PwCbnnKo=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1842033otp.129.1599682571430;
 Wed, 09 Sep 2020 13:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599214329.git.mchehab+huawei@kernel.org> <58d6b31d0134448a35c47e822c887e994164228b.1599214329.git.mchehab+huawei@kernel.org>
In-Reply-To: <58d6b31d0134448a35c47e822c887e994164228b.1599214329.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Sep 2020 14:15:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+e44-_AFqKEkUAKKWapMB7wHCPDCtuWrPvn__NMpNxOw@mail.gmail.com>
Message-ID: <CAL_Jsq+e44-_AFqKEkUAKKWapMB7wHCPDCtuWrPvn__NMpNxOw@mail.gmail.com>
Subject: Re: [RFC 03/10] phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 4:23 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Rename hikey970 to hi3670, in order to use a namespace
> similar to hi3660 driver.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/phy-hi3670-usb3.txt          |  4 +-

Bindings should be a separate patch.

>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 98 +++++++++----------
>  2 files changed, 51 insertions(+), 51 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> index 4cb02612ff23..2fb27cb8beaf 100644
> --- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> @@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
>  -----------------------
>
>  Required properties:
> -- compatible: should be "hisilicon,kirin970-usb-phy"
> +- compatible: should be "hisilicon,hi3670-usb-phy"

Unless this is unused, we can't just change it. It's an ABI.

>  - #phy-cells: must be 0
>  - hisilicon,pericrg-syscon: phandle of syscon used to control phy.
>  - hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> @@ -14,7 +14,7 @@ Refer to phy/phy-bindings.txt for the generic PHY binding properties
>
>  Example:
>         usb_phy: usbphy {
> -               compatible = "hisilicon,kirin970-usb-phy";
> +               compatible = "hisilicon,hi3670-usb-phy";
>                 #phy-cells = <0>;
>                 hisilicon,pericrg-syscon = <&crg_ctrl>;
>                 hisilicon,pctrl-syscon = <&pctrl>;
