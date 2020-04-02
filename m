Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7012C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A04208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbgDBTfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:35:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:1190 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgDBTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:35:02 -0400
IronPort-SDR: wMqRrVMjrRnjyzcailJHPpoDg3t/deQmIOlcCSCmIP8YDJQC3hKQVj29Rv8I8yc5ucYuht7jW0
 rIXqZ3f/lBuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:35:01 -0700
IronPort-SDR: D+9Y1E1mG1Ia8MPeB26kIXnYdPsDBlJCgNId6TdLwahKSnwDA0AhR8D+BOfYd6BnmPnmn2IWm+
 U6hfKN3jPpUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="243174003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2020 12:34:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jK5cC-00FF3h-3I; Thu, 02 Apr 2020 22:35:00 +0300
Date:   Thu, 2 Apr 2020 22:35:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, mingo@redhat.com,
        babu.moger@amd.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Use appropriate API for strings
 terminated by newline
Message-ID: <20200402193500.GC1922688@smile.fi.intel.com>
References: <cover.1585765499.git.reinette.chatre@intel.com>
 <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
 <20200402130625.GA1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402130625.GA1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:06:25PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 01, 2020 at 11:30:48AM -0700, Reinette Chatre wrote:

...

> >  	int ret = 0;
> > +	int user_m;

...and forgot to mention this...

	int user_m;
	int ret;

> >  	/* Valid input requires a trailing newline */
> >  	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> >  		return -EINVAL;
> > -	buf[nbytes - 1] = '\0';
> 
> The above test is not needed and comment now is misleading.
> WRT nbytes I believe that kernel fs code checks for that.
> 
> >  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> >  	if (!rdtgrp) {
> > @@ -1428,11 +1428,15 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
> >  
> >  	mode = rdtgrp->mode;
> >  
> > -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> > -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> > -	    (!strcmp(buf, "pseudo-locksetup") &&
> > -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> > -	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
> > +	user_m = sysfs_match_string(rdt_mode_str, buf);
> > +	if (user_m < 0) {
> > +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> > +		ret = user_m;
> > +		goto out;
> > +	}
> 
> You can do it the way
> 
> 	ret = sysfs_match_string(...);
> 	if (ret < 0) {
> 		...
> 	}
> 	user_m = ret;

...and this changes

	ret = 0;

-- 
With Best Regards,
Andy Shevchenko


