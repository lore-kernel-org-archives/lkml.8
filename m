Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152FC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C10B2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBDWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:25:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:12421 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgBDWZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:25:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 14:25:49 -0800
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="403944584"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 14:25:48 -0800
Date:   Tue, 4 Feb 2020 14:25:47 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: What should we do with match_option()?
Message-ID: <20200204222547.GA21277@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back at the beginning of 2018 David Woodhouse added the inline
function match_option() to aid is parsing boot arguments:

da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")

More recently PeterZ used match_option() in some pseudo-code to help
get the split-lock patches un-jammed.  I cleaned that up a bit and
the patch is now sitting in TIP ready for the next merge window.

But Boris noticed that I'd copy/pasted the inline function defintion,
and I promised to look at resolving the duplication.

My first instinct was to just delete both instances from ".c" files
and move it to <linux/string.h>. But net/netfilter/xt_dccp.c has its
own function with this name (that does something different).

So I looked a bit more closely at what it actually does ... and now
I'm not really sure what problem it is solving.

The issue seems to be that cmdline_find_option() might truncate the
value of the option string to fit in the user supplied buffer. If that
happens, the value in the buffer is guaranteed NUL terminated and
cmdline_find_option() returns the length of the full string.

match_option() checks to see if that return value matches the length
of the option being checked, and fails if it doesn't match. Which
prevents the truncated string from giving a false match against the
option string being checked.

But this seems to be a belt, braces (USA=suspenders) and stapling the
waistband of trousers (USA=pants) to your body approach.

If the user supplies a large enough buffer to cmdline_find_option()
for any of the legal options Then the resulting "arg" will not be
truncated for anything legal. So we should be able to just use
"strcmp()" to see which of the options is matched.

So should we promote match_option() to <linux/string.h>? Or
drop it and just use strcmp() instead?

-Tony
