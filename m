Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF45C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82CB20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584341105;
	bh=45HRX2kButaKESws3Xm5vkgmtdBIZKtTd0w4e4q+taw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mddO5uFrtBJXRxs6k2Ub8JZBpmKazGoPcw9M49xQZPbjnlGvYeHdZ7R5RIY0+YM1t
	 wljP45GmxMD5rrclGEMQC4Oa6S04pTcLYnntkmfaRLYx0+4rXaSVQW8/8ww2hwdQQa
	 2rTu/nbUMWuK2gKVReIBlXDtM+ICaGqm5km0aRNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgCPGpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgCPGpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:45:03 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BB120674;
        Mon, 16 Mar 2020 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584341103;
        bh=45HRX2kButaKESws3Xm5vkgmtdBIZKtTd0w4e4q+taw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExuG8dEOm07lwytoqRDX1c7JEnS3I6oqEf+wJYTxGdKHZzwKD0HqmT+e217bhd6gQ
         GNe5+igC2J6rv1vqtil8mcNtXCbt1g5LZ4N3BWzWsytd1ndrpRoDG7WMYHi56s89Gg
         6OWEWg8I6OrCaVx+8+vyThhyEBeivarpqmmmaUxY=
Date:   Mon, 16 Mar 2020 14:44:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Message-ID: <20200316064456.GJ17221@dragon>
References: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
 <20200316060024.GG17221@dragon>
 <DB3PR0402MB3916C7F4D25024A30FF4EABDF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916C7F4D25024A30FF4EABDF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:31:21AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > Subject: Re: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
> > alphabetically
> > 
> > On Mon, Mar 16, 2020 at 09:26:32AM +0800, Anson Huang wrote:
> > > Sort the labels alphabetically for consistency.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V1:
> > > 	- Rebase to latest branch, no code change.
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 50
> > > ++++++++++++++++-----------
> > >  1 file changed, 30 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > > b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > > index d3d26cc..b1befdb 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > > @@ -30,18 +30,7 @@
> > >  	};
> > >  };
> > >
> > > -&adma_lpuart0 {
> > > -	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_lpuart0>;
> > > -	status = "okay";
> > > -};
> > > -
> > > -&fec1 {
> > > -	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_fec1>;
> > > -	phy-mode = "rgmii-id";
> > > -	phy-handle = <&ethphy0>;
> > > -	fsl,magic-packet;
> > > +&adma_dsp {
> > >  	status = "okay";
> > >
> > >  	mdio {
> > 
> > Here is a rebase issue, i.e. adma_dsp shouldn't get a mdio child node.
> > It came from the conflict with one commit on my fixes branch.  I decided to
> > drop the series for the coming merge window.  Let's start over again after
> > 5.7-rc1 becomes available.
> 
> OK, I am also confused by this conflict, I normally do the patch based on your
> for-next branch, and I did NOT meet the conflict at all, then I redo it based on
> your dt branch I met the conflict and fix it...
> 
> So, do I need to resend the patch series later when 5.7-rc1 available?

You need to resend later.

Shawn
