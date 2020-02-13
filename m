Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F61C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DDF217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581573342;
	bh=oZ9NJ9UTROJIGFfOVsLmAcHJvG9pvWM/bv++TCCy3jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0oV4ZOCVwOYBzyiOWesmTZtB74kCeMXkQbpvH/R4qkrP24XirOX7CR0XJ/88AS6ql
	 uwHZA4TJpIFUbsr9b6ZVO9CZ6Ffn4CF8rBjrMnNflbNpnxh6ku6nIgbIqopQcLjH0H
	 6rfkZfFeP6/LvzpyShjz5SogocXjUhZsz9F7xIks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgBMFzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgBMFzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:55:40 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F2E21734;
        Thu, 13 Feb 2020 05:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581573340;
        bh=oZ9NJ9UTROJIGFfOVsLmAcHJvG9pvWM/bv++TCCy3jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMIw2GOxI3U9lWOZpw7HxZ3wNRZBsRdvXa9/MZ3X4jk0NYycb5YQw05av1gUcosNL
         kr1aUKrJidbaVsj8Jxy63uipawGGazrbaodc+uGUKglcP+m8WIsOWsY3r4vnZkXFTg
         8Se2hzuMy23llWJ3M9COociqKPGHdVCZMwVbHh50=
Date:   Thu, 13 Feb 2020 13:55:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Message-ID: <20200213055532.GN11096@dragon>
References: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
 <1579167145-1480-2-git-send-email-peng.fan@nxp.com>
 <AM7PR04MB6981B45633536729EBEB427487310@AM7PR04MB6981.eurprd04.prod.outlook.com>
 <AM0PR04MB448103B7C47B9AA5621A731A88310@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200213054344.GM11096@dragon>
 <AM0PR04MB448134507B4F957C06F1315A881A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB448134507B4F957C06F1315A881A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:47:41AM +0000, Peng Fan wrote:
> > Subject: Re: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
> > 
> > On Fri, Jan 17, 2020 at 08:15:54AM +0000, Peng Fan wrote:
> > > > > Subject: [RFC 1/4] ARM: imx: use device_initcall for
> > > > > imx_soc_device_init
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > This is preparation to move imx_soc_device_init to
> > > > > drivers/soc/imx/
> > > > >
> > > > > There is no reason to must put dt devices under /sys/devices/soc0,
> > > > > they could also be under /sys/devices/platform, so we could pass
> > > > > NULL as parent when calling of_platform_default_populate.
> > > > >
> > > >
> > > > This change will impact various internal test case & userspace lib, I think.
> > > > Need to ask test team & other developer to double check the impact.
> > >
> > > /sys/devices/soc0 is still there, the patchset only moves the platform
> > > devices which under /sys/devices/soc0 to /sys/devices/platform
> > 
> > Jacky's concern still stands, as there are many user spaces which will be
> > broken and need update.
> 
> The soc device itself still under /sys/devices/soc0, the soc_id/revision still there.
> It is just the platform devices moved to /sys/devices/platform.
> 
> When I confirm with Jacky before, his concern is soc_id/revision will be
> moved. But this is not true, they are still there as before.
> 
> > 
> > > In this way, we aligned with ARM64. And simplify arch code by moving
> > > the code to drivers/soc/imx. In future, considering more cleanup, we
> > > could merge the code to soc-imx8.c, since they share similar silicon
> > > rev ocotp logic.
> > 
> > Though this is a good thing from maintenance point of view, we do not want
> > to break user spaces.
> 
> Actually not break user spaces, since this is RFC, I not expect this be merged.
> If you agree, I could post normal V1 patchset.

Okay.  You send formal patches, and we get them into linux-next to see
if people will complain any breakage.

Shawn
