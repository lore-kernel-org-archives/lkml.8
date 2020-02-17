Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D54C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B901E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581923078;
	bh=8huyWs1GHYkSTi2RFZ2Krx5tJF3cAQPUj+WlMwOkb00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CaeTpyAUl81QX9TwraDTuRlSiLUO2Dp9EvP1cCpl1CmJ/162+aXuD1RL2+WIjGg2H
	 jr2eezyVVpqo/qwwbadKqmML5HvUYq8XA95UmawouYqvCRYOyj2ooQzgdJz3dwzTlg
	 wAPVFpV15X/zavreBECJECl2QHBRGFvzB/PBuVN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgBQHEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQHEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:04:37 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1074208C4;
        Mon, 17 Feb 2020 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581923076;
        bh=8huyWs1GHYkSTi2RFZ2Krx5tJF3cAQPUj+WlMwOkb00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjaOoJTygMYh+hEzc5o5/alIK1VGnIfWqs9aVjWdwP6iEW54ROQno+A8T7cZVXxZ2
         kn/j2IupGMD+giS/2GKIaU1itk6jOtYbgmoL1ScnnN56hEL6bmug5hCDk/sYpLooEz
         WNGI3sR+NCjjK7e287jrPaHpPYD5CUOx3UcQET04=
Date:   Mon, 17 Feb 2020 15:04:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Oliver Graute <oliver.graute@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: clk: imx: clock driver for imx8qm?
Message-ID: <20200217070429.GB7973@dragon>
References: <20200213153151.GB6975@optiplex>
 <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200213174225.GA11566@ripley>
 <AM0PR04MB42111BF00621C1949E1FBA9080150@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42111BF00621C1949E1FBA9080150@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 05:50:48AM +0000, Aisheng Dong wrote:
> > From: Oliver Graute <oliver.graute@gmail.com>
> > Sent: Friday, February 14, 2020 1:42 AM
> > 
> > On 13/02/20, Aisheng Dong wrote:
> > > Hi Oliver,
> > >
> > > >
> > > > is someone working on clock driver for imx8qm? I miss at least a
> > > > clk-imx8qm.c in the drivers/imx/clk/ directory. I saw that you are
> > > > working in this area and perhaps you can give me some insights what is
> > needed here.
> > > >
> > >
> > > MX8QM/QXP are using the same clock driver clk-imx8qxp.c
> > 
> > ok thx, for that clarification.
> > 
> > >
> > > [PATCH RESEND V5 00/11] clk: imx8: add new clock binding for better pm
> > > The review of that patch series is pending for a couple of months.
> > 
> > yes that is what I currently use. So further imx8qm development can happen if
> > this is integrated?
> 
> Yes, it blocks the most following MX8QXP/QM work.
> Let me loop in Shawn to see if any suggestions.
> 
> Shawn,
> Any ideas?

I guess there are still something Stephen is unhappy about, as we
haven't got a nod from him.  Do we really addressed all his comments
and concerns already?

Shawn
