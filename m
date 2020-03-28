Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A5C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 23:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C992620716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 23:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DkvZAGnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgC1X45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:56:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42766 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1X45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:56:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id 139so5297173qkd.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q126VLRY+UYUSrmkccqPHR4aNBhpLWfnHaERaQZZBhY=;
        b=DkvZAGnLJujojh2FwBe85MPB0oPd0pN2tBx5bDa9wF6RcukHpfkTxndsOeNvB1ywpS
         8llx45XFfCgB9Bg4Ma+A+iWfat8arDQpXlyu6wsHoSwkcnK9dT/aY5TZhSRyXwtdKL5i
         829zsXWNd7IkMaUz+clKFGtfrhi62uQChc7eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q126VLRY+UYUSrmkccqPHR4aNBhpLWfnHaERaQZZBhY=;
        b=cnVGbHXXFgPQoQTR+iZSst9QY78NX5F/P5XZfuQyKldGuKUkYmUSCxm77fYx+tSqvz
         Bdgw+bR/nxdxVuy3KaU/8aNA+SMKc8RLLc7znyK0+5wjgxl8DH7+Ci+sn0SUvf8uPGAF
         LSko5q5fRcfI2p1txIKCvmTXRQC3D8tRGzKU+MoWE1jx+LV33QR3QxC0AEUgWm/L4tah
         pL4t8oTTpMEl76LkLfQmXSpLGG6etsUVskOWVD9GAVQvKobS+BfWaZdpjjEd81uhzvRT
         gK7cHSCDwX181QjbNw91ZHbzXO+OCSw4bIHzwzfq+Uy4ELwHT5VlhquOe9KhJfAqmHTE
         0JtA==
X-Gm-Message-State: ANhLgQ36XZYw1vjrd1GcNq2QFhgxoUCwFo62XSiVeiAKONTXKyPEbe1F
        JGFgGl7skUgVS98tg9WrDcHB7w==
X-Google-Smtp-Source: ADFU+vtbIuPoarJxnHd0SBKW5PTvPHbvXQFtcVVNHclf2vcqc/l/Gu8XwZOvUstdJG4dcAaW3huLcA==
X-Received: by 2002:a37:634d:: with SMTP id x74mr6046668qkb.254.1585439814210;
        Sat, 28 Mar 2020 16:56:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r3sm6987044qkd.3.2020.03.28.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 16:56:53 -0700 (PDT)
Date:   Sat, 28 Mar 2020 19:56:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v2 0/4] RCU dyntick nesting counter cleanups
Message-ID: <20200328235653.GA69048@google.com>
References: <20200328221703.48171-1-joel@joelfernandes.org>
 <20200328234306.GC19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328234306.GC19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 04:43:06PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 28, 2020 at 06:16:59PM -0400, Joel Fernandes (Google) wrote:
> > These patches clean up the usage of dynticks nesting counters simplifying the
> > code, while preserving the usecases.
> > 
> > It is a much needed simplification, makes the code less confusing, and prevents
> > future bugs such as those that arise from forgetting that the
> > dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> > common situations.
> > 
> > rcutorture testing with all TREE RCU configurations succeed with
> > CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> 
> Heh!  We now have a three-way collision between Thomas's and Peter's
> series, the RCU Tasks Trace series, and this series.  ;-)
> 
> Remind me once v5.7-rc1 comes out and let's see what fits where.

Ok, no problem, I will resend at 5.7-rc1 time then. I believe I did a lot of
the work to make the series catch up with the tip especially after the KCSAN
changes, so it should be relatively easy (hopefully) for me to rebase at -rc1.

thanks!

 - Joel



> > v1->v2:
> > - Rebase on v5.6-rc6
> > 
> > Joel Fernandes (Google) (4):
> > Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
> > ->dynticks counter")
> > rcu/tree: Add better tracing for dyntick-idle
> > rcu/tree: Clean up dynticks counter usage
> > rcu/tree: Remove dynticks_nmi_nesting counter
> > 
> > .../Data-Structures/Data-Structures.rst       |  31 +--
> > Documentation/RCU/stallwarn.txt               |   6 +-
> > include/linux/rcutiny.h                       |   3 -
> > include/trace/events/rcu.h                    |  29 +--
> > kernel/rcu/rcu.h                              |   4 -
> > kernel/rcu/tree.c                             | 188 +++++++-----------
> > kernel/rcu/tree.h                             |   4 +-
> > kernel/rcu/tree_stall.h                       |   4 +-
> > 8 files changed, 105 insertions(+), 164 deletions(-)
> > 
> > --
> > 2.26.0.rc2.310.g2932bb562d-goog
> > 
