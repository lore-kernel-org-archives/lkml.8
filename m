Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DCEC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1120752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584747111;
	bh=TQcSy/pByrbT1hzG2L6cVJWyJ6MAQEHKZ/tQ1mwysZI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=q+wgZW/VtOsolws6BvoikXhO/zEWEyifjjgGcGE6sjrTU2AWY7c4X71vN60zcvcvZ
	 LhqfkeIL2cpfgbj7r7HNIDfQZl+sWsnba9yYoUop+KYKM296/QQvQi5Ke66p2AZLww
	 Z16ALgwCURB2iiKh2zja+4AW89wpwsi+KYGDCUBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCTXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:31:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3605420714;
        Fri, 20 Mar 2020 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584747109;
        bh=TQcSy/pByrbT1hzG2L6cVJWyJ6MAQEHKZ/tQ1mwysZI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DUY/692/CW8W4G1zBFfaY7jOUPWM9Dx88cigBgqmqlp/DMWC9hrxr7lTp7Dh3eNik
         tB3ChVnyYEMoK30Nrwd6W7qKzZeEqaWKJcr51xU0x/2oaSv3GNw2PwfPCjDiC3EeY6
         mL+jTjymT+OfT4c5soxDOwC61ZKHn2jGnKHeetmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200319053902.3415984-3-bjorn.andersson@linaro.org>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org> <20200319053902.3415984-3-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/4] clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Mar 2020 16:31:48 -0700
Message-ID: <158474710844.125146.15515925711513283888@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-03-18 22:39:00)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Doc=
umentation/devicetree/bindings/clock/qcom,mmcc.yaml
> index 85518494ce43..65d9aa790581 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> @@ -67,6 +67,10 @@ properties:
>      description:
>         Protected clock specifier list as per common clock binding
> =20
> +  vdd_gfx-supply:

Why not vdd-gfx-supply? What's with the underscore?

> +    description:
> +      Regulator supply for the GPU_GX GDSC
> +
>  required:
>    - compatible
>    - reg
