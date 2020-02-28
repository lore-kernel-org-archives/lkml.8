Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A4BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725A924695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa9rI8zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgB1J1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:27:04 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51775 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgB1J1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:27:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so1062439pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WD4KhQIFBHT/PFA/OEmB/LQe+eEdIhYypm09Jxknz4s=;
        b=sa9rI8ziPUkx8kByY/alrQW6qNiA1T1Yp3f4t8tHOt039wvywz2RtK8eKKaR1inMWr
         /j2CopilP4klNZm8sXcHJDUYRD9pF4HRY5qkWyVDIVQkGrD7brIwTNra3aMjLVRiGrhN
         vxq7iYS8dcqWjEElixNA+Zy6VqrPl/O8u6kcvNeuKxQabLX91BfRwWXoOsWjMBhTKTqo
         tsEynsKkvr9dezb9jJy2Cz7219FWLX/kwi4AQqRIPCC9zXDbqEU6kluoYOQGNM/Xx37d
         vl4XBwV+OhxI0wL6UrXCdi8ZOyCOEVIKyESOCXvIgmr2G+c80dKvV//NkfWxjsn9xM0F
         kXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WD4KhQIFBHT/PFA/OEmB/LQe+eEdIhYypm09Jxknz4s=;
        b=ZLm8dBu+MhEsaBFo8LI77SZi1g71UQke+fHyF8HT0aUtbhlEWlRjFckZQUr2wuep6z
         KtnXK2gv6b7+1iNmZPCXrqffoehzp3XtbvLEnDau3LKtc69gpykcukzPetDUp24DKEcc
         yPQTxTn538EFwPfWgCuOEDH0jCARW2TNFXAl7uQLaMRx9Eh8Esyoc6z08ZJtFXaIljcW
         omNzkVyNQgOhaDj/bPDWv+1ecWZ6n8kTWHZsg3DvTcgpUf6iVYjpZ+OKgU32zf50d6Sr
         4QCjqXd6G4ARb5oFQAXo8e1J0SGFa+Cz1nysg0gBokAz8ydcG0noseOet9L7REglxB24
         pAUw==
X-Gm-Message-State: APjAAAXdCIXzg10RcikLEE0WjfOgBd0yPqqgeeozPdl27OkZYRYsbDbp
        AoyIUXu+in/rO5LFZUzPYFxQxf4=
X-Google-Smtp-Source: APXvYqzov338uvbQRuXyEDY4zP/6mfLf894cbTA65pspGjv3xpVy5XFeK30hMe6qxK34yiAhhkv3+g==
X-Received: by 2002:a17:902:169:: with SMTP id 96mr3126214plb.74.1582882022749;
        Fri, 28 Feb 2020 01:27:02 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee0:f1c2:74cd:ab46:bb74:a4a3])
        by smtp.gmail.com with ESMTPSA id g12sm9908081pfh.170.2020.02.28.01.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 01:27:02 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 28 Feb 2020 14:56:55 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Enable RCU list lockdep debugging and drop
 CONFIG_PROVE_RCU_LIST
Message-ID: <20200228092655.GA10762@madhuparna-HP-Notebook>
References: <20200227202355.6163-1-madhuparnabhowmik10@gmail.com>
 <20200227211611.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227211611.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:16:11PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 28, 2020 at 01:53:55AM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch drops the CONFIG_PROVE_RCU_LIST option and instead
> > uses CONFIG_PROVE_RCU for RCU list lockdep debugging.
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
> Good idea, but could you please left PROVE_RCU_LIST and "select" it from
> CONFIG_PROVE_RCU instead?  This gets the same effect, but also makes it
> easier to change our minds later if we wish to.  It also makes it easier
> to find the various different types of debugging.
>
Sure, I have sent the patch with these changes.

> For a template, please see how CONFIG_PROVE_LOCKING controls the
> value of CONFIG_PROVE_RCU in kernel/rcu/Kconfig.debug.

Thank you,
Madhuparna
> 
> 							Thanx, Paul
> 
> > ---
> >  include/linux/rculist.h  |  2 +-
> >  kernel/rcu/Kconfig.debug | 11 -----------
> >  2 files changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 63726577c6b8..f517eb421b5e 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -56,7 +56,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >  
> >  #define check_arg_count_one(dummy)
> >  
> > -#ifdef CONFIG_PROVE_RCU_LIST
> > +#ifdef CONFIG_PROVE_RCU
> >  #define __list_check_rcu(dummy, cond, extra...)				\
> >  	({								\
> >  	check_arg_count_one(extra);					\
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 4aa02eee8f6c..5ec3ea4028e2 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -8,17 +8,6 @@ menu "RCU Debugging"
> >  config PROVE_RCU
> >  	def_bool PROVE_LOCKING
> >  
> > -config PROVE_RCU_LIST
> > -	bool "RCU list lockdep debugging"
> > -	depends on PROVE_RCU && RCU_EXPERT
> > -	default n
> > -	help
> > -	  Enable RCU lockdep checking for list usages. By default it is
> > -	  turned off since there are several list RCU users that still
> > -	  need to be converted to pass a lockdep expression. To prevent
> > -	  false-positive splats, we keep it default disabled but once all
> > -	  users are converted, we can remove this config option.
> > -
> >  config TORTURE_TEST
> >  	tristate
> >  	default n
> > -- 
> > 2.17.1
> > 
