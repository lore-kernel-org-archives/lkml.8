Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E2C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D477B20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBDLeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:34:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:9004 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgBDLeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:34:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 03:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,401,1574150400"; 
   d="scan'208";a="403761549"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2020 03:34:13 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1iywT8-0003sE-QE; Tue, 04 Feb 2020 13:34:14 +0200
Date:   Tue, 4 Feb 2020 13:34:14 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: Re: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Message-ID: <20200204113414.GB10400@smile.fi.intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
 <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
 <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
 <BL0PR11MB3107F8D50FCADD168EAA9E7BF2030@BL0PR11MB3107.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3107F8D50FCADD168EAA9E7BF2030@BL0PR11MB3107.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:00:43AM +0000, Kammela, Gayatri wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, January 27, 2020 11:00 AM
> > To: Kammela, Gayatri <gayatri.kammela@intel.com>
> > Cc: Platform Driver <platform-driver-x86@vger.kernel.org>; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>; Somayaji, Vishwanath
> > <vishwanath.somayaji@intel.com>; Darren Hart <dvhart@infradead.org>;
> > Westerberg, Mika <mika.westerberg@intel.com>; Peter Zijlstra (Intel)
> > <peterz@infradead.org>; Prestopine, Charles D
> > <charles.d.prestopine@intel.com>; Pandruvada, Srinivas
> > <srinivas.pandruvada@intel.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Box, David E
> > <david.e.box@intel.com>
> > Subject: Re: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs
> > entries
> > 
> > On Mon, Jan 27, 2020 at 8:03 PM Kammela, Gayatri
> > <gayatri.kammela@intel.com> wrote:
> > 
> > > > It doesn't apply to our for-next branch.
> > > Sorry to hear that. I've rebased the series on mainline 5.5-rc7. Should I
> > rebase it on for-next branch?
> > 
> > You should always base your branch on the for-next (whatever it's being
> > called) of the subsystem your series against of.
> 
> Hi Andy,
> 
> The current series has a dependency on Tiger Lake and Elkhart Lake patche which is merged in to mainline. 
> 
> (554f269f0f38 platform/x86: intel_pmc_core: Add Intel Elkhart Lake support
> 49a437941c3f platform/x86: intel_pmc_core: Add Intel Tiger Lake support
> 6268c0b278b5 platform/x86: intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status conditional
> e39854781830 platform/x86: intel_pmc_core: Create platform dependent bitmap structs
> b1cb33dae414 platform/x86: intel_pmc_core: Clean up: Remove comma after the termination line)
> 
> But they are not available in for-next branch. I am confused, how that could be the case. For me to base the current series on for-next branch, the dependency patch series should be available in for-next branch.

I'm wondering how did you check it?
The branch location is in this [1] tree.

[1]: http://git.infradead.org/linux-platform-drivers-x86.git

-- 
With Best Regards,
Andy Shevchenko


