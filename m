Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62E206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591116312;
	bh=W1y1Vfa/emqsgezcdtT8y57qWVzPW5hHUrUIvUPR1GY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jDrjPrZgVdTbLvWwjH45HX4n6mHYepIIkk6BzrIT/OIYS2yNxUqH0pAzV7V9OZWlN
	 gFI41Xyp657WIecd6jJp6qkEEH0TDo+bVgQohs3HTvamp9gieSXECUx9SS+X6soP6i
	 m8uNzg08JqGNp3lMCz+LheIQYyowXaKstXK60q94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFBQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBQpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:45:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14B52068D;
        Tue,  2 Jun 2020 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591116310;
        bh=W1y1Vfa/emqsgezcdtT8y57qWVzPW5hHUrUIvUPR1GY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gFA+omXe8z+jHZuGk5h9Cxh+HpdblZmuw0646TgqqnHU4X8qwE4/3fvFqUwynsMw9
         xbLCTxpRSoaIqBrd+A78Tw0QM5xBrDHSJkavYxVgdl+EDdi8TnF0ncvCoMpcm57njS
         aJrOANrZG1ibzEwfaDl7K4dsM0X0h8iXt+7zLr5Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8FAD1352283B; Tue,  2 Jun 2020 09:45:10 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:45:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH 0/5] cleanups
Message-ID: <20200602164510.GH29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200601184552.23128-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601184552.23128-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 07:45:47PM +0100, Jules Irenge wrote:
> 
> Jules Irenge (5):
>   rcu/rcutorture: replace 0 with false
>   rcu: replace 1 with true

I queued these two, thank you!

>   rcu: replace + with |

This one I am not all that excited about, so I am leaving it off.

							Thanx, Paul

>   x86/ftrace: Add annotations for ftrace_arch_code_modify_prepare() and
>     ftrace_arch_code_modify_post_process()
>   sfc: add  missing annotation for efx_ef10_try_update_nic_stats_vf()
> 
>  arch/x86/kernel/ftrace.c        |  2 ++
>  drivers/net/ethernet/sfc/ef10.c |  1 +
>  kernel/rcu/rcutorture.c         |  2 +-
>  kernel/rcu/tree_plugin.h        | 22 +++++++++++-----------
>  kernel/rcu/update.c             |  2 +-
>  5 files changed, 16 insertions(+), 13 deletions(-)
> 
> -- 
> 2.18.2
> 
