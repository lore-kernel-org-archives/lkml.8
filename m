Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F17C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2D2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582900673;
	bh=XFQsfx12dItcvA+iLjesdCvT7+o8NO3ArdHt415SfWM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1n4rMMvEtUoUidglopIPdf2eLTN5+/KtpN3IznlutY2uWcHjnEFiaJiqdQeR+1z/j
	 mqEHvVFXmX6ihEz2wTrlJ9gDTYDcIN9B2zdjiNGNCo2G3e1OicgQl+TSJAC6qI3p4v
	 uCY4VgDka8JsY1DzKmJez3+C1lk0eKbmmRMRMgt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgB1Ohw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgB1Ohw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:37:52 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749682468E;
        Fri, 28 Feb 2020 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582900671;
        bh=XFQsfx12dItcvA+iLjesdCvT7+o8NO3ArdHt415SfWM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jve5DvL8xVAVQPVOWdn8gjP7CetTc6P8sza+3lCwxn9DlPv97bm0I9+U0+r2pZ6d3
         FGIe9aPjqrmsHQ4b6hOLsJxPVI69I+m5yl5IWiDmKTeoK7SVZZ02qaPaHrqba3Jabd
         MhqtaVrYhc4oX6xrdUH5x4QRepybThWTEB4UCgV4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1A5DB35226D1; Fri, 28 Feb 2020 06:37:51 -0800 (PST)
Date:   Fri, 28 Feb 2020 06:37:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     madhuparnabhowmik10@gmail.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200228143751.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
 <20200228142122.GA97131@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228142122.GA97131@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 09:21:22AM -0500, Joel Fernandes wrote:
> On Fri, Feb 28, 2020 at 02:54:51PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch default enables CONFIG_PROVE_RCU_LIST option with
> > CONFIG_PROVE_RCU for RCU list lockdep debugging.
> > 
> > With this change, RCU list lockdep debugging will be default
> > enabled in CONFIG_PROVE_RCU=y kernels.
> > 
> > Most of the RCU users (in core kernel/, drivers/, and net/
> > subsystem) have already been modified to include lockdep
> > expressions hence RCU list debugging can be enabled by
> > default.
> > 
> > However, there are still chances of enountering
> > false-positive lockdep splats because not everything is converted,
> > in case RCU list primitives are used in non-RCU read-side critical
> > section but under the protection of a lock. It would be okay to
> > have a few false-positives, as long as bugs are identified, since this
> > patch only affects debugging kernels.
> > 
> > Co-developed-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you both!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > ---
> >  kernel/rcu/Kconfig.debug | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 4aa02eee8f6c..ec4bb6c09048 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -9,15 +9,10 @@ config PROVE_RCU
> >  	def_bool PROVE_LOCKING
> >  
> >  config PROVE_RCU_LIST
> > -	bool "RCU list lockdep debugging"
> > -	depends on PROVE_RCU && RCU_EXPERT
> > -	default n
> > +	def_bool PROVE_RCU
> >  	help
> > -	  Enable RCU lockdep checking for list usages. By default it is
> > -	  turned off since there are several list RCU users that still
> > -	  need to be converted to pass a lockdep expression. To prevent
> > -	  false-positive splats, we keep it default disabled but once all
> > -	  users are converted, we can remove this config option.
> > +	  Enable RCU lockdep checking for list usages. It is default
> > +	  enabled with CONFIG_PROVE_RCU.
> >  
> >  config TORTURE_TEST
> >  	tristate
> > -- 
> > 2.17.1
> > 
