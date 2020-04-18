Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D6C38A2C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E116E221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDRC0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:26:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:18685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgDRC0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:26:52 -0400
IronPort-SDR: XMK7pRmsgWXha3plY7tZh8bBJJdMMJP3TwhA/LFhT/TWTOum5fTLU0XATbev9shKugZycUKgqe
 MLrNyBQjlslQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 19:26:51 -0700
IronPort-SDR: 35A2oseRG/YO5c/WLZ8e53j+jR/1faCq2g0JUpfy+VxWq8ZWaZRergdRGfNdKoX1zjijveKBfn
 D0c6aC0e0s6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,397,1580803200"; 
   d="scan'208";a="401236256"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.105])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2020 19:26:49 -0700
Date:   Sat, 18 Apr 2020 10:26:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ipmi: use vzalloc instead of kmalloc for user
 creation
Message-ID: <20200418022648.GB46370@shbuild999.sh.intel.com>
References: <1587099689-13678-1-git-send-email-feng.tang@intel.com>
 <20200418020006.GB6246@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418020006.GB6246@minyard.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

On Fri, Apr 17, 2020 at 09:00:06PM -0500, Corey Minyard wrote:
> On Fri, Apr 17, 2020 at 01:01:29PM +0800, Feng Tang wrote:
> > We met mulitple times of failure of staring bmc-watchdog,
> > due to the runtime memory allocation failure of order 4.
> 
> I'm beginning to think that using srcu was a bad idea.  It made things
> cleaner and easier, but it eats tons of memory.  Sigh.

Yes, I was aslo surprised when I first knew the scru_struct is
so big. I thought we may use kmem_cache to dynamically allocate
it, though there are only a few places in kernel.

> Applied, at least for a fix for now.
 
Thanks! It will save us a lot of troubles :)

- Feng

> Thanks,
> 
> -corey
> 
> > 
> >      bmc-watchdog: page allocation failure: order:4, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0-1
> >      CPU: 1 PID: 2571 Comm: bmc-watchdog Not tainted 5.5.0-00045-g7d6bb61d6188c #1
> >      Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.00.01.0015.110720180833 11/07/2018
> >      Call Trace:
> >       dump_stack+0x66/0x8b
> >       warn_alloc+0xfe/0x160
> >       __alloc_pages_slowpath+0xd3e/0xd80
> >       __alloc_pages_nodemask+0x2f0/0x340
> >       kmalloc_order+0x18/0x70
> >       kmalloc_order_trace+0x1d/0xb0
> >       ipmi_create_user+0x55/0x2c0 [ipmi_msghandler]
> >       ipmi_open+0x72/0x110 [ipmi_devintf]
> >       chrdev_open+0xcb/0x1e0
> >       do_dentry_open+0x1ce/0x380
> >       path_openat+0x305/0x14f0
> >       do_filp_open+0x9b/0x110
> >       do_sys_open+0x1bd/0x250
> >       do_syscall_64+0x5b/0x1f0
> >       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Using vzalloc/vfree for creating ipmi_user heals the
> > problem.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index c48d8f0..96f1573 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -1153,7 +1153,7 @@ static void free_user_work(struct work_struct *work)
> >  					      remove_work);
> >  
> >  	cleanup_srcu_struct(&user->release_barrier);
> > -	kfree(user);
> > +	vfree(user);
> >  }
> >  
> >  int ipmi_create_user(unsigned int          if_num,
> > @@ -1185,7 +1185,7 @@ int ipmi_create_user(unsigned int          if_num,
> >  	if (rv)
> >  		return rv;
> >  
> > -	new_user = kmalloc(sizeof(*new_user), GFP_KERNEL);
> > +	new_user = vzalloc(sizeof(*new_user));
> >  	if (!new_user)
> >  		return -ENOMEM;
> >  
> > @@ -1232,7 +1232,7 @@ int ipmi_create_user(unsigned int          if_num,
> >  
> >  out_kfree:
> >  	srcu_read_unlock(&ipmi_interfaces_srcu, index);
> > -	kfree(new_user);
> > +	vfree(new_user);
> >  	return rv;
> >  }
> >  EXPORT_SYMBOL(ipmi_create_user);
> > -- 
> > 2.7.4
> > 
