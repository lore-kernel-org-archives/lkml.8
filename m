Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BB4206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVRmpMr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgGXO7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGXO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:59:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ItMqL340ouNzbzuW1GpW8ukZAZHgejtfjSWU5ZtegA=; b=uVRmpMr5ycKZkUO6F4QTP/NMTI
        3HrE2OI77CTcStV5CVVrS1956k/BQIzdmwF6N/7sw0eSWcxysBjbdE2CIqBLbW1aJ9WYawc3HSPGS
        HutLQiDFDGccMgUw02T4O4hl3eqRpCa3c3CuMGls51WdLHM8Dsiueb/0No86A6erdJ4igbFz0UQ1H
        6u8aJue8kIgWP8E0AFo0EdQkm/tdyKMwPai5If3f0PGlbFt0hmhq4LwFlyetI3lFWl8ac2BU5sWBL
        KrOHfU0TqCl78XkgCT7PRm+rYBH4cHYE6lP7Yt5+ytDtRH8IZuDjcttx/6OCwmoze164Ap3nwQcub
        3fuJvyMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyzAd-0005vQ-6j; Fri, 24 Jul 2020 14:59:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA1593060F3;
        Fri, 24 Jul 2020 16:59:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EC62236F1EB3; Fri, 24 Jul 2020 16:59:34 +0200 (CEST)
Date:   Fri, 24 Jul 2020 16:59:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724145934.GD10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
 <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
 <20200724143258.GB10769@hirez.programming.kicks-ass.net>
 <20200724144632.GE1180481@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724144632.GE1180481@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:46:32AM -0700, Andi Kleen wrote:
> > Something that seems to 'work' is:
> > '{cycles,cpu/instructions,period=50000/}', so maybe you can make the
> > group modifier :S use any sampling event if there is one, and otherwise
> > designate the leader.
> > 
> > Then you can write things like:
> > 
> >   '{slots, metric1, metric2, cpu/cycles,freq=50000/}:S'
> > 
> > and then since cycles is specified as a sampling event, it will use
> > that.
> 
> Okay possible, but it makes things more complicated
> for the user to understand and requires special documentation.
> Hopefully it's worth it the internal simplification.

You already require special documentation for this metrics stuff. We
already need to state that SLOTS cannot be a sampling event, so you
already need to pay attention to this anyway.

A shortcut could be a :s event modifier, then you can write:

 '{slots, metric1, metric2, cycles:s}:S'

and have the tool select the :s tagged one.
