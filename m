Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7000FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F233204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHSNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:50:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:36630 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgHSNsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:48:46 -0400
IronPort-SDR: m6olT64QvCy+xeWEaYc9yD7yonjzvCGHnTSDUJWL34Kk+GfEJi7SvBBekuxAdbwOFqF8GiAzC9
 oaGTeat3yQgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142738264"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="142738264"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 06:48:45 -0700
IronPort-SDR: wYeugUQ1on5s5qvK/sUjNgYPhOBsyCX1T2OgATtQvGIAeOYjeqOAOcJ+IBUUXIHVA5ixtovylM
 yDVj4kQoEccg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="327093530"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 06:48:43 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k8OSI-009syk-IY; Wed, 19 Aug 2020 16:48:42 +0300
Date:   Wed, 19 Aug 2020 16:48:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add device IDs for UART ports for
 Lakefield
Message-ID: <20200819134842.GN1891694@smile.fi.intel.com>
References: <20200819124127.61398-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819124127.61398-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:41:27PM +0300, Andy Shevchenko wrote:
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Add PCI IDs for Lakefield to the list of supported UARTs.

Sorry, it might be not applicable in this form (wrong tree).

-- 
With Best Regards,
Andy Shevchenko


