Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39BAC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAECE21473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEIOUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:20:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50696 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgEIOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:20:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXQLJ-0006Tb-Ur; Sat, 09 May 2020 08:20:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXQLI-0001r0-SE; Sat, 09 May 2020 08:20:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <875zd66za3.fsf_-_@x220.int.ebiederm.org>
        <202005082213.8BDD4AC0CC@keescook>
Date:   Sat, 09 May 2020 09:17:11 -0500
In-Reply-To: <202005082213.8BDD4AC0CC@keescook> (Kees Cook's message of "Fri,
        8 May 2020 22:15:43 -0700")
Message-ID: <87tv0p2nx4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXQLI-0001r0-SE;;;mid=<87tv0p2nx4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18A1U/jWwxjIXHnvSgRraar1VS0tQcBrZU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4/6] exec: Run sync_mm_rss before taking exec_update_mutex
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> $ git grep exec_mm_release
> fs/exec.c:      exec_mm_release(tsk, old_mm);
> include/linux/sched/mm.h:extern void exec_mm_release(struct task_struct *, struct mm_struct *);
> kernel/fork.c:void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
>
> kernel/fork.c:
>
> void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
> {
>         futex_exit_release(tsk);
>         mm_release(tsk, mm);
> }
>
> void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
> {
>         futex_exec_release(tsk);
>         mm_release(tsk, mm);
> }
>
> $ git grep exit_mm_release
> include/linux/sched/mm.h:extern void exit_mm_release(struct task_struct *, struct mm_struct *);
> kernel/exit.c:  exit_mm_release(current, mm);
> kernel/fork.c:void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
>
> kernel/exit.c:
>
>         exit_mm_release(current, mm);
>         if (!mm)
>                 return;
>         sync_mm_rss(mm);
>
> It looks to me like both exec_mm_release() and exit_mm_release() could
> easily have the sync_mm_rss(...) folded into their function bodies and
> removed from the callers. *shrug*

Well it would have to be all of:
	if (mm) 
		sync_mm_rss(mm);

I remember reading through exit_mm_release and seeing that nothing
actually depended upon a non-NULL mm. Unless you have clear_child_tid
set.

I am not up to speed on that part of the mm layer right now to know if
it is a good idea to put sync_mm_rss in exit_mm_release but at a quick
look it feels like it.

Eric

