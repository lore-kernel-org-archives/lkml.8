Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF772065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lhpXQU0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEOKns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgEOKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:43:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bM9kPsQD3QhczF+TG8quv1SXMYXI3f/2x7Gd8UUdmys=; b=lhpXQU0w3FI+AiS3XlETYitOkP
        X1O+Ey1QRYqIAByVDYnrB3LBH6W8IRoqevhVjNCFZAeiKavigV5Y0OfqXQ+hlCAYNjSk9ZoKNrWj6
        PAukiRCmnWRmAYeUxgmzFqVYYA1M2nAp2zwegp71V8bU3uEv+2q6HQw2CktEn161QzSpWhyrlb1pM
        kw4Bhekc1WCD/7YFaOGqJZvkpKoqh91v1NU66dSgY0/9gNpgbfRr/YtCYbVdJICjr2fFt7Baapd/T
        NaUvk8JiUVnxjMCtsaRo8T2FA2RE3oW07Okdu8YnVwJa1/XIX+D56Kf4Tc1oCv3JnybWrJbWegHkN
        woekvOGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZXoD-00057h-O1; Fri, 15 May 2020 10:43:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FF35300455;
        Fri, 15 May 2020 12:43:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5C620267E65; Fri, 15 May 2020 12:43:14 +0200 (CEST)
Date:   Fri, 15 May 2020 12:43:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200515104314.GI3001@hirez.programming.kicks-ass.net>
References: <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
 <CANaguZD_ZknCrnUA8TYs4rc0TLJZ9J2_FcWmW5cxEMWDTdL6hg@mail.gmail.com>
 <20200515103844.GG2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515103844.GG2978@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:38:44PM +0200, Peter Zijlstra wrote:
>   less := !((s64)(s_a - s_b) <= 0)
> 
>   (v_a - S_a) - (v_b - S_b) == v_a - v_b - S_a + S_b
>                             == v_a - (v_b - S_a + S_b)
> 

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -469,7 +469,7 @@ bool cfs_prio_less(struct task_struct *a
>  {
>  	struct sched_entity *se_a = &a->se, *se_b = &b->se;
>  	struct cfs_rq *cfs_rq_a, *cfa_rq_b;
> -	u64 vruntime_a, vruntime_b;
> +	u64 s_a, s_b, S_a, S_b;
>  
>  	while (!is_same_tg(se_a, se_b)) {
>  		int se_a_depth = se_a->depth;
> @@ -484,10 +484,16 @@ bool cfs_prio_less(struct task_struct *a
>  	cfs_rq_a = cfs_rq_of(se_a);
>  	cfs_rq_b = cfs_rq_of(se_b);
>  
> -	vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
> -	vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
> +	S_a = cfs_rq_a->core_vruntime;
> +	S_b = cfs_rq_b->core_vruntime;
>  
> -	return !((s64)(vruntime_a - vruntime_b) <= 0);
> +	if (cfs_rq_a == cfs_rq_b)
> +		S_a = S_b = cfs_rq_a->min_vruntime;
> +
> +	s_a = se_a->vruntime - S_a;
> +	s_b = se_b->vruntime - S_b;
> +
> +	return !((s64)(s_a - s_b) <= 0);
>  }

Clearly I'm not awake yet; 's/s_/l_/g', 's/v_/s_/g', IOW:

  l_a = s_a - S_a


