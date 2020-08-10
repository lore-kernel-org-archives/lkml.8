Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB876C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5A420658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWma1h9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHJUZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:25:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BBDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZiCKrnai24zNTIYm0YDOwdDud4HBEq9sQgBJdZFufl0=; b=rWma1h9zxX09KIfynF2E70xXzX
        Kh/RcX4gtz1uMLBaBrapaM8nfWztEsZ+0Bp6t34owfC47OBm/1S+kn9v/Hpq/zprWR16ufUh2uZDe
        LhL2q5qVPDrgI2QRldN79XPUpmikACZ5qnY74QY7EpvpsHAnjPPb0O7DqTCbuSJCg2llNfP/LmLyD
        /jxV1+71iSoFmth26C4khvULmEXw25o3m72qGYhp+0oz8oWY3dOmH5Q7LAHyAXuA85NzhEioLhk5g
        4RyZSa0pbzuyToGunbQ0/ThPD9l6ZZsUkw2+SkYTKDfIe1SujjyDFrzo47zvTb5aD+wszgUuWwjUW
        d/stZltQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5ELm-0006u5-99; Mon, 10 Aug 2020 20:24:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FB94980D39; Mon, 10 Aug 2020 22:24:53 +0200 (CEST)
Date:   Mon, 10 Aug 2020 22:24:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] libperf: Add support for user space counter access
Message-ID: <20200810202453.GD3982@worktop.programming.kicks-ass.net>
References: <20200807230517.57114-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807230517.57114-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> x86 and arm64 can both support direct access of event counters in
> userspace. The access sequence is less than trivial and currently exists
> in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> projects such as PAPI and libpfm4.
> 
> Patches to add arm64 userspace support are pending[1].
> 
> For this RFC, looking for a yes, seems like a good idea, or no, go away we
> don't want this in libperf.

I'd like it lots better if you'd at least take an optimized version of
this, also see this thread:

  https://lkml.kernel.org/r/20200322101848.GF2452@worktop.programming.kicks-ass.net

Also, I usually strip out all the multiplexing crud out (and use pinned
counters), which saves a bunch.


static inline u64 mmap_read_pinned(void *addr)
{
        struct perf_event_mmap_page *pc = addr;
        u32 seq, idx, width = 0;
        u64 count;
        s64 pmc = 0;

        do {
                seq = pc->lock;
                barrier();

                idx = pc->index;
                count = pc->offset;
                if (pc->cap_user_rdpmc && idx) {
                        width = pc->pmc_width;
                        pmc = rdpmc(idx - 1);
                }

                barrier();
        } while (pc->lock != seq);

        if (idx) {
                pmc <<= 64 - width;
                pmc >>= 64 - width; /* shift right signed */
                count += pmc;
        }

        return count;
}

