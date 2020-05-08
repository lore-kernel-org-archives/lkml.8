Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA49C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE811208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEHKQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:16:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:35738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEHKQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:16:08 -0400
IronPort-SDR: a/aWPKeL7xObCOhn7Xex212W5Xp4t0pgJ4QGbqej8Soyvgl7xZqedftSymziVuuO87a+sfWzXj
 9FqdH1j6oNlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:16:07 -0700
IronPort-SDR: ZRtL00QWJwbe3OhNC8qJ/IWzZ9+E6yWoA6P8YUxyILJPxDMq8oLsfek/6/T7/p1st1UHCu6To/
 M7K4tWVTEsHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="251792934"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2020 03:16:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX032-005Oei-Ew; Fri, 08 May 2020 13:16:04 +0300
Date:   Fri, 8 May 2020 13:16:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508101604.GF185537@smile.fi.intel.com>
References: <20200508021438.4373-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:14:38AM +0000, Luis Chamberlain wrote:
> Device driver firmware can crash, and sometimes, this can leave your
> system in a state which makes the device or subsystem completely
> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> of scraping some magical words from the kernel log, which is driver
> specific, is much easier. So instead provide a helper which lets drivers
> annotate this.
> 
> Once this happens, scrapers can easily scrape modules taint flags.
> This will taint both the kernel and respective calling module.
> 
> The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> this fact should in no way shape or form affect lockdep. This taint
> is device driver specific.

...

> +++ b/include/trace/events/module.h
> @@ -26,7 +26,8 @@ struct module;
>  	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
>  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>  	{ (1UL << TAINT_CRAP),			"C" },		\
> -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> +	{ (1UL << TAINT_FIRMWARE_CRASH),	"Q" })

Perhaps split out the closing parenthesis to avoid changing additional line in
the future?

>  TRACE_EVENT(module_load,

-- 
With Best Regards,
Andy Shevchenko


