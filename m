Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F023C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF34D207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586541155;
	bh=NSx+Q67i//I/6xT9Q3B5BFbOJfQ/XJkYOLB7WHdRK0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RXFESv5V9JFUJyM/loctq6eTXTKdpObqb1IcGsxHm3UXpt/wJWZ5YreWEwf6l1fGM
	 wmdBkedujwmggJgSfba/nRFtUqVjYHc0UH7LwnqP+yl3H7/nKHX+K74ffGyDzrNDj6
	 UZkI2zJwIkllGepNWfUrJS+qIVbcQ69f8oqd9ZAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDJRwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:52:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39044 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:52:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so2549647otp.6;
        Fri, 10 Apr 2020 10:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lrdln4dBvVFJR91vr9hlZjSH31XigTv0FjlsPXSoRUo=;
        b=LYUmBAxqOn/A6GVstNklA+s8sLWlybiYvixCZrI3SftnppuP847ZIxc0wIlqfNBEFc
         ynbc4VvHP0SYnPRoDFJoKJtPgscu5vGIL1ITksPSVhPWN1Hvab/jX6ud86g+ANQHzi7D
         zsMUKs0boR3ji4VugPOF3kiRzMS61Q1a7VfQJ5ILBL6fYUHWVXq4gKjSzlUqHPNSmtPt
         Job0cqfOuP96dm1rTxekPd8Wp3Sldl1Qpe9Uy7bcB8UonzEhn0EYQ8uGG7YgEybG8l6z
         M1kPmj02zZBeuWgFSb1hDdsnD1IN3T0vamvFztNOI4WTmwF77Q5h8pyeHjFETZRT0X/t
         almQ==
X-Gm-Message-State: AGi0PuYuKMptGaEAfJ4asyyc71Ax20sOTV6LGKn8hZWJc5fB4hA7Kt8x
        Rp7kRGxOAkKi2xUxCbS+BA==
X-Google-Smtp-Source: APiQypIJzpPqxAkQRlPF/5U3xRWWYMkPbwF7Wx4paxMhG5vqpFOLez8zWuPdHwN38LwnKLQ3TbUQkw==
X-Received: by 2002:a9d:77cf:: with SMTP id w15mr5195937otl.158.1586541152824;
        Fri, 10 Apr 2020 10:52:32 -0700 (PDT)
Received: from rob-hp-laptop (ip-173-126-55-226.ftwttx.spcsdns.net. [173.126.55.226])
        by smtp.gmail.com with ESMTPSA id 26sm1698146oot.25.2020.04.10.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:52:32 -0700 (PDT)
Received: (nullmailer pid 1070 invoked by uid 1000);
        Fri, 10 Apr 2020 17:52:30 -0000
Date:   Fri, 10 Apr 2020 12:52:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] ARM: dts: rockchip: fix yaml warnings for
 rk3288-pmu-sram compatible nodes
Message-ID: <20200410175230.GA28412@bogus>
References: <20200331121352.3825-1-jbx6244@gmail.com>
 <20200331121352.3825-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331121352.3825-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 02:13:52PM +0200, Johan Jonker wrote:
> A test with the command below gives for example these warnings:
> 
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
> '#size-cells' is a required property
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
> 'ranges' is a required property
> 
> Fix this error by adding '#address-cells', '#size-cells' and
> 'ranges' to the 'rockchip,rk3288-pmu-sram' compatible node
> in rk3288.dtsi.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Not tested with hardware.
> 
> Changed v2:
>   Fix dtsi.
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 9c8741bb1..f102fec69 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -730,6 +730,9 @@
>  	pmu_sram: sram@ff720000 {
>  		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
>  		reg = <0x0 0xff720000 0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0xff720000 0x1000>;

I think we should make these optional instead if there's no child nodes. 
And if there are child nodes, then these will be required.

Rob
