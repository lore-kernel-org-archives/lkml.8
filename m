Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F2A2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594966759;
	bh=OXyJBDXtqGwT4BDStOxuECLiTBRqu25A/zU3+0iQzkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BPwLxFCTHCPJXBQ99evfUZojCUZyNjlK5L9MBZf6ODc+Vui9kMBrEWdM/AOemQRpc
	 KUgoCiDqqLZXJjmklypNp6PGxpmOTY1UM3E8k72NhPg99COZI0CLCM2qH8QYfT3Y/q
	 diBBf/9UcFq2WjAsAlolur/Kx8OG0P5jVFa1OLYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGQGTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgGQGTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:19:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9EB2071A;
        Fri, 17 Jul 2020 06:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594966757;
        bh=OXyJBDXtqGwT4BDStOxuECLiTBRqu25A/zU3+0iQzkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVwy0sp9T5j9unToIf/0RjeIhm19kOFbEa0bab+urAyJbH36Bp5I0ChnKDLGqK5i2
         rvPhGpZqGPSvQ1dfQulUjvTPSoPWOEtyh35VWqOdIuPZVR1JzKvkbaGUf1JGJnINdi
         XIB1smOwbVvbdM9MX5/VFhJ15HNvdKj7YMjIaZTM=
Date:   Fri, 17 Jul 2020 08:19:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
 before connect
Message-ID: <20200717061909.GB3237166@kroah.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-3-rajmohan.mani@intel.com>
 <20200716070508.GB962748@kroah.com>
 <DM6PR11MB39632A8236161E4A27FAB1BBF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB39632A8236161E4A27FAB1BBF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:04:51AM +0000, Mani, Rajmohan wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, July 16, 2020 12:05 AM
> > To: Mani, Rajmohan <rajmohan.mani@intel.com>
> > Cc: Darren Hart <dvhart@infradead.org>; Andy Shevchenko
> > <andy@infradead.org>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Dmitry Torokhov
> > <dmitry.torokhov@gmail.com>; Lee Jones <lee.jones@linaro.org>; Ayman
> > Bagabas <ayman.bagabas@gmail.com>; Masahiro Yamada
> > <masahiroy@kernel.org>; Joseph, Jithu <jithu.joseph@intel.com>; Blaž
> > Hrastnik <blaz@mxxn.io>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>; linux-kernel@vger.kernel.org;
> > platform-driver-x86@vger.kernel.org; Heikki Krogerus
> > <heikki.krogerus@linux.intel.com>; linux-usb@vger.kernel.org;
> > pmalani@chromium.org; bleung@chromium.org
> > Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
> > before connect
> > 
> > On Wed, Jul 15, 2020 at 05:33:10PM -0700, Rajmohan Mani wrote:
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >
> > > The PMC microcontroller that we use for configuration, does not supply
> > > any status information back. For port status we need to talk to
> > > another controller on the board called IOM (I/O manager).
> > >
> > > By checking the port status before configuring the muxes, we can make
> > > sure that we do not reconfigure the port after bootup when the system
> > > firmware (for example BIOS) has already configured it.
> > >
> > > Using the status information also to check if DisplayPort HPD is still
> > > asserted when the cable plug is disconnected, and clearing it if it
> > > is.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > You can't just forward on patches from others without also adding your
> > signed-off-by to them, right?
> > 
> 
> Sorry I missed this.
> 
> > Please fix up this series and try again.
> > 
> 
> Ack. Will fix this with v2.

Stop and go talk to the proper people in Intel for how to submit patches
to the kernel as you are not following the rules they have documented
for you.

thanks,

greg k-h
