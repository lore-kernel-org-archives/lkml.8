Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B15E20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592490965;
	bh=RWb0EG4AA1t/dDxJ4cQzZzWxAFTWvxEs6/gsnf64rjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ThyWgcVPYF6/E3GOtz9o6aM5cCJV/NeBLbQvz3befLjNmo6f3FR2zRI2W4Pg2DhHb
	 ips4tkxap4QyqEGIRTT2xDISwqPVZ4clsdSZJqOQauBK7b0GgCYs491tQBaN6aLl1F
	 DmyhKteQZDGxiIHN51Yp9HkBtksvkWqL1OIbGYxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgFROgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFROgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:36:03 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFAAB20773;
        Thu, 18 Jun 2020 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592490962;
        bh=RWb0EG4AA1t/dDxJ4cQzZzWxAFTWvxEs6/gsnf64rjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xujRlONhy/QxHYnmfV06xqi5FAqnmqD2oMbTyj8lBGS/7aMeVmxM3fF3bFAzzkm4S
         geS+SHB1wN0GDCIlqtcFMvTXLWTqwtr5li2TbAUwtTGPN2EOlMCaLJE0MnxB7MBWus
         wH5FGntEK7KV9U9kuGgXcDOQxa/fOZR7wAZaegGs=
Date:   Thu, 18 Jun 2020 22:35:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2
Message-ID: <20200618143556.GE464@dragon>
References: <20200526170939.104111-1-aford173@gmail.com>
 <CAEnQRZCv0KbVkGUoVz-Sz3XwQyFY-5KZXfLoFw6u5amxGSCVgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZCv0KbVkGUoVz-Sz3XwQyFY-5KZXfLoFw6u5amxGSCVgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:43:24PM +0300, Daniel Baluta wrote:
> On Tue, May 26, 2020 at 8:11 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > LDO1 and LDO2 settings are wrong and case the voltage to go above the
> > maximum level of 2.15V permitted by the SoC to 3.0V.
> >
> > This patch is based on work done on the i.MX8M Mini-EVK which utilizes
> > the same fix.
> >
> > Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> No need for a new line between fixes and signed-off-by.

I fixed it up and applied the patch.

> 
> With that:
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks.

Shawn
