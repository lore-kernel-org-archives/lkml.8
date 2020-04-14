Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC7F206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586871883;
	bh=O3yHi+pTjZnUBnBeMdG1JkADKFH2MW5YvDy4Z2qPrcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ssCNrenjSBENE7kqBg3bo41oT8skNzOGhX+kLt08OMkX9ZWlcO/SFG0ygDZrBCpbk
	 G9yqZY83g7B/O+itBKuzY8WueeNeZ+gGvq4yxE+j0Mks8cto5Dp4eeBMlSPX9/1Joe
	 GUWmoiF7u0vhdksQkHtH0ekKi2DioIAsuKx3TSWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgDNNoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388027AbgDNNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:44:29 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1308E20578;
        Tue, 14 Apr 2020 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586871869;
        bh=O3yHi+pTjZnUBnBeMdG1JkADKFH2MW5YvDy4Z2qPrcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfe1f9rXR6Rra2tHviW4TL5Mj7F4YzPbqAcxAjObaQXpS/bLsktEHfVM3Ba806NIR
         vsZlKqqILcmKeAT0+EYEcpZcs8TFwty2bcMbyzhesFoegESQi9aDHhkFQM6DHO+Nbl
         I45djuh1LHdiZ/JgMfFRBZ2vr4RdLzA57vQLrKz8=
Date:   Tue, 14 Apr 2020 21:44:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com
Subject: Re: [PATCH V2 0/4] ARM: imx7ulp: support HSRUN mode
Message-ID: <20200414134419.GE30676@dragon>
References: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:49:04PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Fix dt_bindings check

Confusing.  The series posted on Mar. 16 was already numbered v3.  Now,
it goes back to v2.  You should at least have a note to explain how they
are related.

Shawn

> 
> This is a splited part from V2:
> ARM: imx7ulp: add cpufreq using cpufreq-dt
> https://patchwork.kernel.org/cover/11390589/
> Nothing changed
> 
> 
> The original V2 patchset is to support i.MX7ULP cpufreq,
> still waiting the virtual clk being accepted. so to decouple,
> this patchset only takes the run mode part.
> 
> Peng Fan (4):
>   dt-bindings: fsl: add i.MX7ULP PMC binding doc
>   ARM: dts: imx7ulp: add pmc node
>   ARM: imx: imx7ulp: support HSRUN mode
>   ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
> 
>  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
>  arch/arm/boot/dts/imx7ulp.dtsi                     | 10 +++++++
>  arch/arm/mach-imx/common.h                         |  1 +
>  arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 ++++++++--
>  arch/arm/mach-imx/pm-imx7ulp.c                     | 25 +++++++++++++++++
>  5 files changed, 79 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> 
> -- 
> 2.16.4
> 
