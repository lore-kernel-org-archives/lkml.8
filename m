Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE6120786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRIks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:40:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:55095 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRIks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:40:48 -0400
IronPort-SDR: UYjZy2cKtU676FWhqX4n2y0I6eFvfemjljQFkljeVtWzgAaL7AUoWdKlpZZY5Zg05C5ybT7Ble
 /BsFSe1+OyeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152495521"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="152495521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 01:40:47 -0700
IronPort-SDR: wNInzQqd1UkMFD+W5YUEfnDZFo64GuyIKyOx5JUYYT2Etei1itQR1hV5prW+pUkaykhZP+FzHd
 yEhprxNWeFLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326668143"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 01:40:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k7xAi-009bjM-5G; Tue, 18 Aug 2020 11:40:44 +0300
Date:   Tue, 18 Aug 2020 11:40:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
Message-ID: <20200818084044.GD1891694@smile.fi.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> USB external connector chip PTN5150 used on the Intel LGM SoC
> boards to detect the USB type and connection.

Internally I meant you can send cleanups, but couple of patches here are the
features and were still under discussion... But here we are.

> ---
> v1:
>   - Initial version
> 
> Ramuthevar Vadivel Murugan (9):
>   extcon: extcon-ptn5150: Switch to GENMASK() for vendor and device ID's
>   extcon: extcon-ptn5150: Switch to GENMASK() for VBUS detection macro
>   extcon: extcon-ptn5150: Switch to BIT() macro for cable attach
>   extcon: extcon-ptn5150: Switch to BIT() for cable detach macro
>   extcon: extcon-ptn5150: Switch to GENMASK() for port attachment macro
>   extcon: extcon-ptn5150: Set and get the VBUS and POLARITY property
>     state
>   extcon: extcon-ptn5150: Add USB debug accessory support
>   extcon: extcon-ptn5150: Add USB analog audio accessory support
>   extcon: extcon-ptn5150: Remove unused variable and extra space
> 
>  drivers/extcon/extcon-ptn5150.c | 135 ++++++++++++++++++++++++----------------
>  1 file changed, 82 insertions(+), 53 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


