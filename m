Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A87C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAA42465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579024711;
	bh=VsShTwZi21AekfCv05LOVOvIqtZ093mN8RWDJF100S4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aL1tlIGitFXoYURqh6f7Y2BSvzzHrIyIsTVBVEc2yKUWuaHvug1AiZAFXYXUDzncs
	 tqE8WcIxgkgobRLqFrq66ifTsfDzyGR5R6g2mKhYXBYNmmCi9ywV5jr78pdtsQUPze
	 kCDsmKN1ks8Lk3LHUKcpy9DXd8o2lMfgaSIBnBN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgANR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANR6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:58:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDE824656;
        Tue, 14 Jan 2020 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579024708;
        bh=VsShTwZi21AekfCv05LOVOvIqtZ093mN8RWDJF100S4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zyrXKLRhzRZ6L3eKqGu0lnMFG75xrsgG3aL0hATtE3/NabMJmmULpJPPKVteBzNTY
         wmm+94/QSUn/n0ZXyr0ACTCzR4vm6OWjqaDmRsyM0olpmckumFXwJD12feUy98TOJp
         5VQx2dsW6CkprSWchPe0N+cgn3RoL3N3Uj9ENa7E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D3A1352278D; Tue, 14 Jan 2020 09:58:28 -0800 (PST)
Date:   Tue, 14 Jan 2020 09:58:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH v2] drivers: char: ipmi: ipmi_msghandler: Pass lockdep
 expression to RCU lists
Message-ID: <20200114175828.GR2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200110164709.26741-1-frextrite@gmail.com>
 <202001121358.YVbD4V9l%lkp@intel.com>
 <20200114030030.GB2559@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114030030.GB2559@workstation-portable>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:30:30AM +0530, Amol Grover wrote:
> On Sun, Jan 12, 2020 at 01:25:58PM +0800, kbuild test robot wrote:
> > Hi Amol,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on char-misc/char-misc-testing]
> > [also build test WARNING on ipmi/for-next arm-soc/for-next v5.5-rc5]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Amol-Grover/drivers-char-ipmi-ipmi_msghandler-Pass-lockdep-expression-to-RCU-lists/20200111-081002
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 16bb7abc4a6b9defffa294e4dc28383e62a1dbcf
> > config: x86_64-randconfig-a003-20200109 (attached as .config)
> > compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from include/linux/export.h:43:0,
> >                     from include/linux/linkage.h:7,
> >                     from include/linux/kernel.h:8,
> >                     from include/linux/list.h:9,
> >                     from include/linux/module.h:12,
> >                     from drivers/char/ipmi/ipmi_msghandler.c:17:
> >    drivers/char/ipmi/ipmi_msghandler.c: In function 'find_cmd_rcvr':
> >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >                             ^
> 
> As mentioned above, RCU_LOCKDEP_WARN macro is called from
> __list_check_rcu with 2 parameters
> 
> 1. !cond && !rcu_read_lock_any_held()
> 2. The message to display incase there is a lockdep warning.
> 
> 
> However, if I pass the lockdep checking condition as:
> 
> list_for_each_entry_rcu(ptr, list, head, lockdep_is_held(&some_lock) || rcu_read_lock_held())

Right, given the _rcu() suffix on the command, the rcu_read_lock_held()
is implied.

> this trickles down to __list_check_rcu and then finally to
> RCU_LOCKDEP_WARN as (here cond is `lockdep_is_held(&some_lock) || rcu_read_lock_held()`):
> 
> RCU_LOCKDEP_WARN(!lockdep_is_held(&some_lock) || rcu_read_lock_held() && !rcu_read_lock_any_held())
> 
> which according to operator precedence (I hopefully got them right)
> would always evaluate to true if we are in an RCU read-side critical
> section (without a lock), and hence, result in a false-positive lockdep
> warning.

It looks that way to me.  But why not actually try it out?  After all,
only the running system knows for sure.  And there might be some trick
that we are both missing.

> This could be easily solved by putting `cond` inside brackets as it is
> correctly done in RCU_LOCKDEP_WARN macro but not in __list_check_rcu
> macro. Is that so, or did I miss something?

Again, that looks correct to me, but please check.

> Secondly, since there is already a condition that checks for RCU
> read-side critical section, the extra `rcu_read_lock_held()` we supply
> is sort of redundant and can be skipped right?

Yes, the general rule is that if the primitives ends with _rcu(), any
lockdep condition will be in addition to rcu_read_lock_any_held().
So you should not need to pass RCU read-side lockdep expressions to 
primitives whose names end in _rcu..

							Thanx, Paul

> Thanks
> Amol
> 
> >    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
> >     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> >                                                        ^
> > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> >       ^
> > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >      ^
> >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> >      for (__list_check_rcu(dummy, ## cond, 0),   \
> >           ^
> >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> >      ^
> >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >                             ^
> >    include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
> >     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> >                                                                 ^
> > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> >       ^
> > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >      ^
> >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> >      for (__list_check_rcu(dummy, ## cond, 0),   \
> >           ^
> >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> >      ^
> >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >                             ^
> >    include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
> >      (cond) ?     \
> >       ^
> >    include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
> >     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
> >                                ^
> > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> >       ^
> > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> >      ^
> >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> >      for (__list_check_rcu(dummy, ## cond, 0),   \
> >           ^
> >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> >      ^
> > 
> > vim +/if +263 include/linux/rcupdate.h
> > 
> > 632ee200130899 Paul E. McKenney 2010-02-22  254  
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  255  /**
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  256   * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  257   * @c: condition to check
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  258   * @s: informative message
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  259   */
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  260  #define RCU_LOCKDEP_WARN(c, s)						\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  261  	do {								\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  262  		static bool __section(.data.unlikely) __warned;		\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18 @263  		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  264  			__warned = true;				\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  265  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  266  		}							\
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  267  	} while (0)
> > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  268  
> > 
> > :::::: The code at line 263 was first introduced by commit
> > :::::: f78f5b90c4ffa559e400c3919a02236101f29f3f rcu: Rename rcu_lockdep_assert() to RCU_LOCKDEP_WARN()
> > 
> > :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
> 
