Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCEA20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:09:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:13846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHMOI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:08:57 -0400
IronPort-SDR: sHShGv06QUvYIugrdHcjVDwrIkhNjW1RErZg669+25WpmAthoFmV5Qb2z5UHMXJzSEqtyO1+MI
 IiPSaUtn+Qwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="154185340"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="154185340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 07:08:56 -0700
IronPort-SDR: o0MhVUkf4xPzEwR7h5E3yQ59OcocB9KOzuxf7ng3Ug8K5sl+Cj+JJ+tAo2jwUPoy/mLQte8mva
 Q2GA2O+HUFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="325420663"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 07:08:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6Dm5-008SAB-PZ; Thu, 13 Aug 2020 17:00:09 +0300
Date:   Thu, 13 Aug 2020 17:00:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Seungil Kang <sil.kang@samsung.com>
Cc:     bhe@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/cmdline: prevent unintented access to address
Message-ID: <20200813140009.GX1891694@smile.fi.intel.com>
References: <CGME20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac@epcas1p3.samsung.com>
 <20200813030741.6896-1-sil.kang@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813030741.6896-1-sil.kang@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:07:41PM +0900, Seungil Kang wrote:
> When args = "\"\0", "i" will be 0 and args[i-1] is used. (*lib/cmdline.c +238)

What I meant is to put hex dump of the args here in the parentheses, something like

"When args = "... \"\0" (... 0x22 0x00), 'i' will be..."

> Because of "i" is an unsigned int type, the function will access at args[0xFFFFFFFF].
> It can make a crash.

...

> > Can you point out to the code that calls this and leads to a crash?
> 
>  *lib/cmdlinc + 201 ~, next_arg function with args = "\"\0"

Not the next_arg() code :-) The code which calls here...

...

> > Can you provide a KUnit test module which can check the case?
> 
>  If necessary, I will make it and share it.

Please, do as a separate patch in the series.

...

> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -200,7 +200,7 @@ bool parse_option_str(const char *str, const char *option)
>   */
>  char *next_arg(char *args, char **param, char **val)
>  {
> -	unsigned int i, equals = 0;
> +	int i, equals = 0;
>  	int in_quote = 0, quoted = 0;
>  	char *next;

At the first glance this is not correct fix for it: 0 - 1 is always 'all 1:s'
independently on signedness, but I need to think about.

And your test case / module would help a lot, if present.

-- 
With Best Regards,
Andy Shevchenko


