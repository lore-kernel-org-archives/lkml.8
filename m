Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF88C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D8720656
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pav7lQzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGXNyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGXNyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:54:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B8eRNxs9htmGJHGObFBZh5ZETBX8Pkz8XXY1/7/EoIw=; b=Pav7lQzprIg8yZ9L799/Y4KMa3
        6iNLrGbH977obkzOva0ADwPFK5cJuComOE/l+sGysGynFSTHhitCXoIuaDya4YNLGQHne/0wK7s3R
        air6SWLRzIa630nyc5x0thZ80Oe3CK/xNQqwyeqMKdaoNpMEXSbgYX4t8hTl++4eQZAtniSf5ASYw
        kzcJW3XDkaJLoWRX/eX/4Ut/m2MhYZoVeGZ9EQasijOVEytC6GUJtjM19acclHhJEqlbdXD4xZZSI
        om/5DITubutoKVYkjDKiHoCKUcSxR7MS1UXdC4ed25cUBiMoDRPaEbrZfm2EkXuDBMvQvm2EummJr
        CYsryBMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyy9N-0002GD-4w; Fri, 24 Jul 2020 13:54:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 442F33060EF;
        Fri, 24 Jul 2020 15:54:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D7A9236F1EA4; Fri, 24 Jul 2020 15:54:12 +0200 (CEST)
Date:   Fri, 24 Jul 2020 15:54:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724135412.GA10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:43:44AM -0400, Liang, Kan wrote:
> 
> 
> On 7/24/2020 7:46 AM, peterz@infradead.org wrote:
> > On Fri, Jul 24, 2020 at 12:55:43PM +0200, peterz@infradead.org wrote:
> > > > +	event_sched_out(event, cpuctx, ctx);
> > > > +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> > > > +}
> > > 
> > > Ah, so the problem here is that ERROR is actually recoverable using
> > > IOC_ENABLE. We don't want that either. Let me try and figure out of EXIT
> > > would work.
> > 
> > EXIT is difficult too.. Also, that COEXIST thing hurt my brian, can't we
> > do a simpler SIBLING thing that simply requires the event to be a group
> > sibling?
> > 
> > The consequence is that SLOTS must be the leader, is that really a
> > problem? You keep providing the {cycles, slots, metric-things} example,
> > but afaict {slots, metric-thing, cycles} should work just fine too.
> > PERF_SAMPLE_READ with PERF_FORMAT_GROUP doesn't need to the the leader.
> 
> I'm not sure I get your point.
> For the PERF_SAMPLE_READ with PERF_FORMAT_GROUP case, other events can be
> the leader, e.g., {cycles, slots, metric-things}:S.
> In this case, the SLOTS event is not a leader. I don't think we can assume
> that the SLOTS event must be the leader.

You can have a sibling event with SAMPLE_READ and FORMAT_GROUP just
fine. The sampling event doesn't need to be the leader.

