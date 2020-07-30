Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E6FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D040920842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5ullnHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgG3M62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgG3M62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:58:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+E0IcQz2G17EYng01IxD+dd16zcpwNuYQtVnBKM4B4=; b=V5ullnHIkfDGk5lRYi5of8CoJL
        X4kITcl5iQD4tSz05UhS4F1DU2HAVZDgiGnnWPmCSJXl6jlHXq6jbVnmwN/RM3lYBMV8phn7kKCSJ
        MpDnZi/FkwVT6Zk9B6fjVNaheSiWDE/ME1Qxq5AFXdR6EavN+ypcxgxJ69sz4w583CNC//sRo5wwb
        WrQh/dQSz2vuNsEz9r7aQyR2UK+7VdoYiPYAz87jMpZGYChleI0otetrrXTMBl7sWYWa0O60p/lLG
        cTKmLgreMGDqt3hKpdWfVAIH60BX8hGX8IVuW5naAhcwPbbX92Ly+VVy1AMADUY1f7qpo/hA/Qv9J
        fYXgrn2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k188a-0005u2-9G; Thu, 30 Jul 2020 12:58:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A33830411F;
        Thu, 30 Jul 2020 14:58:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7271203DB3CC; Thu, 30 Jul 2020 14:58:17 +0200 (CEST)
Date:   Thu, 30 Jul 2020 14:58:17 +0200
From:   peterz@infradead.org
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf/x86: Reset the counter to prevent the leak for a
 RDPMC task
Message-ID: <20200730125817.GL2655@hirez.programming.kicks-ass.net>
References: <20200730123815.18518-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730123815.18518-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:38:15AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The counter value of a perf task may leak to another RDPMC task.

Sure, but nowhere did you explain why that is a problem.

> The RDPMC instruction is only available for the X86 platform. Only apply
> the fix for the X86 platform.

ARM64 can also do it, although I'm not sure what the current state of
things is here.

> After applying the patch,
> 
>     $ taskset -c 0 ./rdpmc_read_all_counters
>     index 0x0 value 0x0
>     index 0x1 value 0x0
>     index 0x2 value 0x0
>     index 0x3 value 0x0
> 
>     index 0x0 value 0x0
>     index 0x1 value 0x0
>     index 0x2 value 0x0
>     index 0x3 value 0x0

You forgot about:

 - telling us why it's a problem,
 - telling us how badly it affects performance.

I would feel much better if we only did this on context switches to
tasks that have RDPMC enabled.

So on del() mark the counter dirty (if we don't already have state that
implies this), but don't WRMSR. And then on
__perf_event_task_sched_in(), _after_ programming the new tasks'
counters, check for inactive dirty counters and wipe those -- IFF RDPMC
is on for that task.

