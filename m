Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EB220792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595338722;
	bh=PPhPM53d2MTIxsJUXtD9BygOVv0SIF0J+lKGXm6IwUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2qzCz0hE+ACyLu7D6ItiQ+Y2cfFGCjvAacix3lnQ1LghJToEY8ybEybDG2wyOQST
	 QoZReVmnDU15wNz+LNCsq6L8s9SOoRsHxGdc+pDf6si7p+Cpq8LK2drjNZzzhuK2wi
	 2RDObIV0vbFMoUEXHXR06dlWjFwph8bfSydlL4sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGUNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:38:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgGUNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:38:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id 184so2938578wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kwZF580by+7OaTNh1bwviGHgBVh2cx54v1+9OBPyRe8=;
        b=MlAt0ubt8vPtG6y3MgONsX3YjBHo6dKJ/QuQYusEoVMcVhWr5pBwDFSAIU7vkbxf91
         3AcwHw6QjLhkQeBlFYCQ9uk9EHKWzMeQtrtoRqKB2nqHZr0COvuJyWR5tEB8HlyOxHUs
         BsjchuGfEbWoy1u/w4SpSjdqMOrx1guYUa7mAWV+FzbDjsaYgG1cFeq03LhunXPyaTmG
         kYk2u9hBJZNmkk1gXiAY3+r1S7YRWJMG6BrXx0QfS+MptL2C3wJZdVGCLUvYOpsCR7kf
         SY1nIDdhaRpZAKVUii9J3puNdsciIKf4owXY9xcLKE83n2onv2r7OeTn0IBkQVVITwVP
         KrJg==
X-Gm-Message-State: AOAM530m4Xbu+7JkPqtp6bOL2E2Z8xWHRIhj4MupxoAz3XueyObQiztt
        +X6BMqE+MSZQkmSf5X69Cgo=
X-Google-Smtp-Source: ABdhPJwDNWr5Q7HHQC1AeGgQy/c1wYdU4H/JDpbXbuKx7zxXnuoB9K1Z+KAUXnO2TD8diyFqifofSw==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr4229905wmd.71.1595338718332;
        Tue, 21 Jul 2020 06:38:38 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id t3sm6298077wre.41.2020.07.21.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:38:37 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:38:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721133835.GL4061@dhcp22.suse.cz>
References: <20200721112529.GJ4061@dhcp22.suse.cz>
 <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
 <20200721121752.GK4061@dhcp22.suse.cz>
 <20200721132343.GA4261@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721132343.GA4261@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 09:23:44, Qian Cai wrote:
> On Tue, Jul 21, 2020 at 02:17:52PM +0200, Michal Hocko wrote:
> > On Tue 21-07-20 07:44:07, Qian Cai wrote:
> > > 
> > > 
> > > > On Jul 21, 2020, at 7:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > 
> > > > Are these really important? I believe I can dig that out from the bug
> > > > report but I didn't really consider that important enough.
> > > 
> > > Please dig them out. We have also been running those things on
> > > “large” powerpc as well and never saw such soft-lockups. Those
> > > details may give us some clues about the actual problem.
> > 
> > I strongly suspect this is not really relevant but just FYI this is
> > 16Node, 11.9TB with 1536CPUs system.
> 
> Okay, we are now talking about the HPC special case. Just brain-storming some
> ideas here.
> 
> 
> 1) What about increase the soft-lockup threshold early at boot and restore
> afterwards? As far as I can tell, those soft-lockups are just a few bursts of
> things and then cure itself after the booting.

Is this really better option than silencing soft lockup from the code
itself? What if the same access pattern happens later on?

> 2) Reading through the comments above page_waitqueue(), it said rare hash
> collisions could happen, so sounds like in this HPC case, it is rather easy to
> hit those hash collisons. Thus, need to deal with that instead?

As all of those seem to be the same class of process I suspect it is
more likely that many processes are hitting the page fault on the same
file page. E.g. a code/library.

> 3) The commit 62906027091f ("mm: add PageWaiters indicating tasks are waiting
> for a page bit") mentioned that,
> 
> "Putting two bits in the same word opens the opportunity to remove the memory
> barrier between clearing the lock bit and testing the waiters bit, after some
> work on the arch primitives (e.g., ensuring memory operand widths match and
> cover both bits)."
> 
> Do you happen to know if this only happen on powerpc?

I have only seen this single instance on that machine. I do not think
this is very much HW specific but ppc platform is likely more prone to
that. Just think of the memory itself. Each memory block is notified via
udev and ppc has very small memblocks (16M to 256M). X86 will use 2G
blocks on large machines.

> Also, probably need to
> dig out if those memory barrier is still there that could be removed to speed
> up things.

I would be really suprised if memory barriers matter much. It sounds
much more likely that there is the same underlying problem as
11a19c7b099f. There are just too many waiters on the page. The commit
prevents just the hard lockup part of the problem by dropping the lock
and continuing after the bookmark. But, as mentioned in the changelog,
cond_resched is not really an option because this path is called from
atomic context as well. So !PREEMPT kernels are still in the same boat.

I might have misunderstood something, of course, and would like to hear
where is my thinking wrong.
-- 
Michal Hocko
SUSE Labs
