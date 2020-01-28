Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DBBC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB70D24686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219270;
	bh=FAiIYynFKBuECEDgOwJSnnC0Hg3xYnzoyPy4Ysdo0HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mRzKRknpnrVpyPQbW7/Han9Pf22DPt8nKmrr4NbhJRKyMoWVHuEUNKakXxBNLJjXY
	 myHkfOeFHgWiyURgmiE0jyWkOEqoDsJnajBnfgoags6nPVpnmqV3/J9IySNC5C2Xq3
	 Zl9+QC7kAr8Oh65s2+OMbXqnMDpXdaNCzS8UCm1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1Nru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1Nrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:47:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD0A24683;
        Tue, 28 Jan 2020 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219267;
        bh=FAiIYynFKBuECEDgOwJSnnC0Hg3xYnzoyPy4Ysdo0HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLZiPPEJ3KZYFeEODDcAdKm12adgwJTR1qNu8E+/VB6oWCwBJucsQAZthyd25GaSm
         jGHTqGPMfkhPC6+DP+HPoE6IHThhQiRXLcdyB7gkdtyywbpx1/t5r0aAVmnkRXDC2v
         FoBHpKTogtOd0WgKUquetU0/w7h5gM/Rcd86KiYE=
Date:   Tue, 28 Jan 2020 14:47:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports
 hub property
Message-ID: <20200128134745.GA3048749@kroah.com>
References: <20200124152504.23411-1-mans@mansr.com>
 <20200127153506.GA4589@bogus>
 <yw1xy2tsvnww.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy2tsvnww.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 04:56:15PM +0000, Måns Rullgård wrote:
> Rob Herring <robh@kernel.org> writes:
> 
> > On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
> >> Add a non-removable-ports property that lists the hardwired downstream
> >> ports of a hub.  Although hubs can provide this information, they are
> >> not always configured correctly.  An alternate means of indicating this
> >> for built-in USB devices is thus useful.
> >> 
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >
> > I reviewed this already, but since you didn't add my reviewed-by, I'm 
> > looking at it again and having 2nd thoughts.
> >
> >> ---
> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> >> index 036be172b1ae..92d863cc96b6 100644
> >> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> >> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> >> @@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
> >>  - #size-cells: shall be 0
> >>  
> >>  
> >> +Optional properties for hub and host-controller nodes:
> >> +- non-removable-ports: list of hardwired downstream ports
> >
> > If you have a hardwired device and need to know that, doesn't that imply 
> > there's some other stuff you need to describe beyond what a standard USB 
> > device has. Such as a power supply that's not Vbus from the hub.
> 
> I suppose there could be, but there isn't in my actual situation.
> 
> > At a minimum, I think this should be a per port property.
> 
> That's what I suggested first.  Greg told me to do it like this instead.

I said that?  I do not remember discussing this at all, when did that
happen?

> > Though really, I think this should just be implied by describing the
> > device in DT. I'm not sure if there's a case for hotpluggable devices
> > described in DT.  Maybe with overlays.
> 
> That's also an option.  Greg, what do you think?

I have no idea, sorry, I'm totally lost here...

greg k-h

> 
> -- 
> Måns Rullgård
