Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B120863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgCCKHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:07:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:55125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCCKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:07:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 02:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="233707070"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2020 02:07:07 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j94SE-006W95-2d; Tue, 03 Mar 2020 12:07:10 +0200
Date:   Tue, 3 Mar 2020 12:07:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v4 3/3] phy: intel: Add driver support for ComboPhy
Message-ID: <20200303100710.GK1224808@smile.fi.intel.com>
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <4e55050985ef0ab567415625f5d14ab1c9b33994.1583127977.git.eswara.kota@linux.intel.com>
 <20200302111901.GT1224808@smile.fi.intel.com>
 <b0f7742d-7d61-9743-4047-c5352dd7495d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f7742d-7d61-9743-4047-c5352dd7495d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 04:41:17PM +0800, Dilip Kota wrote:
> On 3/2/2020 7:19 PM, Andy Shevchenko wrote:
> > On Mon, Mar 02, 2020 at 04:43:25PM +0800, Dilip Kota wrote:
> > > ComboPhy subsystem provides PHYs for various
> > > controllers like PCIe, SATA and EMAC.
> > Thanks for an update, my (few minor) comments below.

...

> > > +enum intel_phy_mode {
> > > +	PHY_PCIE_MODE = 0,
> > > +	PHY_XPCS_MODE,
> > > +	PHY_SATA_MODE
> >  From here it's not visible that above is the only possible values.
> > Maybe in the future you will have another mode.
> > So, I suggest to leave comma here...
> There won't be no further modes,...

Again, this is not obvious from the naming scheme in use.
And how do you know the future?

> i can still add the comma at all the places pointed.

Just use a common sense.

> > > +};
> > > +enum intel_combo_mode {
> > > +	PCIE0_PCIE1_MODE = 0,
> > > +	PCIE_DL_MODE,
> > > +	RXAUI_MODE,
> > > +	XPCS0_XPCS1_MODE,
> > > +	SATA0_SATA1_MODE
> > ...and here...
> > 
> > > +};
> > > +
> > > +enum aggregated_mode {
> > > +	PHY_SL_MODE,
> > > +	PHY_DL_MODE
> > ...and here.
> > 
> > > +};

-- 
With Best Regards,
Andy Shevchenko


