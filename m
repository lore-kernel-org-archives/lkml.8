Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F9BC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20AB21841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIQEWnih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDSPbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:31:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:31:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n143so1129469qkn.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azedkZ7sHyccnMqTcjQA1pZkShaS659fQJ50ILayAM0=;
        b=rIQEWnihbCVEPOKaGMKozAq626/D428rig9I/e5lhsRwS89p0uEhcaU/bmmjw2edFY
         s8CzSRXxOBMZQxhGujejd1CpO6y4A1p625mO8QXoi1wFnJV18nufi5rGbRLuvhQeE3KM
         1iIWQYq546HtuHvf24A69a2VI/TboV37MD38XsNklTUFnS2rJVMtdD3twhjiKokrV9pj
         za91okqDVBGfvjjiaa6siGuxyF8KRzFuCO+FyFUlyVUYUiXhPnex6xBzMcP64IwZ3N0r
         1Nq6uABZqek7cxBBzKjGPqvoDc87GBIzlx956n3uM2C5feBmbyspb/YOR2d6xVqjxzgk
         TE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azedkZ7sHyccnMqTcjQA1pZkShaS659fQJ50ILayAM0=;
        b=rMcfNmwq0tLkA3O+zpieUAxzYHDuugmTgKd7HoxPHEnznIMlmYlQU8onuIx02pwN/h
         v5wzOkABjUSlVOcmwJg7h5m4zB68XII0sJcPVb2jRFHDMSSu3ROJGg/HGlu3LDUjvPqC
         Cx/9lqHy5DKtG7c2GWVo/hAFJpQtJ4RZ4fA8/R/qstgk8IjE32bhDG/zs+AyhlqB2PCF
         HBCQIAzVP9so+KJHRfCJLPyTGd1cRQ1smrfW0XcWcZflNMcz5kEYL12a3xxrX4Kjwu0+
         pYnLD2uiGUI4+oUpCQ7GP2QaaQ3FRWnS2oMHY1Gz+v5yxfUztgyX3aBxW3ikE03nSA2p
         DB4A==
X-Gm-Message-State: AGi0PuaDTp2RQihj3dKRxNpNxPSjExxiRJisYTe9NhwnDMzELM38Y4im
        qfWVZxiPeo7Xv99Y9bey6LCeRPrIM6ozWhAin74=
X-Google-Smtp-Source: APiQypLcLwohk+gNK7IURKtfGZXSP2eHejLfMKRORAANvg7aLSFtXLc/48dCg3Bmc+M6n36kkMleC78UlsccAFQD/cY=
X-Received: by 2002:a05:620a:81b:: with SMTP id s27mr12268158qks.351.1587310302828;
 Sun, 19 Apr 2020 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200416033804.GA5712@HP-G1> <20200417111805.GA20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200417111805.GA20730@hirez.programming.kicks-ass.net>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Sun, 19 Apr 2020 23:31:31 +0800
Message-ID: <CADjb_WQ0rg1O9t8hkevUmf_Yx4mTRZ0O_Wz-p3VN8oDbGVBuJA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and scheduling.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Long Cui <long.cui@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 7:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 16, 2020 at 11:39:05AM +0800, Chen Yu wrote:
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 02495d44870f..ef101a3ef583 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4477,9 +4477,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >               return next;
> >       }
> >
> > -     prev->sched_class->put_prev_task(rq, prev);
> > -     if (!rq->nr_running)
> > -             newidle_balance(rq, rf);
> > +
> > +#ifdef CONFIG_SMP
> > +     for_class_range(class, prev->sched_class, &idle_sched_class) {
> > +             if (class->balance(rq, prev, rf))
> > +                     break;
> > +     }
> > +#endif
> > +     put_prev_task(rq, prev);
> >
> >       smt_mask = cpu_smt_mask(cpu);
>
> Instead of duplicating that, how about you put the existing copy in a
> function to share? finish_prev_task() perhaps?
>
> Also, can you please make newidle_balance() static again; I forgot doing
> that in 6e2df0581f56, which would've made you notice this sooner I
> suppose.
Okay, I'll do that,

Thanks,
Chenyu
