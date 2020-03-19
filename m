Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64AC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194812070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCSSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:06:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:40562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:06:20 -0400
IronPort-SDR: AO+U2krxO3d2qTWZWe4xfRVG1lzbgSNJFjq8cPmIQb4GT99Oauh9HYISr2JFJzv8xUPFNrmLzO
 qacpu61ZpczQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 11:06:19 -0700
IronPort-SDR: wY9apHSG+efZiE2WRme6pg1PFqdInDc/Vg4Kcb1qPG1gRYuKc41C8aBM/6AAdVksyUT2Yia2PF
 6C3Xwv9R6LrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="245239663"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 11:06:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEzYg-00B9rN-LQ; Thu, 19 Mar 2020 20:06:18 +0200
Date:   Thu, 19 Mar 2020 20:06:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Message-ID: <20200319180618.GN1922688@smile.fi.intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com>
 <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
 <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 05:57:06PM +0000, Kammela, Gayatri wrote:
> > -----Original Message-----
> > From: Kammela, Gayatri
> > Sent: Monday, March 2, 2020 10:29 AM
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> > dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> > peterz@infradead.org; Prestopine, Charles D
> > <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> > Box, David E <david.e.box@intel.com>
> > Subject: RE: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
> > code
> > 
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Monday, March 2, 2020 4:54 AM
> > > To: Kammela, Gayatri <gayatri.kammela@intel.com>
> > > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> > > dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> > > peterz@infradead.org; Prestopine, Charles D
> > > <charles.d.prestopine@intel.com>; Chen Zhou
> > <chenzhou10@huawei.com>;
> > > Box, David E <david.e.box@intel.com>
> > > Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug
> > > fixes or code
> > >
> > > On Sun, Mar 01, 2020 at 12:44:21PM -0800, Gayatri Kammela wrote:
> > > > Hi,
> > > >
> > > > This patch series consists of bug fixes and code optimization for
> > > > the series https://patchwork.kernel.org/patch/11365325/
> > > >
> > >
> > > I had applied first four, the fifth requires additional work.
> > > When send a new version, do it only for last one.
> > 
> > Thanks Andy! I will send the 5th patch alone in new version.
> > 
> 
> Hi Andy! I see first 3 patches are merged in for-next branch on 2/28 but not 4th patch. Can you please check? http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/for-next


Is it in my review and testing queue?

-- 
With Best Regards,
Andy Shevchenko


