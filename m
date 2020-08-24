Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9B4204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:57:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:36390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgHXQ5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10B00AD76;
        Mon, 24 Aug 2020 16:57:25 +0000 (UTC)
Date:   Mon, 24 Aug 2020 17:56:53 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Borislav Petkov <bp@suse.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200824165653.GQ2976@suse.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200824161238.GI4794@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:12:38PM +0200, Borislav Petkov wrote:
> 
> > :)  Right, this is what I'm doing right now. Some test job is queued on
> > the test box, and it may needs some iterations of new patch. Hopefully we
> > can isolate some specific variable given some luck.
> 
> ... yes, exactly, you need to identify the contention where this
> happens,
> causing a cacheline to bounce or a variable straddles across a
> cacheline boundary, causing the read to fetch two cachelines and thus
> causes that slowdown. And then align that var to the beginning of a
> cacheline.
> 

Given the test is malloc1, it *may* be struct per_cpu_pages embedded within
per_cpu_pageset. The cache characteristics of per_cpu_pageset are terrible
because of how it mixes up zone counters and per-cpu lists. However, if
the first per_cpu_pageset is cache-aligned then every second per_cpu_pages
will be cache-aligned and half of the lists will fit in one cache line. If
the whole structure gets pushed out of alignment then all per_cpu_pages
straddle cache lines, increase the overall cache footprint and potentially
cause problems if the cache is not large enough to hold hot structures.

The misses could potentially be inferred without c2c from looking at
perf -e cache-misses on a good and bad kernel and seeing if there is a
noticable increase in misses in mm/page_alloc.c with a focus on anything
using per-cpu lists.

Whether the problem is per_cpu_pages or some other structure, it's not
struct mce's fault in all likelihood -- it's just the messenger.

-- 
Mel Gorman
SUSE Labs
