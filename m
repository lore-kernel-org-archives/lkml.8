Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B14C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AFC20E65
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598682444;
	bh=nmPv6vDLuaeXHEYBEjQxMedQhS6gWik2Zx2Xfd6Z2rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KtKZ5a7KI5RTxsdG6hl1qjdyiXTUVxb3p05X1nEY/4mqlGCPQ5JPIWq+E9l8mD8J1
	 /Mt371S+52zU4egOthXtb36nB0xRh7l+ZYspCXRQn0pSDJ56aKAMouJDoQkX56oNjN
	 mRNkiPzhe2GGCLKxiQcSpgYsK6T1+6MoXyRrQNKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgH2G1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2G1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:27:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A177E20936;
        Sat, 29 Aug 2020 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598682442;
        bh=nmPv6vDLuaeXHEYBEjQxMedQhS6gWik2Zx2Xfd6Z2rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyZgoHlz2pgoYTLWrnFmo74kMioGJkgPCP1NRq+fVd7PJUqXibhyxvSyKSumdkiDE
         9aqwGIuCeubslJ3WGVgY6u/TH/7Tj7Gd+q1D+d+ra0jFquK6gPaPj4p/p0733JprTB
         EH3rYPFsdo73/1bCtWAn+jU8J24hIHG9zROoeHA8=
Date:   Sat, 29 Aug 2020 08:27:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200829062719.GA80106@kroah.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
 <DM6PR11MB3963228D43B50604AE4D0F3AF6520@DM6PR11MB3963.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3963228D43B50604AE4D0F3AF6520@DM6PR11MB3963.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:20:22PM +0000, Mani, Rajmohan wrote:
> Hi Greg,
> 
> > Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
> > (IOM) driver
> > 
> > Hi Greg,
> > 
> > On Fri, Aug 28, 2020 at 09:43:59AM +0200, Greg Kroah-Hartman wrote:
> > > I still find this crazy that a whole separate driver is created just
> > > to read a single 32bit value.
> > >
> > > Why not put this logic in the driver that wants to read that value?
> > > That would be much simpler, smaller, and more obvious.
> > 
> > That would mean that we start maintaining something like DMI quirk table in
> > those drivers. Unfortunately the IOM device is not available on every platform.
> > Also, even on platforms that do have it, there is no guarantee that the device is
> > always going to be mapped to the same address.
> > 
> > Nevertheless, I was originally hoping that we could hide the handling of IOM
> > somehow in ACPI without the need for an actual device object, but it now
> > turns out that the other features of the IOM chip have created interest. At
> > least our i915 guys probable have some use for it (I don't know exactly what
> > they are planning to use it for).
> > 
> > So the fact that we may later need the device for something else, on top of the
> > clumsiness and most importantly risks involved with using ACPI to take care of
> > extra tasks (ASL tends to have bugs - bugs that may never ever get fixed), I
> > think the IOM device object, and the driver that binds to it, do have a valid
> > reason for existing.
> > 
> 
> Intel PMC USB mux device is part of the PCH, while IOM is part of the SoC.

I have no idea what a "PCH" is, what "IOM" is, and how any of this
relates to a "SoC" :)

Don't impose arbritrary hardware "splits" to kernel code when the kernel
has no such "partitioning" please.

> This was another reason we had to have a separate ACPI device.

That sounds like a firmware issue you can solve in UEFI.

I think this is the most TLA-laden email I have ever written, and I used
to work at IBM :)

greg k-h
