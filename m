Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C20C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7384120679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgDUOqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:46:03 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:40312 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:46:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C5128FB03;
        Tue, 21 Apr 2020 16:46:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id btwSYLliZDjF; Tue, 21 Apr 2020 16:46:00 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BDC55400FB; Tue, 21 Apr 2020 16:45:59 +0200 (CEST)
Date:   Tue, 21 Apr 2020 16:45:59 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <20200421144559.GA62048@bogon.m.sigxcpu.org>
References: <d9bfb11e3d66376792089d54d7d52fe3778efa33.1584636213.git.agx@sigxcpu.org>
 <20200420145459.GE32419@dragon>
 <20200420163224.GA44571@bogon.m.sigxcpu.org>
 <20200421030307.GB8571@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421030307.GB8571@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Apr 21, 2020 at 11:03:07AM +0800, Shawn Guo wrote:
> On Mon, Apr 20, 2020 at 06:32:24PM +0200, Guido Günther wrote:
> > Hi,
> > On Mon, Apr 20, 2020 at 10:54:59PM +0800, Shawn Guo wrote:
> > > On Thu, Mar 19, 2020 at 05:46:02PM +0100, Guido Günther wrote:
> > > > According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
> > > > when not overclocking to 1GHz (which we currently don't do).
> > > > 
> > > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > 
> > > It doesn't apply to my branch.
> > 
> > This was against linux next when i sent it, can you link to the branch
> > it should apply to please?
> 
> Here it is:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
> 
> Or even better:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt64

Thanks - and sorry for getting confused with all the kernel trees
around. v2 should apply to the above:

   https://lore.kernel.org/linux-arm-kernel/55399d6b297e329f125a71aea16e5f48c2857945.1587480093.git.agx@sigxcpu.org/T/#mfa29f121347a9d3d76bb14d58fc63fe39767db9c

Cheers,
 -- Guido

> 
> Shawn
> 
