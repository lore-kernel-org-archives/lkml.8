Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0639C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E52206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587054605;
	bh=mpHeMEAlR/ji1tp8fo76JV6pVgjhmN7WYn7/MztY/no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I3kBQ5Bazo2nE7O47Ew41/pGZeRQmTz3cNILpFmtMmExUvGAnjGGrBpNoX/lCW8SO
	 M/yAg2OEwbgQ/tRwHPUtijAZJIX2P3wHUO+zAy48g3PQlAKz9ymxLCj4HfvsLXR6/p
	 q8Vxm/t2TcNDr7dEojdu/BmNF52wXPqvO+NHz0oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439478AbgDPQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:30:04 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55158 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgDPQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:30:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1613714pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPXHaqf/qHFSaDpyhJeyRmFm0Vwd2OWwgFFidmGKGzU=;
        b=N+xLbal888HS2OVx/qytfoCews2J46GUgm5jaqhknbUVyudz7es6dGYhuYo0n/FkV8
         /ObZ5YQak1uGSkLWyIyKRk5tflIq2oeuWY47ICtwG1IOMo1JcI9p1WROt2J1VuYOxjTr
         2jjR5eh0+2aMhJeRd/Mo4MYD1OUF4TyXDFuodqLcrC6Bgryi3fd9P5FbYyf3oONadSBS
         XYV4vDLwIKC7PyGKQLcaBHGSUdbtzaBYexZoqejk6MTd1r0WOTo3U4XkN6xjQG6W0SEV
         772f0MDis1wSH1aXZNWUyjkZviATrkGDuQc/0N1RX/XS7e2NTJU0jUZkwh0HgzHdgyxZ
         PgHA==
X-Gm-Message-State: AGi0PuZ9hkWScki5v5UzWGy/iDDjg58k3VRxGCuCqVhPROaC4LuCZ5wL
        tdTp4/JuWz6A1weSlVovLlw=
X-Google-Smtp-Source: APiQypLHkyFwFIh+/3mcPtFc1PtiNwVMT7r5SwMuW8VU7wbRg5FsaSeenVdU6gHgeC6UKZftdO3P+w==
X-Received: by 2002:a17:90b:23ce:: with SMTP id md14mr6123869pjb.164.1587054600890;
        Thu, 16 Apr 2020 09:30:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c201sm17288981pfc.73.2020.04.16.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:29:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C2B3B40277; Thu, 16 Apr 2020 16:29:58 +0000 (UTC)
Date:   Thu, 16 Apr 2020 16:29:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org,
        Sergey Kvachonok <ravenexp@gmail.com>,
        Tony Vroon <chainsaw@gentoo.org>
Subject: Re: [PATCH] umh: always return error when helper was not called
Message-ID: <20200416162958.GU11244@42.do-not-panic.com>
References: <20200415065940.4103990-1-slyfox@gentoo.org>
 <20200416051127.GF11244@42.do-not-panic.com>
 <20200416080316.25d83dc0@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416080316.25d83dc0@sf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 08:03:16AM +0100, Sergei Trofimovich wrote:
> On Thu, 16 Apr 2020 05:11:27 +0000
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Sergei, first, thanks for your patch and bug report!!
> > 
> > On Wed, Apr 15, 2020 at 07:59:40AM +0100, Sergei Trofimovich wrote:
> > > Before this change on a system with the following setup crashed kernel:
> > > 
> > > ```
> > > CONFIG_STATIC_USERMODEHELPER=y
> > > CONFIG_STATIC_USERMODEHELPER_PATH=""
> > > kernel.core_pattern = |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e
> > > ```  
> > 
> > Let us backtrack. The combination of:
> > 
> > CONFIG_STATIC_USERMODEHELPER=y                                                
> > CONFIG_STATIC_USERMODEHELPER_PATH=""
> > 
> > is documented on the kconfig files for when you *want to disable all
> > usermode helper programs.
> > 
> > > The crash happens when a core dump is attempted:
> > > 
> > > ```
> > > [    2.819676] BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > [    2.819859] #PF: supervisor read access in kernel mode
> > > [    2.820035] #PF: error_code(0x0000) - not-present page
> > > [    2.820188] PGD 0 P4D 0
> > > [    2.820305] Oops: 0000 [#1] SMP PTI
> > > [    2.820436] CPU: 2 PID: 89 Comm: a Not tainted 5.7.0-rc1+ #7
> > > [    2.820680] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
> > > [    2.821150] RIP: 0010:do_coredump+0xd80/0x1060
> > > [    2.821385] Code: e8 95 11 ed ff 48 c7 c6 cc a7 b4 81 48 8d bd 28 ff ff ff 89 c2 e8 70 f1 ff ff 41 89 c2 85 c0 0f 84 72 f7 ff ff e9 b4 fe ff ff <48> 8b 57 20 0f b7 02 66 25 00 f0 66 3d 00 8
> > > 0 0f 84 9c 01 00 00 44
> > > [    2.822014] RSP: 0000:ffffc9000029bcb8 EFLAGS: 00010246
> > > [    2.822339] RAX: 0000000000000000 RBX: ffff88803f860000 RCX: 000000000000000a
> > > [    2.822746] RDX: 0000000000000009 RSI: 0000000000000282 RDI: 0000000000000000
> > > [    2.823141] RBP: ffffc9000029bde8 R08: 0000000000000000 R09: ffffc9000029bc00
> > > [    2.823508] R10: 0000000000000001 R11: ffff88803dec90be R12: ffffffff81c39da0
> > > [    2.823902] R13: ffff88803de84400 R14: 0000000000000000 R15: 0000000000000000
> > > [    2.824285] FS:  00007fee08183540(0000) GS:ffff88803e480000(0000) knlGS:0000000000000000
> > > [    2.824767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    2.825111] CR2: 0000000000000020 CR3: 000000003f856005 CR4: 0000000000060ea0
> > > [    2.825479] Call Trace:
> > > [    2.825790]  get_signal+0x11e/0x720
> > > [    2.826087]  do_signal+0x1d/0x670
> > > [    2.826361]  ? force_sig_info_to_task+0xc1/0xf0
> > > [    2.826691]  ? force_sig_fault+0x3c/0x40
> > > [    2.826996]  ? do_trap+0xc9/0x100
> > > [    2.827179]  exit_to_usermode_loop+0x49/0x90
> > > [    2.827359]  prepare_exit_to_usermode+0x77/0xb0
> > > [    2.827559]  ? invalid_op+0xa/0x30
> > > [    2.827747]  ret_from_intr+0x20/0x20
> > > [    2.827921] RIP: 0033:0x55e2c76d2129
> > > [    2.828107] Code: 2d ff ff ff e8 68 ff ff ff 5d c6 05 18 2f 00 00 01 c3 0f 1f 80 00 00 00 00 c3 0f 1f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 <0f> 0b b8 00 00 00 00 5d c3 66 2e 0f 1f 84 0
> > > 0 00 00 00 00 0f 1f 40
> > > [    2.828603] RSP: 002b:00007fffeba5e080 EFLAGS: 00010246
> > > [    2.828801] RAX: 000055e2c76d2125 RBX: 0000000000000000 RCX: 00007fee0817c718
> > > [    2.829034] RDX: 00007fffeba5e188 RSI: 00007fffeba5e178 RDI: 0000000000000001
> > > [    2.829257] RBP: 00007fffeba5e080 R08: 0000000000000000 R09: 00007fee08193c00
> > > [    2.829482] R10: 0000000000000009 R11: 0000000000000000 R12: 000055e2c76d2040
> > > [    2.829727] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > [    2.829964] CR2: 0000000000000020
> > > [    2.830149] ---[ end trace ceed83d8c68a1bf1 ]---
> > > ```
> > > 
> > > Here is the sequence of events why it happens:
> > > fs/coredump.c:do_coredump():
> > > 1. create 'coredump_params = { .file = NULL }'
> > > 2. detect pipe mode
> > > 3. `call_usermodehelper_setup(..., umh_pipe_setup, ...)`
> > > 4. `call_usermodehelper_exec()`
> > > 5. (if both succeeded) `file_start_write(cprm.file);`
> > > 
> > > Here crash happens at [5.] as `cprm.file` is still NULL.
> > > 
> > > Normally it works because `fs/coredump.c:umh_pipe_setup()` is called
> > > successfully and populates `.file` field (or returns the error):
> > > 
> > > ```
> > > static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > > {
> > >         //...
> > >         struct coredump_params *cp = (struct coredump_params *)info->data;
> > >         // ...
> > >         cp->file = files[1];
> > >         // ...
> > > }
> > > ```
> > > 
> > > But in our case neither happens because `kernel/umh.c:call_usermodehelper_exec()`
> > > has a special case:
> > > 
> > > ```
> > > int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> > > {
> > >     int retval = 0;
> > >     // ...
> > >     /*
> > >      * If there is no binary for us to call, then just return and get out of
> > >      * here.  This allows us to set STATIC_USERMODEHELPER_PATH to "" and
> > >      * disable all call_usermodehelper() calls.
> > >      */
> > >     if (strlen(sub_info->path) == 0)
> > >         goto out;
> > >     ...
> > >     out:
> > >         // ...
> > >         return retval;
> > > 
> > > ```
> > > 
> > > This breaks assumption of `do_coredump()`: "either helper was called successfully
> > > and created a file to dump core to or it failed".
> > > 
> > > This change converts this special case to `-EPERM` error.
> > > 
> > > This way we notify user that helper call was not successful
> > > and don't attempt to act on uninitialized `.file` field.
> > > 
> > > User gets `"Core dump to |%s pipe failed\n` dmesg entry.
> > > 
> > > Reported-by: Sergey Kvachonok <ravenexp@gmail.com>
> > > Reported-by: Tony Vroon <chainsaw@gentoo.org>
> > > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=199795
> > > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > > CC: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  kernel/umh.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/umh.c b/kernel/umh.c
> > > index 7f255b5a8845..66b02634a9ba 100644
> > > --- a/kernel/umh.c
> > > +++ b/kernel/umh.c
> > > @@ -565,8 +565,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> > >  	 * here.  This allows us to set STATIC_USERMODEHELPER_PATH to "" and
> > >  	 * disable all call_usermodehelper() calls.
> > >  	 */
> > > -	if (strlen(sub_info->path) == 0)
> > > +	if (strlen(sub_info->path) == 0) {
> > > +		retval = -EPERM;
> > >  		goto out;
> > > +	}
> > >  
> > >  	/*
> > >  	 * Set the completion pointer only if there is a waiter.  
> > 
> > Stakeholders with this setup likely already are relying on the fact that
> > we don't return -EPERM. Your change to return -EPERM may fix the crash
> > you are seeing, but it may also break existing userspace, granted
> > for a crashdump that may not matter much, however I agree it is stupid
> > to crash on a crash :)
> > 
> > Anyway, I don't think its a good idea to return -EPERM unless
> > stakeholders really find a strong reason to change old behaviour.
> 
> I agree changing existing API semantics is dangerous.
> Maybe tweaking a docstring to call_usermodehelper_exec() would be helpful.
> Something like:
> 
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -544,6 +544,11 @@ EXPORT_SYMBOL_GPL(fork_usermode_blob);
>   * Runs a user-space application.  The application is started
>   * asynchronously if wait is not set, and runs as a child of system workqueues.
>   * (ie. it runs with full root capabilities and optimized affinity).
> + *
> + * Note: successful return value does not guarantee helper was called at all.
> + * You can't rely on sub_info->{init,cleanup} being called even for UMH_WAIT_*
> + * wait modes as STATIC_USERMODEHELPER_PATH="" turns all helpers
> + * into a successful no-op.
>   */
>  int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  {
> 
> > Can you try this patch instead?
> 
> Gave it a light crash-test locally. Works fine!
> 
> Tested-by: Sergei Trofimovich <slyfox@gentoo.org>

Thanks, I'll send a follow up.

  Luis
