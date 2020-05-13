Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678BDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0709D2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589393740;
	bh=DRVgA+6vHSXA9HT1ILwpPT8oWoxmN3Nwo5ztWxLd0w8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JeevsNiLIDXltBsWo/wY5FzOmqsbEI0u681Mf9EFS8zYO9BHvVnLf8s9Xjxe5ZJc7
	 DnE2drAYt+Xtdf4nr/uegT68cN1MZ4mgFU+hkD3UbG49KOfRnB/UasOnaSRWpRvKuW
	 Usq5obj4n1p9cXYqnn94ES4OGMRfm/cplSA6mTQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbgEMSPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733175AbgEMSPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:15:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3842020659;
        Wed, 13 May 2020 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589393738;
        bh=DRVgA+6vHSXA9HT1ILwpPT8oWoxmN3Nwo5ztWxLd0w8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B4HiprMPYKY2LGIXSa2C3vRE/sysCHRAaJSHwpyKXRu0YO6jGfjBkXNbgYGNOZzNV
         JrhxliQAfAZhA9Qv3L99pwbUh2HPLZIcPO6OWlwRDn7WeMlzFLXdHdtldjKMl0HAPA
         6Bgh3UG+ARH+NElpOIf30gMishdIvXmEnd+RprD8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5B59E352352C; Wed, 13 May 2020 11:15:37 -0700 (PDT)
Date:   Wed, 13 May 2020 11:15:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 00/10] rcu: Allow a CPU to leave and reenter NOCB state
Message-ID: <20200513181537.GS2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:04PM +0200, Frederic Weisbecker wrote:
> This is a necessary step toward making nohz_full controllable through
> cpuset. Next step should be to allow a CPU to be nocb even if it wasn't
> part of the nocb set on boot.
> 
> The core design of this set is mostly based on suggestions from Paul
> of course.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/nohz
> 
> HEAD: 31cb4ee9da4e9cc6314498ff22d83f0d872b1a88

Very cool!!!  A few comments on individual commits on a quick first
scan, and more later.

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (10):
>       rcu: Directly lock rdp->nocb_lock on nocb code entrypoints
>       rcu: Use direct rdp->nocb_lock operations on local calls
>       rcu: Make locking explicit in do_nocb_deferred_wakeup_common()
>       rcu: Implement rcu_segcblist_is_offloaded() config dependent
>       rcu: Remove useless conditional nocb unlock
>       rcu: Make nocb_cb kthread parkable
>       rcu: Temporarily assume that nohz full CPUs might not be NOCB
>       rcu: Allow to deactivate nocb on a CPU
>       rcu: Allow to re-offload a CPU that used to be nocb
>       rcu: Nocb (de)activate through sysfs
> 
> 
>  include/linux/rcu_segcblist.h |   2 +
>  include/linux/rcupdate.h      |   4 ++
>  kernel/cpu.c                  |  23 +++++++
>  kernel/rcu/rcu_segcblist.c    |   6 +-
>  kernel/rcu/rcu_segcblist.h    |   8 ++-
>  kernel/rcu/tree.c             |  24 +++----
>  kernel/rcu/tree.h             |   2 +-
>  kernel/rcu/tree_plugin.h      | 149 ++++++++++++++++++++++++++++++++++--------
>  8 files changed, 172 insertions(+), 46 deletions(-)
