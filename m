Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571CEC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6420722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589207126;
	bh=Mog0uHKNGC4M58mR6XZNypAnj4EbLBN8Kksnmu+paY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p0zCHUvabpRIpN/sE8N6N2tYJX1cWYNr+26la4XDM1sPq0VFaGjGC4fZWcS8J0Zl5
	 YFTXqAUVMBKvLeBuhZcF9Om5pmnTWmTbGYXcjgBCb7MGD+MJ0qK2Z0OhTRIap+ajji
	 aaESGAB54zYYkIOYm3wFjgH8dNEKHQn0YgjM3RhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgEKOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKOZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:25:24 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2128A20720;
        Mon, 11 May 2020 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589207124;
        bh=Mog0uHKNGC4M58mR6XZNypAnj4EbLBN8Kksnmu+paY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvmpmyVrRNbi0A3YvOn3ZCPJYU+VTX5gO2746dD3N6Hv4Hlu5VcceNIHCjx3N4t9g
         /rQxL3rh/3DQqjaTbAq/aivalGVLtQEIfXKEPWc7OeJxiMmPAj/45hkdx/0y7E8uHj
         BL29kx1UHt5XgWMjZcffDrSgz3SjeObAqGDbUyDw=
Date:   Mon, 11 May 2020 22:25:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V4 0/4] ARM: imx7ulp: support HSRUN mode
Message-ID: <20200511142509.GA26997@dragon>
References: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
 <DB6PR0402MB27607B567D3FD7731A41E75688A50@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27607B567D3FD7731A41E75688A50@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:27:52AM +0000, Peng Fan wrote:
> > Subject: [PATCH V4 0/4] ARM: imx7ulp: support HSRUN mode
> 
> Ping..
> 
> Thanks,
> Peng.
> 
> > 
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > V4:
> >   Fix dt_bindings check
> >   The same patchset was wrongly posted as V2,
> >   https://patchwork.kernel.org/cover/11485107/
> > 
> > This is a splited part from V2:
> > ARM: imx7ulp: add cpufreq using cpufreq-dt
> > https://patchwork.kernel.org/cover/11390589/
> > Nothing changed
> > 
> > The original V2 patchset is to support i.MX7ULP cpufreq, still waiting the
> > virtual clk being accepted. so to decouple, this patchset only takes the run
> > mode part.
> > 
> > Peng Fan (4):
> >   dt-bindings: fsl: add i.MX7ULP PMC binding doc

Need an ACK from Rob on this new binding.

Shawn

> >   ARM: dts: imx7ulp: add pmc node
> >   ARM: imx: imx7ulp: support HSRUN mode
> >   ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
> > 
> >  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32
> > ++++++++++++++++++++++
> >  arch/arm/boot/dts/imx7ulp.dtsi                     | 10 +++++++
> >  arch/arm/mach-imx/common.h                         |  1 +
> >  arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 ++++++++--
> >  arch/arm/mach-imx/pm-imx7ulp.c                     | 25
> > +++++++++++++++++
> >  5 files changed, 79 insertions(+), 3 deletions(-)  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> > 
> > --
> > 2.16.4
> 
