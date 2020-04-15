Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EAAC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B420784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQaEFEvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635828AbgDOIUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635575AbgDOIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:20:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05425C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:20:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so17857583wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tI6bF5NlaH6VP+qupCyijc9MdFpBjDaskO3oNma/yVo=;
        b=EQaEFEvL8a8nS0NGknzoERg+UJatb0uLaxOlI4m8PDNNa9XN/UJ77yfywyfYDxZb9M
         RYPtUHGszY/AwYsfORLlo/bwtANsiGcjTWV/4E3S4gtUIMjtEM96yILnaAOl7xCt4VFQ
         IcJOK13Rbx4DhYG1fdKPJvYb+5PDVnKFiKGtCXrFwVZ7RaJD5Gxmug26QuGkEDqV0Mdr
         WFiMGPM9i5S9s0dg5XrSQyPfDy89PFOjeP1FPFvyYifIZbXrelFNfGBc5p630xGyPFWC
         PpwLG8kxNrr96Avfa+Kr+JZhVEM4qDqnVrDbJyydYKH4CTNe8hK7DRbWaruR7ePh51jn
         VNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tI6bF5NlaH6VP+qupCyijc9MdFpBjDaskO3oNma/yVo=;
        b=Lcv2QH4zd+cEDU91n54sNUdEYPjJPkmG2RsapIZ0za1Bo0TydcYyDKQgd5Ydy4x76p
         N7A/bBU5GYNfjdda4vfmq2zUbdW8+ilpwQ31xXCUuLYePjSj9htBPxoUmQkDnzakmADz
         mwfgAWWX3U3YMwDwKnUl+DD4to++E2da362PwrMaiSdGO1rBRxc07hqasNt3sZrDyFls
         dfHB/LwLYmk8eYzyDzpFfjng5p7olyORNsEaFvOmLifRIt5OvSc107e5toz3/IoO6plk
         uOdLN3qFPGEkuoVALnnaUlnvMamgGuoUixoLHpu8s9U+DA8Fla4P7gu1YEJHEOotw2kl
         M2xA==
X-Gm-Message-State: AGi0PuYo/eqVQlJU12wfmIj6KVkzDGveIGMlzsE5sFT4cjZCD2XLUAvC
        x5rpcn3WIDjGOR5avjnOBNZz2Q==
X-Google-Smtp-Source: APiQypLfCVgV0tOWD0TIjssd9/GA8YX2l0BlHT490ZXW6wAL/ti9Z2T/rtGZQ9qeywYAilxhL40vWA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr3721578wmh.141.1586938805319;
        Wed, 15 Apr 2020 01:20:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f2sm22280970wro.59.2020.04.15.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 01:20:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:20:01 +0100
From:   Quentin Perret <qperret@google.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, ctheegal@codeaurora.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200415082001.GA256573@google.com>
References: <20200414161320.251897-1-qperret@google.com>
 <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tuesday 14 Apr 2020 at 13:45:03 (-0700), Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 14, 2020 at 9:13 AM Quentin Perret <qperret@google.com> wrote:
> >
> > uclamp_fork() resets the uclamp values to their default when the
> > reset-on-fork flag is set. It also checks whether the task has a RT
> > policy, and sets its uclamp.min to 1024 accordingly. However, during
> > reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> > hence leading to an erroneous uclamp.min setting for the new task if it
> > was forked from RT.
> >
> > Fix this by removing the unnecessary check on rt_policy() in
> > uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> > set.
> >
> > Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  kernel/sched/core.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3a61a3b8eaa9..9ea3e484eea2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
> >         for_each_clamp_id(clamp_id) {
> >                 unsigned int clamp_value = uclamp_none(clamp_id);
> >
> > -               /* By default, RT tasks always get 100% boost */
> > -               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -                       clamp_value = uclamp_none(UCLAMP_MAX);
> > -
> >                 uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> 
> The local variable "clamp_value" doesn't have a lot of value anymore,
> does it?  (Pun intended).

:)

> Remove it?

Right, but I figured the generated code should be similar, and
'uclamp_se_set(&p->uclamp_req[clamp_id], uclamp_none(clamp_id), false);'
doesn't fit in 80 cols at this identation level, so I kept the local
var. No strong opinion, though.

Thanks,
Quentin
