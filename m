Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB61C34052
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511602464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBSPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:38:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:31284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:38:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 07:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="315421676"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2020 07:37:59 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j4RQG-003KMF-NA; Wed, 19 Feb 2020 17:38:00 +0200
Date:   Wed, 19 Feb 2020 17:38:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
Message-ID: <20200219153800.GZ10400@smile.fi.intel.com>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:45:58PM +0100, Petr Mladek wrote:
> On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:

...

> Sigh, I should have been more strict[*]. The function should have been
> called err_ptr() and located right below null_pointer().

But taking above into consideration it should be rather error_pointer().
No?

> [*] I am still trying to find a right balance between preventing
> nitpicking, bikeshedding, enforcing my style, and creating a mess.

-- 
With Best Regards,
Andy Shevchenko


