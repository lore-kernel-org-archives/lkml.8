Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7249C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F502063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgF2SkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:40:15 -0400
Received: from muru.com ([72.249.23.125]:59944 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgF2SkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 48A3381C1;
        Mon, 29 Jun 2020 18:21:43 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:20:48 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: ARM: dts: motorola-mapphone-common: remove unneeded
 "simple-graph-card"
Message-ID: <20200629182048.GB37466@atomide.com>
References: <87r1ub39hq.wl-kuninori.morimoto.gx@renesas.com>
 <20200619113607.6h5qnq26nhxijjhp@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619113607.6h5qnq26nhxijjhp@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [200619 11:37]:
> Hi,
> 
> On Fri, Jun 19, 2020 at 02:33:36PM +0900, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Audio Graph Card is using "audio-graph-card" prefix instead of
> > "simple-graph-card", and moreover "widgets / routing" doesn't need it.
> > This patch removes unsupported "simple-graph-card" prefix from
> > motorola-mapphone-common.dtsi and vendor-prefixes.yaml.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Probably best to merge this along with the other asoc patches:

Acked-by: Tony Lindgren <tony@atomide.com>
