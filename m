Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5C22082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eq+onc1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAQI63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:58:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgAQI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rx5v2zBgDx9r1ifE/DecK6ZOBQ6X56FRuYEERu+808Y=; b=eq+onc1I7lw0NkVR3eXJlT6sr
        mHrpp9Rzwt0O57KrrhR+D5FBXhyOm5j/4DLE3BefcYN9pKCOuYqC/kW6BBMdLtWL0rJkzYqvAum86
        +BOyTW8qlQ0ooooWCqsNVtbsPGLFyCMCygLlaR/ldECoRV8sPYXVuE5sfV/T+cfj+IRBpyOqc9euC
        LjOrSgg+l3xfnp2sMcuayCvthHQjXCR43Fn2UINePy+ybaOctuoBAzxgS7P+u+/EGv6oy0E1uAghd
        m8aaIoaj15h/MOZyiAYbO93jxDEVhBdFBN4it0UxchiqJr200HkqD9le0wjyphzLjmoocJOM1aOfO
        IzY1pikZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNSU-0004NE-5m; Fri, 17 Jan 2020 08:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C598304A59;
        Fri, 17 Jan 2020 09:56:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 821FE20AFB27D; Fri, 17 Jan 2020 09:58:23 +0100 (CET)
Date:   Fri, 17 Jan 2020 09:58:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix inaccurate period in context
 switch for auto-reload
Message-ID: <20200117085823.GV2827@hirez.programming.kicks-ass.net>
References: <20200116183154.20880-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116183154.20880-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:31:54AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf doesn't take the left period into account when auto-reload is
> enabled with fixed period sampling mode in context switch.
> Here is the ftrace when recording PEBS event with fixed period.
> 
>     #perf record -e cycles:p -c 2000000 -- ./triad_loop
> 
>       //Task is scheduled out
>       triad_loop-17222 [000] d... 861765.878032: write_msr:
> MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0  //Disable global counter
>       triad_loop-17222 [000] d... 861765.878033: write_msr:
> MSR_IA32_PEBS_ENABLE(3f1), value 0       //Disable PEBS
>       triad_loop-17222 [000] d... 861765.878033: write_msr:
> MSR_P6_EVNTSEL0(186), value 40003003c    //Disable the counter
>       triad_loop-17222 [000] d... 861765.878033: rdpmc: 0, value
> fffffff82840                             //Read value of the counter
>       triad_loop-17222 [000] d... 861765.878034: write_msr:
> MSR_CORE_PERF_GLOBAL_CTRL(38f), value 1000f000000ff  //Re-enable global
> counter

This is unreadable garbage, please don't wrap trace output.
