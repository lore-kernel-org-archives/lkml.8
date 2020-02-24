Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE77C11D3D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A53320732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBXXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:23:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:62441 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBXXXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:23:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 15:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="237481968"
Received: from wtczc53028gn.jf.intel.com (HELO skl-build) ([10.54.87.17])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2020 15:23:53 -0800
Date:   Mon, 24 Feb 2020 15:23:43 -0800
From:   "Christopher S. Hall" <christopher.s.hall@intel.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com,
        x86@kernel.org, jacob.e.keller@intel.com, davem@davemloft.net,
        sean.v.kelley@intel.com
Subject: Re: [Intel PMC TGPIO Driver 1/5] drivers/ptp: Add Enhanced handling
 of reserve fields
Message-ID: <20200224232343.GE1508@skl-build>
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
 <20191211214852.26317-2-christopher.s.hall@intel.com>
 <20200203012700.GA2354@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203012700.GA2354@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thanks for the detailed review.

On Sun, Feb 02, 2020 at 05:27:00PM -0800, Richard Cochran wrote:
> On Wed, Dec 11, 2019 at 01:48:48PM -0800, christopher.s.hall@intel.com wrote:
> > diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> > index 9d72ab593f13..f9ad6df57fa5 100644
> > --- a/drivers/ptp/ptp_chardev.c
> > +++ b/drivers/ptp/ptp_chardev.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/timekeeping.h>
> >  
> >  #include <linux/nospec.h>
> > +#include <linux/string.h>
> 
> Please group these two includes with the others, above, in
> alphabetical order.

OK. Done.

> >  #include "ptp_private.h"
> >  
> > @@ -106,6 +107,28 @@ int ptp_open(struct posix_clock *pc, fmode_t fmode)
> >  	return 0;
> >  }
> >  
> > +/* Returns -1 if any reserved fields are non-zero */
> > +static inline int _check_rsv_field(unsigned int *field, size_t size)
> 
> How about _check_reserved_field() instead?

No problem. Sounds good.

> > +{
> > +	unsigned int *iter;
> 
> Ugh, 'ptr' please.
> 
> > +	int ret = 0;
> > +
> > +	for (iter = field; iter < field+size && ret == 0; ++iter)
> > +		ret = *iter == 0 ? 0 : -1;
> 
> Please use the "early out" pattern:
> 
> 	for (ptr = field; ptr < field + size; ptr++) {
> 		if (*ptr) {
> 			return -1;
> 		}
> 	}
> 	return 0;
> 
> Note:  field + size
> Note:  ptr++

OK for both of these.

> > +
> > +	return ret;
> > +}
> > +#define check_rsv_field(field) _check_rsv_field(field, ARRAY_SIZE(field))
> 
> And check_reserved_field() here.  No need to abbreviate.

OK. Done.

> Thanks,
> Richard

Thanks,
Chris
