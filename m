Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B643C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E120873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rB5+NwrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgBMRgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:36:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgBMRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E+YqIGqhXaGLiebcnUyrjQpIFvsGWbiVb9DTwDgNSSk=; b=rB5+NwrZK62P2emdnqHG7SkBgJ
        xLwI5SiXX29jCKmHgi11HW24ja88d8WfbzYNMtrSzUzV1bThxnzp6ejG56xRCrcymbPy4z+o+MjPk
        PAKu8bAbPmqeXYXtpiGZ6/kdfbG87J6eqUEGaZ44eNeAjTDi/wgTF2MLyN1TVvWvUkZkuWAwLebHM
        bDbbbvMwwEi+9DGzU2nNRlfGkN4dm4sEQ4QkOOY2xw7lKY3/VgjGfPXCo2bTgKsAtDzLoAIcjxOVw
        AQVLgQG++n3nEisrfPZriO+jQIkLQSkDvocoL9aiwkwaPjFbkIoqjWQQisPtwCPxXMu8CERVp14oO
        LPoCzH3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2IPE-0001bw-Rt; Thu, 13 Feb 2020 17:36:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A64130066E;
        Thu, 13 Feb 2020 18:34:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C8A220206D63; Thu, 13 Feb 2020 18:36:02 +0100 (CET)
Date:   Thu, 13 Feb 2020 18:36:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [RFC 3/4] sched/fair: replace runnable load average by runnable
 average
Message-ID: <20200213173602.GQ14897@hirez.programming.kicks-ass.net>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174651.10330-4-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:46:50PM +0100, Vincent Guittot wrote:
> @@ -367,6 +367,14 @@ struct util_est {
>   * For cfs_rq, it is the aggregated load_avg of all runnable and
>   * blocked sched_entities.
>   *
> + * [runnable_avg definition]
> + *
> + *   runnable_avg = runnable%

				 * SCHED_CAPACITY_SCALE

right, just like we have for util_avg.

> + *
> + * where runnable% is the time ratio that a sched_entity is runnable.
> + * For cfs_rq, it is the aggregated runnable_avg of all runnable and
> + * blocked sched_entities.

Which is a verbatim repeat of the runnable% definition for load_avg,
right? Perhaps re-arrange the text such that we only have a single
definition for each symbol?

> + *
>   * [util_avg definition]
>   *
>   *   util_avg = running% * SCHED_CAPACITY_SCALE

Can you please split this patch in two? First remove everything
runnable_load_avg, and then introduce runnable_avg.

I didn't quickly spot anything off, and you're right that runnable vs
util is an interesting signal.
