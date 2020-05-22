Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E33C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D34206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="RM1/oCRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgEVRze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbgEVRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:55:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:55:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s21so14009542ejd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7+ZinecQk+vU2tx3USRyzTX9hWXqwnrfU8Z0ao5NFs=;
        b=RM1/oCRXDo9ryPT24QfNPtGbMQpFbyhAtGPByRCCCkRsAIqdrbBXgtD+Xp5SO5xHVD
         Y5nW0iZ21Q903SnBry33l1LxeDFngn3uirbmpxBPPre74pAl3PQlkFV/9PLuVlTtF12n
         59lPUphICio+7TuzrBBJrxD5HeyV9gmylFGU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7+ZinecQk+vU2tx3USRyzTX9hWXqwnrfU8Z0ao5NFs=;
        b=riXQxIfb76nWs5hQtgR37UUDWeSxIia5BF3Ad9EEz7lSPUfzttqvBbkc/3urvlJlLz
         CregeJIHLTQqWVpEbyzTrAa02FJraDcfuuGYADP9N8i9QiD9JnP3+pkCAJglG9KBjE9u
         Dadpz9GP3+MSvOjsPYJahc4Of7cV+m8tObNMMoZeN3eClRGOUjfDDt1HSDWETYulw6C+
         sQShXb2z/C1smS0xsRcjS5cDfMHrzSynATtbnWPFGfER28qJPgjmjeDoY6h/lboAFE3s
         bgocW9KEkENTKtoXT+QFuNlFq5gN0C1fkErEk0cQHJ01hECAbTo1GeQf5ADmnyqfHd5T
         +ryQ==
X-Gm-Message-State: AOAM532zi/dnqjYm5amDW3k1SfjUB7HLScV0rFSwy4YwvxRg/tryUCDa
        9VBr3tvu/A/WmklP/cS6Piv0YDJdZaKWUpmlvfLRMA==
X-Google-Smtp-Source: ABdhPJz/m46fpJfBvIY7sjEMmScn7M1dEiRH6YRxpET3JjeVNzQT8FxrHABIFR2TSp9Tpc7jFZXMsMl+UXhXNGe1F4U=
X-Received: by 2002:a17:906:9404:: with SMTP id q4mr9055108ejx.138.1590170131063;
 Fri, 22 May 2020 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234005.32370-1-sargun@sargun.me> <87h7wc4zac.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7wc4zac.fsf@x220.int.ebiederm.org>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 22 May 2020 10:54:55 -0700
Message-ID: <CAMp4zn_v-D=gyzdWO7D2KrdZ_vct87dV_0pM5HVNE_3zDG7k8Q@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 4:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Sargun Dhillon <sargun@sargun.me> writes:
>
> > This includes the thread group leader ID in the seccomp_notif. This is
> > immediately useful for opening up a pidfd for the group leader, as
> > pidfds only work on group leaders.
>
> The code looks fine (except for the name of the test), but can you
> please talk and think about this as something other than the
> group leader?
>
> The initial thread in a thread group can die, and the tgid is still
> valid for the entire group.  Because the initial thread of a
> process/thread group can die (but rarely does) that tends to result in
> kernel code that fails when thread_group_leader dies.
>
> To remove that class of bugs I am slowy working to remove the
> thread_group_leader from the kernel entirely.
>
> Looking at the names of the fields in the structure it looks like
> there is another class of bugs to be removed by renaming PIDTYPE_PID
> to PIDTYPE_TID in the kernel as well.  Just skimming the example code
> it looks very simple to get confused.
>
> Is there any chance some can modify struct seccomp_notify to do
> {
>         ...
>         union {
>                 __u32 pid;
>                 __u32 tid;
>         };
>         ...
> }
>
> Just to reduce the chance of confusion between the userspace pid and the
> in kernel pid names?
>
> Eric
Our use cases would be unaffected by this. I think this would be a wonderful
way to move forward, but I don't know if it could break userspace.

I believe Christian's team is the biggest user of this feature in OSS right now,
so he might know.

In addition, I'm not sure where you would want the thread's ID versus the
process's ID, unless you wanted to do something like SIGSTOP, and freeze
the thread to prevent it from making more progress, or being interrupted
while you go do notifier work.

Christian & Kees,
Thoughts?
