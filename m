Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39167C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5EB206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCKV1FhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAPQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:27:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34547 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:27:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so10149985pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=33AP+YAYen1s2WSnRfztlYCAbeJag23CYLEce1GCh04=;
        b=tCKV1FhKCM7abTXh7z0pWudAF4PW7wSs1aw2oQ3xlGl3oNH6w87hSizGBMgDthBHA+
         4r1Hm0HhbFFKu8LEdWreV9MyWQP7fKnb6KDmR9aD/OmACYTtn/9+2QsR+EP02lfECP+6
         /EOSikHPqIe6JZv1PWHp3aIPYOPJqDehesAiKL5P4CZjpqOqBRh9rRslnGb68hXZVqIC
         9xcLLtiCbLTxgYU6w2jRyEUuAK20QbjCi0fbLGDdXXQGWvY5u3qMGJt+ZqRII1nviTDi
         THKM23NvYLoUEAwtdnIsL4lALLozBRKXxkQY5LA5eeVKPmCDaaMatg/rUL5gSzpjihKq
         3dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=33AP+YAYen1s2WSnRfztlYCAbeJag23CYLEce1GCh04=;
        b=Y++S0cxA+VoA2Y1WkQM0ens8YABXVPsXwJt+/zJLkL3UICrH0KftZ5igfghdvpFWCg
         B7FZUfkFt3LOoXxFonOOXZKHBYXqhmdjZEj7mLx0Fc31UstCFK27CWDjJwAfU4s+UFhw
         QrK/ksVmMhkvm0b5aLZjdCkHQ/Rv5IzzYinM1XUQNd5oc1bWOJSUsHD06RM8azKKXpZB
         9Yu29PvUB3D7jLxtYBhk7CbWQ/PpJV5GY2fwvEiw5e8KCJmkvg31ZfFmmcXYBVMeXtDH
         PEkjHYGqpu4cgqy6v/1pUuuJsWU/S5JrTLe/jsq7zUl6hICKKCrr6aRKzcq0NcWizuHl
         CL9Q==
X-Gm-Message-State: APjAAAVKx7A7EQqb/znfYEWgzxS4f/W5ZLq8la59Sgv4mXdMdlsUONHI
        doNa1tGsHV1faKCZfLtcR7w=
X-Google-Smtp-Source: APXvYqxLN8WIIjkAF6siwCJzCA4D+WbL2uFGk6Yo+VZF1iecRO8NzHVIJEXLbQHo18d3pfJaUxGMlQ==
X-Received: by 2002:a63:3404:: with SMTP id b4mr39759018pga.438.1579192066741;
        Thu, 16 Jan 2020 08:27:46 -0800 (PST)
Received: from workstation-portable ([146.196.37.0])
        by smtp.gmail.com with ESMTPSA id o2sm4168588pjo.26.2020.01.16.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:27:46 -0800 (PST)
Date:   Thu, 16 Jan 2020 21:57:37 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200116162737.GA16892@workstation-portable>
References: <20200110164709.26741-1-frextrite@gmail.com>
 <202001121358.YVbD4V9l%lkp@intel.com>
 <20200114030030.GB2559@workstation-portable>
 <20200114175828.GR2935@paulmck-ThinkPad-P72>
 <20200115123653.GA20601@workstation-portable>
 <20200115193259.GC2935@paulmck-ThinkPad-P72>
 <20200116025425.GC8329@workstation-portable>
 <20200116032132.GT2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116032132.GT2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 07:21:32PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 16, 2020 at 08:24:25AM +0530, Amol Grover wrote:
> > On Wed, Jan 15, 2020 at 11:32:59AM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 15, 2020 at 06:06:53PM +0530, Amol Grover wrote:
> > > > On Tue, Jan 14, 2020 at 09:58:28AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Jan 14, 2020 at 08:30:30AM +0530, Amol Grover wrote:
> > > > > > On Sun, Jan 12, 2020 at 01:25:58PM +0800, kbuild test robot wrote:
> > > > > > > Hi Amol,
> > > > > > > 
> > > > > > > Thank you for the patch! Perhaps something to improve:
> > > > > > > 
> > > > > > > [auto build test WARNING on char-misc/char-misc-testing]
> > > > > > > [also build test WARNING on ipmi/for-next arm-soc/for-next v5.5-rc5]
> > > > > > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > > > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > > > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > > > > 
> > > > > > > url:    https://github.com/0day-ci/linux/commits/Amol-Grover/drivers-char-ipmi-ipmi_msghandler-Pass-lockdep-expression-to-RCU-lists/20200111-081002
> > > > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 16bb7abc4a6b9defffa294e4dc28383e62a1dbcf
> > > > > > > config: x86_64-randconfig-a003-20200109 (attached as .config)
> > > > > > > compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> > > > > > > reproduce:
> > > > > > >         # save the attached .config to linux build tree
> > > > > > >         make ARCH=x86_64 
> > > > > > > 
> > > > > > > If you fix the issue, kindly add following tag
> > > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > > > 
> > > > > > > All warnings (new ones prefixed by >>):
> > > > > > > 
> > > > > > >    In file included from include/linux/export.h:43:0,
> > > > > > >                     from include/linux/linkage.h:7,
> > > > > > >                     from include/linux/kernel.h:8,
> > > > > > >                     from include/linux/list.h:9,
> > > > > > >                     from include/linux/module.h:12,
> > > > > > >                     from drivers/char/ipmi/ipmi_msghandler.c:17:
> > > > > > >    drivers/char/ipmi/ipmi_msghandler.c: In function 'find_cmd_rcvr':
> > > > > > >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >                             ^
> > > > > > 
> > > > > > As mentioned above, RCU_LOCKDEP_WARN macro is called from
> > > > > > __list_check_rcu with 2 parameters
> > > > > > 
> > > > > > 1. !cond && !rcu_read_lock_any_held()
> > > > > > 2. The message to display incase there is a lockdep warning.
> > > > > > 
> > > > > > 
> > > > > > However, if I pass the lockdep checking condition as:
> > > > > > 
> > > > > > list_for_each_entry_rcu(ptr, list, head, lockdep_is_held(&some_lock) || rcu_read_lock_held())
> > > > > 
> > > > > Right, given the _rcu() suffix on the command, the rcu_read_lock_held()
> > > > > is implied.
> > > > > 
> > > > > > this trickles down to __list_check_rcu and then finally to
> > > > > > RCU_LOCKDEP_WARN as (here cond is `lockdep_is_held(&some_lock) || rcu_read_lock_held()`):
> > > > > > 
> > > > > > RCU_LOCKDEP_WARN(!lockdep_is_held(&some_lock) || rcu_read_lock_held() && !rcu_read_lock_any_held())
> > > > > > 
> > > > > > which according to operator precedence (I hopefully got them right)
> > > > > > would always evaluate to true if we are in an RCU read-side critical
> > > > > > section (without a lock), and hence, result in a false-positive lockdep
> > > > > > warning.
> > > > > 
> > > > > It looks that way to me.  But why not actually try it out?  After all,
> > > > > only the running system knows for sure.  And there might be some trick
> > > > > that we are both missing.
> > > > > 
> > > > 
> > > > I just tested this, here are the results:
> > > > 
> > > > Case 1: Using`lockdep_is_held() || rcu_read_lock_held()`
> > > > 
> > > > lock	RCU RSCS		Splat?	Actual
> > > > Y	Y			N	N
> > > > Y	N			N	N
> > > > N	Y			Y	N <=
> > > > N	N			Y	Y
> > > > 
> > > > Similar for
> > > > Case 2: Using `rcu_read_lock_held() || lockdep_is_held()`
> > > > 
> > > > Case 3: Consider 2 locks (outside rcu_read_lock())
> > > > `lockdep_is_held(lock1) || lockdep_is_held(lock2)`
> > > > 
> > > > lock1	lock2			Splat?	Actual
> > > > Y	Y			N*	N
> > > > Y	N			N	N
> > > > N	Y			Y	N <=
> > > > N	N			Y	Y
> > > > 
> > > > This too proves the hypothesis (I'd like to call that).
> > > 
> > > Very good!
> > > 
> > > > *However, this shows an interesting result. When both lock1 and lock2
> > > > are held, according to the hypothesis, a splat should've occured, since
> > > > the check condition (albeit faulty atm) would be:
> > > > 
> > > > `!lockdep_is_held(lock1) || lockdep_is_held(lock2) && !rcu_read_lock_any_held()`
> > > > => `!T || T && !F`
> > > > => `F || T && T`
> > > > => `F || T`
> > > > => `T`
> > > > However, there was no splat. Which led me to investigate further and I
> > > > found out:
> > > > 1. `rcu_read_lock_any_held()` always returns 1 even if it is outside RCU
> > > > read-side CS.
> > > > 2. `rcu_read_lock_held()` seems OK, returns 1 when inside and 0 when
> > > > outside
> > > > 
> > > > The kernel is compiled with
> > > > PROVE_RCU=y
> > > > PROVE_RCU_LIST=y
> > > 
> > > Were you within a preempt-disable region, for example, was some other
> > > spinlock held?  (A lockdep splat should give you a list of locks held.)
> > > Both of these act as generalized RCU read-side critical sections in
> > > recent kernels.
> > 
> > I'm not sure if I was inside a preempt-disable region. I just created a
> > thread via kthread_run and ran rcu_read_lock_any_held() inside the
> > thread, I'll investigate further and get back to you. And no-other locks
> > were held. Here is the splat:
> > 
> > [ 2724.551419] =============================
> > [ 2724.551420] WARNING: suspicious RCU usage
> > [ 2724.551421] 5.5.0-rc5-next #15 Tainted: G           OE    
> > [ 2724.551422] -----------------------------
> > [ 2724.551423] /home/amolg/git/lockdep_check/main.c:28 RCU-list
> > traversed in non-reader section!!
> > [ 2724.551424] 
> >                other info that might help us debug this:
> > 
> > [ 2724.551425] 
> >                rcu_scheduler_active = 2, debug_locks = 1
> > [ 2724.551426] no locks held by my_thread/4275.
> > [ 2724.551426] 
> >                stack backtrace:
> > [ 2724.551428] CPU: 2 PID: 4275 Comm: my_thread Tainted: G           OE
> > 5.5.0-rc5-next #15
> > [ 2724.551429] Hardware name: Gigabyte Technology Co., Ltd.
> > Z170-D3H/Z170-D3H-CF, BIOS F21 03/06/2017
> > [ 2724.551430] Call Trace:
> > [ 2724.551437]  dump_stack+0x8f/0xd0
> > [ 2724.551440]  threadfn+0x100/0x105 [main]
> > [ 2724.551443]  ? __kthread_parkme+0x48/0x60
> > [ 2724.551445]  kthread+0xf9/0x130
> > [ 2724.551447]  ? 0xffffffffc00d7000
> > [ 2724.551448]  ? kthread_park+0x90/0x90
> > [ 2724.551451]  ret_from_fork+0x3a/0x50
> 
> Does your .config file by chance contain "CONFIG_PREEMPT=n"?
> 

Indeed, CONFIG_PREEMPT was not set in my config, hence, the different
results.

> In that case, pretty much any code not containing a call to schedule() or
> a return to userspace is an implicit RCU read-side critical section, which
> would mean that this is expected behavior.
> 

Got it, thank you!

Thanks
Amol

> > > > Any thoughts on this? Is this intended? And should I send-in the patch
> > > > for the first problem?
> > > 
> > > Separate patches for the initial problem and fixing the macro argument,
> > > please, if that is what you are asking.
> > 
> > Sorry if I didn't make myself clear earlier. By `first problem` I was
> > referring to the macro argument problem itself.
> > 
> > I think by `initial problem` you mean this patch (drivers/char/ipmi),
> > right? I'll make sure to send in a separate patch for the macro argument
> > problem.
> 
> I did indeed mean that, thank you!
> 
> 							Thanx, Paul
> 
> > Thanks
> > Amol
> > 
> > > 							Thanx, Paul
> > > 
> > > > Thanks
> > > > Amol
> > > > 
> > > > > > This could be easily solved by putting `cond` inside brackets as it is
> > > > > > correctly done in RCU_LOCKDEP_WARN macro but not in __list_check_rcu
> > > > > > macro. Is that so, or did I miss something?
> > > > > 
> > > > > Again, that looks correct to me, but please check.
> > > > > 
> > > > > > Secondly, since there is already a condition that checks for RCU
> > > > > > read-side critical section, the extra `rcu_read_lock_held()` we supply
> > > > > > is sort of redundant and can be skipped right?
> > > > > 
> > > > > Yes, the general rule is that if the primitives ends with _rcu(), any
> > > > > lockdep condition will be in addition to rcu_read_lock_any_held().
> > > > > So you should not need to pass RCU read-side lockdep expressions to 
> > > > > primitives whose names end in _rcu..
> > > > > 
> > > > > 							Thanx, Paul
> > > > > 
> > > > > > Thanks
> > > > > > Amol
> > > > > > 
> > > > > > >    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
> > > > > > >     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> > > > > > >                                                        ^
> > > > > > > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> > > > > > >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> > > > > > >       ^
> > > > > > > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >      ^
> > > > > > >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> > > > > > >      for (__list_check_rcu(dummy, ## cond, 0),   \
> > > > > > >           ^
> > > > > > >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> > > > > > >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > > > > >      ^
> > > > > > >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >                             ^
> > > > > > >    include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
> > > > > > >     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> > > > > > >                                                                 ^
> > > > > > > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> > > > > > >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> > > > > > >       ^
> > > > > > > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >      ^
> > > > > > >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> > > > > > >      for (__list_check_rcu(dummy, ## cond, 0),   \
> > > > > > >           ^
> > > > > > >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> > > > > > >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > > > > >      ^
> > > > > > >    include/linux/rculist.h:53:25: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >                             ^
> > > > > > >    include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
> > > > > > >      (cond) ?     \
> > > > > > >       ^
> > > > > > >    include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
> > > > > > >     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
> > > > > > >                                ^
> > > > > > > >> include/linux/rcupdate.h:263:3: note: in expansion of macro 'if'
> > > > > > >       if (debug_lockdep_rcu_enabled() && !__warned && (c)) { \
> > > > > > >       ^
> > > > > > > >> include/linux/rculist.h:53:2: note: in expansion of macro 'RCU_LOCKDEP_WARN'
> > > > > > >      RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),  \
> > > > > > >      ^
> > > > > > >    include/linux/rculist.h:371:7: note: in expansion of macro '__list_check_rcu'
> > > > > > >      for (__list_check_rcu(dummy, ## cond, 0),   \
> > > > > > >           ^
> > > > > > >    drivers/char/ipmi/ipmi_msghandler.c:1607:2: note: in expansion of macro 'list_for_each_entry_rcu'
> > > > > > >      list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > > > > >      ^
> > > > > > > 
> > > > > > > vim +/if +263 include/linux/rcupdate.h
> > > > > > > 
> > > > > > > 632ee200130899 Paul E. McKenney 2010-02-22  254  
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  255  /**
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  256   * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  257   * @c: condition to check
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  258   * @s: informative message
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  259   */
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  260  #define RCU_LOCKDEP_WARN(c, s)						\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  261  	do {								\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  262  		static bool __section(.data.unlikely) __warned;		\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18 @263  		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  264  			__warned = true;				\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  265  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  266  		}							\
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  267  	} while (0)
> > > > > > > f78f5b90c4ffa5 Paul E. McKenney 2015-06-18  268  
> > > > > > > 
> > > > > > > :::::: The code at line 263 was first introduced by commit
> > > > > > > :::::: f78f5b90c4ffa559e400c3919a02236101f29f3f rcu: Rename rcu_lockdep_assert() to RCU_LOCKDEP_WARN()
> > > > > > > 
> > > > > > > :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > > :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > > 
> > > > > > > ---
> > > > > > > 0-DAY kernel test infrastructure                 Open Source Technology Center
> > > > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> > > > > > 
> > > > > > 
