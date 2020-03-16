Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFBEC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6CD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZFs1AHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgCPX7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:59:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbgCPX7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:59:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so10865729pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qEANOgtBSueUJD8m8QfmAMA6kpeJTGDGbSVYwjdAhYY=;
        b=LZFs1AHZzWCXFBABx/gWhz/foi529c2VuScqMgysiZIwQNb4XFuH27xKV9ySQQcphv
         7bc4HItVdEKt7qsWHI7E8YT9HiIFfwfvuLJf9b8uipeVYZLk86YR8/kD365ty5Lk1o0F
         kYUVAMzZPmjXfabJFjpr6Z+aJWBWP8WVcVvxudBsXr7mb8CZCo4aBT2BsWmPH9v1zCTM
         wcqg5komC29tmplhp7S7hpoWQfrhDZldsd9HoITurHRsw+Kq1nOvvgTeazAc46MAg/Tg
         INZLgApQgCZLSwknjOwJFUKxJjOjuajrYcnRCvqlsaiQahCa0IudUoLXG+3lRyx4qEq/
         pqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qEANOgtBSueUJD8m8QfmAMA6kpeJTGDGbSVYwjdAhYY=;
        b=cVDnaVg+RLeXWoX3qn5dRM2DeY6xm7NdWDxm1vF6IAmj+4rpFnpB0GHdrpFXmT6tLX
         Mnr4d8hkofRNHJleqETRBnTImuxqy1CNMP0SYaBZlSnAiorWYAliv0tFPHoD1efPKvzJ
         k3g5upEUfC5mrfWOdFnOavIYlJbR17ARbGG12EynklzTmu+MG68USYo8p+V1H67Ualel
         kcSz9TdFlHXwgokNaBELtBsPsp5JRBBKvKxZbRV9QMZpViuojFC5ARx1cEbkpQxdH8PI
         byktDo8998cgpeStMArVaLwnERcBfvkI/H7BPHlXU+2zBPUggr3GxDvjmkPxuYbD16cQ
         hEgg==
X-Gm-Message-State: ANhLgQ2YPnSTjE7N8VriHLgEPFQFHB6sN7/mspAdidZ2ygQ71OmXgjGn
        eGFDDjh4zYfEvQ2M1dkfL4sgGGMwCRs=
X-Google-Smtp-Source: ADFU+vs27F0Yx/bWNoklL02tbvp1Izg/1FqYdluXI3a9vgUrHWc5Cr0H8qebaFkZGClk774Go2g7QQ==
X-Received: by 2002:a63:2ec1:: with SMTP id u184mr2169699pgu.446.1584403144583;
        Mon, 16 Mar 2020 16:59:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z16sm930252pfr.138.2020.03.16.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:59:03 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:59:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com>
References: <202003120012.02C0CEUB043533@www262.sakura.ne.jp> <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com> <202003130015.02D0F9uT079462@www262.sakura.ne.jp> <alpine.DEB.2.21.2003131457370.242651@chino.kir.corp.google.com>
 <fa5d7060-4e6e-16d5-2c37-fec6019b4d62@i-love.sakura.ne.jp> <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Mar 2020, Tetsuo Handa wrote:

> > If current thread is
> > an OOM victim, schedule_timeout_killable(1) will give other threads (including
> > the OOM reaper kernel thread) CPU time to run.
> 
> If current thread is an OOM victim, schedule_timeout_killable(1) will give other
> threads (including the OOM reaper kernel thread) CPU time to run, by leaving
> try_charge() path due to should_force_charge() == true and reaching do_exit() path
> instead of returning to userspace code doing "for (;;);".
> 
> Unless the problem is that current thread cannot reach should_force_charge() check,
> schedule_timeout_killable(1) should work.
> 

No need to yield if current is the oom victim, allowing the oom reaper to 
run when it may not actually be able to free memory is not required.  It 
increases the likelihood that some other process schedules and is unable 
to yield back due to the memcg oom condition such that the victim doesn't 
get a chance to run again.

This happens because the victim is allowed to overcharge but other 
processes attached to an oom memcg hierarchy simply fail the charge.  We 
are then reliant on all memory chargers in the kernel to yield if their 
charges fail due to oom.  It's the only way to allow the victim to 
eventually run.

So the only change that I would make to your patch is to do this in 
mem_cgroup_out_of_memory() instead:

	if (!fatal_signal_pending(current))
		schedule_timeout_killable(1);

So we don't have this reliance on all other memory chargers to yield when 
their charge fails and there is no delay for victims themselves.

 [ I'll still propose my change that adds cond_resched() to 
   shrink_node_memcgs() because we can see need_resched set for a 
   prolonged period of time without scheduling. ]

If you agree, I'll propose your patch with a changelog that indicates it 
can fix the soft lockup issue for UP and can likely get a tested-by for 
it.
