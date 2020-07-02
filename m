Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8107AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9E21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593709987;
	bh=rTb8ZTPuq3O/PqCDYSVVh++esn5oPd8Xgy6aOrLB7ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FVzGmdjK2E45WAENckM65NgdQTfC8rXc/64yfY7sOI5E9WUpzFCQ+G3yzQOUqfx2d
	 D6rpMkJfZ6Ntz8cx2avLO77YXkPb5pLhaKd7cvAEeBS3LZzjmB5HuqMqtBpP+231to
	 6y+bZRX7RfPJ9V15PEADySjWcO1OdsYP+SuCIBJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGBRNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:13:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41622 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgGBRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:13:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id e22so24748166edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVnE4dgvyAySr2AFaA3khkVH7tNEvr0JK5jKeXH+JQw=;
        b=E88RV0GJ4qfH3ZZ18t4A0aou6wY4Spn0IogKeSbet7ghWERlp3LVTR3KI66YmcbMVV
         bBbZQ4089uwviSUww5XjCFvmRkuC+aRCvfzeiR/L84tv2hsX/bmVKEGNJDq3V6o/l+nW
         bXMqcIIGZppAeLObyGemvQ6njzyUoeD27YTIpnViih2qMbZgtEHeF8KlbTz7SGZSnH6s
         416pSHrwASpqBZRDy6Iq3ND7WJHAaFWeAO8FaKIwXa7/Qq8DnDdeO+X5/5dJwQgy4O7r
         VTRe0LvQQfwe8zWmam2cHnqczl8Ky9VP2mPq8+d6W/wjoAxqEaNuijWyNi5g2Jlb2RvB
         1yzg==
X-Gm-Message-State: AOAM532URzdrj92TWLYVu4xwcuHBt9duhBaKTavbdwbmDT5/7hwFkf0V
        mKA6vPLasdzwnJMYWPEHZwQ=
X-Google-Smtp-Source: ABdhPJzsx3bO5yi0V/ckWa7Vrn10ZB0zUEKO/SIIlR9h4BC7fL/R/0EN4AXZgNcI++/I6s3g461IIw==
X-Received: by 2002:aa7:c50e:: with SMTP id o14mr36265439edq.168.1593709983439;
        Thu, 02 Jul 2020 10:13:03 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id x4sm7204449eju.2.2020.07.02.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 10:13:02 -0700 (PDT)
Date:   Thu, 2 Jul 2020 19:13:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702171302.GK18446@dhcp22.suse.cz>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
 <20200702163738.GA106423@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702163738.GA106423@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-07-20 09:37:38, Roman Gushchin wrote:
> On Thu, Jul 02, 2020 at 06:22:02PM +0200, Michal Hocko wrote:
> > On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> > [...]
> > > >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> > > From: Roman Gushchin <guro@fb.com>
> > > Date: Wed, 1 Jul 2020 11:05:32 -0700
> > > Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> > > 
> > > Historically the kernel memory accounting was an opt-in feature, which
> > > could be enabled for individual cgroups. But now it's not true, and
> > > it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> > > user has at least one non-root memory cgroup, the kernel memory
> > > accounting is on. So in most setups it's either always on (if memory
> > > cgroups are in use and kmem accounting is not disabled), either always
> > > off (otherwise).
> > > 
> > > memcg_kmem_enabled() is used in many places to guard the kernel memory
> > > accounting code. If memcg_kmem_enabled() can reverse from returning
> > > true to returning false (as now), we can't rely on it on release paths
> > > and have to check if it was on before.
> > > 
> > > If we'll make memcg_kmem_enabled() irreversible (always returning true
> > > after returning it for the first time), it'll make the general logic
> > > more simple and robust. It also will allow to guard some checks which
> > > otherwise would stay unguarded.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  mm/memcontrol.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 50ae77f3985e..2d018a51c941 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> > >  	objcg->memcg = memcg;
> > >  	rcu_assign_pointer(memcg->objcg, objcg);
> > >  
> > > -	static_branch_inc(&memcg_kmem_enabled_key);
> > > +	if (!memcg_kmem_enabled())
> > > +		static_branch_inc(&memcg_kmem_enabled_key);
> > 
> > Wouldn't be static_branch_enable() more readable?
> 
> Agree, will change, add reported-by and tested-by tags and resend.
> Thanks!

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> Btw, don't we wanna to change memcg_kmem_enabled() definition
> from static_branch_unlikely() to static_branch_likely()?

Honestly, I do not know what would be the impact but considering kmem
is enabled unless explicitly disabled these days then likely sounds more
logical from reading POV. I do not think that early allocations until
the first memcg is created is the case to optimize for.
Worth a separate patch I guess.

-- 
Michal Hocko
SUSE Labs
