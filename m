Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE93C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E332720780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592883645;
	bh=YnFKD2SuD44mKD4MHh/11/4JdpjARNP9QmTVMDETsFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hSTnRWG3pAavxeds6WPnqvjuhQobwazUTkZen/LFFhUzNAtfx1KKusHItB29Dzpdx
	 WtaNbsWYrJRmFw6S6O+mImKgaMsQpebBjDM8tOonNHeoHVJgTQYCuupjGnQAVPwTdb
	 DY3sh4CSPgrdd72SLCxas2Zk6mQAedNeuzUTV1gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgFWDkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgFWDkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:40:42 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03DB206C1;
        Tue, 23 Jun 2020 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592883641;
        bh=YnFKD2SuD44mKD4MHh/11/4JdpjARNP9QmTVMDETsFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwQ/rjW3rD29ihmU/ZiivDNFUn9sMGLMqcGoVW6l03+BONg1fSJkoaNzzCQ7oWIau
         hPLFxOsjW6gfmOnOoNHHiE0woEMl5Zh8kCC8q0FBMyKkPFpax7OhnB8ib/mhBy3TTP
         +BYdTj/gzPOj6REQ0BM3Ac/2n6teqZqE8PEUdg1k=
Date:   Tue, 23 Jun 2020 11:40:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: Change WDOG_ANY signal from push-pull to
 open-drain
Message-ID: <20200623034033.GJ30139@dragon>
References: <20200528144312.25980-1-frieder.schrempf@kontron.de>
 <20200528144312.25980-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528144312.25980-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 02:43:43PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The WDOG_ANY signal is connected to the RESET_IN signal of the SoM
> and baseboard. It is currently configured as push-pull, which means
> that if some external device like a programmer wants to assert the
> RESET_IN signal by pulling it to ground, it drives against the high
> level WDOG_ANY output of the SoC.
> 
> To fix this we set the WDOG_ANY signal to open-drain configuration.
> That way we make sure that the RESET_IN can be asserted by the
> watchdog as well as by external devices.
> 
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Added 'imx6ul-kontron:' to subject and applied both patches.

Shawn
