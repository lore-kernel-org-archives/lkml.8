Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8858A2065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Oz7cLKms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgENWvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgENWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:51:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:51:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a2so526217oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsxDgZiwde/RbsjizwoCaIfRTRznKDXgt3JRZ4eLYUk=;
        b=Oz7cLKmsTiRHGVk5sRTp1fF1U+fXja5iOYTWOabw8rgXRPDTwUce5TFYvcFlME+9Fw
         fGoUINar4IxqZHI7Ht6cmk7vIa3juRSCIgHETmh8azVvy1NwFULqY4AIQBWqNWDBEHS/
         5/183MJ9qXPdnbI7B/BkMh1wAL8zYam2ffxdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsxDgZiwde/RbsjizwoCaIfRTRznKDXgt3JRZ4eLYUk=;
        b=k9xPOcaIOhGGmKj6s8LDyliIy6w6oSQgRjswZwaIw26mhnRrPZnzo2aiN3WKkAcvLl
         baIDRQtwLSgEFUgnUezShP0tGMh+FlJOMJjk1f2qJB5CTnFCkwtQwAsSYAbx/9uInY8c
         GvMspisZBsPa+549GEpilknEHfVFAQ262B2juhNuUsrMPcvMH0Wg5MyjspbtX+75/nMj
         B2mzAo4T372NrcQrWFobf7JzOW0hVg9Boy14gRAIVHj1eNOgoZVuxuEW5ko4V1elpoph
         766fZSE5LK19r+TD35JgUGL2PvZqSIXRdD9TyhCqVSwr1rn/0t0uIexyz7sjisZwhncq
         E23Q==
X-Gm-Message-State: AOAM533zlW7dsihOh4L4uYdNHtAVaVMp6QmpaX9WiwpcZa5Lpr8PZK4S
        Pb7QMQ4QAdbRTsZXhVMI0EiiyE83gSHqoMCZ9dJ56Q==
X-Google-Smtp-Source: ABdhPJxdbJrmkOU8mLOx8PnJj0VzGzSknVzfSyXh4S0rYtb4Q+YM1eRPnu2oc0T4JmYIcVy+GLK4VgUm/670nog4R7I=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr151319oib.160.1589496698945;
 Thu, 14 May 2020 15:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain> <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop> <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net> <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net> <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
In-Reply-To: <20200514130248.GD2940@hirez.programming.kicks-ass.net>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Thu, 14 May 2020 18:51:27 -0400
Message-ID: <CANaguZD_ZknCrnUA8TYs4rc0TLJZ9J2_FcWmW5cxEMWDTdL6hg@mail.gmail.com>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority comparison
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
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

Hi Peter,

On Thu, May 14, 2020 at 9:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> A little something like so, this syncs min_vruntime when we switch to
> single queue mode. This is very much SMT2 only, I got my head in twist
> when thikning about more siblings, I'll have to try again later.
>
Thanks for the quick patch! :-)

For SMT-n, would it work if sync vruntime if atleast one sibling is
forced idle? Since force_idle is for all the rqs, I think it would
be correct to sync the vruntime if atleast one cpu is forced idle.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> -               if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> -                       rq_i->core_forceidle = true;
> +               if (is_idle_task(rq_i->core_pick)) {
> +                       if (rq_i->nr_running)
> +                               rq_i->core_forceidle = true;
> +               } else {
> +                       new_active++;
I think we need to reset new_active on restarting the selection.

> +               }
>
>                 if (i == cpu)
>                         continue;
> @@ -4476,6 +4473,16 @@ next_class:;
>                 WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
>         }
>
> +       /* XXX SMT2 only */
> +       if (new_active == 1 && old_active > 1) {
As I mentioned above, would it be correct to check if atleast one sibling is
forced_idle? Something like:
if (cpumask_weight(cpu_smt_mask(cpu)) == old_active && new_active < old_active)

> +               /*
> +                * We just dropped into single-rq mode, increment the sequence
> +                * count to trigger the vruntime sync.
> +                */
> +               rq->core->core_sync_seq++;
> +       }
> +       rq->core->core_active = new_active;
core_active seems to be unused.

> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +       struct sched_entity *se_a = &a->se, *se_b = &b->se;
> +       struct cfs_rq *cfs_rq_a, *cfa_rq_b;
> +       u64 vruntime_a, vruntime_b;
> +
> +       while (!is_same_tg(se_a, se_b)) {
> +               int se_a_depth = se_a->depth;
> +               int se_b_depth = se_b->depth;
> +
> +               if (se_a_depth <= se_b_depth)
> +                       se_b = parent_entity(se_b);
> +               if (se_a_depth >= se_b_depth)
> +                       se_a = parent_entity(se_a);
> +       }
> +
> +       cfs_rq_a = cfs_rq_of(se_a);
> +       cfs_rq_b = cfs_rq_of(se_b);
> +
> +       vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
> +       vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
Should we be using core_vruntime conditionally? should it be min_vruntime for
default comparisons and core_vruntime during force_idle?

Thanks,
Vineeth
