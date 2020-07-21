Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7F2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB0B2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBCispH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGUNKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGUNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:10:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8376C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bzG30uW1QQPXIbjKnRH60T7j2KtPqcKAnWW8zGBS+p4=; b=gBCispH2vUYT6jHwGHUaXqA38T
        TMI2m2ybmBFqs6CytlGY81XoeXAgxE39spZ3vnYqqQLlPGVaM0nt7vpWtEjOTC1upvIdBN3+cTJlW
        W06aJDt8/8od4+aOFddejW++uKTYQGECb2efV8ZEmahIWF6BFDTklg+4hKd7jCV4FUVoOHysARFNQ
        wUuYkKNfO8An4LVy101So4sWQIzm6e+f59g7uu2oll47wk7p8qvt9WYlYvgOMTaXMrvZSLJtFNR5h
        c4dMpMdpI66Vbi+rrUq31Wcab8bY41eAMjGk1roYgdaiI2fz7XTgr1FR2Wbwo6i4ixCyLnep36Ozt
        s5q1zpgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxs29-0001G7-29; Tue, 21 Jul 2020 13:10:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4632A301AC6;
        Tue, 21 Jul 2020 15:10:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3363920FEE06D; Tue, 21 Jul 2020 15:10:11 +0200 (CEST)
Date:   Tue, 21 Jul 2020 15:10:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 11/14] perf/x86/intel: Disable sample-read the slots
 and metrics events
Message-ID: <20200721131011.GY10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-12-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-12-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:51AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Users fail to sample-read the slots and metrics events, e.g.,
> perf record -e '{slots, topdown-retiring}:S'.
> 
> When reading the metrics event, the fixed counter 3 (slots) has to be
> reset, which impacts the sampling of the slots event.
> 
> Add a specific validate_group() support to reject the case and error out
> for Ice Lake.
> 
> An alternative fix may unconditionally disable slots sampling, but it's
> not a decent fix. Users may want to only sample the slot events
> without the topdown metrics events.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

I'm confused by this; it doesn't make sense.

Should not patch 7 have something like the below instead?

Also, I think there is a bug when we create a group like this and then
kill the leader, in that case the core code will 'promote' the sibling
metric events to their own individual events, see perf_group_detach().

We need additional code to move those events into unrecoverable ERROR
state. A new group_caps flag could indicate this promotion isn't
allowed.

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3441,8 +3441,22 @@ static int intel_pmu_hw_config(struct pe
 	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
 	 */
 	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
-		if (is_metric_event(event) && is_sampling_event(event))
-			return -EINVAL;
+
+		if (is_metric_event(event)) {
+			struct perf_event *leader = event->group_leader;
+
+			if (is_sampling_event(event))
+				return -EINVAL;
+
+			if (leader == event)
+				return -EINVAL;
+
+			if (!is_slots_event(leader))
+				return -EINVAL;
+
+			if (is_sampling_event(leader))
+				return -EINVAL;
+		}
 
 		if (!is_sampling_event(event)) {
 			if (event->attr.config1 != 0)
