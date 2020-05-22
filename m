Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5FEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820062073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gNgfFEfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgEVUNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:13:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ACAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:13:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f189so11971015qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QHwAobU9LqnPNzizNz3NX14Vi1ewzfeVxavFPKRE3Jc=;
        b=gNgfFEfdXfpGCIAWsZ5Q7nBonfiYNTZypKmcQkjlq9hVm/OqFdNWyj6jHdf1pvwXUy
         UHrpoBtVHqHdyjYQ2BeAhsz3PWuW9kwk/CKEh5mgm+Qfrl/DfFKgzvFxWF8Ic1YMXWdB
         d7dM3/w3bfH5lbIudu1Flh6Xat+6I1+4ZGxGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QHwAobU9LqnPNzizNz3NX14Vi1ewzfeVxavFPKRE3Jc=;
        b=URI2uKs2VCne0GHfA8onk+ifAjSWsGwM4BQ5tosC3qP/sFJTOJQcIe3lzK/8nryKv7
         whzIyQYVU3MwzzHQtVRjWULpx30TNER5k075ng0nWcvJ5+jhpKqZ/lYufXRe4l1RhQeQ
         qY3B8PLmEksuKQNbIqc2H6hc2ZP5Le4OaNs9jIIar4PtpmP72kJNCPohaGHZohYdV/pq
         w/ah8FEmj9kL1ePx3gKd0aFtyCspMogDlW/8rwN3qABcmHMT8RGTyAQkz3Hw8Q5IJQvK
         MH24R9C/p2m9Y36/L8ROIZe/ZtGr3zNNaRjt0LX9TBvK/H0jq9Wfeuwm8IYCLu5KHE6M
         PxFA==
X-Gm-Message-State: AOAM5313dAvQxoQo/4WfttS2dcRyTynAgNQpt6dxDt2Y6oItyJ1x56EW
        Mmmcjtbg2DH8HjyZKLAu9uESpg==
X-Google-Smtp-Source: ABdhPJwkFCvrR7N4ZnF2YxuEPR8/EpzcgH0bt9XNottpDCMFflZ0aYHc36bx/t1bAyielLYSJLAM+g==
X-Received: by 2002:a37:bc7:: with SMTP id 190mr16547207qkl.286.1590178393898;
        Fri, 22 May 2020 13:13:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g26sm9000360qtk.76.2020.05.22.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:13:13 -0700 (PDT)
Date:   Fri, 22 May 2020 16:13:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200522201312.GC213825@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200521231426.GA246288@google.com>
 <20200522023556.GE140701@google.com>
 <20200522034406.GC6339@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522034406.GC6339@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:44:06AM +0800, Aaron Lu wrote:
[...]
> > Updated diff below:
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 005d7f7323e2d..625377f393ed3 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -182,9 +182,6 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> >  
> >  	rq->core->core_task_seq++;
> >  
> > -	if (!p->core_cookie)
> > -		return;
> > -
> >  	node = &rq->core_tree.rb_node;
> >  	parent = *node;
> >  
> > @@ -215,7 +212,7 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> >  
> >  void sched_core_add(struct rq *rq, struct task_struct *p)
> >  {
> > -	if (p->core_cookie && task_on_rq_queued(p))
> > +	if (task_on_rq_queued(p))
> >  		sched_core_enqueue(rq, p);
> >  }
> 
> It appears there are other call sites of sched_core_enqueue() where
> core_cookie is checked: cpu_cgroup_fork() and __sched_write_tag().

Thanks, but looks like pick_task()'s caller also makes various assumptions
about cookie == 0 so all that needs to be vetted again I think.

 - Joel

