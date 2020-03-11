Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBEC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8600420749
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEjOycvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCKTiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:38:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40746 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgCKTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:38:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so1738740pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zb5q/Mu4Y05A8mwi2SFVQb8nWna0MTPdNN6cb7H8VpE=;
        b=gEjOycvx4YQW2uEn6K7qwHEwfNAGZYNaSKbDvy1IVY56seaG5DAmfh9kBhmrYGMXqs
         ZqlKVr1XsUWCWptcndhsmwO+Mtiq+tcdxEPjddRld13v5IEbCsKSLYc3mqVr/LB9UbYs
         zboqVnO8hTlArH7Wi/Z0HcqJP/jrr5og7GZYWIP5h64jIuXT5+E+j66XWTvNUP1/kiLD
         OC/jyASsnhZOhK4+g4oHDSRhZYjk9f7n9t1ZTyLlA1Og3ObGHHgXxcfjPOPJo1pyeX4K
         NJzwpMsOguK2wm7Z1Xgr8sqdJSnMYtAK3lVEKy3JGL3JELhaYj4cihBUmV6I1EWIAUcP
         sNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zb5q/Mu4Y05A8mwi2SFVQb8nWna0MTPdNN6cb7H8VpE=;
        b=V4LXdfkBRM8qHTiQSBlMdWmZ7SN5EJiUwHQNsayFUCjOMe6POUQAtaPu2dYxUiWG8z
         oB+FBoLCN9uovF9ASrzmwLSyOk1x8ZLqsRzvJwKshT25FWSyjX51XBvpfRH8ZPbnZfrE
         JERNMD5+fvDnuWbSnqTUXLNbJIoNOigblGSU69KvKfvj8VnxyShJ3QwqMdkRzrzxfUO2
         YlPRmSHrJuU6TnsWO2HfaK16j+HQ/EqIDhodDxLiVhlGxzGXWVQYNILZhW1NlfPo5pWU
         8oU5+pt8aGLxnmJ6nf2pYI+BghpaMlH9cHT5NBW8BRojZlvasYcnFRd8zQRRS3bg+yph
         F0og==
X-Gm-Message-State: ANhLgQ1V+TNhYN1X+BTQNJdLQbKxUAfG1yb3GVEHAUapTzJikdvWnr+b
        zczlxxzCnn5h6tPGvgIvxfC+9Q==
X-Google-Smtp-Source: ADFU+vu4w2Fjd9qLpxvfjtML0AhQNSJS4jd+sFLDO6cpsSiLPD5qfQgTvXBo2xt9ibO4JgPeFVVIxg==
X-Received: by 2002:a62:5cc1:: with SMTP id q184mr2272743pfb.259.1583955489598;
        Wed, 11 Mar 2020 12:38:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x72sm13897760pfc.156.2020.03.11.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:38:08 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:38:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <7a6170fc-b247-e327-321a-b99fb53f552d@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003111235080.171292@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp> <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com>
 <7a6170fc-b247-e327-321a-b99fb53f552d@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Tetsuo Handa wrote:

> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >>>  		unsigned long reclaimed;
> >>>  		unsigned long scanned;
> >>>  
> >>> +		cond_resched();
> >>> +
> >>
> >> Is this safe for CONFIG_PREEMPTION case? If current thread has realtime priority,
> >> can we guarantee that the OOM victim (well, the OOM reaper kernel thread rather
> >> than the OOM victim ?) gets scheduled?
> >>
> > 
> > I think it's the best we can do that immediately solves the issue unless 
> > you have another idea in mind?
> 
> "schedule_timeout_killable(1) outside of oom_lock" or "the OOM reaper grabs oom_lock
> so that allocating threads guarantee that the OOM reaper gets scheduled" or "direct OOM
> reaping so that allocating threads guarantee that some memory is reclaimed".
> 

The cond_resched() here is needed if the iteration is lengthy depending on 
the number of descendant memcgs already.

schedule_timeout_killable(1) does not make any guarantees that current 
will be scheduled after the victim or oom_reaper on UP systems.

If you have an alternate patch to try, we can test it.  But since this 
cond_resched() is needed anyway, I'm not sure it will change the result.

> > 
> >>>  		switch (mem_cgroup_protected(target_memcg, memcg)) {
> >>>  		case MEMCG_PROT_MIN:
> >>>  			/*
> >>>
> >>
> 
> 
