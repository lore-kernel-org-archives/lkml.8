Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5865C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7E20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOih5r5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCIPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbgCIPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583767177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/SV7acAIkFFySVIGC5SqbEA3QLMLQnR0tuQ2YopQFU=;
        b=BOih5r5m6/VFe/HqI3k2xnN9ZbmVx9SLSnepGY430GBJHVkyYeBSqe04O8Praw3h20PFhr
        bPVyT3ixfldrIZV45syxFcEaiwO73+2iZTJ/QvHuv5yQuPV9zZb+ZthwaEtvAHYz8lKF0R
        CjZ+s5/BGhDA/mY+cvoBem9QPd0691g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-7NrhzbGVMXKSdZMTxRwW7A-1; Mon, 09 Mar 2020 11:19:35 -0400
X-MC-Unique: 7NrhzbGVMXKSdZMTxRwW7A-1
Received: by mail-wm1-f71.google.com with SMTP id x7so923435wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/SV7acAIkFFySVIGC5SqbEA3QLMLQnR0tuQ2YopQFU=;
        b=hRzcqIs9GhVGoRiDOZNld4j7AhhA9ohn2PcHQCBPRyAlHbm9JbAxj+PDFh4gmVqcw5
         5GqAUc8sik7gEAlVxU+FllS4hUnCScK/pMnqyGIbDudsn+YZqv3yLoNt1Dd8rugijSiV
         hpt9egJiCcnKk8PxDgume9UPOrtkCGv30Wd/PJjthZJgT2o7A6wDLvh89JOX7xiJmXGW
         4QBLGa7TUA1RrlA0YOlEUrlxMWRkd2hwUmy1PH4yIvZnjeYBY+DdjE4LakjIB1DKvsfZ
         Gsuai2caQ8Q5NbLnWpUpMMo5dUpjU1FZQPGH+9bwrGv2fTQhNUC0oKoVC9AGbaYvXMTF
         /bmA==
X-Gm-Message-State: ANhLgQ0aZgJ4baW0WHFOPvyqhQheo43taEFfYYIVzL8fMp+9LrDFdLiF
        XJUB1EBvbVlg2yI9gCekBJgkZcZmrBJD34oqrTCJEwLeNnQE7ZwAyhKlEhblVPFeKVRRuR6SyEu
        X/uyMARoN81ZLeGKl2FiQFMLn
X-Received: by 2002:adf:e98f:: with SMTP id h15mr22025414wrm.263.1583767174026;
        Mon, 09 Mar 2020 08:19:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupWYccqwQBjzSfnUgk4+BX0LlUz3VDK06jTEhXknfwI3x2Zp+MMN6uNViGZIUpuFxVlxzn9g==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr22025397wrm.263.1583767173814;
        Mon, 09 Mar 2020 08:19:33 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f127sm26539134wma.4.2020.03.09.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:19:33 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:19:32 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
Message-ID: <20200309151932.6sjwq6bucbu6zsea@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-8-minchan@kernel.org>
 <2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz>
 <20200306134146.mqiyvsdnqty7so53@butterfly.localdomain>
 <a63768c1-3959-563b-376b-1d8d90d79b41@suse.cz>
 <20200309131117.anvyjszaigpoz2kp@butterfly.localdomain>
 <20200309150815.GR8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309150815.GR8447@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:08:15PM +0100, Michal Hocko wrote:
> On Mon 09-03-20 14:11:17, Oleksandr Natalenko wrote:
> > On Fri, Mar 06, 2020 at 05:08:18PM +0100, Vlastimil Babka wrote:
> [...]
> > > Dunno, it's nice to react to signals quickly, for any proces that gets them, no?
> > 
> > So, do you mean something like this?
> > 
> > ===
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 363ec8189561..b39c237cfcf4 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -849,7 +849,8 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
> >  	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
> >  		if (ksm_test_exit(vma->vm_mm))
> >  			break;
> > -		if (signal_pending(current))
> > +		if (signal_pending(current) ||
> > +		    signal_pending(rcu_dereference(vma->vm_mm->owner)))
> >  			err = -ERESTARTSYS;
> >  		else
> >  			err = break_ksm(vma, addr);
> > ===
> 
> This is broken because mm might be attached to different tasks.
> AFAIU this check is meant to allow quick backoff of the _calling_
> process so that it doesn't waste time when the context is killed
> already. I do not understand why should we care about any other context
> here? What is the actual problem this would solve?

I agree with you, but still trying to understand what does Vlastimil mean
:).

> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

