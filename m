Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173AC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C822522
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD8pWHFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCINL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:11:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58352 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726414AbgCINL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583759484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRJIUHA2CnOOeiHBMD4y+dr1ZXYznLSuwH0WgiBK5ck=;
        b=SD8pWHFZtyclFsLyZychQ3WhfZaP7d9FJSQ3urFJU1Sj1cziI2MB0SJmtHjEPp1nhnGrZu
        XKa7Xeo4iFXPYCwxGJ4SnVsdtX7C1fu77ghQL0pAjmR5Jcl0f+bcQ3MCAeY8EuANET5xIE
        fpNfjKqaaXRit5vue6Tbd8x7Y2sjxG8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-MhwNH3oiPYieyfIk55V9iQ-1; Mon, 09 Mar 2020 09:11:20 -0400
X-MC-Unique: MhwNH3oiPYieyfIk55V9iQ-1
Received: by mail-wr1-f70.google.com with SMTP id b12so5221783wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRJIUHA2CnOOeiHBMD4y+dr1ZXYznLSuwH0WgiBK5ck=;
        b=mMNr5I77AYsQBXb7UPP73qrx0VWZQnY+Mypd/k98b1Pu0uSZX7U0oE5OPQD9AsXw0c
         ph3/c1rN7xioqCpeKSQIUSanr9ffoJjGkNDR95NhG6Jb+aVW0kenj1tgOweUAQQK/xoG
         rc/Pb6qDe48tWV08/V9+IB2dN3eyeZ1ZsvJ+6lpb1SazW9IE8Ha9vW1gSajFJLdOp5WR
         AfXoJuvKoRYAN0XM70fMf+87AoAtOI7HkWfOdA1rn+VDt40svHKoP7x3uTyI5dIImAfP
         xTs397iwiHRlDjsLp9jBFQHkMc3CokSawZ6Q/xaF+c28T7ltq7xeZO9ZOCosC6srXv2V
         nJTQ==
X-Gm-Message-State: ANhLgQ2G8kj01oKt8zxw1LYVdJGBJ8JclWmoHytMO+j0HAJ1Ln6Bvl6l
        uEn0uy1j9pQ2pTH9HLOqZFdY7C3yks7Ghpw0XBAi5iQcU91XmdmbNYWoBr1lsDC9ROmOHAegSql
        ZyuxXL0wnKHTK82y0HwmPNdap
X-Received: by 2002:adf:e506:: with SMTP id j6mr20733582wrm.309.1583759479368;
        Mon, 09 Mar 2020 06:11:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuCDJFZ7JTpz5uoFvZAVeKx+9vsgLNPQPPkBhoFe61RXjhOioyK15/Hhufdoq2jrHxA0uFd5Q==
X-Received: by 2002:adf:e506:: with SMTP id j6mr20733564wrm.309.1583759479021;
        Mon, 09 Mar 2020 06:11:19 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y15sm5710650wrq.89.2020.03.09.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:11:18 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:11:17 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
Message-ID: <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
 <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
 <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:08:18PM +0100, Vlastimil Babka wrote:
> On 3/6/20 2:41 PM, Oleksandr Natalenko wrote:
> > On Fri, Mar 06, 2020 at 02:13:49PM +0100, Vlastimil Babka wrote:
> >> On 3/2/20 8:36 PM, Minchan Kim wrote:
> >> > From: Oleksandr Natalenko <oleksandr@redhat.com>
> >> > 
> >> > It all began with the fact that KSM works only on memory that is marked
> >> > by madvise(). And the only way to get around that is to either:
> >> > 
> >> >   * use LD_PRELOAD; or
> >> >   * patch the kernel with something like UKSM or PKSM.
> >> > 
> >> > (i skip ptrace can of worms here intentionally)
> >> > 
> >> > To overcome this restriction, lets employ a new remote madvise API. This
> >> > can be used by some small userspace helper daemon that will do auto-KSM
> >> > job for us.
> >> > 
> >> > I think of two major consumers of remote KSM hints:
> >> > 
> >> >   * hosts, that run containers, especially similar ones and especially in
> >> >     a trusted environment, sharing the same runtime like Node.js;
> 
> Ah, I forgot to ask, given the discussion of races in patch 2 (Question 2),
> where android can stop the tasks to apply the madvise hints in a race-free
> manner, how does that work for remote KSM hints in your scenarios, especially
> the one above?

We have cgroup.freeze for that.

> 
> >> > 
> >> >   * heavy applications, that can be run in multiple instances, not
> >> >     limited to opensource ones like Firefox, but also those that cannot be
> >> >     modified since they are binary-only and, maybe, statically linked.
> >> > 
> >> > Speaking of statistics, more numbers can be found in the very first
> >> > submission, that is related to this one [1]. For my current setup with
> >> > two Firefox instances I get 100 to 200 MiB saved for the second instance
> >> > depending on the amount of tabs.
> >> > 
> >> > 1 FF instance with 15 tabs:
> >> > 
> >> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> >> >    410
> >> > 
> >> > 2 FF instances, second one has 12 tabs (all the tabs are different):
> >> > 
> >> >    $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> >> >    592
> >> > 
> >> > At the very moment I do not have specific numbers for containerised
> >> > workload, but those should be comparable in case the containers share
> >> > similar/same runtime.
> >> > 
> >> > [1] https://lore.kernel.org/patchwork/patch/1012142/
> >> > 
> >> > Reviewed-by: SeongJae Park <sjpark@amazon.de>
> >> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> >> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> >> 
> >> This will lead to one process calling unmerge_ksm_pages() of another. There's a
> >> (signal_pending(current)) test there, should it check also the other task,
> >> analogically to task 3?
> > 
> > Do we care about current there then? Shall we just pass mm into unmerge_ksm_pages and check the signals of the target task only, be it current or something else?
> 
> Dunno, it's nice to react to signals quickly, for any proces that gets them, no?

So, do you mean something like this?

===
diff --git a/mm/ksm.c b/mm/ksm.c
index 363ec8189561..b39c237cfcf4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -849,7 +849,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
 		if (ksm_test_exit(vma->vm_mm))
 			break;
-		if (signal_pending(current))
+		if (signal_pending(current) ||
+		    signal_pending(rcu_dereference(vma->vm_mm->owner)))
 			err = -ERESTARTSYS;
 		else
 			err = break_ksm(vma, addr);
===

BTW, this won't work with !CONFIG_MEMCG, so probably task_struct should be
passed through instead. IIUC, this would also require amending struct
mm_slot in order to share the same code path with ksmd.

I'm not sure I've seen such a culprit anywhere else, so I'm in doubt
this would be a correct thing to do.

Ideas?

> 
> >> Then break_ksm() is fine as it is, as ksmd also calls it, right?
> > 
> > I think break_ksm() cares only about mmap_sem protection, so we should
> > be fine here.
> > 
> >> 
> >> > ---
> >> >  mm/madvise.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> > 
> >> > diff --git a/mm/madvise.c b/mm/madvise.c
> >> > index e77c6c1fad34..f4fa962ee74d 100644
> >> > --- a/mm/madvise.c
> >> > +++ b/mm/madvise.c
> >> > @@ -1005,6 +1005,10 @@ process_madvise_behavior_valid(int behavior)
> >> >  	switch (behavior) {
> >> >  	case MADV_COLD:
> >> >  	case MADV_PAGEOUT:
> >> > +#ifdef CONFIG_KSM
> >> > +	case MADV_MERGEABLE:
> >> > +	case MADV_UNMERGEABLE:
> >> > +#endif
> >> >  		return true;
> >> >  	default:
> >> >  		return false;
> >> > 
> >> 
> > 
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

