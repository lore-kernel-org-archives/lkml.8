Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEFDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4207A2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgHRQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:34:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:14053 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgHRQeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:34:00 -0400
IronPort-SDR: weAyHH8irlpDKQVdo2JES8dNS8SpRBjz9TaA5Ap0VwC+byRZWmHCcJomwsF/AyR7p2fhbUbKsC
 m4A/TRIA37Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152359618"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="152359618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 09:34:00 -0700
IronPort-SDR: 2271QJgWYxz0oDjodaP7J16j0OQkBWBtwICA1LKBZXLjQDqmefq91/HlylKXsBs9VVkxpPNQS4
 2BnHx+GEOD/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="278090565"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2020 09:33:57 -0700
Date:   Tue, 18 Aug 2020 19:33:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kprobes: Use module_name() macro
Message-ID: <20200818163356.GG137138@linux.intel.com>
References: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
 <20200818234956.c616371d8766e74aef5e7bd2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818234956.c616371d8766e74aef5e7bd2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:49:56PM +0900, Masami Hiramatsu wrote:
> On Tue, 18 Aug 2020 08:08:57 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > It is advised to use module_name() macro instead of dereferencing mod->name
> > directly. This makes sense for consistencys sake and also it prevents a
> > hard dependency to CONFIG_MODULES.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>,
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> OK, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Great, thank you.

When this might get included to a PR, or at minimum land to linux-next?

Just thinking what to use as the baseline for the next version of my
main series.

BR,
/Jarkko
