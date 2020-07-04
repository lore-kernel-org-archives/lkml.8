Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB9F208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593842692;
	bh=/8vSxFn9V0oswGlBEN5dRRU1JZ7ExkRloN1fTwm5oNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lf/54FuRMjiAIssUD1vYO2GGAXg704NPqG8Iunf4TDHnmFN/cp6Bn+ROY1MHoe2fP
	 IH3Q3XgWGrnB1SrAVf64guDtfQJAg6XcgjfEHclTBiYAymJNIfpumiTMgE4laeuQDV
	 EedoDMu0i62s9PnJ1Jj95EP6HMFyEso4fhbB6amE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGDGEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 02:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGDGEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 02:04:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DCC207D4;
        Sat,  4 Jul 2020 06:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593842690;
        bh=/8vSxFn9V0oswGlBEN5dRRU1JZ7ExkRloN1fTwm5oNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iItwMtHdFCkvptr3+wC5oBSGGXbOgDNx2gPwmgsCTOB9hZaNp9x1NukOjke8PsoZm
         LU6UKJAFh7leBTlINaLmf8/tik/QF8IhaHYbr1woCmpOwenN8aJ6AMdSu0uNm3QREh
         su1Am+O/L4hv41K8lDOtafcHW541qbu7l2T4hx4A=
Date:   Sat, 4 Jul 2020 08:04:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Message-ID: <20200704060446.GA20254@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-12-lee.jones@linaro.org>
 <20200703072926.GA2322133@kroah.com>
 <e88abd64-4acf-31f6-f76a-5a333df3d46a@synopsys.com>
 <20200703171626.GC2743379@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200703171626.GC2743379@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 06:16:26PM +0100, Lee Jones wrote:
> On Fri, 03 Jul 2020, Minas Harutyunyan wrote:
> 
> > Hi,
> > 
> > On 7/3/2020 11:29 AM, Greg KH wrote:
> > > On Thu, Jul 02, 2020 at 03:46:06PM +0100, Lee Jones wrote:
> > >> Commit ec1f9d9f01384 ("usb: dwc2: gadget: parity fix in isochronous mode") moved
> > >> these checks to dwc2_hsotg_change_ep_iso_parity() back in 2015.  The assigned
> > >> value hasn't been read back since.  Let's remove the unnecessary H/W read.
> > >>
> > >> Fixes the following W=1 warning:
> > >>
> > >>   drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_epint’:
> > >>   drivers/usb/dwc2/gadget.c:2981:6: warning: variable ‘ctrl’ set but not used [-Wunused-but-set-variable]
> > >>   2981 | u32 ctrl;
> > >>   | ^~~~
> > >>
> > >> Cc: Minas Harutyunyan <hminas@synopsys.com>
> > >> Cc: Ben Dooks <ben@simtec.co.uk>
> > >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >> ---
> > >>   drivers/usb/dwc2/gadget.c | 2 --
> > >>   1 file changed, 2 deletions(-)
> > >>
> > >> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > >> index 116e6175c7a48..fa07e3fcb8841 100644
> > >> --- a/drivers/usb/dwc2/gadget.c
> > >> +++ b/drivers/usb/dwc2/gadget.c
> > >> @@ -2975,10 +2975,8 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
> > >>   	u32 epctl_reg = dir_in ? DIEPCTL(idx) : DOEPCTL(idx);
> > >>   	u32 epsiz_reg = dir_in ? DIEPTSIZ(idx) : DOEPTSIZ(idx);
> > >>   	u32 ints;
> > >> -	u32 ctrl;
> > >>   
> > >>   	ints = dwc2_gadget_read_ep_interrupts(hsotg, idx, dir_in);
> > >> -	ctrl = dwc2_readl(hsotg, epctl_reg);
> > > 
> > > As you know, lots of hardware requires reads to happen to do things, so
> > > are you sure it is safe to remove this read call?
> > > 
> > 
> > Greg, yes, it's Ok to remove this unnecessary read which remained from 
> > previous implementations.
> > 
> > Lee, please add "Fixes:" tag and resubmit v2.
> 
> Is this suitable for Stable Greg?

Does it fix something that people have ever noticed or care about?
Given the age of the bug, I doubt it :)

thanks,

greg k-h
