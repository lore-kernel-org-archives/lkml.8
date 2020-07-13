Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05321C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE05D20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594622181;
	bh=UT7xCgBr7XTK0g96nMID4egnSzqW6jseo+avRrShlUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ViLB4qoiQCOpTGgOh5Cckao6pYOObpR+Dxth5/s+GKAt328+2I7xAVTLh+pw317s1
	 IbCFMB+CqCG07kPzZP8G6hhUgP8t5OgtM0RCfzq4wqkzUTi0LlUKJiKPn4klg/Etsj
	 jSnGQmEU8hPAidsfEME3MoFebsxmB+opazI2/nPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgGMGgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgGMGgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:36:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E42C20720;
        Mon, 13 Jul 2020 06:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594622179;
        bh=UT7xCgBr7XTK0g96nMID4egnSzqW6jseo+avRrShlUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8k47lCLPPTQIhGZPWfJiSk2yvJ8A4JPnhgOjfHlKjK0sxYQ0ohoHESYQlkoLy9Nl
         p0wwkt6LSxfmr5qx/r6Tt/QII9QRTS/sEVclyFWTfZd0B+m4FvulQfvyFltSc8dUtk
         P7MZBLAdxg1EOkClpqPtKp8PUfYyXx11frYsrh7o=
Date:   Mon, 13 Jul 2020 14:36:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-ssmb-dtu: Pass "no-sdio"/"no-sd"
 properties
Message-ID: <20200713063611.GF12113@dragon>
References: <CAFXsbZoovWBavRFaEWEFcSkVjNx26BkKOkhcutNfzL8MrHwMTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXsbZoovWBavRFaEWEFcSkVjNx26BkKOkhcutNfzL8MrHwMTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 08:16:10PM -0700, Chris Healy wrote:
> esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
> properties.
> 
> esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>

I would suggest something like below for patch subject.

  ARM: dts: vf610-zii-ssmb-dtu: Add no-sdio/no-sd properties

Also the patch doesn't apply to my branch.

Shawn

> ---
>  arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> index 0bb3dcff0b79..7d4ddfb6b5b5 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> @@ -81,6 +81,8 @@
>      non-removable;
>      no-1-8-v;
>      keep-power-in-suspend;
> +    no-sdio;
> +    no-sd;
>      status = "okay";
>  };
> 
> @@ -88,6 +90,7 @@
>      pinctrl-names = "default";
>      pinctrl-0 = <&pinctrl_esdhc1>;
>      bus-width = <4>;
> +    no-sdio;
>      status = "okay";
>  };
> 
> -- 
> 2.21.3
