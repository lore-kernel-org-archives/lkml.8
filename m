Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E9AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A313206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599667316;
	bh=gCT1PxEjHYMnqsc3IvRBLytlHp3Q+TLZOGRYtcA00sU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q0V8WF/h1qiSRfyTejMThCL136ZkPItM3UJE8cc1cMs5ffh6aUUgnvTv6/w/H5Nx/
	 nhgoWydNvxZ0hWdLqfgqoI8DCSaQnaVzJxWk9Fc4+ErWldx04Lxkjmrlw7Fs8/dld2
	 y9jIbOy1dtsGZ/+zt94lnK/TWb6mJdjR7y7SwvkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgIIQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730721AbgIIQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:01:00 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113592067C;
        Wed,  9 Sep 2020 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599667259;
        bh=gCT1PxEjHYMnqsc3IvRBLytlHp3Q+TLZOGRYtcA00sU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pt3N8HoH3a+eDZqio6ImrjIXNZmkwfnNSI1lzhPVdUJxLiorxqYClioNwFwZA3NXh
         qEkynAsRcZP1fht5kGWwTvTgx5gyftJio8jabIzKtPVpb94ZaDPmTkannaAJ1uNoEP
         Asa+s+3Ou4Q+aMLBi7einndS6rIL1hsuHWs3R4/4=
Received: by mail-oi1-f170.google.com with SMTP id w16so2877799oia.2;
        Wed, 09 Sep 2020 09:00:59 -0700 (PDT)
X-Gm-Message-State: AOAM531son41hDdnHW4lzlJGoAJe9uV5CQeq51mzfZZHuyVFBSojz4UQ
        u49a6G5+Sqxjd4+CNyYMzMzZKeXDzbG4A0zmFA==
X-Google-Smtp-Source: ABdhPJxxfDXQk+6W+xnjTSduPNlggtWkN48qYEkMLzn2/lnfsbJZ547HMTqHktm+eYoi9g0Fz3c0ICdHDjbvpLrhV8U=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr1092879oii.106.1599667258344;
 Wed, 09 Sep 2020 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-2-git-send-email-manish.narani@xilinx.com>
 <20200908230520.GA1102401@bogus> <BYAPR02MB589674F9C2EFC763AFC63BD2C1260@BYAPR02MB5896.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB589674F9C2EFC763AFC63BD2C1260@BYAPR02MB5896.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 10:00:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfF6+ocozmSf0n0r8LPjbyK4CurS2qqy1rdNNqQw+cnA@mail.gmail.com>
Message-ID: <CAL_JsqKfF6+ocozmSf0n0r8LPjbyK4CurS2qqy1rdNNqQw+cnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for
 Versal DWC3 Controller
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:46 AM Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks for the review.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, September 9, 2020 4:35 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
> > balbi@kernel.org; p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git <git@xilinx.com>
> > Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for
> > Versal DWC3 Controller
> >
> > On Thu, Aug 27, 2020 at 12:14:00AM +0530, Manish Narani wrote:
> > > Add documentation for Versal DWC3 controller. Add required property
> > > 'reg' for the same. Also add optional properties for snps,dwc3.
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  .../devicetree/bindings/usb/dwc3-xilinx.txt          | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > > index 4aae5b2cef56..dd41ed831411 100644
> > > --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > > +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> > > @@ -1,7 +1,8 @@
> > >  Xilinx SuperSpeed DWC3 USB SoC controller
> > >
> > >  Required properties:
> > > -- compatible:      Should contain "xlnx,zynqmp-dwc3"
> > > +- compatible:      May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-
> > dwc3"
> > > +- reg:             Base address and length of the register control block
> > >  - clocks:  A list of phandles for the clocks listed in clock-names
> > >  - clock-names:     Should contain the following:
> > >    "bus_clk"         Master/Core clock, have to be >= 125 MHz for SS
> > > @@ -13,12 +14,19 @@ Required child node:
> > >  A child node must exist to represent the core DWC3 IP block. The name of
> > >  the node is not important. The content of the node is defined in dwc3.txt.
> > >
> > > +Optional properties for snps,dwc3:
> > > +- dma-coherent:    Enable this flag if CCI is enabled in design. Adding this
> > > +           flag configures Global SoC bus Configuration Register and
> > > +           Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> > > +- interrupt-names: This property provides the names of the interrupt ids
> > used
> >
> > You have to define what the names are. 'dwc_usb3' seems pretty pointless
> > if only 1 name.
>
> OK. I am planning to add more interrupt ids going ahead. For now I will remove
> this interrupt name in v2. The interrupt name will be added along with other interrupt
> names.

Define all the interrupts you have. Bindings should be complete, not
what a driver for some OS happens to use at some point in time.

Rob
