Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FAAC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557F92076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCRLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:08:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33250 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRLIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:08:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEA862003C6;
        Wed, 18 Mar 2020 12:08:08 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C18FD201202;
        Wed, 18 Mar 2020 12:08:08 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AD12620506;
        Wed, 18 Mar 2020 12:08:08 +0100 (CET)
Date:   Wed, 18 Mar 2020 13:08:08 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 10/11] reset: imx: Add audiomix reset controller support
Message-ID: <20200318110808.hzwr7m2hc2nfftvm@fsr-ub1664-175>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
 <ac6eb54c01cce4ec52560ac622e024ab47f2136c.camel@pengutronix.de>
 <20200313141606.euumtuizm562zghv@fsr-ub1664-175>
 <3aedf6357f321efaf1d59a0b654300803ad51cef.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aedf6357f321efaf1d59a0b654300803ad51cef.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-13 16:55:47, Philipp Zabel wrote:
> On Fri, 2020-03-13 at 16:16 +0200, Abel Vesa wrote:
> [...]
> > > > +	if (assert) {
> > > > +		pm_runtime_get_sync(rcdev->dev);
> > > 
> > > This seems wrong. Why is the runtime PM reference count incremented when
> > > a reset is asserted ...
> > 
> > The audiomix IP has its own power domain. 
> 
> The reset controller does not control the power domain for its
> consumers. The consumer of this reset should implement runtime PM.
> 

No, the reset controller itself is part of a more complex IP called audiomix
that has its own power domain.

> > The way I see it, when the last deassert is done, there is no point
> > in keeping the audiomix on. So, unless the clock controller part of it does it,
> > the audiomix will be powered down.
> 
> You mean when the last assert is done? Presumably the driver wants to
> use the hardware after deasserting the reset and asserts the reset when
> it is done.

No, I mean deassert. If there is no reset asserted anymore, then the audiomix
can power down, if nothing else (I'm talking about the other stuff that's
in the audiomix, like clock controller) keeping it on.

The reset controller needs to be on only when there is an assertion of at least
one reset bit going on.

> 
> regards
> Philipp
