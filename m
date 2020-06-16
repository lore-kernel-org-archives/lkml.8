Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844E620679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgFPQoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:44:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:43680 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPQoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:44:21 -0400
IronPort-SDR: DU6ncOoptTtJz33SPGU/nw4MSnUNRCPP7Efz1LSJyyW7jSne/xF3Vb2rUHYc4Ard86/9D153mT
 x6L5OxMVYtmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 09:44:19 -0700
IronPort-SDR: TJI5y5oij0AyPsuZ2yZQovBcZ85sh5U0/hxzsldUuarJzm84wllOs0erwwAzCd675W3z3Tht2Z
 yMtDGbKMEKxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="298973699"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 09:44:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jlEhA-00DsK7-JB; Tue, 16 Jun 2020 19:44:20 +0300
Date:   Tue, 16 Jun 2020 19:44:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com
Subject: Re: [PATCH v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200616164420.GZ2428291@smile.fi.intel.com>
References: <20200616143818.13579-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200616143818.13579-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616143818.13579-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:38:18PM +0800, Wan Ahmad Zainie wrote:
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

return ret;

(Since it's only one minor issue, it's up to maintainers to decide if new
 version is needed)

-- 
With Best Regards,
Andy Shevchenko


