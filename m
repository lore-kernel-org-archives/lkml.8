Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1525C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B800B2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgGaSTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:19:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:28768 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbgGaSTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:19:01 -0400
IronPort-SDR: /I1ARLBqlZkq8xTxCx2a3INUSTL7pW5xRDCSEGVXuSBKJmk9Axg4hi94YX1Or+uJwF0yKnPZXZ
 n+utIFWhPIdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="216290800"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="216290800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 11:18:46 -0700
IronPort-SDR: LLJ2N6V333Drvt0ak9qegxOHH6/16NIozjU4ajTxzwwX7lzbIA6m6eDGRs1rie1KSK1vhQRUD9
 csWZ5OcBv3YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="273263176"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2020 11:18:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1ZcB-005MAP-Dq; Fri, 31 Jul 2020 21:18:43 +0300
Date:   Fri, 31 Jul 2020 21:18:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Grant Likely <grant.likely@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
Message-ID: <20200731181843.GO3703480@smile.fi.intel.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
 <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:08:23PM +0300, Andy Shevchenko wrote:
> When printing phandle via %pOFp the custom spec is used. First of all,
> it has a SMALL flag which makes no sense for decimal numbers. Second,
> we have already default spec for decimal numbers. Use the latter in
> the %pOFp case as well.

Forgot to mention that the patch (and actually the series) has been tested
against test_printf and OF unittest modules.

-- 
With Best Regards,
Andy Shevchenko


