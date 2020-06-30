Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C177206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qd3qNcBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbgF3Qn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733117AbgF3Qn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vsk0mxwJOaXt9uCahr9TNdYqbSQlm97pZd45zIWHEk4=; b=qd3qNcBcxEqYNYgoRnSH7hTBEc
        gYI0fVzAbNRpEPUhanWf0EyL60M0YKgvTOBuJ8Jny5YsDrwVuvUBjS3zOygzJf7mjidgjF5QqJYxY
        phhvwY5tZDJg08B2FMOx+mbjg/BgTeopjCnFgoQCitn7tTJXHhgR321KJt5Au/gaOXuVWMQfhkLzO
        tcILF8yWfVCzTJUhxKY8sIchPQi7LB54I+pg2NhiNx+Cf8I+N75VcKsIo81mUSoj5bgb2FE5C4TLz
        2Q5Fyuyw0CjWpK+YhS8jYLxHQdYEDP039VTIMboNA0bMmCpTl6acWRnqRoqivX+svx5I92wZ5cSyM
        zyil8cXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqJL0-0001us-Js; Tue, 30 Jun 2020 16:42:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 055C130015A;
        Tue, 30 Jun 2020 18:42:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5C9920CF3986; Tue, 30 Jun 2020 18:42:25 +0200 (CEST)
Date:   Tue, 30 Jun 2020 18:42:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 14/23] perf/x86/intel/lbr: Support Architectural LBR
Message-ID: <20200630164225.GZ4817@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-15-git-send-email-kan.liang@linux.intel.com>
 <20200630154954.GU4781@hirez.programming.kicks-ass.net>
 <c597c040-57d5-ca9a-9acf-3dfc2debcf0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c597c040-57d5-ca9a-9acf-3dfc2debcf0e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:17:57PM -0400, Liang, Kan wrote:

> > > +static inline bool is_lbr_call_stack_bit_set(u64 config)
> > > +{
> > > +	if (x86_pmu.arch_lbr)
> > > +		return !!(config & ARCH_LBR_CALL_STACK);
> > > +
> > > +	return !!(config & LBR_CALL_STACK);
> > > +}

> > > +	x86_pmu.arch_lbr = true;

> > How about we make this here clear FEATURE_ARCH_LBR if it fails and then
> > do away with x86_pmu.arch_lbr and use
> > static_cpu_has(X86_FEATURE_ARCH_LBR) a lot more?
> 
> Yes, it's doable. So we can save a bit for arch_lbr in structure x86_pmu.

Mostly it's about getting rid of a load-test-branch.

> I will clear the FEATURE_ARCH_LBR via clear_cpu_cap(&boot_cpu_data,
> X86_FEATURE_ARCH_LBR);, if the check fails.
> I will replace x86_pmu.arch_lbr with static_cpu_has(X86_FEATURE_ARCH_LBR)
> everywhere.

Thanks!
