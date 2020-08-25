Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C927BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16BB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHYOcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:32:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:22174 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHYOcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:32:33 -0400
IronPort-SDR: noZL9phiXY3oO1TsfQkD3IUsj1iCdx60v5PaYUuDVerhDvC22eoN9100GQNzyRvFS5KknlGZcu
 /cDgS7zgPanw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153688720"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="153688720"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 07:32:32 -0700
IronPort-SDR: GfgR888EqII5XdJD72waaKiFsEn1snYO90FUG+SVICdI1oCgSRKBb9sB/6cjbL8Yl/r/ZvMS5J
 RvvI4tgPoEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328879737"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 07:32:30 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAZzw-00BLOn-VM; Tue, 25 Aug 2020 17:32:28 +0300
Date:   Tue, 25 Aug 2020 17:32:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/3] software node: Introduce device_add_software_node()
Message-ID: <20200825143228.GK1891694@smile.fi.intel.com>
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
 <20200825135951.53340-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825135951.53340-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 04:59:50PM +0300, Heikki Krogerus wrote:
> This helper will register a software node and then assign
> it to device at the same time. The function will also make
> sure that the device can't have more than one software node.

> +	/* Only one software node per device. */
> +	if (dev_to_swnode(dev))
> +		return -EBUSY;

> +	swnode = dev_to_swnode(dev);
> +	if (!swnode)
> +		return;

Hmm... I didn't find implementation of dev_to_swnode().
What did I miss?

-- 
With Best Regards,
Andy Shevchenko


