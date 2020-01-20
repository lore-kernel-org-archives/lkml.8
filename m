Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F1EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C647207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgATMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:16:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:44839 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:16:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 04:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="425177331"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2020 04:16:44 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1itVz3-0001HR-KC; Mon, 20 Jan 2020 14:16:45 +0200
Date:   Mon, 20 Jan 2020 14:16:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <20200120121645.GI32742@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> Until now DMI information is lost when kexec'ing. Fix this in the same way as
> it has been done for ACPI RSDP.
> 
> Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> particular the default I2C host speed is choosen based on DMI system
> information and now gets it correct.

Guys, it was quite a long no hear from you.
Today I found that Microsoft Surface 3 also affected by this.

Can we apply these patches for now until you will find better solution?

P.S. I may resend them rebased on recent vanilla.

-- 
With Best Regards,
Andy Shevchenko


