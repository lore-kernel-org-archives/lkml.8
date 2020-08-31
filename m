Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BFCC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185402076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598836759;
	bh=mgkYqqYUY/6gm3kecIYTT61uw6xviBxBd6zQOEXZCAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CMDMe/E8L76xkdSxNTO83RklltYU69+fZnvn5/tdlBqVnFSD3wqS7HyxFyl4We+ns
	 kxlm6L+Ojgw0SZHAsD6/mr+1EuDeIUdKqEx4kqFwg2iwXDyE5GDuwdpJcbIfRaK7od
	 o7dUhUYRglaXn4CHsSNMoWTHZHUwJnMLU0GG+ia0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgHaBTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgHaBTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:19:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E5F2076D;
        Mon, 31 Aug 2020 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598836754;
        bh=mgkYqqYUY/6gm3kecIYTT61uw6xviBxBd6zQOEXZCAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXNEbO+SnauOYu3JJOlhkAe3HD9/ab4KZUF0PKhs1z2rbVWpvjXn6bmcQkGQgCMro
         cRY4/DUigBPD/m5bIGkMpap2xO0PLtqJDZDbl7GstMwkDEkOuzBKFkV4ji1ZbpDsHB
         jovmN2oGap9fbOAWOzezTNuR4KstOSl97MprfXhI=
Date:   Mon, 31 Aug 2020 09:19:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        kernel@puri.sm, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mchehab@kernel.org,
        Anson.Huang@nxp.com, agx@sigxcpu.org, angus@akkea.ca,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] MAINTAINERS: Add Purism Librem 5 section to the
 list
Message-ID: <20200831011906.GB4488@dragon>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
 <20200821121755.24599-2-martin.kepplinger@puri.sm>
 <20200830131459.GL32096@dragon>
 <1d7c6ef2794bedca7e3164e5435f46864eacddfa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7c6ef2794bedca7e3164e5435f46864eacddfa.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 08:32:01AM -0700, Joe Perches wrote:
> On Sun, 2020-08-30 at 21:15 +0800, Shawn Guo wrote:
> > On Fri, Aug 21, 2020 at 02:17:54PM +0200, Martin Kepplinger wrote:
> > > Add development information for the devicetree files for hardware
> > > by Purism SPC.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > 
> > I decided to drop this patch from my queue, as I took the suggestion
> > from Joe and sent a patch to have get_maintainer report email address
> > in the dts file.
> 
> It's OK to find maintainers in files, but what about the
> B: bug reporting and T: source code repository location lines,
> 
> Those seem useful.

Hmm, I doubt they are practically useful for just a number of dts files.
They are more used for out-of-tree Librem5 kernel drivers, I guess.

Shawn

> 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > > @@ -14061,6 +14061,13 @@ T:	git git://linuxtv.org/media_tree.git
> > >  F:	Documentation/admin-guide/media/pulse8-cec.rst
> > >  F:	drivers/media/cec/usb/pulse8/
> > >  
> > > +PURISM LIBREM 5
> > > +M:	Purism Kernel Team <kernel@puri.sm>
> 
> People feel like their mails go into a void when no
> responses happen after sending to nameless addresses.
> 
> It's better to have a named individual as a maintainer
> rather than an unspecified exploder address.
> 
> It's OK to have both, but just the exploder doesn't
> really have that much value as it's faceless.
> 
> > > +S:	Supported
> > > +B:	https://source.puri.sm/Librem5/linux-next/issues
> > > +T:	https://source.puri.sm/Librem5/linux-next
> 
> This T: line should be something else.
> 
> Perhaps
> W;	https://source.puri.sm/Librem5/linux-next
> T:	git https://source.puri.sm/Librem5/linux-next.git
> 
> > > +F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*
> 
> 
