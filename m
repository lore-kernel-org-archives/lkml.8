Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEEFC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90FF24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X94vFv8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBSPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:13:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37453 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:13:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so196762plz.4;
        Wed, 19 Feb 2020 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/WCgzKsAGcAiBdB1Q4Nk8rPvu+Sieh53r5g+a2fQlI=;
        b=X94vFv8umiSsRLPKefpXwFeBxqVoTskjis3OGYeRoB3yH7CJqpyGv79+y/Mo0meKis
         SXfe5YE+Pt4D6baIy25Ui6fT9zixwLVzn0XijkFwJDvAbkG7jPJ6yR/H3ZSZue1UubF1
         gvIp0IeTuwZyKEycDb+MZiUiG3DvBIl4A6GlendnbVWBQyTJhYCPYQJBjBdcoM27SF6v
         h1i0gMOYyu0UhgIbEN3nhd1Q9SAILIU/n862AujprgAyNt5a5xMP6qpLNXdKq6qALt4V
         aXRH1IKbnGSJ2hdtOLRXLT4CpMmQ/b6GLWNfMSEbSjE5oFsHfb6SndxWkRYk915nsCVr
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/WCgzKsAGcAiBdB1Q4Nk8rPvu+Sieh53r5g+a2fQlI=;
        b=CO45BVsumcfKGvzegI+KiiRlhTVkKedBmydpMUAtI+OD6bnaPFd1S5in5r8sVewX9G
         rn0JjQoKjoBTwA5NaFU8PB3dau1GGPdZ9krEmLruKw7R7/MK4P95N36d8aSKByOOweC5
         Z0M5cfGgxWED0MyCwWEg19btQvCJrRnUTrshzwPHPQPL19g6w5TCK1y3/6+mZaxyL9en
         Ys/hDULsXRNtDMJzrQRkhJ425MaJ/HlfFeg7Rs5r3gUNio2URhj/d316UiBjpp88Cb2Z
         hI4Jn1lCv9Q1f2cJvFNtl/4iN+O9XU2dRhgIsFfaC05rejny1YE8N/W+jpQje4zupJ5S
         ySQQ==
X-Gm-Message-State: APjAAAX33BQ9pqUHeYTh31uP72u4cThP4qtvhFl64mAUNhNtxCkCLBKX
        WATpBnHbMiqkuiSOd+dkBVA=
X-Google-Smtp-Source: APXvYqwLqLNlOBaRUkfoOdjsQ527g670hCXQCrGsOhAqD8Aitha1iqFp11ieH3OcuiENx7gNU/jPmQ==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id fa17mr9329610pjb.90.1582125219764;
        Wed, 19 Feb 2020 07:13:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x26sm3633825pfq.55.2020.02.19.07.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 07:13:38 -0800 (PST)
Date:   Wed, 19 Feb 2020 07:13:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lockdep splat for acpi power meter
Message-ID: <20200219151336.GA17501@roeck-us.net>
References: <8561ff118638c9ed077573c1099adea3521c9734.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8561ff118638c9ed077573c1099adea3521c9734.camel@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:15:28AM +0000, Damien Le Moal wrote:
> Jean, Guenter,
> 
> I am getting the following lockdep splat on boot since 5.5-rc1 (my
> apologies for not signaling this earlier). I do not see this with 5.4
> and as of 5.6-rc2, it still shows up 100% of the time on boot.
> 
I think this is a real problem. I am not sure though what makes it
appear now; there have been no interesting changes in the acpi
code or in the hwmon driver. There _have_ been some locking related
changes in kernfs, though. I don't know if those changes cause the
problem, or if they expose it.

Either case, the acpi_power_meter driver locks its resources, then
removes and re-creates all its attributes (which requires a kernfs
lock). At the same time, if an attribute is read, the same lock
is acquired by kernfs, then the driver locks its resources. Perfect
deadlock.

I may be missing something, but I think this entire code is broken.
Not only deletes and re-creates it all attributes while the hwmon
driver is active, it also releases and re-creates various strings
while potentially accessing those very same strings ... without
any locking. This is just asking for trouble.

We can (try to) work around the lockdep splat, but I don't think
that will solve all the problems. Jean, any thoughts ?

Guenter

> If you are not the right persons to look into this, please let me know.
> Thanks !
> 
> [   64.145761] ======================================================
> [   64.152295] WARNING: possible circular locking dependency detected
> [   64.158850] 5.6.0-rc2+ #629 Not tainted
> [   64.158851] ------------------------------------------------------
> [   64.158854] python/1397 is trying to acquire lock:
> [   64.177039] ffff888619080070 (&resource->lock){+.+.}, at:
> show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.177050] 
>                but task is already holding lock:
> [   64.177050] ffff88881643f188 (kn->count#119){++++}, at:
> kernfs_seq_start+0x6a/0x160
> [   64.177058] 
>                which lock already depends on the new lock.
> 
> [   64.177058] 
>                the existing dependency chain (in reverse order) is:
> [   64.177059] 
>                -> #1 (kn->count#119){++++}:
> [   64.177066]        __kernfs_remove+0x626/0x7e0
> [   64.177068]        kernfs_remove_by_name_ns+0x41/0x80
> [   64.177070]        remove_attrs+0xcb/0x3c0 [acpi_power_meter]
> [   64.177073]        acpi_power_meter_notify+0x1f7/0x310
> [acpi_power_meter]
> [   64.177078]        acpi_ev_notify_dispatch+0x198/0x1f3
> [   64.177081]        acpi_os_execute_deferred+0x4d/0x70
> [   64.177085]        process_one_work+0x7c8/0x1340
> [   64.177087]        worker_thread+0x94/0xc70
> [   64.177089]        kthread+0x2ed/0x3f0
> [   64.177094]        ret_from_fork+0x24/0x30
> [   64.177094] 
>                -> #0 (&resource->lock){+.+.}:
> [   64.177100]        __lock_acquire+0x20be/0x49b0
> [   64.177101]        lock_acquire+0x127/0x340
> [   64.177104]        __mutex_lock+0x15b/0x1350
> [   64.177106]        show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.177110]        dev_attr_show+0x3f/0x80
> [   64.177112]        sysfs_kf_seq_show+0x216/0x410
> [   64.177114]        seq_read+0x407/0xf90
> [   64.177119]        vfs_read+0x152/0x2c0
> [   64.177121]        ksys_read+0xf3/0x1d0
> [   64.177125]        do_syscall_64+0x95/0x1010
> [   64.177127]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   64.177128] 
>                other info that might help us debug this:
> 
> [   64.177129]  Possible unsafe locking scenario:
> 
> [   64.177130]        CPU0                    CPU1
> [   64.177130]        ----                    ----
> [   64.177131]   lock(kn->count#119);
> [   64.177132]                                lock(&resource->lock);
> [   64.177134]                                lock(kn->count#119);
> [   64.177135]   lock(&resource->lock);
> [   64.177137] 
>                 *** DEADLOCK ***
> [   64.177138] 4 locks held by python/1397:
> [   64.177139]  #0: ffff8890242d64e0 (&f->f_pos_lock){+.+.}, at:
> __fdget_pos+0x9b/0xb0
> [   64.177145]  #1: ffff889040be74e0 (&p->lock){+.+.}, at:
> seq_read+0x6b/0xf90
> [   64.177148]  #2: ffff8890448eb880 (&of->mutex){+.+.}, at:
> kernfs_seq_start+0x47/0x160
> [   64.177151]  #3: ffff88881643f188 (kn->count#119){++++}, at:
> kernfs_seq_start+0x6a/0x160
> [   64.177155] 
>                stack backtrace:
> [   64.177158] CPU: 10 PID: 1397 Comm: python Not tainted 5.6.0-rc2+
> #629
> [   64.177159] Hardware name: Supermicro Super Server/X11DPL-i, BIOS
> 3.1 05/21/2019
> [   64.177160] Call Trace:
> [   64.177167]  dump_stack+0x97/0xe0
> [   64.177170]  check_noncircular+0x32e/0x3e0
> [   64.177172]  ? print_circular_bug.isra.0+0x1e0/0x1e0
> [   64.177177]  ? unwind_next_frame+0xb9a/0x1890
> [   64.177180]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   64.177182]  ? graph_lock+0x79/0x170
> [   64.177183]  ? __lockdep_reset_lock+0x3c0/0x3c0
> [   64.177185]  ? mark_lock+0xbc/0x1150
> [   64.177187]  __lock_acquire+0x20be/0x49b0
> [   64.177190]  ? mark_held_locks+0xe0/0xe0
> [   64.177194]  ? stack_trace_save+0x91/0xc0
> [   64.177196]  lock_acquire+0x127/0x340
> [   64.177199]  ? show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.177201]  ? device_remove_bin_file+0x10/0x10
> [   64.177203]  ? device_remove_bin_file+0x10/0x10
> [   64.177205]  __mutex_lock+0x15b/0x1350
> [   64.177208]  ? show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.177210]  ? show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.177212]  ? mutex_lock_io_nested+0x11f0/0x11f0
> [   64.177214]  ? lock_downgrade+0x6a0/0x6a0
> [   64.177216]  ? kernfs_seq_start+0x47/0x160
> [   64.177218]  ? lock_acquire+0x127/0x340
> [   64.177219]  ? kernfs_seq_start+0x6a/0x160
> [   64.177222]  ? device_remove_bin_file+0x10/0x10
> [   64.177226]  ? show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.572676]  show_power+0x3c/0xa0 [acpi_power_meter]
> [   64.572681]  dev_attr_show+0x3f/0x80
> [   64.581931]  ? memset+0x20/0x40
> [   64.581935]  sysfs_kf_seq_show+0x216/0x410
> [   64.581938]  seq_read+0x407/0xf90
> [   64.581943]  ? security_file_permission+0x16f/0x2c0
> [   64.581948]  vfs_read+0x152/0x2c0
> [   64.581951]  ksys_read+0xf3/0x1d0
> [   64.581954]  ? kernel_write+0x120/0x120
> [   64.581957]  ? filp_open+0x50/0x50
> [   64.581962]  do_syscall_64+0x95/0x1010
> [   64.581967]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   64.581971] RIP: 0033:0x7fbb4e2c644c
> [   64.581974] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8
> d9 49 f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f
> 05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 48 89 44 24 08 e8 0f 4a f9 ff 48
> [   64.581976] RSP: 002b:00007ffe30d33400 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [   64.581979] RAX: ffffffffffffffda RBX: 00005569d016e1e0 RCX:
> 00007fbb4e2c644c
> [   64.581980] RDX: 0000000000001000 RSI: 00005569d0222970 RDI:
> 0000000000000003
> [   64.581982] RBP: 00007fbb4e398300 R08: 0000000000000000 R09:
> 00007fbb4e397190
> [   64.581984] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00005569d016e1e0
> [   64.581985] R13: 00007fbb4e397700 R14: 0000000000000d68 R15:
> 0000000000000d68
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
