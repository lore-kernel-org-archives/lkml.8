Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDBAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B7720787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGPPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:47:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:63006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgGPPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:47:23 -0400
IronPort-SDR: 66vCs9QHHj+AyBLAdyD2uiHVhokEOENqGeHP72k7Db9XNGLYSaI6dBbj7Foj9v1+JXolYlZsnO
 cXWGvnDx7ghQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147401517"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="147401517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 08:47:22 -0700
IronPort-SDR: xSxEJLfX4nvgtLlEKhPBOw6PTUbGGrB41NYeDdBHnh8wYRSLIYXKK6oSLOO3e4pGAJeWEKKKdg
 7K4Du4uFfdmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="325178688"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 08:47:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jw66T-002BYF-6O; Thu, 16 Jul 2020 18:47:21 +0300
Date:   Thu, 16 Jul 2020 18:47:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
Message-ID: <20200716154721.GO3703480@smile.fi.intel.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> Hi!
> 
> Few days ago I bisected a regression on 5.8 kernel:
> 
> I have nvidia rtx 2070s and its USB type C port driver (which is open source)
> started to crash on load:

...

> Reverting the commit helped fix this oops.
> 
> My .config attached.
> If any more info is needed I'll be happy to provide it,
> and of course test patches.

Can you test below?

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1e6d75e65938..d58aa98fe964 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -721,7 +721,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	if (!IS_ERR_OR_NULL(fwnode->secondary))
+	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
 		next = fwnode_get_next_child_node(fwnode->secondary, child);
 
 	return next;
-- 
With Best Regards,
Andy Shevchenko


