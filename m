Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B28FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7AB206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+ZRZcXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCES6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:58:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46919 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCES6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:58:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so3181709pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEFdNaLn9qc/1KGkVNR/8+Uvt4MTtE2QlJpzKnz0Doo=;
        b=E+ZRZcXkgB6k/nrlh6YzWJQxU/7k4l0mOLbdh5LzEoE0Znc9UW9//j7C6DAhavzDBW
         wsGC+/h53ACZSQYHqbC0WectP8CIzIKPqiqaTOIff4KlZdTsf59jlKBqd8+T4n4S68nf
         ZXuZZe2wpxDKV/ewtjzfnf9DdMKTQB61EVOBLHKBs0RlYcinhu81+0g+VQzwu5L3s3zf
         jVWWvMTITKZV0wN+PThi2NnFwmcDiO4ClApVFczgOeEOIkBPv++8oPfowIMzg+WDP/05
         bmh38My1aJ4UvJYiYk14jwgH/18+v0/85ER22tjwXKy1m9MAZnvbSfUTmnM5d+9xo0SV
         soag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEFdNaLn9qc/1KGkVNR/8+Uvt4MTtE2QlJpzKnz0Doo=;
        b=tvwbC+KMykRKwf/ZXs3rDwfPjTwhiEpUNrjgg9BY2bwKK7I5xhzY68NcQvgL9mk4i2
         Tr/jwguloTtVvukjpUPvAXFC/Lrb+/J+ftvHBzlAuVI+F+SYAutfDpkl5umcsD2ilyqI
         Bw+/QT6rQ69aBL001XHU8AYz2AFEdQLSZPYKbcaDI8jnXQyrHVV5OSy07FGWBXqOpAKq
         MN3e2ffdzppibheS8hD4RNHJnFZvNXseuO/FhN/0h01fm9rUxg/KuvKCLmiqLFueCoMO
         tpdnJVrIhuQ2UalWV1Ldhef36FdLKKuB0d5qK9iS22ZjyaRnueunpcHFgHMw6UfDYATU
         7yJw==
X-Gm-Message-State: ANhLgQ33fuA9XH7Zp4r6qabQmSib4iJUlBY6gOQzyw7CgB56Qe41bfvD
        dXOfZbbtieCYxRxRSFQWdGk=
X-Google-Smtp-Source: ADFU+vtS9mhFLTR6Ow3Wr/D2qd4bjghVj3gbDn0hDpUiR7e2dBK40NeB5lRv6213RnroHYizc+8SKw==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr8637067pgh.331.1583434700975;
        Thu, 05 Mar 2020 10:58:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s25sm5804391pfe.147.2020.03.05.10.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 10:58:20 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:58:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200305185818.GA28151@roeck-us.net>
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
 <20200305155238.GA8669@roeck-us.net>
 <20200305173953.GA10538@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305173953.GA10538@madhuparna-HP-Notebook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:09:54PM +0530, Madhuparna Bhowmik wrote:
> On Thu, Mar 05, 2020 at 07:52:38AM -0800, Guenter Roeck wrote:
> > On Fri, Feb 28, 2020 at 02:54:51PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > 
> > > This patch default enables CONFIG_PROVE_RCU_LIST option with
> > > CONFIG_PROVE_RCU for RCU list lockdep debugging.
> > > 
> > > With this change, RCU list lockdep debugging will be default
> > > enabled in CONFIG_PROVE_RCU=y kernels.
> > > 
> > > Most of the RCU users (in core kernel/, drivers/, and net/
> > > subsystem) have already been modified to include lockdep
> > > expressions hence RCU list debugging can be enabled by
> > > default.
> > > 
> > > However, there are still chances of enountering
> > > false-positive lockdep splats because not everything is converted,
> > > in case RCU list primitives are used in non-RCU read-side critical
> > > section but under the protection of a lock. It would be okay to
> > > have a few false-positives, as long as bugs are identified, since this
> > > patch only affects debugging kernels.
> > > 
> > > Co-developed-by: Amol Grover <frextrite@gmail.com>
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > Who is going to fix the fallout ?
> > 
> > fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> > kernel/kprobes.c:329 RCU-list traversed in non-reader section!!
> > net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!
> >
> Hi,
> There is already a patch for fixing the warnings in kernel/kprobes.c :
> https://lore.kernel.org/lkml/157905963533.2268.4672153983131918123.stgit@devnote2/
> 
> Same for net/ipv4/ipmr:
> https://lore.kernel.org/patchwork/patch/1198934/
> 
> Can you please send the warning with the stack backtrace and locks held
> for btrfs/block-group.c, I will work on it.
> 

See below. I think that should be easy to reproduce by mounting
a btrfs file system.

Guenter

---
[   28.920119] BTRFS: device fsid afe7540f-98fe-4a5c-ba94-3fb85a5da345 devid 1 transid 6 /dev/root scanned by swapper/0 (1)
[   28.961347] BTRFS info (device sda): disk space caching is enabled
[   28.963199] BTRFS info (device sda): has skinny extents
[   28.963427] BTRFS info (device sda): flagging fs with big metadata feature
[   29.104392]
[   29.104591] =============================
[   29.104756] WARNING: suspicious RCU usage
[   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
[   29.105231] -----------------------------
[   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
[   29.105643]
[   29.105643] other info that might help us debug this:
[   29.105643]
[   29.106344]
[   29.106344] rcu_scheduler_active = 2, debug_locks = 1
[   29.106590] 1 lock held by swapper/0/1:
[   29.106776]  #0: ffff0000199e90d8 (&type->s_umount_key#23/1){+.+.}, at: alloc_super+0xac/0x2c0
[   29.107436]
[   29.107436] stack backtrace:
[   29.107784] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200305 #1
[   29.107989] Hardware name: linux,dummy-virt (DT)
[   29.108344] Call trace:
[   29.108488]  dump_backtrace+0x0/0x1a0
[   29.108638]  show_stack+0x14/0x20
[   29.108784]  dump_stack+0xe8/0x150
[   29.108921]  lockdep_rcu_suspicious+0xf8/0x108
[   29.109071]  btrfs_read_block_groups+0x754/0x860
[   29.109222]  open_ctree+0xe74/0x1580
[   29.109359]  btrfs_mount_root+0x3cc/0x4c0
[   29.109514]  legacy_get_tree+0x2c/0x60
[   29.109653]  vfs_get_tree+0x24/0xe8
[   29.109872]  fc_mount+0x14/0x50
[   29.110010]  vfs_kern_mount.part.41+0x68/0x98
[   29.110158]  vfs_kern_mount+0x10/0x20
[   29.110297]  btrfs_mount+0x158/0x4b0
[   29.110434]  legacy_get_tree+0x2c/0x60
[   29.110573]  vfs_get_tree+0x24/0xe8
[   29.110709]  do_mount+0x568/0x998
[   29.110849]  do_mount_root+0x8c/0x11c
[   29.110990]  mount_block_root+0x114/0x244
[   29.111134]  mount_root+0x124/0x154
[   29.111272]  prepare_namespace+0x128/0x164
[   29.111417]  kernel_init_freeable+0x298/0x2b8
[   29.111569]  kernel_init+0x10/0x100
[   29.111710]  ret_from_fork+0x10/0x18

