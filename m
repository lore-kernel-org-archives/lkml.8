Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB607C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62E22076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fKNpbLbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439080AbgDOVZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438998AbgDOVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:24:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:24:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so1345003otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxU2EAet1tn2ZKgYk7KLjPbGkAJNTRyOlp80JE9Vobo=;
        b=fKNpbLbnplbjAmd7tX3Tt7+9GboeLayjSU2crm8qh0/T2uz6k2lAXU1z4cPNJWyrOz
         k/DHv2zmyf2oX1lpjweTMuVdNaUuYq1hDmzXyZs8x6BvxwuO/3lRnGYMzgTIEmBWTFpr
         3GQOr5ICDJ49h077iX6ZiqNJ1Ii8wS1woQ96k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxU2EAet1tn2ZKgYk7KLjPbGkAJNTRyOlp80JE9Vobo=;
        b=livlAn0YHZx+h7pOnrZ6wjHNDZ08mTfe1cGedhe0IkVC+E66wwLptVUUPb5PjYxFKk
         4INTXY8YF6iEGlCKJFCpbZbE+GXDukdTH+zS+bAyWSj8AA5Avh/cSQnLQiiwXUk+gvl0
         txLbGcvweI0xoq4Qvkl1h3HeElSU8/8ccgqUyXkKnpAwtBJhYWiLAdU0NuuADDn7muyN
         aSiG4ccHisX5snYzv0mS9xY5ZByLGR9H0oUbEbM/BDh2EeeLN0ajjQiCz14zHCsTVUIM
         Ni4mUtLw+f3a08Pryr/YVApt4KiFuAFMeCrEBYkIseHsHYYsLG3ZDsiS/95zUtNyRQ5C
         a++Q==
X-Gm-Message-State: AGi0PuZYt45sTkzaMbqaQEAwTyt+e+0KB5cmhXSUy3nj2J62R4FhhKXr
        CUvLFF5x2Y50HQ7SAt2x2iidkRjMreYuUc8sH5AdUA==
X-Google-Smtp-Source: APiQypI0v5fyAQ0m+BqzAwSG7gMuAqEy1A/2DGkdaIQolUPjqQS4D9DpSp+2Mk8ETKhrmjRQ/rZYGhenkUqKl5F8m0U=
X-Received: by 2002:a9d:6252:: with SMTP id i18mr2486405otk.33.1586985881637;
 Wed, 15 Apr 2020 14:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net> <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
In-Reply-To: <20200415040741.GA169001@ziqianlu-desktop.localdomain>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Wed, 15 Apr 2020 17:24:30 -0400
Message-ID: <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/13] sched/fair: core wide vruntime comparison
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You forgot the time complexity analysis.
> >
> > This is a mistake and the adjust should be needed only once when core
> > scheduling is initially enabled. It is an initialization thing and there
> > is no reason to do it in every invocation of coresched_adjust_vruntime().
>
> Correction...
> I meant there is no need to call coresched_adjust_vruntime() in every
> invocation of update_core_cfs_rq_min_vruntime().

Due to the checks in place, update_core_cfs_rq_min_vruntime should
not be calling coresched_adjust_vruntime more than once between a
coresched enable/disable. Once the min_vruntime is adjusted, we depend
only on rq->core and the other sibling's min_vruntime will not grow
until coresched disable.

I did some micro benchmark tests today to verify this and observed
that coresched_adjust_vruntime called at most once between a coresched
enable/disable.

Thanks,
Vineeth
