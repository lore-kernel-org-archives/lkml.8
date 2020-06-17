Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ECFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5974620776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:01:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:55840 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgFQOBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:01:18 -0400
IronPort-SDR: KL9/j16fP0u6vgKM68IgxiOCtR2igPo7reZeLP6G7K5mgv/2a1pUz7wQ/0c50BvwNZa5xpgpxa
 jU5PZ6noycbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 07:01:07 -0700
IronPort-SDR: pHhd1moQFCEilgzcaIfWOZxD8yIrsQ3v98hiX2jss36iUYAD6RfJld9ysOdQRNPLZfsTUncnNe
 MXMrxxJ9wyMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="277283737"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 07:01:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jlYcl-00E41G-LW; Wed, 17 Jun 2020 17:01:07 +0300
Date:   Wed, 17 Jun 2020 17:01:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com
Subject: Re: [RESEND v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200617140107.GF2428291@smile.fi.intel.com>
References: <20200616233252.15619-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200616233252.15619-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616233252.15619-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 07:32:52AM +0800, Wan Ahmad Zainie wrote:
> Add support for eMMC PHY on Intel Keem Bay SoC.

...

> +	ret = regmap_read_poll_timeout(priv->syscfg, PHY_STAT,
> +				       dllrdy, IS_DLLRDY(dllrdy),
> +				       0, 50 * USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(&phy->dev, "dllrdy failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}

This has no changes.

Are you sure the version is correct?

-- 
With Best Regards,
Andy Shevchenko


