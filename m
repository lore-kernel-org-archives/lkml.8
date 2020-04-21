Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C81C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC02082E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587438197;
	bh=vqvUV0TB68GwK6fP6tJbnKqDVXw1gfsNdoWz4+42JN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=urUVCVOITinP/NI+Q46uHR2lXPS2FiJyLuzJS50VFZ6buA/w9WsLSJjkBLdE/4Qhn
	 KIq0V496CAnq0iF/tOGquJcULHqzMd3OdbahQjZhrCKM80iM/bi0UCSzdhABcjvtWp
	 /AKZ37CbCWQUWO23CNfx/WCvAOunqFiUFQV92i/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDUDDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUDDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:03:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4075420782;
        Tue, 21 Apr 2020 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587438195;
        bh=vqvUV0TB68GwK6fP6tJbnKqDVXw1gfsNdoWz4+42JN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cI19nYGI+jkJGceTHNo7PwKvxFsl40oFyvOgcatNzPvMMLWs0Rzm4vGGJCE/iqAQ5
         rGuAvgUSJxbauiSrLNcdOyhYB8mJaA/oiAapybc7ggMRyE+bPFILdtA0hUYguhUTcO
         cLcK9BhJN1jrqsBeD29kQgVr6Nax9MGH7CJzC/Z8=
Date:   Tue, 21 Apr 2020 11:03:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
Message-ID: <20200421030307.GB8571@dragon>
References: <d9bfb11e3d66376792089d54d7d52fe3778efa33.1584636213.git.agx@sigxcpu.org>
 <20200420145459.GE32419@dragon>
 <20200420163224.GA44571@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420163224.GA44571@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:32:24PM +0200, Guido Günther wrote:
> Hi,
> On Mon, Apr 20, 2020 at 10:54:59PM +0800, Shawn Guo wrote:
> > On Thu, Mar 19, 2020 at 05:46:02PM +0100, Guido Günther wrote:
> > > According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
> > > when not overclocking to 1GHz (which we currently don't do).
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > 
> > It doesn't apply to my branch.
> 
> This was against linux next when i sent it, can you link to the branch
> it should apply to please?

Here it is:

 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next

Or even better:

 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt64

Shawn
