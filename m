Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CFC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B13206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgELL4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:56:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53064 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgELL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:56:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYTW3-0000Dd-ND; Tue, 12 May 2020 05:56:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYTW2-0006WD-Ps; Tue, 12 May 2020 05:56:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
        <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
        <20200512003305.GX11244@42.do-not-panic.com>
Date:   Tue, 12 May 2020 06:52:35 -0500
In-Reply-To: <20200512003305.GX11244@42.do-not-panic.com> (Luis Chamberlain's
        message of "Tue, 12 May 2020 00:33:05 +0000")
Message-ID: <87y2pxs73w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYTW2-0006WD-Ps;;;mid=<87y2pxs73w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Mp2g/GCv9Wkg39vzKmSv+w+sqwRvuPww=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
>> On 2020/5/11 9:11, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > Today's linux-next merge of the vfs tree got a conflict in:
>> > 
>> >    kernel/sysctl.c
>> > 
>> > between commit:
>> > 
>> >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
>> > 
>> > from the parisc-hd tree and commit:
>> > 
>> >    f461d2dcd511 ("sysctl: avoid forward declarations")
>> > 
>> > from the vfs tree.
>> > 
>> > I fixed it up (see below) and can carry the fix as necessary. This
>> > is now fixed as far as linux-next is concerned, but any non trivial
>> > conflicts should be mentioned to your upstream maintainer when your tree
>> > is submitted for merging.  You may also want to consider cooperating
>> > with the maintainer of the conflicting tree to minimise any particularly
>> > complex conflicts.
>> > 
>> 
>> 
>> Kernel/sysctl.c contains more than 190 interface files, and there are a
>> large number of config macro controls. When modifying the sysctl interface
>> directly in kernel/sysctl.c , conflicts are very easy to occur.
>> 
>> At the same time, the register_sysctl_table() provided by the system can
>> easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
>> .
>> 
>> Should we add instructions in the patch guide (coding-style.rst
>> submitting-patches.rst):
>> Preferentially use register_sysctl_table() to add a new sysctl interface,
>> centralize feature codes, and avoid directly modifying kernel/sysctl.c ?
>
> Yes, however I don't think folks know how to do this well. So I think we
> just have to do at least start ourselves, and then reflect some of this
> in the docs.  The reason that this can be not easy is that we need to
> ensure that at an init level we haven't busted dependencies on setting
> this. We also just don't have docs on how to do this well.
>
>> In addition, is it necessary to transfer the architecture-related sysctl
>> interface to arch/xxx/kernel/sysctl.c ?


>
> Well here's an initial attempt to start with fs stuff in a very
> conservative way. What do folks think?

I don't see how any of that deals with the current conflict in -next.

You are putting the fs sysctls in the wrong place.  The should live
in fs/ not in fs/proc/.  Otherwise you are pretty much repeating
the problem the problem of poorly located code in another location.


>  fs/proc/Makefile          |  1 +
>  fs/proc/fs_sysctl_table.c | 97 +++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c           | 48 -------------------
>  3 files changed, 98 insertions(+), 48 deletions(-)
>  create mode 100644 fs/proc/fs_sysctl_table.c
>
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index bd08616ed8ba..8bf419b2ac7d 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -28,6 +28,7 @@ proc-y	+= namespaces.o
>  proc-y	+= self.o
>  proc-y	+= thread_self.o
>  proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
> +proc-$(CONFIG_SYSCTL)		+= fs_sysctl_table.o
>  proc-$(CONFIG_NET)		+= proc_net.o
>  proc-$(CONFIG_PROC_KCORE)	+= kcore.o
>  proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
> diff --git a/fs/proc/fs_sysctl_table.c b/fs/proc/fs_sysctl_table.c
> new file mode 100644
> index 000000000000..f56a49989872
> --- /dev/null
> +++ b/fs/proc/fs_sysctl_table.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * /proc/sys/fs sysctl table
> + */
> +#include <linux/init.h>
> +#include <linux/sysctl.h>
> +#include <linux/poll.h>
> +#include <linux/proc_fs.h>
> +#include <linux/printk.h>
> +#include <linux/security.h>
> +#include <linux/sched.h>
> +#include <linux/cred.h>
> +#include <linux/namei.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/bpf-cgroup.h>
> +#include <linux/mount.h>
> +#include <linux/dnotify.h>
> +#include <linux/pipe_fs_i.h>
> +#include <linux/aio.h>
> +#include <linux/inotify.h>
> +#include <linux/kmemleak.h>
> +#include <linux/binfmts.h>
> +
> +static unsigned long zero_ul;
> +static unsigned long long_max = LONG_MAX;
> +
> +static struct ctl_table fs_table[] = {
> +	{
> +		.procname	= "inode-nr",
> +		.data		= &inodes_stat,
> +		.maxlen		= 2*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_inodes,
> +	},
> +	{
> +		.procname	= "inode-state",
> +		.data		= &inodes_stat,
> +		.maxlen		= 7*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_inodes,
> +	},
> +	{
> +		.procname	= "file-nr",
> +		.data		= &files_stat,
> +		.maxlen		= sizeof(files_stat),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_files,
> +	},
> +	{
> +		.procname	= "file-max",
> +		.data		= &files_stat.max_files,
> +		.maxlen		= sizeof(files_stat.max_files),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &zero_ul,
> +		.extra2		= &long_max,
> +	},
> +	{
> +		.procname	= "nr_open",
> +		.data		= &sysctl_nr_open,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &sysctl_nr_open_min,
> +		.extra2		= &sysctl_nr_open_max,
> +	},
> +	{
> +		.procname	= "dentry-state",
> +		.data		= &dentry_stat,
> +		.maxlen		= 6*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_dentry,
> +	},
> +	{ }
> +};
> +
> +static struct ctl_table fs_base_table[] = {
> +	{
> +		.procname	= "fs",
> +		.mode		= 0555,
> +		.child		= fs_table,
> +	},
> +	{ }
> +};
  ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
  
> > +static int __init fs_procsys_init(void)
> +{
> +	struct ctl_table_header *hdr;
> +
> +	hdr = register_sysctl_table(fs_base_table);
              ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
	AKA
        hdr = register_sysctl("fs", fs_table);
> +	kmemleak_not_leak(hdr);
> +
> +	return 0;
> +}
> +
> +early_initcall(fs_procsys_init);
