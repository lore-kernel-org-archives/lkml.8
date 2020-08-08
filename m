Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14213C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E495B221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgHHFkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 01:40:10 -0400
Received: from verein.lst.de ([213.95.11.211]:55918 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHHFkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 01:40:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4932068C7B; Sat,  8 Aug 2020 07:40:07 +0200 (CEST)
Date:   Sat, 8 Aug 2020 07:40:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: fs/init.c:72:8: warning: Variable 'error' is reassigned a
 value before the old one has been used.
Message-ID: <20200808054006.GA16706@lst.de>
References: <202008081143.D8Y8xO2X%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008081143.D8Y8xO2X%lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 11:35:45AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
> commit: 4b7ca5014cbef51cdb99fd644eae4f3773747a05 init: add an init_chroot helper
> date:   8 days ago
> compiler: hppa-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
> >> fs/init.c:72:8: warning: Variable 'error' is reassigned a value before the old one has been used. [redundantAssignment]
>     error = security_path_chroot(&path);
>           ^
>    fs/init.c:69:8: note: Variable 'error' is reassigned a value before the old one has been used.
>     error = -EPERM;
>           ^
>    fs/init.c:72:8: note: Variable 'error' is reassigned a value before the old one has been used.
>     error = security_path_chroot(&path);

I really don't understand the warning.  We assign a value to error, if
there is an error we jump the out labe and return it, or else continue.

That is a pretty common pattern in the kernel.  What do I miss?

> 
> vim +/error +72 fs/init.c
> 
>     57	
>     58	int __init init_chroot(const char *filename)
>     59	{
>     60		struct path path;
>     61		int error;
>     62	
>     63		error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
>     64		if (error)
>     65			return error;
>     66		error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
>     67		if (error)
>     68			goto dput_and_out;
>     69		error = -EPERM;
>     70		if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>     71			goto dput_and_out;
>   > 72		error = security_path_chroot(&path);
>     73		if (error)
>     74			goto dput_and_out;
>     75		set_fs_root(current->fs, &path);
>     76	dput_and_out:
>     77		path_put(&path);
>     78		return error;
>     79	}
>     80	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
---end quoted text---
