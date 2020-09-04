Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6D20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0unH8lzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgIDJmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:42:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC30C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:42:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so6065732wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ihStvmxeICdK+2a2A315UqI3Xpm7Xki56CG14zw6b0=;
        b=0unH8lzKp8Z+k7t2GxLe3AOI5ZJPTvjuzsO13RClY/8OIKkbAgGSb1XfWdbXC95zig
         s1pV4hJj3/gpovqCY8D2yKX7dwmasdKuq4GFZB3a0uXwshWJtyDS3uB7bKN4RH/bZDF+
         T8x/UXVpPqZvqN605TwGcGJFOY7IYuqghOIpOCx6FIoWJVi7AjzxCYxv4lg+9IxNu4Fk
         47hzdZ2qtZJMKjqiI640LFVbsyQqDWtMleES6syOFbfH1cclGkD+WjaUQAs3pYiascD4
         hHHCu2fWCnjz1ncyvsxEUSaZhCp00z5OsGZGrwlI6RmN3/41kDgE5ugNGb5d1w+rOrXU
         haDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ihStvmxeICdK+2a2A315UqI3Xpm7Xki56CG14zw6b0=;
        b=iPdbP5mYbQABAPckIerqxQsWZ8XFqFe7A7+jhLJyw1GmT3ROpX2NYnrKmKR98tqopB
         K4n+X+sTdLbIASrTT/EbXojprjpVAV1pF3fOK4g5h1XZvLTdXSdGbIgymeb8KpIPPCYx
         zc1VcsrHj0hpO5OQbSkyU8uF3aFqUv9hunHxkG8CWdxeOsOd2oiZPV+2Ibh+HRctueUI
         wzeyDlTbjDSrFR9PmH787HQKloT3XqtBOJX1VVQ5f6LkSEa740Ql4L7yAl2zRVP0iQVh
         6SQHen2kHsb95+VaIzAy49gHeWWGW28SPUNGc8hf1N4LNWAOBUFFc+QhYmtd+lcYBkFN
         mENw==
X-Gm-Message-State: AOAM53348i79uyD2L/CzDcrrp1lU69Jq6h34t6cpD7qK7+h4xL0dJjYU
        2NPfPdNsSbHWK9dgBb+FgZgxtZ5JeABQ4qqDsC1efg==
X-Google-Smtp-Source: ABdhPJxiVm+aSLeVUDG0U95BMpgibDzqkLKjiLIqtjEwVu/9BCH0d0+r85PB/STLsUXC/wVTvpnCOuy5SxWyLXM+zT4=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr6843739wrp.356.1599212549757;
 Fri, 04 Sep 2020 02:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com> <20200904083109.GA9182@infradead.org>
In-Reply-To: <20200904083109.GA9182@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 4 Sep 2020 15:12:18 +0530
Message-ID: <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 2:01 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 21, 2020 at 12:35:20PM -0700, Linus Torvalds wrote:
> > On Fri, Aug 21, 2020 at 11:26 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > * The CLINT driver has been split in two: one to handle the M-mode CLINT
> > >   (memory mapped and used on NOMMU systems) and one to handle the S-mode CLINT
> > >   (via SBI).
> >
> > This looks more like development than fixes.
> >
> > I guess I don't care deeply enough about it, but please don't do this.
>
> Well, I care because this late pull requests completely breaks nommu
> (nommu_virt_defconfig).   More specifically commit 2bc3fc877aa9
> ("RISC-V: Remove CLINT related code from timer and arch") leas to this
> spew when booting under qemu:
>
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@c000000: mapped 53 interrupts with 2 handlers for 4 contexts.
> [    0.000000] Oops - illegal instruction [#1]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc1-00003-g2bc3fc877aa9c4 #609
> [    0.000000] epc: 000000008000de78 ra : 000000008000ddaa sp : 0000000080187f40
> [    0.000000]  gp : 00000000801a3aa8 tp : 000000008018bd40 t0 : 0000000000000019
> [    0.000000]  t1 : 0000000000000018 t2 : 0000000000000001 s0 : 0000000080187f80
> [    0.000000]  s1 : 0000000000000200 a0 : 000000008019b738 a1 : 0000000000000000
> [    0.000000]  a2 : ffffffff80187f50 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000080169018 a6 : 0000000000000000 a7 : 00000000000001e4
> [    0.000000]  s2 : 00000000801a40a8 s3 : 00000000801a4068 s4 : 000000008fc7c040
> [    0.000000]  s5 : 00000000801a4038 s6 : 00000000801a4030 s7 : 0000000080012da0
> [    0.000000]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : 00000000801c40d8 t4 : 0000000000000068
> [    0.000000]  t5 : 000000000000004c t6 : 0000000000000033
> [    0.000000] status: 0000000000001800 badaddr: 0000000000000000 cause: 0000000000000002
> [    0.000000] random: get_random_bytes called from 0x00000000800210c4 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

I tried Linux-5.9-rc3 using nommu_virt_defconfig at my end. I am not
able to reproduce
this issue. Is there additional Kconfig option required to reproduce
this issue ??

anup@anup-ubuntu64-vm:~/Work/riscv-test/nommu$ qemu-system-riscv64 -M
virt -m 8M -display none -nographic -kernel
./build-riscv64/arch/riscv/boot/loader -append "root=/dev/ram rw
console=ttyS0" -smp 4
qemu-system-riscv64: warning: No -bios option specified. Not loading a firmware.
qemu-system-riscv64: warning: This default will change in a future
QEMU release. Please use the -bios option to avoid breakages when this
happens.
qemu-system-riscv64: warning: See QEMU's deprecation documentation for details.
[    0.000000] Linux version 5.9.0-rc3 (anup@anup-ubuntu64-vm)
(riscv64-unknown-linux-gnu-gcc (GCC) 9.2.0, GNU ld (GNU Binutils)
2.34) #1 SMP Fri Sep 4 15:02:31 IST 2020
[    0.000000] earlycon: uart8250 at MMIO 0x0000000010000000 (options
'115200n8')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000807fffff]
[    0.000000] riscv: ISA extensions acdfimsu
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: max_distance=0x30000 too large for vmalloc space 0x0
[    0.000000] percpu: Embedded 12 pages/cpu s18592 r0 d30560 u49152
[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 2020
[    0.000000] Kernel command line: root=/dev/vda rw
earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0
[    0.000000] Dentry cache hash table entries: 1024 (order: 1, 8192
bytes, linear)
[    0.000000] Inode-cache hash table entries: 512 (order: 0, 4096
bytes, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 6016K/8192K available (1283K kernel code, 138K
rwdata, 200K rodata, 106K init, 133K bss, 2176K reserved, 0K
cma-reserved)
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: plic@c000000: mapped 53 interrupts with 4
handlers for 8 contexts.
[    0.000000] random: get_random_bytes called from 0x00000000800019b4
with crng_init=0
[    0.000000] clint: clint@2000000: timer running at 10000000 Hz
[    0.000000] clocksource: clint_clocksource: mask:
0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120
ns
[    0.000212] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
every 4398046511100ns
[    0.016835] Console: colour dummy device 80x25
[    0.034899] Calibrating delay loop (skipped), value calculated
using timer frequency.. 20.00 BogoMIPS (lpj=40000)
[    0.050107] pid_max: default: 4096 minimum: 301
[    0.051951] Mount-cache hash table entries: 512 (order: 0, 4096
bytes, linear)
[    0.052711] Mountpoint-cache hash table entries: 512 (order: 0,
4096 bytes, linear)
[    0.151318] rcu: Hierarchical SRCU implementation.
[    0.158697] smp: Bringing up secondary CPUs ...
[    0.213140] smp: Brought up 1 node, 4 CPUs
[    0.245903] devtmpfs: initialized
[    0.262757] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.264822] futex hash table entries: 16 (order: -2, 1024 bytes, linear)
[    0.413555] clocksource: Switched to clocksource clint_clocksource
[    0.580364] workingset: timestamp_bits=62 max_order=11 bucket_order=0
[    0.589640] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.604478] printk: console [ttyS0] disabled
[    0.611025] 10000000.uart: ttyS0 at MMIO 0x10000000 (irq = 2,
base_baud = 230400) is a 16550A
[    0.621897] printk: console [ttyS0] enabled
[    0.621897] printk: console [ttyS0] enabled
[    0.622997] printk: bootconsole [uart8250] disabled
[    0.622997] printk: bootconsole [uart8250] disabled
[    0.646964] syscon-poweroff soc:poweroff: pm_power_off already
claimed (____ptrval____)
[    0.648264] syscon-poweroff: probe of soc:poweroff failed with error -16
[    0.677403] VFS: Cannot open root device "vda" or
unknown-block(0,0): error -6
[    0.679474] Please append a correct "root=" boot option; here are
the available partitions:
[    0.682862] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(0,0)

Regards,
Anup
