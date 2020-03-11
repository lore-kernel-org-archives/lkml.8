Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13983C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05E720848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583915263;
	bh=YA9GhQZV5L6bynEq7gS0i8wlNt1x1Jqt9yMiyPHrT8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x7nrSKEtt4cY2tgriLHazvIvzFIo/mm/yyZoJfl0lgBzFF8AnigtWTeqEDrcQA+h5
	 Ct7PI1U2aL/BENPCrzU596kOuB1jKkHuyS21+FwQ/lotVCNlRz3X46lfLk8OZ5bx1E
	 CfZEc3vshK3bnGz6EyMqMBLTGv24TbdvKcLI0CpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgCKI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:27:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55436 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:27:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so1035489wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/jUgb2WsM9EoAjEAHRyAbPDuMelzLd2J5nybEhmsYU=;
        b=jHuIGIPOTjRCns6e64/dXbYgRrRsDy+pS6K8S4EmExmqKFFbUgBTaLKS4L5ZwUkSzM
         SPQn9Xlo7E6IjBDgvDbIJ+Kb0eaBIU2dSDHtm5jjesh0aZ2ks/HtL8gHNN4l8j4SHcBW
         d/j/znw+ORjHUBrQrpgvdlbuqrqNKDRUuoyIp1OS7n8tTS3t0Mjr+atdWtVNFge92vvo
         MJFqHvO3eUkl4/ZJ+ljSx8qy7T0+MiZyC1VprLhkuzRU+RXTyo5+y1+wiDiKeFQZU6O1
         yV3dTWSzv238IubogBkkJbe0RPjVPd9AV5/OzTr9CbofAuhatDfPnCcnC+VqCdQ0Zr8B
         YJlw==
X-Gm-Message-State: ANhLgQ0dShsrGl9ByBHtY4HExhaOoiJckSJxlgeFeQ9NpPcvdFGFE2Ky
        79mDbRyI7np5NjsORZU6sOU=
X-Google-Smtp-Source: ADFU+vt1rzvjovs9Fqx3ZtwpZNkzPk0A8oKdn7NCmBdaEs2hWB3Vz0N8ji7oL3cMOzx5S1SulIhugw==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr2565466wme.34.1583915258992;
        Wed, 11 Mar 2020 01:27:38 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y184sm7683553wmd.43.2020.03.11.01.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:27:38 -0700 (PDT)
Date:   Wed, 11 Mar 2020 09:27:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200311082736.GA23944@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <20200310221019.GE8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 16:02:23, David Rientjes wrote:
> On Tue, 10 Mar 2020, Michal Hocko wrote:
> 
> > > When a process is oom killed as a result of memcg limits and the victim
> > > is waiting to exit, nothing ends up actually yielding the processor back
> > > to the victim on UP systems with preemption disabled.  Instead, the
> > > charging process simply loops in memcg reclaim and eventually soft
> > > lockups.
> > > 
> > > Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> > > CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> > > RIP: 0010:shrink_lruvec+0x4e9/0xa40
> > > ...
> > > Call Trace:
> > >  shrink_node+0x40d/0x7d0
> > >  do_try_to_free_pages+0x13f/0x470
> > >  try_to_free_mem_cgroup_pages+0x16d/0x230
> > >  try_charge+0x247/0xac0
> > >  mem_cgroup_try_charge+0x10a/0x220
> > >  mem_cgroup_try_charge_delay+0x1e/0x40
> > >  handle_mm_fault+0xdf2/0x15f0
> > >  do_user_addr_fault+0x21f/0x420
> > >  page_fault+0x2f/0x40
> > > 
> > > Make sure that something ends up actually yielding the processor back to
> > > the victim to allow for memory freeing.  Most appropriate place appears to
> > > be shrink_node_memcgs() where the iteration of all decendant memcgs could
> > > be particularly lengthy.
> > 
> > There is a cond_resched in shrink_lruvec and another one in
> > shrink_page_list. Why doesn't any of them hit? Is it because there are
> > no pages on the LRU list? Because rss data suggests there should be
> > enough pages to go that path. Or maybe it is shrink_slab path that takes
> > too long?
> > 
> 
> I think it can be a number of cases, most notably mem_cgroup_protected() 
> checks which is why the cond_resched() is added above it.  Rather than add 
> cond_resched() only for MEMCG_PROT_MIN and for certain MEMCG_PROT_LOW, the 
> cond_resched() is added above the switch clause because the iteration 
> itself may be potentially very lengthy.

Was any of the above the case for your soft lockup case? How have you
managed to trigger it? As I've said I am not against the patch but I
would really like to see an actual explanation what happened rather than
speculations of what might have happened. If for nothing else then for
the future reference.

If this is really about all the hierarchy being MEMCG_PROT_MIN protected
and that results in a very expensive and pointless reclaim walk that can
trigger soft lockup then it should be explicitly mentioned in the
changelog.
-- 
Michal Hocko
SUSE Labs
