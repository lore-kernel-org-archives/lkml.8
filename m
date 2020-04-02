Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7585C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587220784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X0A+Fzuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbgDBM4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:56:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36983 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgDBM4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:56:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id de14so3970719edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kqap/nho/VO53wl1Vvcx8z2BRfU3VDatECjPDe+uq9o=;
        b=X0A+Fzucb/KO5++vaKA82oslAdSJ02Ad2PGxG52ciH4zqaN2Ob8RUBW8nA0UWosKPZ
         PPtJYVvaYCzZ5n035ZACtzQCPpIAM9qZeZqSIl8mp35Gj5eCth7/M8I0LiPpNGrdtrIj
         WT+FKp3KqN4oIGomZ3sb5UiP4Nyaq3Ns7Qx+M5YfSJppFUzriaiMkqNr4qfxo/Bf/FXJ
         gLEwmfs8P6WzW5RbkM7GrzaPiESoKE5R54dzEzPQWQiC9knvJf2ICkuiTbLfmA8/S9hf
         dzKErLHxzxke8Crk1wmgJlTmvnkkz6Uu/ifKaB+UOJb9GU95F096QP35C8CzQ2Wda/Oi
         1oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kqap/nho/VO53wl1Vvcx8z2BRfU3VDatECjPDe+uq9o=;
        b=WruaZZm7Eur4u3hpOFXcrd2VB8otMPrDo0yaOfibfly7QS/9TJn3zQftSlU8aCKpmC
         YBVBEwTk5g1RGU1L48OoQLw+0DeETbG9UnVQbeO7eCY+WP5c0wY+qfDJqCSrjc1yNaF5
         6UFEuaPs445Uv7zxqs2FnEjQoAwvtWsGcwfM6H9BtEjm8mKfaVLb4uV4lsh4T+tNm+qJ
         FQrB+nx6V8I/85gePj4+qXUNjntu3YwoAeF8YuEGGMuwFADVsn3lm0ZUc/QMW50GEjXu
         eVUPZctSnA1ADQD10wEJ4Mvwm0tahyway2P014LR9m0HJyQ4nBv2zkhN7Q05RnmUc1q8
         iUGQ==
X-Gm-Message-State: AGi0PuaLdIhw/Py2ddasOmOsua8ylOpHHwfbsLBZL0t8jOkCkiluC1Qa
        ftT9WaXY2yKfwKEXaX987i0py+J2qhB8b+BYRtkZ
X-Google-Smtp-Source: APiQypLVYVm4b4T8DRqBziIjHudBd14857uA+siaIatX8UbnCBqo/2HtxpahLb9nbo8P4Et/bV6FLvts7uscuxu9uyA=
X-Received: by 2002:a17:906:583:: with SMTP id 3mr3007633ejn.308.1585832207648;
 Thu, 02 Apr 2020 05:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200402055640.6677-1-frextrite@gmail.com> <20200402055640.6677-3-frextrite@gmail.com>
In-Reply-To: <20200402055640.6677-3-frextrite@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Apr 2020 08:56:36 -0400
Message-ID: <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 RESEND] auditsc: Do not use RCU primitive to read from
 cred pointer
To:     Amol Grover <frextrite@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 1:57 AM Amol Grover <frextrite@gmail.com> wrote:
> task_struct::cred is only used task-synchronously and does
> not require any RCU locks, hence, rcu_dereference_check is
> not required to read from it.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/auditsc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

This is the exact same patch I ACK'd back in February, yes?

https://lore.kernel.org/linux-audit/CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4effe01ebbe2..d3510513cdd1 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -430,24 +430,19 @@ static int audit_field_compare(struct task_struct *tsk,
>  /* Determine if any context name data matches a rule's watch data */
>  /* Compare a task_struct with an audit_rule.  Return 1 on match, 0
>   * otherwise.
> - *
> - * If task_creation is true, this is an explicit indication that we are
> - * filtering a task rule at task creation time.  This and tsk == current are
> - * the only situations where tsk->cred may be accessed without an rcu read lock.
>   */
>  static int audit_filter_rules(struct task_struct *tsk,
>                               struct audit_krule *rule,
>                               struct audit_context *ctx,
>                               struct audit_names *name,
> -                             enum audit_state *state,
> -                             bool task_creation)
> +                             enum audit_state *state)
>  {
>         const struct cred *cred;
>         int i, need_sid = 1;
>         u32 sid;
>         unsigned int sessionid;
>
> -       cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> +       cred = tsk->cred;
>
>         for (i = 0; i < rule->field_count; i++) {
>                 struct audit_field *f = &rule->fields[i];
> @@ -745,7 +740,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
>         rcu_read_lock();
>         list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
>                 if (audit_filter_rules(tsk, &e->rule, NULL, NULL,
> -                                      &state, true)) {
> +                                      &state)) {
>                         if (state == AUDIT_RECORD_CONTEXT)
>                                 *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
>                         rcu_read_unlock();
> @@ -791,7 +786,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
>         list_for_each_entry_rcu(e, list, list) {
>                 if (audit_in_mask(&e->rule, ctx->major) &&
>                     audit_filter_rules(tsk, &e->rule, ctx, NULL,
> -                                      &state, false)) {
> +                                      &state)) {
>                         rcu_read_unlock();
>                         ctx->current_state = state;
>                         return state;
> @@ -815,7 +810,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
>
>         list_for_each_entry_rcu(e, list, list) {
>                 if (audit_in_mask(&e->rule, ctx->major) &&
> -                   audit_filter_rules(tsk, &e->rule, ctx, n, &state, false)) {
> +                   audit_filter_rules(tsk, &e->rule, ctx, n, &state)) {
>                         ctx->current_state = state;
>                         return 1;
>                 }
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
