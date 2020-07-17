Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BBC206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594975585;
	bh=aSTOwrsf1OoTmGFAxEAYLQB33noREJVm4joxNsHwJJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PZmK9QssevsuMGFgzgh20dChPi8Wg8Xj4VjBWyHAjMr5kGuiagStzaWZG4W1k3A1D
	 dA9B2OjDDeWViSfZFxppbiMPXY3N0otQY24Sxxc8avzDI1T9c5wU1V3EBRdmchz7Sx
	 CFVphdmO3PrRtXBjcFw9c1ht76cJwx5mlv+hfhws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQIqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQIqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:46:23 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255BF20691;
        Fri, 17 Jul 2020 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594975583;
        bh=aSTOwrsf1OoTmGFAxEAYLQB33noREJVm4joxNsHwJJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lma2rZauHo7sWrCEhYqla+A4EvPfjNNuawxIR/EPmU/HB+K8RnWoxUCr6vhlH5btM
         vfRPFagdp7H/oMq+T3HQahlsqGgF+x4O/nzO0UEFpEuJPdujSvgMvWTeOGGs/oHXVM
         ie6AY9FhSgTWvOXLoRMt6rfY2Agi+T8Ch9wyt9f8=
Date:   Fri, 17 Jul 2020 14:16:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] phy: renesas: rcar-gen3-usb2: fix SError happen if
 DEBUG_SHIRQ is enabled
Message-ID: <20200717084618.GM82923@vkoul-mobl>
References: <1594642288-9986-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20200717063856.GH82923@vkoul-mobl>
 <TY2PR01MB3692ED71A574F16848CD48ECD87C0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3692ED71A574F16848CD48ECD87C0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 08:16, Yoshihiro Shimoda wrote:
> Hello Vinod,
> 
> > From: Vinod Koul, Sent: Friday, July 17, 2020 3:39 PM
> > 
> > hello Yoshihiro,
> > 
> > On 13-07-20, 21:11, Yoshihiro Shimoda wrote:
> > 
> > Please consider revising patch subject. It tell me you are fixing an
> > error but it doesnt tell me what this patch is about :)
> > 
> > Perhpas :move irq registration to init" maybe a better title which
> > describes the changes this patch brings in
> 
> Thank you for your suggestion! I also think your suggestion is better.
> So, I will fix it.
> 
> <snip>
> > > @@ -389,12 +390,39 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
> > >  	rcar_gen3_device_recognition(ch);
> > >  }
> > >
> > > +static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
> > > +{
> > > +	struct rcar_gen3_chan *ch = _ch;
> > > +	void __iomem *usb2_base = ch->base;
> > > +	u32 status = readl(usb2_base + USB2_OBINTSTA);
> > > +	irqreturn_t ret = IRQ_NONE;
> > > +
> > > +	if (status & USB2_OBINT_BITS) {
> > > +		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
> > > +		writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> > > +		rcar_gen3_device_recognition(ch);
> > > +		ret = IRQ_HANDLED;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int rcar_gen3_phy_usb2_init(struct phy *p)
> > >  {
> > >  	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
> > >  	struct rcar_gen3_chan *channel = rphy->ch;
> > >  	void __iomem *usb2_base = channel->base;
> > >  	u32 val;
> > > +	int ret;
> > > +
> > > +	if (!rcar_gen3_is_any_rphy_initialized(channel) && channel->irq >= 0) {
> > > +		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
> > > +		ret = request_irq(channel->irq, rcar_gen3_phy_usb2_irq,
> > > +				  IRQF_SHARED, dev_name(channel->dev), channel);
> > > +		if (ret < 0)
> > > +			dev_err(channel->dev, "No irq handler (%d)\n",
> > > +				channel->irq);
> > 
> > This could be in a single line :)
> 
> Yes. We could be 80 over characters in a line now :)
> I'll fix it.
> 
> > Should we continue on error here?
> 
> Hmm, maybe it's better if the request_irq() failed because
> it can avoid unexpected behaviors. But, original code continued on error.
> In this case, should I make a separated incremental patch to exit on error?

Yes that would be better :), Always, a patch per change

-- 
~Vinod
