Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA5C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E0020848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0HJWZyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCKJTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:19:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38743 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:19:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id h5so1984027edn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmtKDGUYuG7F5ier3ytBGX7nrV1tLNtpZ8bZTDERCN0=;
        b=I0HJWZylukZsSxnfiD6bjxOnk/ELuRVRJQStaFLEbwpL/yC+VBBYMDBYNf3AevSXQ4
         IlB5Hhf+jYMUgcq4r7pMkTIOQAooTu0z2D31glUyPptvSu8vsigQPlHnfRDXlXjA0Zk+
         h9xBVZ/zCCpxq7EyMQJeLVj/SZF4HHgy5OA/D39ii14rYaPrHUGDR/uOwSDOt7d4WSTq
         L1iaQTFpDQE2Etl0muIFiG4a/PtcNAmdMYbyN7oatkk1v/mE38L06U4kcZ9ZUNDq88Fc
         ycYJTmTQ+HmSO2BG21gLnK77IyomBBvaIUrSciNBBM+dd500ySi9707FT2m1fAsiV6eP
         YQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmtKDGUYuG7F5ier3ytBGX7nrV1tLNtpZ8bZTDERCN0=;
        b=PWUUS9r4tq4YbVOJqhXtuOjCEPfKNQoElIS9i1c3N5JkZPrwbUFlIohuAmwit4RmTr
         t5JpsYTmVe31QSNL9F1JFubjgMCsWDuunIjMq6k/sziTrGCln+g8lafzyzeMO+Ew4TFi
         PxcN6kMoEUcDpggnpXKg5jIJQsb4WpP/lLQookBTSi2gPU6FnkGB1qQuMmeGsCYti5P6
         x71F202/lB0WiwxH0RQMjgACEBgYIuNkIG0GR2NMlEEgHgnkyKAviPachQhnvVn0szLm
         h3tDf6fAyIGrXgAypFXZTPzK+XVj4oLMAhfPZsV/B1JxR0ou5ATDfGIRqGS8liEdk25J
         lHfA==
X-Gm-Message-State: ANhLgQ0tiQMJ53NEB4Sm2+dJPmpbSBKfY9tOmgClvnetTFoOkF/4WZxQ
        4jr4zQQais93COkYOwFfknyF0NwRltxK+dKBnlSG/Q==
X-Google-Smtp-Source: ADFU+vvoTtkBtQdM9NOqONrxxTGORBUCqKuUEtSHcAs+812eNyJUFXzaZ7ClDJjzt3mLQLb/brNX1z8b7Lt8MNIJmFQ=
X-Received: by 2002:a05:6402:618:: with SMTP id n24mr1906687edv.366.1583918370705;
 Wed, 11 Mar 2020 02:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200310175452.7503-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200310175452.7503-1-srinivas.kandagatla@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 11 Mar 2020 10:22:55 +0100
Message-ID: <CAMZdPi9446g388LfJPXTi-mt-+EyhkxVTMA4YGs65PX-paVu8w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: msm8916: Add fastrpc node
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 at 18:55, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Add fastrpc device node for adsp with one compute bank.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index bef1a66334c3..a7cd8f87df97 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1157,6 +1157,19 @@
>                                 qcom,remote-pid = <1>;
>
>                                 label = "hexagon";
> +                               fastrpc {
> +                                       compatible = "qcom,fastrpc";
> +                                       qcom,smd-channels = "fastrpcsmd-apps-dsp";
> +                                       label = "adsp";
> +
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       cb@1{
> +                                               compatible = "qcom,fastrpc-compute-cb";
> +                                               reg = <1>;
> +                                       };
> +                               };
>                         };
>                 };
>
> --
> 2.21.0
>

Tested on dragonboard410c with various HexagonSDK examples

Tested-by: Loic Poulain <loic.poulain@linaro.org>
