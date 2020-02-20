Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA5EC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B0E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="FTWiBs2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBTRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:43:25 -0500
Received: from vps.xff.cz ([195.181.215.36]:55740 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgBTRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582220599; bh=7BG+1cfDaleCgWG24+EuOoEzF99bjlW8TOxBcqOLLHE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=FTWiBs2aUKamgHDVx6vgZ9w6hXR8jmaN8JU03i78l+qL+vFRL+h15NlLNSmjfiqD6
         ow4N0zIQwLZl1jalCRnOTLJ/h+86nSVPuIJ/Xk6SBuw/YMvABrREICM1eghjwjcra7
         xBq3p240BfMgWfnZbXxGIl4vwxTSs8rHITGyaFew=
Date:   Thu, 20 Feb 2020 18:43:19 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: sunxi-rsb: Return correct data when mixing 16-bit
 and 8-bit reads
Message-ID: <20200220174319.k2icqoxlubu5o2fu@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200219010951.395599-1-megous@megous.com>
 <20200220173213.s2ytf3zdi6q3bxli@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220173213.s2ytf3zdi6q3bxli@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 20, 2020 at 06:32:13PM +0100, Maxime Ripard wrote:
> On Wed, Feb 19, 2020 at 02:09:50AM +0100, Ondrej Jirman wrote:
> > When doing a 16-bit read that returns data in the MSB byte, the
> > RSB_DATA register will keep the MSB byte unchanged when doing
> > the following 8-bit read. sunxi_rsb_read() will then return
> > a result that contains high byte from 16-bit read mixed with
> > the 8-bit result.
> >
> > The consequence is that after this happens the PMIC's regmap will
> > look like this: (0x33 is the high byte from the 16-bit read)
> >
> > % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> > 00: 33
> > 01: 33
> > 02: 33
> > 03: 33
> > 04: 33
> > 05: 33
> > 06: 33
> > 07: 33
> > 08: 33
> > 09: 33
> > 0a: 33
> > 0b: 33
> > 0c: 33
> > 0d: 33
> > 0e: 33
> > [snip]
> >
> > Fix this by masking the result of the read with the correct mask
> > based on the size of the read. There are no 16-bit users in the
> > mainline kernel, so this doesn't need to get into the stable tree.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  drivers/bus/sunxi-rsb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> > index b8043b58568ac..8ab6a3865f569 100644
> > --- a/drivers/bus/sunxi-rsb.c
> > +++ b/drivers/bus/sunxi-rsb.c
> > @@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >  {
> >  	u32 cmd;
> >  	int ret;
> > +	u32 mask;
> >
> >  	if (!buf)
> >  		return -EINVAL;
> > @@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >  	switch (len) {
> >  	case 1:
> >  		cmd = RSB_CMD_RD8;
> > +		mask = 0xffu;
> >  		break;
> >  	case 2:
> >  		cmd = RSB_CMD_RD16;
> > +		mask = 0xffffu;
> >  		break;
> >  	case 4:
> >  		cmd = RSB_CMD_RD32;
> > +		mask = 0xffffffffu;
> >  		break;
> >  	default:
> >  		dev_err(rsb->dev, "Invalid access width: %zd\n", len);
> > @@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >  	if (ret)
> >  		goto unlock;
> >
> > -	*buf = readl(rsb->regs + RSB_DATA);
> > +	*buf = readl(rsb->regs + RSB_DATA) & mask;
> 
> Thanks for debugging this and the extensive commit log.
> 
> I guess it would be cleaner to just use GENMASK(len * 8, 0) here?

GENMASK most probably fails with value (32,0) I think.

#define GENMASK(h, l) \
	(((~UL(0)) - (UL(1) << (l)) + 1) & \
	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

would give ~0 >> -1

regards,
	o.

> Maxime


