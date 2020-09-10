Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79296C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143B421D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kj5yuItS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgIJOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgIJOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:40:42 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF17C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e14so3501456vsa.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wYSv2yNWOcm4swEzcOjcSrWwn0iN5ISZ7p6aiaQtxY=;
        b=kj5yuItS5VW5RD+cgq8g4j3xq/R7MiuNMmVVtmTlNO/uY+xoAwD4LNuNxyQtyIbDec
         C5oWEWUkk1Uv9J97FOOUvy96B/Nnb5QKCBDMqnZyVYULLLSKjCHMDQjTdvDVB2pdvOVk
         igIGtx9irofGK2AiYhVhw1fm0moseGf1NxXyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wYSv2yNWOcm4swEzcOjcSrWwn0iN5ISZ7p6aiaQtxY=;
        b=r7Y1gapd4HssIeu2ZL/RT9oYSggV8u/ztbpN1Euv+Hrzb7f03n6jCROzJC6H8TMbN3
         285j4Et/V2d2JfdOUSJ6YGAkvk+fgrgF0sqI3mXQZtDT8bgGm6oIwpBgdYWjJRnzo7Pe
         w8nSs/IW8WaSE+IgmdwP/qTi8gJUiGWY12f1uTLR+T3ycGejtAlJ16lSKXg7KklbmH8v
         FiKcwxg2EBrjydamyaB6rquKdzAgQeVwWMRZyoXBSHXNajZ+9JwbU6e3tfgjbGG7SIVF
         3qjS4lvVyFi+xgghR+Sw8AfJ+f4LMyv1ah9eBMN4AEFMkQT46/d+epjnYniOI7AKWFvp
         E9oA==
X-Gm-Message-State: AOAM532H3tbnnwdB7gL0hT2reff9r8enboVNM0GEk2YdkYt4Tyc5lVK+
        HpKBNeYz03JxRNsCYlfDoA97qG1SFvst6g==
X-Google-Smtp-Source: ABdhPJxR8bLRw/botEZvJztBSkY9WZusbSEgXjXuv8cbJAqbDi+BkuF732CRbw08A+BiYTXd6C0/Qg==
X-Received: by 2002:a67:383:: with SMTP id 125mr4344793vsd.9.1599748837646;
        Thu, 10 Sep 2020 07:40:37 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a7sm771831vsl.12.2020.09.10.07.40.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:40:36 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id q67so3510497vsd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:36 -0700 (PDT)
X-Received: by 2002:a05:6102:10c2:: with SMTP id t2mr4114960vsr.10.1599748836032;
 Thu, 10 Sep 2020 07:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <1599742438-16811-1-git-send-email-skakit@codeaurora.org> <1599742438-16811-3-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1599742438-16811-3-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Sep 2020 07:40:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULJqgHutr524wb-wVq4gejqo1p_zqRXP=h4Co6Gvmzew@mail.gmail.com>
Message-ID: <CAD=FV=ULJqgHutr524wb-wVq4gejqo1p_zqRXP=h4Co6Gvmzew@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] arm64: dts: qcom: sc7180: Add necessary pinctrl
 and interrupt config for BT UART
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
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - This patch adds sleep state for BT UART. Newly added in V2.
>
> Changes in V3:
>  - Remove "output-high" for TX from both sleep and default states
>    as it is not required. Configure pull-up for TX in sleep state.
>
> Changes in V4:
>  - As per Matthias's comment, removed drive-strength for sleep state
>    and fixed nit-pick.
>
> Changes in V5:
>  - As per Matthias's comments, moved pinmux change for sleep state,
>    pinctrl and interrupt config to the board specific file.
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 48 +++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Similar comment to patch #1 in that this applies only to the IDP board
but that's not obvious from ${SUBJECT}


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 04888df..e529a41 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -344,6 +344,10 @@
>  };
>
>  &uart3 {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-1 = <&qup_uart3_sleep>;
> +       interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +                               <&tlmm 41 IRQ_TYPE_EDGE_FALLING>;

You need a:

/delete-property/interrupts;

...or, alternatively, a patch before this one that converts all the
UARTs in sc7180 to just use interrupts-extended.


>         status = "okay";

Slight nit is that usually I see the status line first.  All the other
instances in this file have it that way.  Can you match?




-Doug
