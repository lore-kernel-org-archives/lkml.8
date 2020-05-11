Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6317C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92F1207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589206631;
	bh=Ob5LzW6or1bgt8QJEej0N0n3nAwNIxNlGYzct4IBp9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jYoz70qclHU7zqECJ0teH2PNIPxn86LCSk2xk8rwY18EBx7pL8QN9q2dC5YC2MuO5
	 xjs7CS8uWoO8Gurr+R46Vsonuso8z2r9iE06Dzbzkk/Y8933BIOFPBmGvQ+YKugZ8L
	 wDXD54UNjeI7Hnzpap93tP3qRQrWmJ1V/yci233Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgEKORL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbgEKORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:17:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580EC206DB;
        Mon, 11 May 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589206630;
        bh=Ob5LzW6or1bgt8QJEej0N0n3nAwNIxNlGYzct4IBp9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snUjkqAvRJ2UBs9scUQny0zXdyEbfo4nBNpyVvsaIfkPVmR6+TckArxHbw+c4Ynbb
         77kcmlUvk0Wr5Zz171wxr1Cnqm5vLH+YyUZV3jxyOCR4Yb8XrBHs9+FCRviUBPfh1U
         D+obonNTIrWL1qyScSnKtG/5Mgqhvw80b5PBDKK0=
Date:   Mon, 11 May 2020 22:16:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: Re: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Message-ID: <20200511141649.GA26831@dragon>
References: <20200407064251.39244-1-biwen.li@oss.nxp.com>
 <20200426131751.GC30501@dragon>
 <DB6PR0401MB2438A8B634DBE15FADD3CFB18FA20@DB6PR0401MB2438.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0401MB2438A8B634DBE15FADD3CFB18FA20@DB6PR0401MB2438.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:35:47AM +0000, Biwen Li (OSS) wrote:
> > 
> > On Tue, Apr 07, 2020 at 02:42:48PM +0800, Biwen Li wrote:
> > > From: Biwen Li <biwen.li@nxp.com>
> > >
> > > The patch adds ftm_alarm0 DT node for Soc LX2160A
> > > FlexTimer1 module is used to wakeup the system in deep sleep
> > >
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 18
> > > ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > index e5ee5591e52b..e0d8d68ce070 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > @@ -16,6 +16,10 @@
> > >  	#address-cells = <2>;
> > >  	#size-cells = <2>;
> > >
> > > +	aliases {
> > > +		rtc1 = &ftm_alarm0;
> > > +	};
> > > +
> > >  	cpus {
> > >  		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > > @@ -768,6 +772,20 @@
> > >  			timeout-sec = <30>;
> > >  		};
> > >
> > > +		rcpm: rcpm@1e34040 {
> > 
> > Keep the node sort in unit-address.  Also, try to use a generic node name.
> Hi Shawn,
> Sorry for late reply.
> The node sort will be updated in v2.
> rcpm is called as Run Control and Power Management. Don't
> Have a generic node name, any suggestions?

It sounds like some sort of power controller, so maybe 'power-controller'?

Shawn
