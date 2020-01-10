Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002562080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ZIaFRqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgAJPK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:10:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgAJPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EOly64n1bW9A8cciZ1GsSjqaul4aqxrKRoF/7rR8Npg=; b=1ZIaFRqcaOBqY3PTIc2myc4/T
        2bqFse/mCvbU0ZywdFOYX8JeeV82iaW4dhncF9xgCXu7AF6hHsxC3iNEef+Uh3EtTE5sE9O9Skv9E
        B4TAS69ZekjiuMOLRFlPh6NgjNLd3jMWouCAVNlTmBEZ+JAOa/8t8O4bPcMHUpHDcdmuFbrvOruBr
        /ZGsCe8QyHqGsWNSHsR2dX8HE7SuPYXOJVwmpo3E2yk4aWtrZPP/PhLlJhgGbGcGt0A+PxQBk/tdM
        c/Tdyh2c5e8DMidSd+HO9S2FjgqeFDBNfamwvg6UOsRt2O9AvRqnvpfdwaCFTSUBH3tZADHb8bVD9
        ChUlgoC8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipvvF-0004gW-Jv; Fri, 10 Jan 2020 15:10:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3460C30018B;
        Fri, 10 Jan 2020 16:08:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 202002B612601; Fri, 10 Jan 2020 16:09:58 +0100 (CET)
Date:   Fri, 10 Jan 2020 16:09:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per
 Cycle Events
Message-ID: <20200110150958.GP2844@hirez.programming.kicks-ass.net>
References: <20191114183720.19887-1-kim.phillips@amd.com>
 <20191114183720.19887-3-kim.phillips@amd.com>
 <20191220120945.GG2844@hirez.programming.kicks-ass.net>
 <ca10060f-f78f-695f-4929-fe4bc30c6712@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca10060f-f78f-695f-4929-fe4bc30c6712@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 04:26:47PM -0600, Kim Phillips wrote:
> On 12/20/19 6:09 AM, Peter Zijlstra wrote:
> > On Thu, Nov 14, 2019 at 12:37:20PM -0600, Kim Phillips wrote:

> >> @@ -926,10 +944,14 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
> >>  			break;
> >>  
> >>  		/* not already used */
> >> -		if (test_bit(hwc->idx, used_mask))
> >> +		if (test_bit(hwc->idx, used_mask) || (is_large_inc(hwc) &&
> >> +		    test_bit(hwc->idx + 1, used_mask)))
> >>  			break;
> >>  
> >>  		__set_bit(hwc->idx, used_mask);
> >> +		if (is_large_inc(hwc))
> >> +			__set_bit(hwc->idx + 1, used_mask);
> >> +
> >>  		if (assign)
> >>  			assign[i] = hwc->idx;
> >>  	}
> > 
> > This is just really sad.. fixed that too.
> 
> [*]

> If I undo re-adding my perf_assign_events code, and re-add my "not
> already used" code that you removed - see [*] above - the problem DOES
> go away, and all the counts are all accurate.
> 
> One problem I see with your change in the "not already used" fastpath
> area, is that the new mask variable gets updated with position 'i'
> regardless of any previous Large Increment event assignments.

Urgh, I completely messed that up. Find the below delta (I'll push out a
new version to queue.git as well).

> I.e., a
> successfully scheduled large increment event assignment may have
> already consumed that 'i' slot for its Merge event in a previous
> iteration of the loop.  So if the fastpath scheduler fails to assign
> that following event, the slow path is wrongly entered due to a wrong
> 'i' comparison with 'n', for example.

That should only be part of the story though; the fast-path is purely
optional. False-negatives on the fast path should not affect
functionality, only performance. False-positives on the fast path are a
no-no of course.

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 222f172cbaf5..3bb738f5a472 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -937,7 +937,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 * fastpath, try to reuse previous register
 	 */
 	for (i = 0; i < n; i++) {
-		u64 mask = BIT_ULL(i);
+		u64 mask;
 
 		hwc = &cpuc->event_list[i]->hw;
 		c = cpuc->event_constraint[i];
@@ -950,6 +950,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		if (!test_bit(hwc->idx, c->idxmsk))
 			break;
 
+		mask = BIT_ULL(hwc->idx);
 		if (is_counter_pair(hwc))
 			mask |= mask << 1;
 
