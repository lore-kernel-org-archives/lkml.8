Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883FFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A25A206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591573778;
	bh=0TF0leXYWFGxet7qAtSdeujQVIiYdI+NYlNSS88R1Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HD9eVdp3ELstWE58HdUEieKhUP+TzOM/hWYAKXQatJMameBX6J3160Ym43TJSAKd0
	 ZBmZ2S9J8kUie3bEkQjGU5Lme1Am32PzdRgNIA8Nfb77GLU4reFa2KeqGdagOe6TeN
	 z97LerM0oY/KnKvQZKwY3y0zfHlwD3G8muQs0KYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgFGXth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 19:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgFGXtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 19:49:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6980206D5;
        Sun,  7 Jun 2020 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591573776;
        bh=0TF0leXYWFGxet7qAtSdeujQVIiYdI+NYlNSS88R1Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZhwUklEiN78/5Rv9Z2cinkdxsqmdubQW5/hg7rxbaIZJMYXH1yaTwfKvWNgsR7hxR
         qjzzYKdnpEVEWDpyVf0rUA6z0IrJnwYRQ7j3OQOVmYBUrheyTfkfRAK4effJ90FvzC
         tY463T8ILmrprj6rDKt0NErsIX9F5NXtaQ+gD8LY=
Date:   Sun, 7 Jun 2020 16:49:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Steven Price <steven.price@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jan Beulich <jbeulich@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [x86] 24256c140e:
 dmesg.UBSAN:array-index-out-of-bounds_in_arch/x86/mm/dump_pagetables.c
Message-Id: <20200607164935.6df93a6018389f2ed995b26c@linux-foundation.org>
In-Reply-To: <20200607072749.GW12456@shao2-debian>
References: <20200607072749.GW12456@shao2-debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jun 2020 15:27:49 +0800 kernel test robot <rong.a.chen@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 24256c140e59c3431af4918fd4ec892102cbc2f3 ("x86: mm: ptdump: calculate effective permissions correctly")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    8.785395] UBSAN: array-index-out-of-bounds in arch/x86/mm/dump_pagetables.c:285:27
> [    8.787718] index -1 is out of range for type 'pgprotval_t [5]'
> [    8.789278] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc7-00027-g24256c140e59c #1
> [    8.791350] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    8.793505] Call Trace:
> [    8.794221]  dump_stack+0x6c/0x94
> [    8.795140]  ubsan_epilogue+0x8/0x3e
> [    8.796132]  __ubsan_handle_out_of_bounds+0x48/0x53
> [    8.797362]  ? is_visible+0x2b/0x32
> [    8.798231]  ? atomic_try_cmpxchg+0x4c/0x57
> [    8.799203]  note_page+0x37/0x80b
> [    8.800138]  ? __up_read+0x352/0x37b
> [    8.801124]  ptdump_walk_pgd+0x57/0x60
> [    8.802145]  ptdump_walk_pgd_level_core+0x72/0x9f
> [    8.803369]  ? ptdump_walk_pgd_level_debugfs+0x18/0x18
> [    8.804613]  ? ptdump_walk_pgd_level_core+0x9f/0x9f
> [    8.805779]  ptdump_walk_pgd_level_checkwx+0x1d/0x21
> [    8.806873]  mark_rodata_ro+0x9f/0xa6
> [    8.807821]  ? rest_init+0x7f/0x164
> [    8.808808]  kernel_init+0x44/0xf7
> [    8.809735]  ? rest_init+0x164/0x164
> [    8.810708]  ret_from_fork+0x19/0x24

Yup, thanks, the new note_page() doesn't handle level==-1, which is
"unknown" according to the comment in include/linux/ptdump.h.

Steven, could you please take a look?
