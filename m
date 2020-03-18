Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D16C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FCE20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zxh3TAA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCRVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:40:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgCRVkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:40:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so198661pfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tM1vSIKwCnlZUi/xGFebQI1FUo5MhWvpnsIJnM9Uk1Y=;
        b=Zxh3TAA2TCweDaW7C+E0Yv8wPsabF/oNuLlphDFoxMBH9tdjRpxhTdsjLSucayZibU
         u4SwgpHEZAkrvbn7UUnqkCu9OOoPkoMeeSWm+pMvCcbT4vDmMZ5hjW7yhshioxFdTQLI
         VpWe/E+Mfz+DRBCt2L1VASK1FpgzLl4aKzAibEMySdN1r/sOyZQqUhDGgiLvLkGfzxz4
         3Nd6KpSVahsfqxARdCtadmC/2ayZab4uuGcXx+EYX2oyKzgTJYYwMgGuusoWC3Ig0pHl
         Aqfhh/hcuLjjyiYsn9dYLK65TJI+rSbbQFsaoKyREY8EJfGXjzqaR/dUjnSjnqSX9/em
         ZmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tM1vSIKwCnlZUi/xGFebQI1FUo5MhWvpnsIJnM9Uk1Y=;
        b=HkEO7MIWuTty/yZRcI/CQ+SV5n8jQizw7/dnPdH6n6x4D6lgiiXVKqPxSOKuXiaDKm
         qGaQJGUwGkcyB/e771AuFQr+2PwVS4O5TIAKIuIR94LTFrMofF/3TqkGNEC+ILL9OOGM
         lrrvAJGVI7VNVnoBs1SXwFwVHnm4wkCLSDO3YfDypoi/sRRL+dkL4MzK6pqxn0ArAAMp
         Mdd6EM+9+mm4U5uvt8bywkQohc0gunyOgPUTQ2ZP1PzS8dViPOj818OiwZVuMP4gxrZ0
         INiBOfKAzASyecHGGQiHltr3PAdmqtqI8JSIPbluKcvHIuh46PdKy/cW/8NBPruiPvUN
         L86Q==
X-Gm-Message-State: ANhLgQ0AZ87y+GYji9c9gzy3P4NUE7dmOnHPuV3NyV92mp/BfgywXl8e
        C4cKDEftPYfhkcoZucUKMJmdDg==
X-Google-Smtp-Source: ADFU+vu2wFsjtdzyFMMql6gFNUPR6++F1kzN2nAhJ4bCAj4cn4r4N8RG6OE6fTq1rCyAtJqRlhmSCw==
X-Received: by 2002:aa7:96a6:: with SMTP id g6mr364347pfk.88.1584567647456;
        Wed, 18 Mar 2020 14:40:47 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q9sm53027pgs.89.2020.03.18.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:40:46 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:40:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <20200318094219.GE21362@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003181437270.70237@chino.kir.corp.google.com>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com> <202003170318.02H3IpSx047471@www262.sakura.ne.jp> <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com> <20200318094219.GE21362@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, Michal Hocko wrote:

> > When a process is oom killed as a result of memcg limits and the victim
> > is waiting to exit, nothing ends up actually yielding the processor back
> > to the victim on UP systems with preemption disabled.  Instead, the
> > charging process simply loops in memcg reclaim and eventually soft
> > lockups.
> 
> It seems that my request to describe the setup got ignored. Sigh.
> 
> > Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, 
> > anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB 
> > oom_score_adj:0
> > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> > CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> > RIP: 0010:shrink_lruvec+0x4e9/0xa40
> > ...
> > Call Trace:
> >  shrink_node+0x40d/0x7d0
> >  do_try_to_free_pages+0x13f/0x470
> >  try_to_free_mem_cgroup_pages+0x16d/0x230
> >  try_charge+0x247/0xac0
> >  mem_cgroup_try_charge+0x10a/0x220
> >  mem_cgroup_try_charge_delay+0x1e/0x40
> >  handle_mm_fault+0xdf2/0x15f0
> >  do_user_addr_fault+0x21f/0x420
> >  page_fault+0x2f/0x40
> > 
> > Make sure that once the oom killer has been called that we forcibly yield 
> > if current is not the chosen victim regardless of priority to allow for 
> > memory freeing.  The same situation can theoretically occur in the page 
> > allocator, so do this after dropping oom_lock there as well.
> 
> I would have prefered the cond_resched solution proposed previously but
> I can live with this as well. I would just ask to add more information
> to the changelog. E.g.

I'm still planning on sending the cond_resched() change as well, but not 
as advertised to fix this particular issue per Tetsuo's feedback.  I think 
the reported issue showed it's possible to excessively loop in reclaim 
without a conditional yield depending on various memcg configs and the 
shrink_node_memcgs() cond_resched() is still appropriate for interactivity 
but also because the iteration of memcgs can be particularly long.

> "
> We used to have a short sleep after the oom handling but 9bfe5ded054b
> ("mm, oom: remove sleep from under oom_lock") has removed it because
> sleep inside the oom_lock is dangerous. This patch restores the sleep
> outside of the lock.

Will do.

> "
> > Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Tested-by: Robert Kolchmeyer <rkolchmeyer@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/memcontrol.c | 2 ++
> >  mm/page_alloc.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1576,6 +1576,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	 */
> >  	ret = should_force_charge() || out_of_memory(&oc);
> >  	mutex_unlock(&oom_lock);
> > +	if (!fatal_signal_pending(current))
> > +		schedule_timeout_killable(1);
> 
> Check for fatal_signal_pending is redundant.
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
