Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92371C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6032C20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es48Y6nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:11:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39940 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:11:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so2068815pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XnRL/6GCJnnLqnsq4zYt0l8kyVXrVP3xw1YFsqQnEx4=;
        b=Es48Y6nx1HIXVE1wzsyfQo33Kx1crK2xDdWk+ZULrQ0st3KadIGmT4/fB0b1CPvL2N
         5cRSgayMUW2fCiLQUmT/VYkYpllxPjd75L9CxY8uMSZ6biMIa/KqxIK8OY/osn1KKoGl
         TMsk5V1eL/zvu8n/0t6KvbPfxaJU9yFupnFyDotUGUyruJes9Wyis3RoZn4g1CTIjhtq
         t5ayCIlA3No6HgQxprrWldDVdLubes9dWrFuQ932SILEjR2l7+OBBfN3B0ZiW/h4/eLH
         sNWr71yNhL6ACs1m9+nTo/a3f51M9yDbdnx4UTXw/n1O7vIBDUfg9RVe/v77lfkR5Zll
         EeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnRL/6GCJnnLqnsq4zYt0l8kyVXrVP3xw1YFsqQnEx4=;
        b=kRVsQFL/DBUBloykDmozFtQs6NgE2k9grDHFsYvU1Ry6yGh3IwVL+hnTu/ZW3AdBHD
         MdxO+zXI1V8PsMSTJExWnHoIDnO18/XbXvkBmc9Q9Cu9QVYPplTxTWU+j76rj5fSxrIx
         ZUWP7tK9dxsNJ0lCO7rmO5verRx+oCKHeYpK+n+0OoEXr6430Wt6gTq2maA4sxu48LgL
         Doo0Yjz31rb7DXtaJ9Wt2YEZxrQne5QoGDqMK8jGM3FTRZeHk2EmhLyBkGgCEApX5fnw
         6CypLTOfeqZybebbj5gvoJSAGYbWIAIQTr+bE/8ffR9sZWhjUkm/UDtPR5RkU9/L6lim
         L1OQ==
X-Gm-Message-State: APjAAAX+3clbmtgwoHg86TFDL9dNGK2PlzB2kyYcAV+HdA981PxBPs0U
        uZt7Lt6LXvmeJnoaSzg7OjA=
X-Google-Smtp-Source: APXvYqzfz/PE2mNdtJw+e11/Z3yxDbjoO6rLO+S8IVtkypnf1/CSYFZ6seYri1fPVJTKNtoS2bbH3g==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr28523894plt.10.1581581513257;
        Thu, 13 Feb 2020 00:11:53 -0800 (PST)
Received: from workstation-portable ([103.211.17.23])
        by smtp.gmail.com with ESMTPSA id o16sm1681844pgl.58.2020.02.13.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 00:11:52 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:41:39 +0530
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
Subject: Re: [PATCH 3/3] auditsc: Do not use RCU primitive to read from cred
 pointer
Message-ID: <20200213081139.GB26550@workstation-portable>
References: <20200207180504.4200-1-frextrite@gmail.com>
 <20200207180504.4200-3-frextrite@gmail.com>
 <CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:19:04AM -0500, Paul Moore wrote:
> On Fri, Feb 7, 2020 at 1:08 PM Amol Grover <frextrite@gmail.com> wrote:
> >
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
> Considering the other changes in this patchset this change seems
> reasonable to me.  I'm assuming you were intending this patchset to go
> in via some tree other than audit?
> 

Yes, that's correct. Thank you for the ack!

> Acked-by: Paul Moore <paul@paul-moore.com>
> 
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
> >
> 
> 
> -- 
> paul moore
> www.paul-moore.com
