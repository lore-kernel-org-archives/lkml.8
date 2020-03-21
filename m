Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B8BC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01E22076E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753173;
	bh=UpjtCkcZ3o56cAD5W00WlFMo5JOW6OD8HqWxb7x/bZ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gI1GF1ZvPPUX7QIHiQig23gCCwJsCGBGaBA7yQMaMVkWGw1K7xyLBcXr3ZQ4C+G53
	 BciTR/PYGWc608S6VMWKDpLNRATYV31lTp4P2OxQTLiaNsc9Jm4LrNSld9XJBrD9jT
	 +MPRuwodwuMuGsphPOUEBV8mcTqT28IUoH1iaK20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCUBMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCUBMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:12:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A372076C;
        Sat, 21 Mar 2020 01:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753171;
        bh=UpjtCkcZ3o56cAD5W00WlFMo5JOW6OD8HqWxb7x/bZ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Mg8lE1bFa54K4tVF92hk40rIOHIBcCD2DMh/FAdBsS5xLIAOZu2EwDTfbieFqvbpV
         4ci2wS11utw+Q+XeE0TE4QhFiFRqfScZ+bdYXCHsxYc3hboiSZgmAHCyhwektViPa3
         luK37aFuKYUds2OQR3sqQF9ys25xgAnuklu7LLcU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200304072730.9193-4-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com> <20200304072730.9193-4-zhang.lyra@gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Mar 2020 18:12:50 -0700
Message-ID: <158475317083.125146.1467485980949213245@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-03-03 23:27:26)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> add a new bindings to describe sc9863a clock compatible string.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
[...]
> +examples:
> +  - |
> +    ap_clk: clock-controller@21500000 {
> +      compatible =3D "sprd,sc9863a-ap-clk";
> +      reg =3D <0 0x21500000 0 0x1000>;
> +      clocks =3D <&ext_26m>, <&ext_32k>;
> +      clock-names =3D "ext-26m", "ext-32k";
> +      #clock-cells =3D <1>;
> +    };
> +
> +  - |
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      ap_ahb_regs: syscon@20e00000 {
> +        compatible =3D "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> +        reg =3D <0 0x20e00000 0 0x4000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        ranges =3D <0 0 0x20e00000 0x4000>;
> +
> +        apahb_gate: apahb-gate@0 {

Why do we need a node per "clk type" in the simple-mfd syscon? Can't we
register clks from the driver that matches the parent node and have that
driver know what sorts of clks are where? Sorry I haven't read the rest
of the patch series and I'm not aware if this came up before. If so,
please put details about this in the commit text.

> +          compatible =3D "sprd,sc9863a-apahb-gate";
> +          reg =3D <0x0 0x1020>;
> +          #clock-cells =3D <1>;
