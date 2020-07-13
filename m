Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A99C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0494320809
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594637548;
	bh=ADqVZRWZ/51fjjRPcMqetiQetPZ84+yWUeey/gb/nUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l/sUKvNBmg+a4YGb6UP/imt0xJKu5prVtU7I1AHrMJ689G/+vBvzwYAw3EHO282nE
	 pXrBkO7txDPmKjBqzf18yHOZ5HwfLe+yKPmAxeu/3CZyQFUlothCgo7MRzWgPTBk/C
	 97N29P3LKma6DWEGnu8CIowXcafzhbK6147u4MiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGMKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbgGMKw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:52:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4933020773;
        Mon, 13 Jul 2020 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594637546;
        bh=ADqVZRWZ/51fjjRPcMqetiQetPZ84+yWUeey/gb/nUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpC2uSQJRwoNT6hkjWdSmS6Qn5EDAzTySC6hz2Sj0WilIDu3UOC7m1U2k2p8l2DcV
         adnQd6KIIyxKLh52sebskcVgxdGfQzuo3gqnKMHSSMdVaw6UFodxwXuEwND/keqv1y
         krEFqpxgDguMEYS3qRh3XxHN0YzdgYGdeWzExU6I=
Date:   Mon, 13 Jul 2020 18:52:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Message-ID: <20200713105219.GN15718@dragon>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
 <20200710132423.497230-3-philippe.schenker@toradex.com>
 <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:46:04AM +0200, Ahmad Fatoum wrote:
> Hello Philippe,
> 
> On 7/10/20 3:24 PM, Philippe Schenker wrote:
> > Since the runtime-pm wakeup bug was fixed in
> > drivers/usb/chipidea/core.c usb dual-role host/device switching is
> > working. So make use of it.
> > 
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > 
> > ---
> > 
> >  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 9 +++++++++
> >  arch/arm/boot/dts/imx7-colibri.dtsi         | 4 ++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > index 97601375f264..db56a532a34a 100644
> > --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > @@ -20,6 +20,14 @@ clk16m: clk16m {
> >  		clock-frequency = <16000000>;
> >  	};
> >  
> > +	extcon_usbc_det: usbc_det {
> > +		compatible = "linux,extcon-usb-gpio";
> 
> According to 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver"):
> "the old way using extcon to support USB Dual-Role switch is now deprecated
>  when use Type-B connector."
> 
> Have you considered using a compatible = "gpio-usb-b-connector" child node instead?

I dropped patch #2 and #3 for now.

Shawn
