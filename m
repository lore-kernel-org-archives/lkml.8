Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA113C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC73206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="leGPhWIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgGUTUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgGUTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:20:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VhiQA6qev8PWeov/hSb1BErF1Q8azhYHkTiZfTrt8pE=; b=leGPhWIGaMSDBw2JNEVNvsOkGe
        nB4QK89Tr1IHLRgdVJ0wqikAmCEA5yXVgWKMmx8I0vK9X24cnML/gjmaXgtgNUQw9384WjA+4Or4h
        L4QMRYGhbMOr7Py2ejR+ezbA2lavO5T9rTwQercFCsNThT42ZvqWOjB4cTgpvcd+IWrwUwmRVIzSp
        4KDxwcAXQdml67PpXqT1S9QFE0qf8GT102f9l41tcsqiHzCOrdJNMkY63yeU9YE+XPElWceyPm8P5
        gYP/DbdqUSzpGDw81M8Me7V0l5Ff1Re5WvepqvidwOceJOyaArpUSrzapEY/V0CArMQAwXZKCmF7V
        Hhbq9C3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxxo3-0008Ve-02; Tue, 21 Jul 2020 19:20:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A385304D28;
        Tue, 21 Jul 2020 21:20:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76F4C20140AC3; Tue, 21 Jul 2020 21:20:02 +0200 (CEST)
Date:   Tue, 21 Jul 2020 21:20:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
Message-ID: <20200721192002.GI10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
 <20200721124042.GX10769@hirez.programming.kicks-ass.net>
 <20200721173859.GG1180481@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721173859.GG1180481@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:38:59AM -0700, Andi Kleen wrote:
> > Also, that for_each_set_bit() loop, trying to find the events to
> > update...
> > 
> > Can't we, instead, make the SLOTS update advance 5 running counters in
> > cpuc and feed the events off of that?
> 
> The original patches implemented this through a perf transaction and a
> cache.  I think what you're suggesting is similar to the old cache.

I can't remember :-) Anyway, the TXN_READ thing Kan pointed out should
work fine, I just missed it when reading through the code.
