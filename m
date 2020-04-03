Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1246C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA3D20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7h63Qkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390082AbgDCH4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:56:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:56:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id g20so3131589pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGFgJcnAZcYkOmTi2e6KUvl6de/EYQat/43QjCkuwX0=;
        b=Z7h63QkcMcJIMchjnZ6OGIbR7pN+UWcQwA7SLkySnzrKirDCo6HDYjKLFj5gWEAnZ7
         eNje8dyr5R8eU5fzk7yuvLwNKSfGuGmgXQcn5C74h+HP+PIlnunCyS5JlB1IpbAx2a2Z
         v+chsSP0JlFTG+TaEXCQhDNpOVcTHhJoPHwmmH2vcEtEF28W1QbcRpP6gXtOd1pxvvnC
         ei8R2TzjGijsRQB5iQHMXm9BaoqncW9navKH+Ca3GTgo1Wvp3wLJI82uQAJcZbxoDTWh
         o7f/VVcH8H1KrIuYuqLCXRUTmPFweG5l1KHN8uub4FEZoHXWgjoHr4s/zLTDj5fmmIHK
         56Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGFgJcnAZcYkOmTi2e6KUvl6de/EYQat/43QjCkuwX0=;
        b=ssKr4BIZWJ8l3fFYRilsRdAqLX4bMZHNmRU+mXvRdxIPFyf7sotsg0UY720lEv4Swj
         QBc8imjfg3m94VizAf3B+l/wtvFX7tBeOPo2gPkdEhsw0dTvl3Y2G2u3sDAHEBLFONbh
         IlZz2fr1usGTE5fYPXFzfU/FCmdYH9QxArSnb8DEBf7vQy7BhrHepWNxKJmMTA9YzjXr
         zs/IYPcLsmfyQu0u4EQtDOMlIjyYoauYvwaqkF3cAZAzZereLSEvCFmrDOX5XL6jD3Ys
         jPHplhYf8W9xGfMGW/SYf+zXQ7N3rAhKYSxjkWTgM1j7C6uG5E3BvWviKEG7Osc96IGc
         kL2A==
X-Gm-Message-State: AGi0Puadmr6L6qJu1Cr/Xt3t7FxHS661VtuE+QedPEbQPPL1Fqpoopwe
        yqiG6mld1tIQzBM9RkP07Cc=
X-Google-Smtp-Source: APiQypKtNPH46VRnJiamU928TrLfF1ef1udk+bsqM/kxdW3Cx6y1GHNcPLh23zVq5txnbater8/vkQ==
X-Received: by 2002:aa7:999e:: with SMTP id k30mr7018349pfh.235.1585900582356;
        Fri, 03 Apr 2020 00:56:22 -0700 (PDT)
Received: from workstation-portable ([103.87.56.98])
        by smtp.gmail.com with ESMTPSA id g75sm5146054pje.37.2020.04.03.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:56:21 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:26:13 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3 RESEND] auditsc: Do not use RCU primitive to read
 from cred pointer
Message-ID: <20200403075613.GA2788@workstation-portable>
References: <20200402055640.6677-1-frextrite@gmail.com>
 <20200402055640.6677-3-frextrite@gmail.com>
 <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:56:36AM -0400, Paul Moore wrote:
> On Thu, Apr 2, 2020 at 1:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > task_struct::cred is only used task-synchronously and does
> > not require any RCU locks, hence, rcu_dereference_check is
> > not required to read from it.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> >  kernel/auditsc.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> This is the exact same patch I ACK'd back in February, yes?
> 
> https://lore.kernel.org/linux-audit/CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com
> 

Hi Paul,

That's correct. I've resend the series out of the fear that the first 2
patches might've gotten lost as it's been almost a month since I last
sent them. Could you please ack this again, and if you don't mind could
you please go through the other 2 patches and ack them aswell?

Thanks
Amol

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 4effe01ebbe2..d3510513cdd1 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -430,24 +430,19 @@ static int audit_field_compare(struct task_struct *tsk,
> >  /* Determine if any context name data matches a rule's watch data */
> >  /* Compare a task_struct with an audit_rule.  Return 1 on match, 0
> >   * otherwise.
> > - *
> > - * If task_creation is true, this is an explicit indication that we are
> > - * filtering a task rule at task creation time.  This and tsk == current are
> > - * the only situations where tsk->cred may be accessed without an rcu read lock.
> >   */
> >  static int audit_filter_rules(struct task_struct *tsk,
> >                               struct audit_krule *rule,
> >                               struct audit_context *ctx,
> >                               struct audit_names *name,
> > -                             enum audit_state *state,
> > -                             bool task_creation)
> > +                             enum audit_state *state)
> >  {
> >         const struct cred *cred;
> >         int i, need_sid = 1;
> >         u32 sid;
> >         unsigned int sessionid;
> >
> > -       cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> > +       cred = tsk->cred;
> >
> >         for (i = 0; i < rule->field_count; i++) {
> >                 struct audit_field *f = &rule->fields[i];
> > @@ -745,7 +740,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
> >         rcu_read_lock();
> >         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
> >                 if (audit_filter_rules(tsk, &e->rule, NULL, NULL,
> > -                                      &state, true)) {
> > +                                      &state)) {
> >                         if (state == AUDIT_RECORD_CONTEXT)
> >                                 *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
> >                         rcu_read_unlock();
> > @@ -791,7 +786,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
> >         list_for_each_entry_rcu(e, list, list) {
> >                 if (audit_in_mask(&e->rule, ctx->major) &&
> >                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
> > -                                      &state, false)) {
> > +                                      &state)) {
> >                         rcu_read_unlock();
> >                         ctx->current_state = state;
> >                         return state;
> > @@ -815,7 +810,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
> >
> >         list_for_each_entry_rcu(e, list, list) {
> >                 if (audit_in_mask(&e->rule, ctx->major) &&
> > -                   audit_filter_rules(tsk, &e->rule, ctx, n, &state, false)) {
> > +                   audit_filter_rules(tsk, &e->rule, ctx, n, &state)) {
> >                         ctx->current_state = state;
> >                         return 1;
> >                 }
> > --
> > 2.24.1
> 
> -- 
> paul moore
> www.paul-moore.com
