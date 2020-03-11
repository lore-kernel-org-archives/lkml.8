Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C2C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3120691
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYpp36/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgCKTpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:45:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40232 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgCKTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:45:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so1564076plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nFRs9bK23pbJQXC6bUj6mkbtL51dUeEnYQnX4EaW7/o=;
        b=oYpp36/HyX8lIYTEX+wvxIJ0e83Ge2gcbE6GFr5zkNlm4gw0jUtfJ0IpGhGQxHIpcF
         Yqo2psLJ2Ksv5G42JEowpaGmxcuoJrGVHqUikPBEGqAM67uMLrulwf1wrJ+yjEtVoaar
         XPWlknhaLrQf7UxdZpnQsQbRc3tllMOhtsPkspavbOGpxC6uaB0KZDB0wtmedoMTEiFR
         yg+zfAQvWOe/udO2+kRD0J3tFTcjhIfciRb2d0WC3J39Th30tdSQ2JJuBiZmqGJJmXvT
         KUhvpStha+ELIksu5T7IaC3kZoNVKOJNAdlOF/Yp8zPzfiYaWjUrjZ4Y09kdlomVKQ57
         Etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nFRs9bK23pbJQXC6bUj6mkbtL51dUeEnYQnX4EaW7/o=;
        b=Kjx42jUlWs2NGh8H80gygXuyJ2v+k/XZouvqNAxv4xh534nWM1AbEyyJ3jTKxYeN6b
         r0Xq9sHzApC3h7Uryo3LRxz2wPqpuTTe8YcFrudwOAITiyck6mXSLZ/XYuGZOSBiHVDs
         oqACk6WmlQfi7Gxufk2dAy8rknMJwFM4Mi2RwM1Vczloelehb8zJ0xGmDeWmWCaWCWU2
         1puyw9vCMyRsQRW0Neq7J70ExWAycQDppQYgf0GsFKXkw9nlTD2XxeEP0LgHZxZILcE2
         ByJWek2MoOYouBqFFm5+NuYybLZnFvnxkmxR9HN+FFUNX6NJPhaR9DXjPDVIzOKgDokP
         qwRA==
X-Gm-Message-State: ANhLgQ2WaDg2kKjPfddY/OxauGy+qGCnTt7p5D9casVMiRPovKkmBXHa
        6HQWYHM3XtlXCrYgyV7Wi/g5zw==
X-Google-Smtp-Source: ADFU+vvqdY78yHScE4P7paO+WdY5n+XAJZKUa2HXsu65btUXaSDv4nu/HBdiBfww9RdqwwTfy0TQMg==
X-Received: by 2002:a17:90b:3888:: with SMTP id mu8mr318609pjb.33.1583955941766;
        Wed, 11 Mar 2020 12:45:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a6sm5853180pfb.104.2020.03.11.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:45:40 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:45:40 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <20200311082736.GA23944@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <20200310221019.GE8447@dhcp22.suse.cz> <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com> <20200311082736.GA23944@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Michal Hocko wrote:

> > > > When a process is oom killed as a result of memcg limits and the victim
> > > > is waiting to exit, nothing ends up actually yielding the processor back
> > > > to the victim on UP systems with preemption disabled.  Instead, the
> > > > charging process simply loops in memcg reclaim and eventually soft
> > > > lockups.
> > > > 
> > > > Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> > > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> > > > CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> > > > RIP: 0010:shrink_lruvec+0x4e9/0xa40
> > > > ...
> > > > Call Trace:
> > > >  shrink_node+0x40d/0x7d0
> > > >  do_try_to_free_pages+0x13f/0x470
> > > >  try_to_free_mem_cgroup_pages+0x16d/0x230
> > > >  try_charge+0x247/0xac0
> > > >  mem_cgroup_try_charge+0x10a/0x220
> > > >  mem_cgroup_try_charge_delay+0x1e/0x40
> > > >  handle_mm_fault+0xdf2/0x15f0
> > > >  do_user_addr_fault+0x21f/0x420
> > > >  page_fault+0x2f/0x40
> > > > 
> > > > Make sure that something ends up actually yielding the processor back to
> > > > the victim to allow for memory freeing.  Most appropriate place appears to
> > > > be shrink_node_memcgs() where the iteration of all decendant memcgs could
> > > > be particularly lengthy.
> > > 
> > > There is a cond_resched in shrink_lruvec and another one in
> > > shrink_page_list. Why doesn't any of them hit? Is it because there are
> > > no pages on the LRU list? Because rss data suggests there should be
> > > enough pages to go that path. Or maybe it is shrink_slab path that takes
> > > too long?
> > > 
> > 
> > I think it can be a number of cases, most notably mem_cgroup_protected() 
> > checks which is why the cond_resched() is added above it.  Rather than add 
> > cond_resched() only for MEMCG_PROT_MIN and for certain MEMCG_PROT_LOW, the 
> > cond_resched() is added above the switch clause because the iteration 
> > itself may be potentially very lengthy.
> 
> Was any of the above the case for your soft lockup case? How have you
> managed to trigger it? As I've said I am not against the patch but I
> would really like to see an actual explanation what happened rather than
> speculations of what might have happened. If for nothing else then for
> the future reference.
> 

Yes, this is how it was triggered in my own testing.

> If this is really about all the hierarchy being MEMCG_PROT_MIN protected
> and that results in a very expensive and pointless reclaim walk that can
> trigger soft lockup then it should be explicitly mentioned in the
> changelog.

I think the changelog clearly states that we need to guarantee that a 
reclaimer will yield the processor back to allow a victim to exit.  This 
is where we make the guarantee.  If it helps for the specific reason it 
triggered in my testing, we could add:

"For example, mem_cgroup_protected() can prohibit reclaim and thus any 
yielding in page reclaim would not address the issue."
