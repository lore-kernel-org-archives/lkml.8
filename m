Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6817C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E62215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583885952;
	bh=y5QJ9GXWSnz15V7XZRVYJqb5uqwEux6PilkXReQ4U1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nzaFpZqNM/pvC6OwKPHo4+V2/WqaYavC5NrBy37T0SaXQT35vIweDeCwJTY1TKYkR
	 BTDNbLQt99ieBTWo8Rqbc0d/zl+6XwE3ptejeRVqVon973Dvr87tBe6/k9GFcHdXVf
	 bA7TPqaFNndnTQQd2o7pKvn+u0JHOY5b/lhCZxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCKASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgCKASD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:18:03 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4334222C4;
        Wed, 11 Mar 2020 00:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583885883;
        bh=y5QJ9GXWSnz15V7XZRVYJqb5uqwEux6PilkXReQ4U1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pO7/4cHWR3qTj0bznJ7188fG64qaOSB88v7476iEvv3KbMspuOvOFmbEqLGsOanQ1
         9/io2pTiqypzmUKiZ/4F0cXTFv2UUPnnwJQ9foCp+4eBKERrzND7jG8Aw8qFxSU4U3
         2XbTIWxreNknyUIg94KcQqpX/rci92Nfcn53fLfU=
Date:   Tue, 10 Mar 2020 17:18:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
Message-Id: <20200310171802.128129f6817ef3f77d230ccd@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 14:39:48 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> When a process is oom killed as a result of memcg limits and the victim
> is waiting to exit, nothing ends up actually yielding the processor back
> to the victim on UP systems with preemption disabled.  Instead, the
> charging process simply loops in memcg reclaim and eventually soft
> lockups.
> 
> Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> RIP: 0010:shrink_lruvec+0x4e9/0xa40
> ...
> Call Trace:
>  shrink_node+0x40d/0x7d0
>  do_try_to_free_pages+0x13f/0x470
>  try_to_free_mem_cgroup_pages+0x16d/0x230
>  try_charge+0x247/0xac0
>  mem_cgroup_try_charge+0x10a/0x220
>  mem_cgroup_try_charge_delay+0x1e/0x40
>  handle_mm_fault+0xdf2/0x15f0
>  do_user_addr_fault+0x21f/0x420
>  page_fault+0x2f/0x40
> 
> Make sure that something ends up actually yielding the processor back to
> the victim to allow for memory freeing.  Most appropriate place appears to
> be shrink_node_memcgs() where the iteration of all decendant memcgs could
> be particularly lengthy.
>

That's a bit sad.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		unsigned long reclaimed;
>  		unsigned long scanned;
>  
> +		cond_resched();
> +
>  		switch (mem_cgroup_protected(target_memcg, memcg)) {
>  		case MEMCG_PROT_MIN:
>  			/*


Obviously better, but this will still spin wheels until this tasks's
timeslice expires, and we might want to do something to help ensure
that the victim runs next (or soon)?

(And why is shrink_node_memcgs compiled in when CONFIG_MEMCG=n?)

