Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421E12072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="fUVsBbEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEM7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:59:40 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41840 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCEM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:59:38 -0500
Received: by mail-vk1-f194.google.com with SMTP id y201so1565929vky.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENi9YssFnNrxIavWdof089xJmIH8gmeds5g//LfUp44=;
        b=fUVsBbEloBN3ui7o2WuEDc4txVUIiaEuZ54fCn8hUe2OgxGlrRouGF/0tM/JRlLskK
         wc9gnLtfk5lcXDMK+ZM6gwalTXjVvfCGOHi3NntxWHBmcaUh/2yC3bTb6gd96gJyHE+8
         hxFDdihTUi47ba5vmrhc/kHp2sD3mXR0zIoNmvw7o4aGi90mb8IuwHXLcHmyFauAKT9E
         fkEYEA7XzgoqpB31snLHS8ZZ1FN2ecKdQAWeBbpxBvbucg/7iOMPuYugJ5rNui8C6Xx+
         XmJI/oVR9yH6EUO0VDVTvQEjXjLkW2N2uv4wVJpWVWYtGrJ+XOL39wYB+NNSSXptkB12
         +Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENi9YssFnNrxIavWdof089xJmIH8gmeds5g//LfUp44=;
        b=O5fZjMs/1gy0/ITVFA8WBGcjpVYNgeqH6UAATjn2UdMsWIsd8D2rOQ29aeRFmh63B1
         A2s41hmJyxgQRphqLY9MJTZhy/6WYZjW4e1mtkAjrTzgnU5P/ejQ3zBTNKLhdu2XSTmI
         Fn8YFjBkZYwHtXPnfnjqxB/044nzGaF13gVQ97GivFmWptaQwpHLS/gsFrQEih5j8jeo
         qDf0FijqpZ+ujmuTNPhuYsCvndlF+heZCwoFq4q+poE9UkxiPLbDTXtmiLgPHDo4G3dp
         uV34fvwgwD1BKCdJkeY0AULpqZeR9R22uRYFHc86MYmTVXUd+Vo32IsH2zebY+/jjfkj
         caVA==
X-Gm-Message-State: ANhLgQ3/bgn50GGnxEdNMvwCCUEYL85PpdocZdBhSkBF1h7RUsE7YKIQ
        eXuQui56IRr6jlm/uW5HxThsH8Zyn2CZEn/+15mDqQ==
X-Google-Smtp-Source: ADFU+vthOpcSnEMfoc58TZoJB2q1XsBRBO/ycdfjLggnL0JssdRwpzmWuaPKw+kP/3woe4bR5m8vDpKaITSqlpVksuk=
X-Received: by 2002:a1f:2882:: with SMTP id o124mr4678329vko.86.1583413176966;
 Thu, 05 Mar 2020 04:59:36 -0800 (PST)
MIME-Version: 1.0
References: <1583394547-12779-1-git-send-email-rkambl@codeaurora.org> <1583394547-12779-2-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1583394547-12779-2-git-send-email-rkambl@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Mar 2020 18:29:26 +0530
Message-ID: <CAHLCerM-qkkJWqdGWk62XzHmw2AiVBFgKNBYnkvPtwq7+VGKqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7180: Added critical trip point
 Thermal-zones node
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sanm@codeaurora.org, sivaa@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajeshwari,

Please cc reviewers of the previous version of the patches in the future.

On Thu, Mar 5, 2020 at 1:19 PM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> To enable kernel critical shutdown feature added critical trip point to
> all non CPU sensors to perform shutdown in orderly manner.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 253274d..ca876ed 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2366,6 +2366,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               aoss0_crit: aoss0_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2421,6 +2427,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               gpuss0_crit: gpuss0_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2436,6 +2448,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               gpuss1_crit: gpuss1_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2451,6 +2469,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               aoss1_crit: aoss1_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2466,6 +2490,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               cwlan_crit: cwlan_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2481,6 +2511,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               audio_crit: audio_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2496,6 +2532,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               ddr_crit: ddr_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2511,6 +2553,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               q6_hvx_crit: q6_hvx_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2526,6 +2574,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               camera_crit: camera_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2541,6 +2595,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               mdm_crit: mdm_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2556,6 +2616,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               mdm_dsp_crit: mdm_dsp_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2571,6 +2637,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               npu_crit: npu_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>
> @@ -2586,6 +2658,12 @@
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> +
> +                               video_crit: video_crit {
> +                                       temperature = <110000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
>                         };
>                 };
>         };
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
