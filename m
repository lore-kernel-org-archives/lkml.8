Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1863E207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxXlzi+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHUP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgHUP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:29:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E76C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:29:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id n4so1005097vsl.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfNlVXRvcKj6Y0hPR3mdXqrOmf9uMfzMQoJ/2wwN28s=;
        b=TxXlzi+3Re0/Y9A0DJKuWYYfMbzRZqmxmjtsXj3fQuS4mqCgNSCPkMIQPvBngkmWlL
         l+2M8q+GXYbPRKVD+IckYVampaZtFXiHooayDG34TdBXVrx9JkAMywZrNoMj4nxurTbK
         hIEm/0LDDdzWPZXsTtvAUAku7YOeaXpfHpi8sX0O6l0dcRBbvZN7a84HeF1b02vhtebg
         9YXjlG+gLFSzi9twT8LENDCNB7E555n/NpyTP1TmCq4IocXeoibGF8U+WhgTSQO/Qf/1
         Dluhy83z8d9UtOK4Xcv0+yM9ul9o4AEHrED67jdkIUeyhJ3q18M4gxRHP/YJ7S+WD1Bl
         y9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfNlVXRvcKj6Y0hPR3mdXqrOmf9uMfzMQoJ/2wwN28s=;
        b=q0XmntA98F9vmh526d6+taW07+gzUTmMh7eD4gKw0aMR1qmQM7H2cjtr7NvRzFYtzi
         57CX0JuC4tCBvsAUaZITxuMaW0IycPhsccwhZhbhM3Fu2aog1R2a2y8bmAtB7gB+kShL
         llTNcdZcXHD8Dng08Bwm+BhXcTRw2eDO3aH1qrjtGzxk3XlMKzkLf/baNR40ZFG7mOFH
         FRrJCCjXsmjASocVYBlfsF+YBea2R2C7ESNzpCJTizSGG1ObB29+d01ahN14V0IZ4C9k
         4oX5eIsHGglj+inqA/qzAUL52bo5/bGPcLO7oF8whofEu2k/IIVlO+pkWMkHVuqDbArI
         CobA==
X-Gm-Message-State: AOAM532mDnLNYGkkq1eP7gcTfyScu2pvtCI1kDj4/TTJTZhkkiK8APeQ
        GkxZjTY0/p8yseOvZJxLod5bpXCWKRxOHg6qtDE23Q==
X-Google-Smtp-Source: ABdhPJzuHGDNNiJJ/NVWgNCFo1qYw+4Wfg2mv7fUfSmQoHgQcGFTX5WEJREfXbTaagyxn+o5RQxZ5jAycl8ogxstPMQ=
X-Received: by 2002:a67:f30e:: with SMTP id p14mr2165736vsf.119.1598023739293;
 Fri, 21 Aug 2020 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <87d03lxysr.fsf@x220.int.ebiederm.org> <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein> <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org> <20200821111558.GG4546@redhat.com>
In-Reply-To: <20200821111558.GG4546@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Aug 2020 08:28:48 -0700
Message-ID: <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 08/20, Eric W. Biederman wrote:
> >
> > That said if we are going for a small change why not:
> >
> >       /*
> >        * Make sure we will check other processes sharing the mm if this is
> >        * not vfrok which wants its own oom_score_adj.
> >        * pin the mm so it doesn't go away and get reused after task_unlock
> >        */
> >       if (!task->vfork_done) {
> >               struct task_struct *p = find_lock_task_mm(task);
> >
> >               if (p) {
> > -                     if (atomic_read(&p->mm->mm_users) > 1) {
> > +                     if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {
>
> In theory this needs a barrier to avoid the race with do_exit(). And I'd
> suggest to use signal->live, I think signal->nr_threads should die...
> Something like
>
>         bool probably_has_other_mm_users(tsk)
>         {
>                 return  atomic_read_acquire(&tsk->mm->mm_users) >
>                         atomic_read(&tsk->signal->live);
>         }
>
> The barrier implied by _acquire ensures that if we race with the exiting
> task and see the result of exit_mm()->mmput(mm), then we must also see
> the result of atomic_dec_and_test(signal->live).
>
> Either way, if we want to fix the race with clone(CLONE_VM) we need other
> changes.

The way I understand this condition in __set_oom_adj() sync logic is
that we would be ok with false positives (when we loop unnecessarily)
but we can't tolerate false negatives (when oom_score_adj gets out of
sync). With the clone(CLONE_VM) race not addressed we are allowing
false negatives and IMHO that's not acceptable because it creates a
possibility for userspace to get an inconsistent picture. When
developing the patch I did think about using (p->mm->mm_users >
p->signal->nr_threads) condition and had to reject it due to that
reason.

>
> Oleg.
>
