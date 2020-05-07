Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22482C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F301420735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:32:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:2582 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgEGMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:32:20 -0400
IronPort-SDR: aFf3ztMiMVEpMsT5QMiYrZ7JD0RUfkYEGeOPY0+Nuhzlt0ubjXLLKsCsuf+bQaEqVsYwIJmggy
 zwzhSsRFLHjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 05:32:19 -0700
IronPort-SDR: psNQk5yugDahepXd1JCbvjMsPpur5jqKY8gOAD7enN67H3q5V1iHpYZjMT88mZ0oxkvg3ujTUS
 cP+vcZgcHqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="462129671"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 07 May 2020 05:32:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWfhL-005DG5-GF; Thu, 07 May 2020 15:32:19 +0300
Date:   Thu, 7 May 2020 15:32:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add TI tps6598x device tree
 binding documentation
Message-ID: <20200507123219.GT185537@smile.fi.intel.com>
References: <20200507122352.1773661-1-bryan.odonoghue@linaro.org>
 <20200507122352.1773661-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507122352.1773661-2-bryan.odonoghue@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:23:51PM +0100, Bryan O'Donoghue wrote:
> Add device tree binding documentation for the Texas Instruments tps6598x
> Type-C chip driver.

> +maintainers:
> +  - Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This makes Heikki maintainer of a shema. I dunno if he want this.

> +        #size-cells = <0>;
> +    

Trailing spaces.

-- 
With Best Regards,
Andy Shevchenko


