Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6301FC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382E9205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584353699;
	bh=DFAsW5BCw7jOq218iRus2k5QQlmGy0khiOahlBnPX5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=llD4otnEwGITqZUchv2C9/nVM/UYEmZjye3jjiuZjVqW1a21HZoJuqE6Pwchkprdv
	 PtKnoF6FMSjQH7r9sUmFnme/dqqMwY8aAhRNjcI69CcFzpSBqHImflYKPf4RlEv3Uf
	 aGpNSmJjcbP1SIObqOaAyHHsnmePYgy5ixAbssfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgCPKO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:14:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50330 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgCPKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:14:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z13so898431wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 03:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mT1+gDN6f+fs8b4YY3DWtQhvan8/bp51m7MCR4G4Mzo=;
        b=FpWtw7SuvswMu9i1u6lEcZ+rlwhwb/vHKajYgTFlr00whKvJng7+GMA4Fnb5l7gDbC
         Sx1vob+GefNQcNsER4I3d46ad9wJLWr7L1x7pzigDXx5sxQGLY4YKHj/09CVZK8qW4ZY
         75hHS+Mx3rccymWAWaapf0P0RjuTAF1lL2yEhxwV1KMnn6WtoP/FEMMoqnYQINZupDmU
         X4sTVy51wom5NIiReS31XsMkDDZzgHEuebp2o0Ve2fDPFWSy85g6EIivZkzoFsi82bDu
         4FiAJtOKczCB+9Suz5gfLnvCc6TILsMU5rRoBTNWsjlQHHS7L7CZOiCPTxkWaSZ8zDFd
         GwrA==
X-Gm-Message-State: ANhLgQ3puuzmObOUZNZ5ptVpAowLY9rVGI6BAF12164oYqKtnvu4nnmi
        U9QsHeoZsRWHB+7rwAhG7Dk=
X-Google-Smtp-Source: ADFU+vtA/WLpwlxPON9GJCyTDEGOBVOLAOZyuD5aJpEMOo4RR9nE2eqbad++oqGEagHw2b3VZuEEfQ==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr26782494wmt.60.1584353693932;
        Mon, 16 Mar 2020 03:14:53 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id j39sm14665548wre.11.2020.03.16.03.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:14:52 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:14:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200316101449.GG11482@dhcp22.suse.cz>
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
 <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
 <20200312153238.c8d25ea6994b54a2c4d5ae1f@linux-foundation.org>
 <20200316093152.GE11482@dhcp22.suse.cz>
 <3be371a0-5b1e-7115-8659-186612ad5fb0@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be371a0-5b1e-7115-8659-186612ad5fb0@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-03-20 19:04:44, Tetsuo Handa wrote:
> On 2020/03/16 18:31, Michal Hocko wrote:
> >> What happens if the allocator has SCHED_FIFO?
> > 
> > The same thing as a SCHED_FIFO running in a tight loop in the userspace.
> > 
> > As long as a high priority context depends on a resource held by a low
> > priority task then we have a priority inversion problem and the page
> > allocator is no real exception here. But I do not see the allocator
> > is much different from any other code in the kernel. We do not add
> > random sleeps here and there to push a high priority FIFO or RT tasks
> > out of the execution context. We do cond_resched to help !PREEMPT
> > kernels but priority related issues are really out of scope of that
> > facility.
> > 
> 
> Spinning with realtime priority in userspace is a userspace's bug.
> Spinning with realtime priority in kernelspace until watchdog fires is
> a kernel's bug. We are not responsible for userspace's bug, and I'm
> asking whether the memory allocator kernel code can give enough CPU
> time to other threads even if current thread has realtime priority.

We've been through that discussion many times and the core point is that
this requires a large surgery to work properly. It is not just to add a
sleep into the page allocator and be done with that. Page allocator
cannot really do much on its own. It relies on many other contexts to
make a forward progress. What you really demand is far from trivial.
Maybe you are looking something much closer to the RT kernel than what
other preemption modes can offer currently.

Right now, you really have to be careful when running FIFO/RT processes
and plan their resources very carefully. Is that ideal? Not really but
considering that this is the status quo for many years it seems that
the usecases tend to find their way around that restriction.
-- 
Michal Hocko
SUSE Labs
