Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A729320838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgBJOvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:51:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:28270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbgBJOvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:51:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="233124785"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2020 06:51:28 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1APJ-000ZaM-Sa; Mon, 10 Feb 2020 16:51:29 +0200
Date:   Mon, 10 Feb 2020 16:51:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1] MAINTAINERS: Sort entries in database for VSPRINTF
Message-ID: <20200210145129.GV10400@smile.fi.intel.com>
References: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
 <20200210142154.x2azckvduvh3xuea@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210142154.x2azckvduvh3xuea@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:21:55PM +0100, Petr Mladek wrote:
> Hi Andy,
> 
> On Tue 2020-01-28 16:34:25, Andy Shevchenko wrote:
> > Run parse-maintainers.pl and choose VSPRINTF record. Fix it accordingly.
> 
> Does this produce any visible error or warning anywhere, please?

Not for the moment.
Nevertheless, there is an initial motivation behind this [1,2].


> checkpatch.pl does not warn about it.
> 
> Also the order does not look defined in the file. When I run
> parse-maintainers.pl on the entire MAINTAINERS file:

See [2] for the details.

>  MAINTAINERS | 5584 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
>  1 file changed, 2787 insertions(+), 2797 deletions(-)
> 
> The file has 18545 lines. It means that huge amount of entries
> do not follow the order.

Yes, but it's getting better.

[1]: 7683e9e52925 ("Properly alphabetize MAINTAINERS file")
[2]: https://lore.kernel.org/lkml/CA+55aFy3naVgbRubhjfq7k4CcSiFOEdQNkNwHTLDLmepECu9yA@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


