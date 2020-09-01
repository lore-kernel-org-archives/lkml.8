Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3706320866
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7zM3oww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgIAReP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIAReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:34:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93959C061244;
        Tue,  1 Sep 2020 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NBd4CEJHk/V22yHxxBJHba2nyRDDhviZtRbsdWXhk4A=; b=B7zM3owwuX4LFPWYxt7rYk5bEm
        X5NQPyaKB80Yr0Ew19FtJGUY6mYi9lfWPzapzYUgcBNIRCL0xmaNeYKbaNp8veQKup7ib9foMum8D
        2mx6W1DcGDU7dhn6GsLPMP0dflxs8QgP+z0fVKz34oSI36UkF/XTgeUNNHtziTe7OMTC0KY4xYljo
        +EpaYFaqr9N2A9y3+6cKYW4WXJ5YmTrP7psWIl0wQVELW6i7eJifDH/M7ZlQHfHrwG015fWco57wR
        u4V3YLwVjxgqcnjzNXQ9K3fMd7RTthIkhuopHMIXFAGZolE3kCJ162/8/uNvG7BoFUfKE5icc/ayV
        zGBqQh9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDAAY-0004qi-Bk; Tue, 01 Sep 2020 17:34:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32F86980D85; Tue,  1 Sep 2020 19:34:05 +0200 (CEST)
Date:   Tue, 1 Sep 2020 19:34:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Al Grant <al.grant@foss.arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200901173405.GI29142@worktop.programming.kicks-ass.net>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
 <20200901150630.GB1424523@kernel.org>
 <20200901151204.GE2674@hirez.programming.kicks-ass.net>
 <20200901155834.GC10147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901155834.GC10147@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:58:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 01, 2020 at 05:12:04PM +0200, peterz@infradead.org escreveu:
> > On Tue, Sep 01, 2020 at 12:06:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > > Also you mixed up tools/ with include/ things, the perf part of the
> > > kernel is maintained by Ingo, PeterZ.
> > 
> > Right, it helps if the right people are on Cc.
> > 
> > > Peter, the patch is the one below, I'll collect the
> > > tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
> > > please consider taking the kernel part.
> > 
> > Al, can you resend with the right people on Cc? Also see below.
> > 
> > > ---
> > > 
> > > From:   Al Grant <al.grant@foss.arm.com>
> > > Subject: [PATCH] perf: correct SNOOPX field offset
> > > Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
> > > Date:   Mon, 24 Aug 2020 10:28:34 +0100
> > > 
> > > perf_event.h has macros that define the field offsets in the
> > > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > > were both 37. These are distinct fields, and the bitfield layout
> > > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > > 
> > 
> > This needs a Fixes: tag.
> 
> He provided it in a later message, here it goes:
> 
>     Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")
> 
> Also Andi has provided this:
> 
>     Reviewed-by: Andi Kleen <ak@linux.intel.com>

Have him send a new and complete patch, we're not an editing service.
