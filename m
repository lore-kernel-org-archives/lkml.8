Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C7E206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595778546;
	bh=N5WNgxXcjcNG067YYFm8hGJiHkBCgATZcujyfxGGvu4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XVJQa870zCYj/VhyR619ABaGRPYhBmUp+G9EFEgkJvM95DzvzXIUvUFZuQAZvEQHy
	 YgctsQ1/rG1pzR9gCqc6E3U5/E77wH/SuSb4tyP2/5us+LqTj1rw9XRsYN39QC9mqN
	 KSzcux1lHJxf6VyWLRGlE7VvIjrPPWEYswtcNKOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgGZPtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgGZPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:49:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB570206D7;
        Sun, 26 Jul 2020 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595778543;
        bh=N5WNgxXcjcNG067YYFm8hGJiHkBCgATZcujyfxGGvu4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BEpQKb8xD0q6ojgIWEAoBIY6WkX0XLd8klvrFBJOxvJRdh2EQfgHxxC+r8JuSW3uT
         o0dGdktfGmbuM+74S54wRxcMcN/LV+/X1ejIh5SVncqZb19dfi2aM4iX2qzmCXwXcN
         EnZ0LyiR69+HqjEDdf4lHPLjg4vJ8HB0L30DX+Ts=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 788C5352263B; Sun, 26 Jul 2020 08:49:03 -0700 (PDT)
Date:   Sun, 26 Jul 2020 08:49:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.07.14a 64/73] include/linux/rculist.h:727:30:
 error: left-hand operand of comma expression has no effect
Message-ID: <20200726154903.GD9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202007261137.CXV59i6b%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202007261137.CXV59i6b%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:28:55AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.07.14a
> head:   aace6daf32cce6b644083754c7be6260aae439db
> commit: 93d62a873f87bf69209a5c29d62b9497888de6d6 [64/73] kvm: mmu: page_track: Fix RCU list API usage
> config: i386-randconfig-a006-20200726 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout 93d62a873f87bf69209a5c29d62b9497888de6d6
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, but this commit has been superseded by 74e71f01ff46 ("kvm:
mmu: page_track: Fix RCU list API usage").  As always, thank you for
your testing efforts.

							Thanx, Paul

> Note: the rcu/dev.2020.07.14a HEAD aace6daf32cce6b644083754c7be6260aae439db builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/kvm_host.h:12,
>                     from arch/x86/kvm/mmu/page_track.c:14:
>    arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_write':
> >> include/linux/rculist.h:727:30: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
>      727 |  for (__list_check_srcu(cond),     \
>          |                              ^
>    arch/x86/kvm/mmu/page_track.c:232:2: note: in expansion of macro 'hlist_for_each_entry_srcu'
>      232 |  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_flush_slot':
> >> include/linux/rculist.h:727:30: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
>      727 |  for (__list_check_srcu(cond),     \
>          |                              ^
>    arch/x86/kvm/mmu/page_track.c:258:2: note: in expansion of macro 'hlist_for_each_entry_srcu'
>      258 |  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +727 include/linux/rculist.h
> 
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  688  
> 1cc523271ef0b63 stephen hemminger       2010-02-22  689  #define __hlist_for_each_rcu(pos, head)				\
> 67bdbffd696f29a Arnd Bergmann           2010-02-25  690  	for (pos = rcu_dereference(hlist_first_rcu(head));	\
> 75d65a425c0163d Linus Torvalds          2011-05-19  691  	     pos;						\
> 67bdbffd696f29a Arnd Bergmann           2010-02-25  692  	     pos = rcu_dereference(hlist_next_rcu(pos)))
> 1cc523271ef0b63 stephen hemminger       2010-02-22  693  
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  694  /**
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  695   * hlist_for_each_entry_rcu - iterate over rcu list of given type
> b67bfe0d42cac56 Sasha Levin             2013-02-27  696   * @pos:	the type * to use as a loop cursor.
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  697   * @head:	the head for your list.
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  698   * @member:	the name of the hlist_node within the struct.
> ddc465936643108 Jonathan Neuschäfer     2020-03-05  699   * @cond:	optional lockdep expression if called from non-RCU protection.
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  700   *
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  701   * This list-traversal primitive may safely run concurrently with
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  702   * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  703   * as long as the traversal is guarded by rcu_read_lock().
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  704   */
> 28875945ba98d1b Joel Fernandes (Google  2019-07-16  705) #define hlist_for_each_entry_rcu(pos, head, member, cond...)		\
> 28875945ba98d1b Joel Fernandes (Google  2019-07-16  706) 	for (__list_check_rcu(dummy, ## cond, 0),			\
> 28875945ba98d1b Joel Fernandes (Google  2019-07-16  707) 	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
> b67bfe0d42cac56 Sasha Levin             2013-02-27  708  			typeof(*(pos)), member);			\
> b67bfe0d42cac56 Sasha Levin             2013-02-27  709  		pos;							\
> b67bfe0d42cac56 Sasha Levin             2013-02-27  710  		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  711  			&(pos)->member)), typeof(*(pos)), member))
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  712  
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  713  /**
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  714   * hlist_for_each_entry_srcu - iterate over rcu list of given type
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  715   * @pos:	the type * to use as a loop cursor.
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  716   * @head:	the head for your list.
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  717   * @member:	the name of the hlist_node within the struct.
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  718   * @cond:	lockdep expression for the lock required to traverse the list.
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  719   *
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  720   * This list-traversal primitive may safely run concurrently with
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  721   * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  722   * as long as the traversal is guarded by srcu_read_lock().
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  723   * The lockdep expression srcu_read_lock_held() can be passed as the
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  724   * cond argument from read side.
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  725   */
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  726  #define hlist_for_each_entry_srcu(pos, head, member, cond)		\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12 @727  	for (__list_check_srcu(cond),					\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  728  	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  729  			typeof(*(pos)), member);			\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  730  		pos;							\
> bd4444c47de914a Madhuparna Bhowmik      2020-07-12  731  		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
> b67bfe0d42cac56 Sasha Levin             2013-02-27  732  			&(pos)->member)), typeof(*(pos)), member))
> 82524746c27fa41 Franck Bui-Huu          2008-05-12  733  
> 
> :::::: The code at line 727 was first introduced by commit
> :::::: bd4444c47de914a27b650f029d46efbbb6809765 rculist : Introduce list/hlist_for_each_entry_srcu() macros
> 
> :::::: TO: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


