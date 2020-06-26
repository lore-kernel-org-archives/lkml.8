Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC626C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E24206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TzRKu38I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgFZPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgFZPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:06:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD780C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:06:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q21so1363213otc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uY4k5Z/UQqoQvOvVgfkvTWigbamlyzLaUaHC2CeozWA=;
        b=TzRKu38IHrOYEnn7eQMlny/8KQczWLEAZwgAofjuqa3y5Zpw3E+YI3AiQEwa9GPpQb
         jXRKhGEddjotQCKXEhF+GgyB/Iu3SsV1tjQoWVu4dTD1Duv3C49Vtn7QHnxySqx1RgRg
         VsUxLqEwK2lpayCSOhF3aZCmEmPAz3VSKHiuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uY4k5Z/UQqoQvOvVgfkvTWigbamlyzLaUaHC2CeozWA=;
        b=r4FWdSJXZ57iv64yVVk/r6q6Vg2Uy3l3Fsz3BjcYwWa55pnifcYJxwQa+73fl+jYWO
         X9AyXg0CteiswJlu5w7k97+A3gwhYPTX3dAHZtndCBHhgN9CMpFgsBTwwDB5c7/y6z5q
         0NiKuOrxZ099FEEjBuqzcGDTnz/1DgTUgdVKGQ6YBh2iTJLaPwUGrcl3LjmC3q4LH4Qu
         KES49FV6/Obvg4nov8FBm27vJG1pfE5BhqvqX3Qz2Lv+cmFXCgJCyt0tU3U8wSUV+ptQ
         RNj1CGQBCGTwvVVlUG5DlV/1xUrd1Vto/yToQ6KBWKpG/tycI+To/fti9rVFYU6Tmpj/
         hZDQ==
X-Gm-Message-State: AOAM530YeUxrMI8bhXnrPNomsyklK1VWanElyvXVm/3Hn3Ro8K9mjiac
        lBo6EuN1l/H3TvxmU1STn6fHOrUaS+4c5INsngapsw==
X-Google-Smtp-Source: ABdhPJxVGK9yrwVC6cRwelY0XvBharV6IA4CfmeoOFX+2FvbXVO9wRa4PtSnsVOPSN2VRSh/3fYmuyvaiJmMorbVHzE=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr2675304oto.246.1593184006135;
 Fri, 26 Jun 2020 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com> <6c48d9428e5b23aab9be67538a94fe0436b16ecb.1583332765.git.vpillai@digitalocean.com>
In-Reply-To: <6c48d9428e5b23aab9be67538a94fe0436b16ecb.1583332765.git.vpillai@digitalocean.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 26 Jun 2020 11:06:35 -0400
Message-ID: <CANaguZB5+CZ0Lrtgn2y9M5AadLKiooEWMZCD=6f_t7GFogDNyA@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] sched: cgroup tagging interface for core scheduling
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
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

On Wed, Mar 4, 2020 at 12:00 PM vpillai <vpillai@digitalocean.com> wrote:
>
>
> Marks all tasks in a cgroup as matching for core-scheduling.
>
> A task will need to be moved into the core scheduler queue when the cgroup
> it belongs to is tagged to run with core scheduling.  Similarly the task
> will need to be moved out of the core scheduler queue when the cgroup
> is untagged.
>
> Also after we forked a task, its core scheduler queue's presence will
> need to be updated according to its new cgroup's status.
>
This came up during a private discussion with Joel and thanks to
him for bringing this up! Details below..

> @@ -7910,7 +7986,12 @@ static void cpu_cgroup_fork(struct task_struct *task)
>         rq = task_rq_lock(task, &rf);
>
>         update_rq_clock(rq);
> +       if (sched_core_enqueued(task))
> +               sched_core_dequeue(rq, task);
A newly created task will not be enqueued and hence do we need this
here?

>         sched_change_group(task, TASK_SET_GROUP);
> +       if (sched_core_enabled(rq) && task_on_rq_queued(task) &&
> +           task->core_cookie)
> +               sched_core_enqueue(rq, task);
>
Do we need this here? Soon after this, wake_up_new_task() is called
which will ultimately call enqueue_task() and adds the task to the
coresched rbtree. So we will be trying to enqueue twice. Also, this
code will not really enqueue,  because task_on_rq_queued() would
return false at this point(activate_task is not yet called for this
new task).

I am not sure if I missed any other code path reaching here that
does not proceed with wake_up_new_task().Please let me know, if I
missed anything here.

Thanks,
Vineeth
