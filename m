Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F7E2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ilg0T+sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHXM3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:29:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70073C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:29:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o64so1029562qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DvXVXQBGeCp575LsYUQ2noCVvh4pOaK9+sGcXNN5mC0=;
        b=ilg0T+sH9RCis4SgJ1afoZCALTChF57q20f8JRTNGbed7eSn6Bm1mUPN5KR8m/eX1C
         wjD354EWg4LgpbpbwOSMmkpqjJZuLNQ1I5LCBItr35O7QQRSYYCWQ2mjr6dGPqd61QAr
         O/LOx2vtbgKMLf4QikU08qzA/8oBG0DAqTGdfLTuUYeSisy6N4M7lNhL3eX8mCWr+arZ
         hSz4ZaSRSO1EQ8XtE63ov6JBzCOTKxEjl8xD7iPOFTWhZC3ohBnv7tchnXhG41i6Lc/1
         VszNaiFQOSkUQ6p7C5uL+vTP98t6fERfTWFgHfLATpmFmwOJ91vjtM6wWTKD6isv5wYz
         UKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DvXVXQBGeCp575LsYUQ2noCVvh4pOaK9+sGcXNN5mC0=;
        b=dWlfNSjOU6FiWNstO5kpVW073z+lu0Yh2BDhP+/dnzp/zr/82I5pefGdVCfhAuFVO3
         ccJmhLPth264INMUsEwu6Irb/VD86oy9a+w14oODoa+NJEaY/VddpA3soH1qqcNnhTfQ
         /xYCSfeBIme9u9VzWSLFVmtAkpNTLQ4ukNb2TVihRZxGpilj1Ynx6JnJPRPornT2Xo6q
         fkgr8g8Av+EGIOShOeMDmZ/rEFq9XCkBsnjBeH1o7kkGLi51ja8veiXVCoNXV6sFar55
         GjdXxfIPgeExLwdwPcAZEg05YuDriSyrsuBaEcKc6/Y2rcNFv92XaptjH012tHaBPHDk
         rFrA==
X-Gm-Message-State: AOAM532XuqgC+9Recxi4M9RKBnUBkBUpYKNY9ggQFRiCv2qgDxRFChAk
        G3AdYomzbRi/Bw8xvkmsngNqbRHQjNF2Ug==
X-Google-Smtp-Source: ABdhPJxym8jXZ+Px3eVRzKoftW/X8WpiIDmKxRvp/rg66puqDNdlKZ2egBoq5o+0cW3N2KhyaaChSg==
X-Received: by 2002:a37:8301:: with SMTP id f1mr4314138qkd.86.1598272178622;
        Mon, 24 Aug 2020 05:29:38 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y24sm10767552qtv.71.2020.08.24.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:29:38 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:29:30 -0400
From:   Qian Cai <cai@lca.pw>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm] c566586818:
 BUG:kernel_hang_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
Message-ID: <20200824122929.GA4337@lca.pw>
References: <20200818002351.GC18179@shao2-debian>
 <20200821010132.GC4622@lca.pw>
 <5e286a22-921c-8e2b-14dc-7ef96e320010@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e286a22-921c-8e2b-14dc-7ef96e320010@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:47:20AM +0800, Rong Chen wrote:
> 
> 
> On 8/21/20 9:01 AM, Qian Cai wrote:
> > On Tue, Aug 18, 2020 at 08:23:51AM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: c5665868183fec689dbab9fb8505188b2c4f0757 ("mm: kmemleak: use the memory pool for early allocations")
> > I might see one of those early boot failure before. In my case, the bare-metal
> > system was reset. Can you try to narrow down to a smaller
> > CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE (assume 0 works if your bisecting was
> > correct) that works?
> 
> Hi Qian,
> 
> Adding CONFIG_EARLY_PRINTK=y to the kconfig file, and the boot hangs in the
> below position:
> 
> [    0.715834] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug
> apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1
> nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200
> console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=60
> [    0.719688] sysrq: sysrq always enabled.
> [    0.801005] Dentry cache hash table entries: 2097152 (order: 12, 16777216
> bytes, linear)
> [    0.805588] Inode-cache hash table entries: 1048576 (order: 11, 8388608
> bytes, linear)
> [    0.806464] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    1.080978] Memory: 12319196K/12680692K available (10243K kernel code,
> 2414K rwdata, 8184K rodata, 856K init, 20772K bss, 361496K reserved, 0K
> cma-reserved)
> qemu-system-x86_64: terminating on signal 2
> 
> The problem disappeared if CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400:

Interesting. Can you paste the line as show:

./scripts/faddr2line vmlinux lookup_address_in_pgd+0xd1/0x158

Also, does this happens on the latest mainline or linux-next? Looks like you
were reproducing using v5.3.

> 
> [    1.064575] Kernel command line: root=/dev/ram0 hung_task_panic=1 debug
> apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1
> nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200
> console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=60
> [    1.068883] sysrq: sysrq always enabled.
> [    1.108720] Dentry cache hash table entries: 2097152 (order: 12, 16777216
> bytes, linear)
> [    1.148852] Inode-cache hash table entries: 1048576 (order: 11, 8388608
> bytes, linear)
> [    1.150271] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    1.835309] Memory: 12325340K/12680692K available (10243K kernel code,
> 2414K rwdata, 8192K rodata, 856K init, 14628K bss, 355352K reserved, 0K
> cma-reserved)
> [    3.487078] general protection fault: 0000 [#1] DEBUG_PAGEALLOC PTI
> [    3.488185] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.3.0-11792-gc5665868183fe #1
> [    3.489581] RIP: 0010:lookup_address_in_pgd+0xd1/0x158
> [    3.490566] Code: 80 e0 01 0f 84 a7 00 00 00 49 89 f0 b8 11 ff ff 01 48
> 21 f9 49 c1 e8 12 48 c1 e0 27 41 81 e0 f8 0f 00 00 49 01 c0 49 8d 04 08 <48>
> f7 00 9f ff ff ff 0f 84 34 ff ff ff c7 02 02 00 00 00 48 8b 38
> [    3.494020] RSP: 0000:ffffffff8239e700 EFLAGS: 00010086
> [    3.494959] RAX: ffff110302110d90 RBX: 0000000000000001 RCX:
> ffff888302110000
> [    3.496222] RDX: ffffffff8239e72c RSI: ffff88833653b000 RDI:
> ffff88833653a000
> [    3.497363] RBP: ffffffff8239e808 R08: ffff888000000d90 R09:
> 0000000000346000
> [    3.498467] R10: 0000000000000001 R11: 0000000000000000 R12:
> 0000000000000001
> [    3.499554] R13: 0000000000000000 R14: ffff88833653b000 R15:
> 0000000000000000
> [    3.500638] FS:  0000000000000000(0000) GS:ffffffff8243d000(0000)
> knlGS:0000000000000000
> [    3.501863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.503036] CR2: ffff8883447ff000 CR3: 0000000002420000 CR4:
> 00000000000006b0
> [    3.504116] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    3.505156] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    3.506225] Call Trace:
> [    3.506597] Modules linked in:
> [    3.507255] random: get_random_bytes called from init_oops_id+0x1d/0x2c
> with crng_init=0
> [    3.508734] ---[ end trace 0000000000000000 ]---
> 
> 
> Best Regards,
> Rong Chen
