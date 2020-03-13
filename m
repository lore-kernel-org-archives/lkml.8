Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB89C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8D32074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584131801;
	bh=YGjsqFx/56tPlZc6Xud+QYhtZNOqdz27BP2OPxM/VMs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=agFGjG7c8aiNvRZ20x1T/ogeOXKX8rKj7N+96wWRr3whHuc8FBm23YA3I/nlD3wgf
	 jbnNtTy/snTfj47MN+w8MEHuQFw3j2XSUvh/+C9V3T2TeMsL8EXLvzH2IMYz5iKA0N
	 7dl7+yzZcITtWZacse9XrZrv9MHwRplFnQf0ddYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCMUgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMUgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:36:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925742074B;
        Fri, 13 Mar 2020 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131798;
        bh=YGjsqFx/56tPlZc6Xud+QYhtZNOqdz27BP2OPxM/VMs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YViRRY43mziJONtuFz5Bp3a+BpVgGSdn3ONn730D2vjKAAhCsAGt1+OJ8JVbzZt74
         mWrY3sTHWW0iI1G7o6+V6a605f6Tdi1Y0Bl7Zz0P2LhA7nQhFmljkAwizDqFzjYSIg
         4xae7eKiexz7GheW+/2l8Ce65igJtXBwzYsFJyN8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200313195816.12435-1-ansuelsmth@gmail.com>
References: <20200313195816.12435-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] ARM: qcom: Disable i2c device on gsbi4 for ipq806x
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Mathieu Olivari <mathieu@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>, agross@kernel.org
Date:   Fri, 13 Mar 2020 13:36:37 -0700
Message-ID: <158413179776.164562.8295974225127853050@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2020-03-13 12:58:16)
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts=
/qcom-ipq8064-ap148.dts
> index 554c65e7aa0e..580aec63030d 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> @@ -21,14 +21,5 @@ mux {
>                                 };
>                         };
>                 };
> -
> -               gsbi@16300000 {
> -                       i2c@16380000 {
> -                               status =3D "ok";
> -                               clock-frequency =3D <200000>;
> -                               pinctrl-0 =3D <&i2c4_pins>;
> -                               pinctrl-names =3D "default";
> -                       };
> -               };
>         };
>  };
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806=
x.c
> index b0eee0903807..75706807e6cf 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -782,7 +782,7 @@ static struct clk_rcg gsbi4_qup_src =3D {
>                         .parent_names =3D gcc_pxo_pll8,
>                         .num_parents =3D 2,
>                         .ops =3D &clk_rcg_ops,
> -                       .flags =3D CLK_SET_PARENT_GATE,
> +                       .flags =3D CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSE=
D,

A better solution is to use the protected-clocks property so we don't
try to touch these clks at all on this device. So this whole patch can
be routed through arm-soc and remove the i2c node and add some dt
property to the gcc node.

>                 },
>         },
>  };
