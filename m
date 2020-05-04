Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0B8C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75D920663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CNZs7zCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgEDRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730039AbgEDRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:38:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E486C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:38:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s10so12040240iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0fsepn3Ehc6T1kax7xZI+IBiV7boArhydSrUBRKNVg=;
        b=CNZs7zCwd/vJ9hQOc34lDO6VUgH2PpUgVQUN8rT+NwMDc35FjNtyvo/XYEDy84Rk2x
         YnzW4b3oCh1s0bcp9wpuQ2BXiLyKrs7edd3JhXx/Yg7ZdMhSOt3xJM2iE7XXtZv5q6B0
         AZTuMNm1xu0GIBpE6+6BUnENc9K0k6bQQgg6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0fsepn3Ehc6T1kax7xZI+IBiV7boArhydSrUBRKNVg=;
        b=UdffyYPlxMhbr3+Z/CA9ppJQTJQ5lrBIfKeTLONzZGO8AG4Ba8HXXlBcKHkcNal/DA
         Le3wknkLPqSFGi+9nE5a3Po2EU+a9TyqeEssaU3pDQzfjVn93Y6eKf8sJMcvWkAgZjyY
         hv3k35c6ttdv2AHWDTIE7RBfkb8meY5g5BLmiYtz80Jaoxpr/ynJWSOU9Wp/CPT1r/ke
         tA///23bh7sq6q42lCexo6ejKeUVojI5CG5oOO2mOE14JSsq9aknjv8KBVvfo7O6/222
         gAGoSefioNZmfrjbPxwYBEXun7t+XYqu2v37D+ILPd/0dZnSQCnvrKoDIH2fNlnb2+Cw
         7unw==
X-Gm-Message-State: AGi0Pub3Znix300FZwvuWAtoaaICMDq1Og2LBvcaLIB63sGqPDHbQITK
        73eIrPwTbHOKEvmU6hDEqfEJRNqivznY0s/pFYlBpg==
X-Google-Smtp-Source: APiQypJaQpBu3P7krd8Dq+c9FZQ5zt5v/9tmm2nB8jbjYNGxidPoOSN3wE0BIbK9/dMcRgTGINAbDI1jjAN3LkE4/8c=
X-Received: by 2002:a92:3509:: with SMTP id c9mr17728934ila.262.1588613880520;
 Mon, 04 May 2020 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200504120505.89351-1-joel@joelfernandes.org> <20200504171532.GR2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200504171532.GR2869@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 4 May 2020 13:37:48 -0400
Message-ID: <CAEXW_YQNm9QMzLNay8TMnXoUsJgVhxOFEdvT3aLDLE+0zx2Mng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        kernel-team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
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
> >
> > v1->v2:
> > - Rebase on v5.6-rc6
> >
> > v2->v3:
> > - Rebase on rcu/dev with adjustments for tasks-RCU.
>
> Thank you!
>
> But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.
>
> Where should I be trying to apply it?
>

Hi Paul,
It is for the rcu/dev branch as mentioned in the cover letter subject
line. I thought it would reduce conflicts for you if I rebased on
that. There are conflicts with trace-RCU for example.

What do you suggest?

Thanks,

 - Joel
