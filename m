Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0E920756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597140801;
	bh=sxalbirXKTrzUzilHNqlhefi10Ahai737Gtu+KvD8MQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qMxWwqeXFgjPCYu0nCI3m0GfrYFQQ3SB4c54b/84zvrYN1q1wZ/siYgXxcYfh4QkT
	 XdY6LroVGD0NK9DjWHNxQv1L4MuCaCxSvXAfjwE6xnu+Bjx14kd94VWq36AzRGIAkv
	 ISprXLD4m1BC2Ziw4CisLVs9Zv3hVVlNSznjNveM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHKKNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgHKKNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:13:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6B52054F;
        Tue, 11 Aug 2020 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597140798;
        bh=sxalbirXKTrzUzilHNqlhefi10Ahai737Gtu+KvD8MQ=;
        h=Date:From:To:Cc:Subject:From;
        b=V8udMVEbBM5Sxcaiwq/68D1ayyW7QcSw4SqeMzYzL5ebOZJpl/kdohZznjhKd2nNw
         8xcTT0DnXigx70xuSgJakCxxv5k4cu2eQxbW8cxGWZ42LD1U9PMx0E7/oPzE1CRDro
         3wc+GaToT8BnenfRZnHD+5vRFC0OpI84r48gZnkE=
Date:   Tue, 11 Aug 2020 11:13:13 +0100
From:   Will Deacon <will@kernel.org>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: lockdep splat ("possible circular locking dependency detected") with
 PL011 on 5.8
Message-ID: <20200811101313.GA6970@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using magic-sysrq via a keyboard interrupt over the serial console results in
the following lockdep splat with the PL011 UART driver on v5.8. I can reproduce
the issue under QEMU with arm64 defconfig + PROVE_LOCKING.

Any chance somebody could take a look, please? It's a little annoying,
because it means when I uses magic-sysrq to increase the loglevel prior
to testing something else, lockdep gets disabled as a result.

Cheers,

Will

--->8

[   56.377562] sysrq: Changing Loglevel
[   56.385777] sysrq: Loglevel set to 9
[   56.387291] 
[   56.387378] ======================================================
[   56.387391] WARNING: possible circular locking dependency detected
[   56.387401] 5.8.0 #2 Not tainted
[   56.387411] ------------------------------------------------------
[   56.387421] swapper/0/0 is trying to acquire lock:
[   56.387467] ffffb190db294ab0 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable+0x34/0x70
[   56.387525] 
[   56.387535] but task is already holding lock:
[   56.387544] ffff0000fe512898 (&port_lock_key){-.-.}-{2:2}, at: pl011_int+0x40/0x488
[   56.387582] 
[   56.387592] which lock already depends on the new lock.
[   56.387600] 
[   56.387608] 
[   56.387618] the existing dependency chain (in reverse order) is:
[   56.387626] 
[   56.387633] -> #1 (&port_lock_key){-.-.}-{2:2}:
[   56.387671]        lock_acquire+0xc8/0x2a0
[   56.387680]        _raw_spin_lock+0x6c/0x84
[   56.387690]        pl011_console_write+0x88/0x1e0
[   56.387699]        console_unlock+0x2f4/0x544
[   56.387708]        vprintk_emit+0x130/0x1c4
[   56.387717]        vprintk_default+0x4c/0x74
[   56.387726]        vprintk_func+0x1fc/0x204
[   56.387735]        printk+0x5c/0x84
[   56.387744]        register_console+0x340/0x38c
[   56.387754]        uart_add_one_port+0x4b0/0x590
[   56.387763]        pl011_register_port+0x98/0xd4
[   56.387772]        sbsa_uart_probe+0x240/0x294
[   56.387781]        platform_drv_probe+0x98/0xc0
[   56.387791]        really_probe+0x1b8/0x430
[   56.387800]        driver_probe_device+0x80/0xbc
[   56.387809]        __device_attach_driver+0x100/0x11c
[   56.387821]        bus_for_each_drv+0x84/0xd0
[   56.387830]        __device_attach+0xc4/0x168
[   56.387840]        device_initial_probe+0x18/0x24
[   56.387849]        bus_probe_device+0x38/0xa0
[   56.387858]        device_add+0x8f8/0xa10
[   56.387868]        platform_device_add+0x88/0x228
[   56.387878]        platform_device_register_full+0x13c/0x180
[   56.387888]        acpi_create_platform_device+0x1f4/0x254
[   56.387897]        acpi_bus_attach+0x284/0x2cc
[   56.387906]        acpi_bus_attach+0xcc/0x2cc
[   56.387916]        acpi_bus_attach+0xcc/0x2cc
[   56.387925]        acpi_bus_scan+0x4c/0xac
[   56.387934]        acpi_scan_init+0xc0/0x24c
[   56.387943]        acpi_init+0xa4/0xbc
[   56.387952]        do_one_initcall+0x9c/0x17c
[   56.387961]        do_initcall_level+0x9c/0xb8
[   56.387971]        do_initcalls+0x54/0x94
[   56.387980]        do_basic_setup+0x24/0x30
[   56.387989]        kernel_init_freeable+0x158/0x1b0
[   56.387998]        kernel_init+0x18/0x190
[   56.388007]        ret_from_fork+0x10/0x30
[   56.388015] 
[   56.388023] -> #0 (console_owner){-.-.}-{0:0}:
[   56.388060]        validate_chain+0x658/0x2918
[   56.388069]        __lock_acquire+0xb4c/0xf98
[   56.388078]        lock_acquire+0xc8/0x2a0
[   56.388088]        console_lock_spinning_enable+0x60/0x70
[   56.388097]        console_unlock+0x2ac/0x544
[   56.388106]        vprintk_emit+0x130/0x1c4
[   56.388115]        vprintk_default+0x4c/0x74
[   56.388124]        vprintk_func+0x1fc/0x204
[   56.388133]        printk+0x5c/0x84
[   56.388142]        __handle_sysrq+0x180/0x200
[   56.388151]        handle_sysrq+0x30/0x3c
[   56.388160]        pl011_fifo_to_tty+0xf4/0x200
[   56.388170]        pl011_int+0x204/0x488
[   56.388179]        __handle_irq_event_percpu+0xac/0x1a0
[   56.388188]        handle_irq_event+0x64/0x150
[   56.388198]        handle_fasteoi_irq+0xf8/0x1cc
[   56.388207]        __handle_domain_irq+0x8c/0xd0
[   56.388216]        gic_handle_irq+0xc8/0x168
[   56.388225]        el1_irq+0xbc/0x180
[   56.388234]        arch_cpu_idle+0x3c/0x5c
[   56.388243]        do_idle+0x104/0x2b0
[   56.388253]        cpu_startup_entry+0x28/0x2c
[   56.388262]        rest_init+0x1f4/0x208
[   56.388271]        arch_call_rest_init+0x10/0x1c
[   56.388280]        start_kernel+0x3a4/0x420
[   56.388288] 
[   56.388298] other info that might help us debug this:
[   56.388305] 
[   56.388315]  Possible unsafe locking scenario:
[   56.388322] 
[   56.388332]        CPU0                    CPU1
[   56.388341]        ----                    ----
[   56.388349]   lock(&port_lock_key);
[   56.388373]                                lock(console_owner);
[   56.388396]                                lock(&port_lock_key);
[   56.388418]   lock(console_owner);
[   56.388440] 
[   56.388448]  *** DEADLOCK ***
[   56.388456] 
[   56.388465] 3 locks held by swapper/0/0:
[   56.388473]  #0: ffff0000fe512898 (&port_lock_key){-.-.}-{2:2}, at: pl011_int+0x40/0x488
[   56.388516]  #1: ffffb190db297770 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x40
[   56.388559]  #2: ffffb190db294990 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x128/0x1c4
[   56.388602] 
[   56.388611] stack backtrace:
[   56.388621] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0 #2
[   56.388632] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   56.388640] Call trace:
[   56.388649]  dump_backtrace+0x0/0x1d8
[   56.388658]  show_stack+0x1c/0x28
[   56.388667]  dump_stack+0xe4/0x190
[   56.388676]  print_circular_bug+0x5dc/0x610
[   56.388685]  check_noncircular+0x1a8/0x1b0
[   56.388694]  validate_chain+0x658/0x2918
[   56.388703]  __lock_acquire+0xb4c/0xf98
[   56.388712]  lock_acquire+0xc8/0x2a0
[   56.388721]  console_lock_spinning_enable+0x60/0x70
[   56.388730]  console_unlock+0x2ac/0x544
[   56.388739]  vprintk_emit+0x130/0x1c4
[   56.388748]  vprintk_default+0x4c/0x74
[   56.388757]  vprintk_func+0x1fc/0x204
[   56.388766]  printk+0x5c/0x84
[   56.388776]  __handle_sysrq+0x180/0x200
[   56.388787]  handle_sysrq+0x30/0x3c
[   56.388796]  pl011_fifo_to_tty+0xf4/0x200
[   56.388805]  pl011_int+0x204/0x488
[   56.388815]  __handle_irq_event_percpu+0xac/0x1a0
[   56.388824]  handle_irq_event+0x64/0x150
[   56.388834]  handle_fasteoi_irq+0xf8/0x1cc
[   56.388843]  __handle_domain_irq+0x8c/0xd0
[   56.388852]  gic_handle_irq+0xc8/0x168
[   56.388861]  el1_irq+0xbc/0x180
[   56.388870]  arch_cpu_idle+0x3c/0x5c
[   56.388880]  do_idle+0x104/0x2b0
[   56.388889]  cpu_startup_entry+0x28/0x2c
[   56.388898]  rest_init+0x1f4/0x208
[   56.388907]  arch_call_rest_init+0x10/0x1c
[   56.388917]  start_kernel+0x3a4/0x420
