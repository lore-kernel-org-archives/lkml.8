Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2521C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD62F20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nt6ZepCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHJVfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFACC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQG4jitOTpWA8DJ0dv1Ku3T6gmtn5fPpsfnq6pnuULU=; b=nt6ZepCXbqB+lmHPizg9mbyQM1
        tKv+lK/5jpfpw9V3JJjzWDoK8PZ5id9IWtv9uPmg3GFi++d66Itm4NAPL6v63BTMfL6dZPOgexugH
        ACFsUTGPN/zTQ1w0KDzvI5VpTlaCt6osz9az6tTXRDKizbXj+2nL7S1Xwnl+Aa3XTcYkx6GBerxWs
        7wY9lqkn8GC/n1ybbKfmWdtQIG7Qnn27VE1HHVjqa7D/eOw21g+CrzwNrW8CENSVYr4m7f4l2rHI/
        /894KTxI1yP4bDwRb2vT+r5U8TV/suJ5dgaboJpITyqk9ajxAbAKwt2zUILhYKF9/Y480xMAD4bF8
        PtSIMKiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FS2-0004u4-0J; Mon, 10 Aug 2020 21:35:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B433980D39; Mon, 10 Aug 2020 23:35:24 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:35:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20200810213524.GI3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810212436.8026-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:24:21PM -0700, Kan Liang wrote:
> Current perf can report both virtual addresses and physical addresses,
> but not the page size. Without the page size information of the utilized
> page, users cannot decide whether to promote/demote large pages to
> optimize memory usage.
> 
> Add a new sample type for the data page size.
> 
> Current perf already has a facility to collect data virtual addresses.
> A page walker is required to walk the pages tables and calculate the
> page size from a given virtual address.
> 
> On some platforms, e.g., X86, the page walker is invoked in an NMI
> handler. So the page walker must be IRQ-safe and low overhead. Besides,
> the page walker should work for both user and kernel virtual address.
> The existing generic page walker, e.g., walk_page_range_novma(), is a
> little bit complex and doesn't guarantee the IRQ-safe. The follow_page()
> is only for user-virtual address.

s/IRQ/NMI/g
