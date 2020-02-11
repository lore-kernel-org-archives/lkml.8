Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7734C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC1A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aSuu2DmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgBKPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:19:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38949 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgBKPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:19:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so5078397edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16SLjLXO8g+qbOwDjgyf7x2FsF2pVisv4jB570F5ilM=;
        b=aSuu2DmLP5BGoZWIgkKNcdwUhKU6htHEo28BK6My4sj4kupO+Haz8DWn2OJVKhqIO/
         SdrQuM5vRc0nDFTBEL+8R8MUhNIUGFrMWJT/BEDG5aIFpN8ffqvbBheaJPJqYQzPbIYG
         n67kIIUgWE0UkPxGo1Awiw7KRWecWqPJuGG1buEU2AuosK3U9CpDBIQajtQSfeq9aOSu
         O+bf2+7XrxM/+AWzlli5bcNGowACJ3Jk3RXRtNM5KgjWB2CUwGTL5JHpswlckqjXNVUE
         HUkGmprWvNphy3WJ64vrFxZQIf+6daO1KpvE06jgb4Y9GqSJsS2Bc9ESCc4O6LTIvT3K
         bqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16SLjLXO8g+qbOwDjgyf7x2FsF2pVisv4jB570F5ilM=;
        b=TtlFNj8Df7SEr14RNMmBV96n6Z8IU0QMYRuq7NxD2dx0fezMuvJ5NOcZihUm+VTM4j
         o1Ne3YlwAmZ0lSC9C6r7IoysTk4LLuihErcKGV2z9Ad3HJS8mo8g5fsNRDozrW63KrMh
         rBCNO08h8Xi1fEtT6RBxcXQ4wGNCxB9asm/pbu/S18CE6sykfv+j0CctHfCqOshs2Dg5
         45bgXR7xacfM2+4rOnC3aQ9dBDVNxoTZM51NqEPqrYizppsxiOKGZph7LAbH5nyq+ycv
         fnPKE+Fdf2cdP+e2mRjCSm2mpB+xz7CiTvpXUup7fu/ongtUylf8TFnDmzqhFW/FX8sf
         fpgA==
X-Gm-Message-State: APjAAAX0Cv1p0WFNXeJIosxnTYSqFVzD/0uK82CrM6chbyOXGyzdK87a
        gBRcl9Ndu+9XPrcXEFT/HGhoWSfAJSLF3B0Ak0NO
X-Google-Smtp-Source: APXvYqzvp0A3Md5np85OTOmVafrLccWiHt/aia4W8UTcrgVN+vogKxSKhOx0HDUUmxQaBGGAeCjSoxcBxitiPjBXBS8=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr5926242edv.135.1581434355583;
 Tue, 11 Feb 2020 07:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20200207180504.4200-1-frextrite@gmail.com> <20200207180504.4200-3-frextrite@gmail.com>
In-Reply-To: <20200207180504.4200-3-frextrite@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 10:19:04 -0500
Message-ID: <CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] auditsc: Do not use RCU primitive to read from cred pointer
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

On Fri, Feb 7, 2020 at 1:08 PM Amol Grover <frextrite@gmail.com> wrote:
>
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

Considering the other changes in this patchset this change seems
reasonable to me.  I'm assuming you were intending this patchset to go
in via some tree other than audit?

Acked-by: Paul Moore <paul@paul-moore.com>

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
>


-- 
paul moore
www.paul-moore.com
