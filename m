Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B5C4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDE21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sx4t934S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgBZQUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:20:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pLcMLY+l8Jn014Qw6oW/1gcX4+lXMwKFovCkSJaWe78=; b=sx4t934StzYnAVVNNCrqTLwGEm
        YBfgRrLQz3W8A1lHn+TV3zDVjWaw4chqU00r3OfTafA50YWMqhNCvN9tABO6ZKRR+2zIKGCz5IG4q
        P8fnPl/WEIHSu88kboKd/UIgbtCFCSwH0lqTUlgpzVK7C8JAms7ctFteU79TuQQcapOTPqEqGdX1H
        xn85Vd6KYb7mXNDQiEqJhmWx+sUjMoLXyZxDrHzoQor1PQDC16+OVMHHHJgwcFEvj+Zv0Np7UL5q1
        xOs0Q+vYa4KOl9Byl+9uQWbYYaGP40cdlEx/68yA+Z96i9NJRopWEb0vLfnoW7JUzq4s1xlZc/su8
        AgNh80AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zPU-00017f-TM; Wed, 26 Feb 2020 16:19:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FCC4305EFE;
        Wed, 26 Feb 2020 17:17:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BBA12B7418A0; Wed, 26 Feb 2020 17:19:41 +0100 (CET)
Date:   Wed, 26 Feb 2020 17:19:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, giuseppe.lettieri@unipi.it, toke@redhat.com,
        hawk@kernel.org, mingo@redhat.com, acme@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 1/2] kstats: kernel metric collector
Message-ID: <20200226161941.GZ18400@hirez.programming.kicks-ass.net>
References: <20200226134637.31670-1-lrizzo@google.com>
 <20200226134637.31670-2-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226134637.31670-2-lrizzo@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:46:36AM -0800, Luigi Rizzo wrote:
> kstats is a helper to accumulate in-kernel metrics (timestamps, sizes,
> etc.) and show distributions through debugfs.
> Set CONFIG_KSTATS=m or y to enable it.
> 
> Creating a metric takes one line of code (and one to destroy it):
> 
>   struct kstats *key = kstats_new("foo", 3 /* frac_bits */);
>   ...
>   kstats_delete(key);
> 
> The following line records a u64 sample:
> 
>   kstats_record(key, value);
> 
> kstats_record() is cheap (5ns hot cache, 250ns cold cache). Samples are
> accumulated in a per-cpu array with 2^frac_bits slots for each power
> of 2. Using frac_bits = 3 gives about 30 slots per decade.

So I think everybody + dog has written code like this, although I never
bothered with the log2 based buckets myself. Nor have I ever bothered
with doing a debugfs interface.

I find it very hard to convince myself something like this deserves to
live upstream, vs. remaining in the local debug/hack toolbox.

Tracing has an aggregator (histogram), you can dump the raw deltas, or
you can hack up a custom aggregator in a few lines, or you do BPF if
you're so inclined.

Why do we need this specific one?
