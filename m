Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1406C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947912073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCYCM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:12:58 -0400
Received: from baldur.buserror.net ([165.227.176.147]:55816 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgCYCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:12:58 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jGvSx-0004so-1k; Tue, 24 Mar 2020 21:08:23 -0500
Message-ID: <81c68751cb89bbff13a09467b94530a555d69552.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, mark.rutland@arm.com, paulus@samba.org,
        benh@kernel.crashing.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Mar 2020 21:08:21 -0500
In-Reply-To: <877dz9xkhr.fsf@mpe.ellerman.id.au>
References: <20200324213612.31614-1-chris.packham@alliedtelesis.co.nz>
         <877dz9xkhr.fsf@mpe.ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, chris.packham@alliedtelesis.co.nz, robh+dt@kernel.org, mark.rutland@arm.com, paulus@samba.org, benh@kernel.crashing.org, hamish.martin@alliedtelesis.co.nz, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/fsl: Add cache properties for T2080/T2081
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 12:59 +1100, Michael Ellerman wrote:
> Chris Packham <chris.packham@alliedtelesis.co.nz> writes:
> > Add the d-cache/i-cache properties for the T208x SoCs. The L1 cache on
> > these SoCs is 32KiB and is split into 64 byte blocks (lines).
> > 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >  arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> LGTM.
> 
> I'll wait a few days to see if Scott wants to ack it.
> 
> cheers
> 
> 
> > diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> > index 3f745de44284..2ad27e16ac16 100644
> > --- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> > @@ -81,6 +81,10 @@ cpus {
> >  		cpu0: PowerPC,e6500@0 {
> >  			device_type = "cpu";
> >  			reg = <0 1>;
> > +			d-cache-line-size = <64>;
> > +			i-cache-line-size = <64>;
> > +			d-cache-size = <32768>;
> > +			i-cache-size = <32768>;
> >  			clocks = <&clockgen 1 0>;
> >  			next-level-cache = <&L2_1>;
> >  			fsl,portid-mapping = <0x80000000>;

U-Boot should be setting d/i-cache-size and d/i-cache-block-size -- are you
using something else?

The line size is the same as the block size so we don't need a separate d/i-
cache-line-size.

-Scott


