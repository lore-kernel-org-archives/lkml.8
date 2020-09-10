Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4469207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVSPAVfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgIJOz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731055AbgIJOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:52:36 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC0C061799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:42:44 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s127so1623973vkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xn2z91UfCtrgcaftSJI2dNlH0TFk/vXw21rz//Drd/M=;
        b=UVSPAVfNwE3+6oK7YYZjhiud+K7lnkgA2zgaHh02Rowe50M2AyiZS9odTByUXmtVxF
         Di08SfgpXs/tjHW3UcuczZMqEczt1J/Rek8K66sVerDDfqDSau4pvge+N0mcHDWOLNBL
         nHy3s4N6+sgOwEX3D20NKo0xUVYSDGqfM97OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xn2z91UfCtrgcaftSJI2dNlH0TFk/vXw21rz//Drd/M=;
        b=blGYNsEz69LUgx4Y+owAaXinFXUhrwoiZVMdDiWoKQq3A6hs7Ggqa/uVmZT2csP8mt
         RmLcY/SSuBU98M2zGODdlV7r++Cc0JsObOGi8nGJH/+SeMwO+lrg3Bh8rH97TcSjhuFg
         omQJZacEI/2274hoqGS3g8N49mT3Ykqne+goHaBZVaWDdvQhG3Q0CPhgKxTbt7ku+Bs5
         QEkvQhsUV1vnbWz8MPM9UDb1mG8DSdW/SwbfAud5a9PVEYRIwtUnOZLq4kIwvF4NCYli
         wPdSlBa+pU2j42/AwK8uATJfD/6Gl0S0STvIKChchVz9gT1eO0CoG9+vzb2rEGAheAly
         nIfA==
X-Gm-Message-State: AOAM532KWqFukTOZ2z3oQA9FOUBYldT3ipG5DQ/+sh08JO9HD1hm/4Jp
        pk08khteg+su7wlSrbp0ydHSHyG3kXiy7Q==
X-Google-Smtp-Source: ABdhPJzHV3eJF3p0mKcm9cE8cMQ3QAQPktmoU4sOuzG4xlV7qQ4WFtR6qpflj7feLg7imr8qwira7A==
X-Received: by 2002:a1f:988f:: with SMTP id a137mr4170220vke.8.1599748962984;
        Thu, 10 Sep 2020 07:42:42 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a59sm498393uaa.12.2020.09.10.07.42.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:42:42 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id a16so3498779vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:42:42 -0700 (PDT)
X-Received: by 2002:a67:d907:: with SMTP id t7mr4555810vsj.8.1599748961645;
 Thu, 10 Sep 2020 07:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <1599742438-16811-1-git-send-email-skakit@codeaurora.org> <1599742438-16811-4-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1599742438-16811-4-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Sep 2020 07:42:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wxo6ggLN39UMtMNwd6GOQwnEjA1MCxHjB6cmE9RTRMPA@mail.gmail.com>
Message-ID: <CAD=FV=Wxo6ggLN39UMtMNwd6GOQwnEjA1MCxHjB6cmE9RTRMPA@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] arm64: dts: qcom: sc7180-trogdor: Add pinctrl and
 interrupt config for BT UART
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

On Thu, Sep 10, 2020 at 5:55 AM satya priya <skakit@codeaurora.org> wrote:
>
> Add a suitable sleep configuration for uart3 to support Bluetooth wakeup.
>
> If QUP function is selected in sleep state, UART RTS/RFR is pulled high
> during suspend and BT SoC not able to send wakeup bytes. So, configure
> GPIO mode in sleep state to keep it low during suspend.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V5:
>  - Newly added in V5. This patch adds wakeup support for trogdor board files.
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 48 ++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Note: I can't find this email on any of the mailing lists.  Can you
check your config?  I tried:

http://lore.kernel.org/r/1599742438-16811-4-git-send-email-skakit@codeaurora.org

...and also checked patchwork servers.  I only see patch 1 and 2.  I
think Bjorn usually applies from patchwork so this'll likely be a
problem...


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index a6b9beb..96b5331 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -792,6 +792,11 @@ ap_spi_fp: &spi10 {
>  #include <arm/cros-ec-sbs.dtsi>
>
>  &uart3 {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-1 = <&qup_uart3_sleep>;
> +       interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +                               <&tlmm 41 IRQ_TYPE_EDGE_FALLING>;
> +
>         status = "okay";

Same comments here as for patch #2.


>         bluetooth: bluetooth {
> @@ -1345,4 +1350,47 @@ ap_spi_fp: &spi10 {
>                         drive-strength = <2>;
>                 };
>         };
> +
> +       qup_uart3_sleep: qup-uart3-sleep {

I believe things in this section are supposed to be sorted
alphabetically.  Thus "qup..." should be sorted before "trackpad..."
