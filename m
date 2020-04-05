Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D6C2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86A62070E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586056236;
	bh=kIx1RwDLGEcqPPIAxfxHLABlBLsQ0tfPVc+AsI9wId0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gxOOGt/JGYPVe9/vPFHe3T6ZwiB1JrxOgldUwHyOhN8dUrnl/vBQlJDunAAHN7tYG
	 Obfp75QDSwDoj0s8FOYs3kD4g4ZqexDXPPeOewsV0DhicT9AZM1wUUzoxxy7rfA/Rj
	 0DYoPbwEJ/AnUp27gssAMDidbcg7akUvWr2/a4MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgDEDKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDEDKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:10:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3BE206A3;
        Sun,  5 Apr 2020 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586056235;
        bh=kIx1RwDLGEcqPPIAxfxHLABlBLsQ0tfPVc+AsI9wId0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pXamp4nkiQoy7exHotB/mfI+a4tKPTV91qXOXpv8MfNMLJkn01chX2ranfvTsUgKS
         /s9oyOXrHV1ZmEiRpxBLTDtrpmwgfvZmHlaApCA0mI/JmY9aFEzAZT0n1i+6WbpZtk
         G1yBZlyKP6BALtvym17XP6sLvzJ1cy2O2Sxyd/r8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DCD3235227F2; Sat,  4 Apr 2020 20:10:34 -0700 (PDT)
Date:   Sat, 4 Apr 2020 20:10:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20200405031034.GX19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200405114959.335eae46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405114959.335eae46@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 11:49:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> kernel/trace/ftrace.c: In function 'ftrace_shutdown':
> kernel/trace/ftrace.c:2924:3: error: implicit declaration of function 'synchronize_rcu_tasks_rude'; did you mean 'synchronize_rcu_tasks'? [-Werror=implicit-function-declaration]
>  2924 |   synchronize_rcu_tasks_rude();
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |   synchronize_rcu_tasks
> 
> Caused by commit
> 
>   59377f3e06b8 ("ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()")
> 
> synchronize_rcu_tasks_rude() is only declared when
> CONFIG_TASKS_RCU_GENERIC is defined.
> 
> I have reverted that commit for today.
> 
> Just asking: are all the commits currently in the rcu tree actually
> intended for v5.7?

My bad!  I have moved rcu/next to where it need to be for the duration
of the merge window.  Please accept my apologies for the hassle.

							Thanx, Paul
