Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F62C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5232065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFZPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:00:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:46378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFZPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:00:22 -0400
IronPort-SDR: 92O6C5haC1m3SSiM4D1TLXW2dJ/dspDMjmPh+XvhXL2vqXWO2QUI92dDXCWBnTFJHt0NY+/pIP
 G5UZoNoPVDgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132767126"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="132767126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 08:00:21 -0700
IronPort-SDR: yHl0O8SJJXKqifHtnUd6rN0qqjbg+YRRAnToPjCoKu1gXAK69IhBXcq/RzLn3wgWDRa3+tnRcI
 tJQN/277K2hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="312340678"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2020 08:00:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jopq1-00GC6h-0d; Fri, 26 Jun 2020 18:00:21 +0300
Date:   Fri, 26 Jun 2020 18:00:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/7] Some atomisp fixes and improvements
Message-ID: <20200626150021.GY3703480@smile.fi.intel.com>
References: <cover.1593180146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593180146.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:04:52PM +0200, Mauro Carvalho Chehab wrote:
> Those patches are meant to improve device detection by the atomisp driver,
> relying on ACPI bios when possible.
> 
> It also adds a basis for using ACPI PM, but only if the DSDT tables have
> a description about how to turn on the resources needed by the cameras.
> 
> At least on the device I'm using for tests, this is not the case.

Is this in your experimental tree? I'll rebase mine on top and test.
After I will send the rest from my series and give a tag to this.

> 
> Mauro Carvalho Chehab (7):
>   media: atomisp: reorganize the code under gmin_subdev_add()
>   media: atomisp: Prepare sensor support for ACPI PM
>   media: atomisp: properly parse CLK PMIC on newer devices
>   media: atomisp: fix call to g_frame_interval
>   media: atomisp: print info if gpio0 and gpio2 were detected
>   media: atomisp: split add from find subdev
>   media: atomisp: place all gpio parsing together
> 
>  .../staging/media/atomisp/pci/atomisp_cmd.c   |   2 +-
>  .../media/atomisp/pci/atomisp_gmin_platform.c | 393 ++++++++++++------
>  2 files changed, 267 insertions(+), 128 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


