Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18548C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E774022B51
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272736;
	bh=Om8xZs9mcJXOyX/qFodq9Pq+msKkoq6y3fF20Bxe1Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilfX164ophU8e4QN5OFuTKMo9oD4ocBXGivrrPnZ7gKqhH8nxFby2h4850siBNf9r
	 iDuqqzRsXr0WGyBVl1SpJqlYPGmItc9wkuDhfCdiKELrvFd0HTUYpAYoKWUqdZeyE3
	 8I/7iL+JMr/kwDMl3MrPfYHP7mc4N730Txno5I4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgGTTSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgGTTSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:18:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5726C2176B;
        Mon, 20 Jul 2020 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595272733;
        bh=Om8xZs9mcJXOyX/qFodq9Pq+msKkoq6y3fF20Bxe1Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcYZHK/Nzn/xdJPoiofCtqIUj3KqPXi57fGrFg3rG/OyA3Q2vwOj6D/g/s/UE20Ml
         AYLHIADELU1DDkA08Xf/ijoVazGAaTr+a1s+gRD+W98JlKhjPzcNQq2JDrwOijcAVy
         LdPRq4BOeg9jsaWpQmL2oM6UCmpmEgqSnK0MDDZ0=
Date:   Mon, 20 Jul 2020 21:19:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200720191903.GD1529125@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155810.GC186665@kroah.com>
 <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200718064656.GB245355@kroah.com>
 <SN6PR11MB25746161DC8D54AD5BD30F96F67B0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB25746161DC8D54AD5BD30F96F67B0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 07:02:05PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, July 18, 2020 1:47 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > 
> > On Fri, Jul 17, 2020 at 06:18:46PM +0000, Eads, Gage wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Sunday, July 12, 2020 10:58 AM
> > > > To: Eads, Gage <gage.eads@intel.com>
> > > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > > >
> > > > On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > > > > +static int dlb2_probe(struct pci_dev *pdev,
> > > > > +		      const struct pci_device_id *pdev_id) {
> > > > > +	struct dlb2_dev *dlb2_dev;
> > > > > +	int ret;
> > > > > +
> > > > > +	dev_dbg(&pdev->dev, "probe\n");
> > > >
> > > > ftrace is your friend.  Remove all of your debugging code now, you don't
> > need
> > > > it anymore, especially for stuff like this where you didn't even need it in
> > the
> > > > first place :(
> > >
> > > I'll remove this and other similar dev_dbg() calls. This was an oversight on
> > my part.
> > >
> > > I have other instances that a kprobe can't easily replace, such as printing
> > structure contents, that are useful for tracing the usage of the driver. It looks
> > like other misc drivers use dev_dbg() similarly -- do you consider this an
> > acceptable use of a debug print?
> > 
> > Why can't a kernel tracepoint print a structure?
> 
> I meant the command-line installed kprobes[1], but instrumenting the driver is
> certainly an option. We don't require the much lower overhead of a tracepoint,
> so I didn't choose it. This driver handles the (performance-insensitive)
> device configuration, while the fast-path operations take place in user-space.
> 
> Another reason is the "hardware access library" files use only non-GPL external
> symbols, and some tracepoint functions are exported GPL. Though it's probably
> feasible to lift that tracing code up into a (GPLv2-only) caller function.

Stop going through crazy gyrations for something that your own legal
team has told you not to do anymore in the first place.

No "hardware access library" files please, that's not how Linux drivers
are written.

you all know better...

> But if tracepoints are the preferred method and/or you think the driver would
> benefit, I'll make the change.

I don't think you need any of that stuff, now that the code works
properly, right?

greg k-h
