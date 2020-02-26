Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F4EC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9392821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBZOpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:45:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:18305 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgBZOpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:45:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 06:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="230457861"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 26 Feb 2020 06:45:29 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j6xwJ-004x21-02; Wed, 26 Feb 2020 16:45:31 +0200
Date:   Wed, 26 Feb 2020 16:45:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
Message-ID: <20200226144530.GR10400@smile.fi.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
 <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
 <20200226144147.GQ10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226144147.GQ10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:41:47PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 26, 2020 at 06:09:53PM +0800, Dilip Kota wrote:

> > +	i = 0;
> > +	fwnode_for_each_available_child_node(dev_fwnode(dev), fwnode) {
> 
> > +		if (i >= PHY_MAX_NUM) {
> > +			fwnode_handle_put(fwnode);
> > +			dev_err(dev, "Error: DT child number larger than %d\n",
> > +				PHY_MAX_NUM);
> > +			return -EINVAL;
> > +		}
> 
> Logically this part is better to put after i++; line...

Ah, dismiss this, I forgot the fwnode_handle_put() part along with amount of
accessible children.

> > +		ret = intel_cbphy_iphy_dt_parse(cbphy, fwnode, i);
> > +		if (ret) {
> > +			fwnode_handle_put(fwnode);
> > +			return ret;
> > +		}
> > +
> 
> > +		i++;
> 
> ...here.
> 
> > +	}
> > +
> > +	return intel_cbphy_dt_sanity_check(cbphy);
> > +}

-- 
With Best Regards,
Andy Shevchenko


