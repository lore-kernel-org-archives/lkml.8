Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF97C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224482071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUaYUxCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFOV5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOV5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:57:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:57:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so8215696pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+XZNwwgFRWN2YfgBwEC3ayNYLxxibOoTCejm5/GHWY=;
        b=VUaYUxCHIB99FCGZtex1432WECyI2mAyKaZV0DeKfdICp6jdhd5cGggKM0iy6sTP+S
         IXIReYqfCqyeiTV36w0eYXRL5sf2Ado4zz6F+qFQr0kavyIc+/xiCKlVv1zAsmyzQBmm
         U5pNlukcJbhvYokWPIUOm/3p0S+eXzqqMvKLwFSNj9mryLXhJuV/dYVXcOI2KQJDPYmC
         xWkof1oiLCjHUTJgo7AtxkE8LZbb41uXURN3JiF5lf7/b8C3GXW7HKqVr+TvhtSvKsLR
         JbUm+Y42Nkwg/DPToj8oT/AqjfnfFjLfPOFiM/O2BdzBVcrNtCGzrE/BlAa6fdyMgzim
         K2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+XZNwwgFRWN2YfgBwEC3ayNYLxxibOoTCejm5/GHWY=;
        b=QaFcR+kCfa7y3F4csD4vydtLjZrigQLKMZYTs2t2jDyqcIyIcmhOfp3djF+IIYwBqe
         2+mD1V7V08iNRYzEnITbX552fkMJbF5xrisvchIVNC0X9FnCfVMLcPdzuVpMaxVFAbBZ
         +yn+3D0I1YHcXLLevfMvlyMT3OPJzcUO5GOdlAKm+1QOQxD0FYZ0bA5VZ6PN1f6RKZus
         fHG+xKrcK47oxdXC/n5cWfSquHG5zUFmv//K7ATDQyk9EfQKkKZDc6mKOk8mbXJdMUlW
         37vTDUk8vv0zBKS7ArVutP9PdiFF1TTlziF026qqq4nCTl6+1AFt2w0/pq+nx0xiWffe
         IWTg==
X-Gm-Message-State: AOAM531BAMgQ5zd8akfa+OnjNhfJhma4UnVER4SDGYpeM6VvqN3Rptu8
        01TpnFQvNhHGOIpFev7n7dM=
X-Google-Smtp-Source: ABdhPJyQcyN3op+rH0nbrDKoATRuWGkI1oYXTY9OJWje5wgokCdaDAl6t7F21JJs83LjpfHykyMW2g==
X-Received: by 2002:aa7:84cf:: with SMTP id x15mr24773327pfn.214.1592258270068;
        Mon, 15 Jun 2020 14:57:50 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id ha16sm405421pjb.40.2020.06.15.14.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:57:49 -0700 (PDT)
Date:   Tue, 16 Jun 2020 06:57:47 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Subject: Re: mm lock issue while booting Linux on 5.8-rc1 for RISC-V
Message-ID: <20200615215747.GO75760@lianli.shorne-pla.net>
References: <CAOnJCUJ_rA6TW0QgmDkXnrMoyKKMBygzs1sFQukuJ3mAF3Cu1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUJ_rA6TW0QgmDkXnrMoyKKMBygzs1sFQukuJ3mAF3Cu1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:28:11AM -0700, Atish Patra wrote:
> Hi,
> I encountered the following issue while booting 5.8-rc1 on Qemu for RV64.
> I added additional dump_stack and observed that it's happening in bpf free path.
> It happens always if CONFIG_DEBUG_VM is enabled. VM_BUG_ON_MM is
> compiled away without that.
> ------------------------------------------------------------------------
> forked to background, child pid 113
> [   10.328850] CPU: 3 PID: 51 Comm: kworker/3:1 Not tainted
> 5.8.0-rc1-dirty #732
> [   10.331739] Workqueue: events bpf_prog_free_deferred
> [   10.334133] Call Trace:
> [   10.338039] [<ffffffe000202698>] walk_stackframe+0x0/0xa4
> [   10.339988] [<ffffffe000202880>] show_stack+0x2e/0x3a
> [   10.340902] [<ffffffe00047074c>] dump_stack+0x72/0x8c
> [   10.341451] [<ffffffe0002db4ce>] mmap_assert_locked.part.13+0x14/0x1c
> [   10.342131] [<ffffffe0002db330>] walk_page_range_novma+0x0/0x4e
> [   10.342973] [<ffffffe000204f94>] set_direct_map_invalid_noflush+0x66/0x6e
> [   10.343917] [<ffffffe0002e0706>] __vunmap+0xe8/0x212
> [   10.344680] [<ffffffe0002e0882>] __vfree+0x22/0x6e
> [   10.345270] [<ffffffe0002e0902>] vfree+0x34/0x56
> [   10.345834] [<ffffffe00027d752>] __bpf_prog_free+0x2c/0x36
> [   10.346529] [<ffffffe0002801a2>] bpf_prog_free_deferred+0x74/0x8a
> [   10.347394] [<ffffffe000219c70>] process_one_work+0x13a/0x272
> [   10.348239] [<ffffffe00021a4b4>] worker_thread+0x50/0x2e4
> [   10.348900] [<ffffffe00021ed98>] kthread+0xfc/0x10a
> [   10.349470] [<ffffffe0002013da>] ret_from_exception+0x0/0xc
> [   10.354405] mm ffffffe001018600 mmap 0000000000000000 seqnum 0 task_size 0
> [   10.354405] get_unmapped_area 0000000000000000
> [   10.354405] mmap_base 0 mmap_legacy_base 0 highest_vm_end 0
> [   10.354405] pgd ffffffe001074000 mm_users 2 mm_count 1
> pgtables_bytes 8192 map_count 0
> [   10.354405] hiwater_rss 0 hiwater_vm 0 total_vm 0 locked_vm 0
> [   10.354405] pinned_vm 0 data_vm 0 exec_vm 0 stack_vm 0
> [   10.354405] start_code ffffffe000200000 end_code ffffffe00084acc2
> start_data 0 end_data ffffffe00106dfe4
> [   10.354405] start_brk 0 brk ffffffe0010bd6d0 start_stack 0
> [   10.354405] arg_start 0 arg_end 0 env_start 0 env_end 0
> [   10.354405] binfmt 0000000000000000 flags 0 core_state 0000000000000000
> [   10.354405] ioctx_table 0000000000000000
> [   10.354405] exe_file 0000000000000000
> [   10.354405] tlb_flush_pending 0
> [   10.354405] def_flags: 0x0()
> [   10.369325] ------------[ cut here ]------------
> [   10.370763] kernel BUG at include/linux/mmap_lock.h:81!
> [   10.375235] Kernel BUG [#1]
> [   10.377198] Modules linked in:
> [   10.378931] CPU: 3 PID: 51 Comm: kworker/3:1 Not tainted 5.8.0-rc1-dirty #732
> [   10.380179] Workqueue: events bpf_prog_free_deferred
> [   10.381270] epc: ffffffe0002db4d4 ra : ffffffe0002db4d4 sp : ffffffe3eaea7c70
> [   10.382561]  gp : ffffffe00106d950 tp : ffffffe3ef752f80 t0 :
> ffffffe0010836e8
> [   10.383996]  t1 : 0000000000000064 t2 : 0000000000000000 s0 :
> ffffffe3eaea7c90
> [   10.385119]  s1 : ffffffe001018600 a0 : 0000000000000289 a1 :
> 0000000000000020
> [   10.386099]  a2 : 0000000000000005 a3 : 0000000000000000 a4 :
> ffffffe001012758
> [   10.387294]  a5 : 0000000000000000 a6 : 0000000000000102 a7 :
> 0000000000000006
> [   10.388265]  s2 : ffffffe3f00674c0 s3 : ffffffe00106e108 s4 :
> ffffffe00106e100
> [   10.389250]  s5 : ffffffe00106e908 s6 : 0000000000000000 s7 :
> 6db6db6db6db6db7
> [   10.390272]  s8 : 0000000000000001 s9 : ffffffe00021a4f8 s10:
> ffffffffffffffff
> [   10.391293]  s11: ffffffe3f0066600 t3 : 000000000001a7a8 t4 :
> 000000000001a7a8
> [   10.392314]  t5 : 0000000000000000 t6 : ffffffe00107b76b
> [   10.393096] status: 0000000000000120 badaddr: 0000000000000000
> cause: 0000000000000003
> [   10.397755] ---[ end trace 861659596ac28841 ]---
> ---------------------------------------------------------------------------------------------------
> 
> I haven't had the chance to bisect to figure out which commit caused
> the issue. Just wanted
> to check if it is a known issue already.

Hi Atish,

Note, I am getting the same (just now) when booting v5.8-rc1 on OpenRISC.  If
you have any updates please post back.  I will try to look into this today or
tomorrow.

-Stafford
