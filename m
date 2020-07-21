Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE0C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5033F206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GiVqDkxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgGUTSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:18:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o9oymOdRtXGBWxhCuRCIUyVAr5ZVv5Qq2LLyDa4+QxA=; b=GiVqDkxP6Uc0PwgRFkbJanO9TX
        LHUfjIHSZ7nEBg/C+vhAMIZrworBNIQRb5do4Zx7aWPg+DH4lXB+Q5uXtcFhI9WvsEM5thl3GG2Yq
        GgMsG9JdTv5wFhWO7vfiCO3bzsznrgURte4gnUdYb1EQ3YcyXraT8PQaP2GBvWbB3tZSMEg+Su0fr
        vKti10E+rWIimxGOvMRdbNuV4Co82qm4vB9YmqS9N+kd+G7V4ObTD58ayCnR+tty8FkGP8WvEzgK9
        +hunYHcStEWms+HwxFFQMcLaTQQNNsCET/2CLSBG0n35faYXs2KRIqDBBWtke1snFCGqI5fezUXsd
        WIG7qYgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxxmJ-0000Xy-5U; Tue, 21 Jul 2020 19:18:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D3F9304D28;
        Tue, 21 Jul 2020 21:18:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2579B20140AC3; Tue, 21 Jul 2020 21:18:11 +0200 (CEST)
Date:   Tue, 21 Jul 2020 21:18:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 11/14] perf/x86/intel: Disable sample-read the slots
 and metrics events
Message-ID: <20200721191811.GH10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-12-kan.liang@linux.intel.com>
 <20200721131011.GY10769@hirez.programming.kicks-ass.net>
 <b24b9bd3-bbfb-98d4-4df3-c263e002dcf5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24b9bd3-bbfb-98d4-4df3-c263e002dcf5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:07:29PM -0400, Liang, Kan wrote:

> I'm trying to produce the bug mentioned above, but I'm not sure under what
> situation, the core code will 'promote' the sibling metric events?

Create an event group:

	fd = sys_perf_event_open();
	fd1 = sys_perf_event_open(.group_fd = fd);
	...

then kill the group leader:

	close(fd);

Then the sibling events: fdN, should get promoted. Ideally try and use
fd1 in a read or so after this.

> I tried the suggested code below. It works well for the sample-read case.
> Perf tool errors out as expected.

I'm not sure you can create that case with perf-tool, it's a bit of a
daft thing to do, so you'll have to write a custom program.
