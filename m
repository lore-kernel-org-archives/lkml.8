Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50491C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333BD2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgFVRJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:09:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:51793 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbgFVRJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:09:10 -0400
IronPort-SDR: rBKDNNUv/tMvvxPaNKHfwnCbFEBIIIkPFomf+yXIOYYIufMC6iRWFk74EWCdnwmA67zQ5/YY/Q
 v0NhWcOW1ueA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142070173"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142070173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:09:09 -0700
IronPort-SDR: VHxWJt7ptx9HHx4WK344vGUALukh8akHWvyCalEuZ9CS01Mc9dloFtzX3NjjYSecdNj6PrEglQ
 2M269qMSPB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="281128230"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007.jf.intel.com with SMTP; 22 Jun 2020 10:09:01 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Jun 2020 20:09:01 +0300
Date:   Mon, 22 Jun 2020 20:09:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Message-ID: <20200622170901.GZ2795@lahna.fi.intel.com>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
 <20200622163756.GV2795@lahna.fi.intel.com>
 <1d2d1c3e753d42ed86cf89a6ed926a67@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2d1c3e753d42ed86cf89a6ed926a67@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:41:35PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Monday, June 22, 2020 11:38 AM
> > To: Limonciello, Mario
> > Cc: Andreas Noever; Michael Jamet; Yehezkel Bernat; linux-usb@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Hi Mario,
> > 
> > On Mon, Jun 22, 2020 at 09:30:33AM -0500, Mario Limonciello wrote:
> > > Currently updates to Thunderbolt and USB4 controllers are fully atomic
> > > actions. When writing into the non-active NVM nothing gets flushed to
> > > the hardware until authenticate is sent.
> > >
> > > There has been some desire to improve the perceived performance of these
> > > updates, particularly for userland that may perform the update upon
> > > a performance sensitive time like logging out.
> > >
> > > So allow userland to flush the image to hardware at runtime, and then
> > > allow authenticating the image at another time.
> > >
> > > For the Dell WD19TB some specific hardware capability exists that allows
> > > extending this to automatically complete the update when unplugged.
> > > Export that functionality to userspace as well.
> > >
> > > This patch series is done relative thunderbolt.git/next.
> > 
> > Thanks for the patch series. I wonder if you could base this on top of
> > my "retimer NVM upgrade" series here (you are also Cc'd):
> > 
> >   https://lore.kernel.org/linux-usb/20200616135617.85752-1-
> > mika.westerberg@linux.intel.com/
> > 
> > That series moves some of the common NVM functionality into a separate
> > file (nvm.c).
> 
> Sure thing.  Do you by chance already have that on a public branch somewhere
> that I can easily rebase it?

I just pushed "bleeding-edge" branch that you should be able to base
your stuff on top:

   https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/log/?h=bleeding-edge

It includes a couple of other patches as well (subject to change since
they are also under review).
