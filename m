Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA08DC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97AC20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgCMPz7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:55:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58639 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:55:59 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jCmf7-00012X-Sk; Fri, 13 Mar 2020 16:55:49 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jCmf6-00054P-27; Fri, 13 Mar 2020 16:55:48 +0100
Message-ID: <3aedf6357f321efaf1d59a0b654300803ad51cef.camel@pengutronix.de>
Subject: Re: [RFC 10/11] reset: imx: Add audiomix reset controller support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
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
Date:   Fri, 13 Mar 2020 16:55:47 +0100
In-Reply-To: <20200313141606.euumtuizm562zghv@fsr-ub1664-175>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
         <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
         <ac6eb54c01cce4ec52560ac622e024ab47f2136c.camel@pengutronix.de>
         <20200313141606.euumtuizm562zghv@fsr-ub1664-175>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 16:16 +0200, Abel Vesa wrote:
[...]
> > > +	if (assert) {
> > > +		pm_runtime_get_sync(rcdev->dev);
> > 
> > This seems wrong. Why is the runtime PM reference count incremented when
> > a reset is asserted ...
> 
> The audiomix IP has its own power domain. 

The reset controller does not control the power domain for its
consumers. The consumer of this reset should implement runtime PM.

> The way I see it, when the last deassert is done, there is no point
> in keeping the audiomix on. So, unless the clock controller part of it does it,
> the audiomix will be powered down.

You mean when the last assert is done? Presumably the driver wants to
use the hardware after deasserting the reset and asserts the reset when
it is done.

regards
Philipp
