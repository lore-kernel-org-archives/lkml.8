Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61B020714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgG1J2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:28:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:29557 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgG1J2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:28:50 -0400
IronPort-SDR: GtK3jfF2Tkn6QqVEr85txDsjawIBfEHGgVAHiXnB9A8z8PB9h6oTccgH9kGqC9YS1wE3C30ANo
 nGIJqjZeXYkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="215700964"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="215700964"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 02:02:51 -0700
IronPort-SDR: DYsNK5p0wA1OX+qdux/yMXI60Qs1mPjG4h2tCf8nMSEeCd8IZD2ybs0hJz0aDd0PSjU8DjppkL
 KvYNrWKkAdpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="xz'?gz'50?scan'50,208,50";a="490283925"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2020 02:02:48 -0700
Date:   Tue, 28 Jul 2020 17:02:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: 17e5888e4e ("x86: Select HARDIRQS_SW_RESEND on x86"): [   12.158111]
 WARNING: possible circular locking dependency detected
Message-ID: <20200728090216.GE23458@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 17e5888e4e180b45af7bafe7f3a86440d42717f3
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Thu Jan 23 22:02:42 2020 +0100
Commit:     Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed Mar 11 22:39:39 2020 +0100

    x86: Select HARDIRQS_SW_RESEND on x86
    
    Modern x86 laptops are starting to use GPIO pins as interrupts more
    and more, e.g. touchpads and touchscreens have almost all moved away
    from PS/2 and USB to using I2C with a GPIO pin as interrupt.
    Modern x86 laptops also have almost all moved to using s2idle instead
    of using the system S3 ACPI power state to suspend.
    
    The Intel and AMD pinctrl drivers do not define irq_retrigger handlers
    for the irqchips they register, this is causing edge triggered interrupts
    which happen while suspended using s2idle to get lost.
    
    One specific example of this is the lid switch on some devices, lid
    switches used to be handled by the embedded-controller, but now the
    lid open/closed sensor is sometimes directly connected to a GPIO pin.
    On most devices the ACPI code for this looks like this:
    
    Method (_E00, ...) {
            Notify (LID0, 0x80) // Status Change
    }
    
    Where _E00 is an ACPI event handler for changes on both edges of the GPIO
    connected to the lid sensor, this event handler is then combined with an
    _LID method which directly reads the pin. When the device is resumed by
    opening the lid, the GPIO interrupt will wake the system, but because the
    pinctrl irqchip doesn't have an irq_retrigger handler, the Notify will not
    happen. This is not a problem in the case the _LID method directly reads
    the GPIO, because the drivers/acpi/button.c code will call _LID on resume
    anyways.
    
    But some devices have an event handler for the GPIO connected to the
    lid sensor which looks like this:
    
    Method (_E00, ...) {
            if (LID_GPIO == One)
                    LIDS = One
            else
                    LIDS = Zero
            Notify (LID0, 0x80) // Status Change
    }
    
    And the _LID method returns the cached LIDS value, since on open we
    do not re-run the edge-interrupt handler when we re-enable IRQS on resume
    (because of the missing irq_retrigger handler), _LID now will keep
    reporting closed, as LIDS was never changed to reflect the open status,
    this causes userspace to re-resume the laptop again shortly after opening
    the lid.
    
    The Intel GPIO controllers do not allow implementing irq_retrigger without
    emulating it in software, at which point we are better of just using the
    generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
    emulation for this separately in aprox. 14 different pinctrl drivers.
    
    Select HARDIRQS_SW_RESEND to solve the problem of edge-triggered GPIO
    interrupts not being re-triggered on resume when they were triggered during
    suspend (s2idle) and/or when they were the cause of the wakeup.
    
    This requires
    
     008f1d60fe25 ("x86/apic/vector: Force interupt handler invocation to irq context")
     c16816acd086 ("genirq: Add protection against unsafe usage of generic_handle_irq()")
    
    to protect the APIC based interrupts from being wreckaged by a software
    resend.
    
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Link: https://lkml.kernel.org/r/20200123210242.53367-1-hdegoede@redhat.com

87f2d1c662  genirq/irqdomain: Check pointer in irq_domain_alloc_irqs_hierarchy()
17e5888e4e  x86: Select HARDIRQS_SW_RESEND on x86
92ed301919  Linux 5.8-rc7
+---------------------------------------------------------------+------------+------------+----------+
|                                                               | 87f2d1c662 | 17e5888e4e | v5.8-rc7 |
+---------------------------------------------------------------+------------+------------+----------+
| boot_successes                                                | 93         | 15         | 11       |
| boot_failures                                                 | 39         | 25         | 3        |
| WARNING:suspicious_RCU_usage                                  | 38         | 10         |          |
| net/ipv4/fib_trie.c:#RCU-list_traversed_in_non-reader_section | 38         | 10         |          |
| invoked_oom-killer:gfp_mask=0x                                | 1          |            |          |
| Mem-Info                                                      | 1          |            |          |
| WARNING:possible_circular_locking_dependency_detected         | 0          | 15         | 3        |
+---------------------------------------------------------------+------------+------------+----------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[   12.156126] ALSA device list:
[   12.156425]   #0: Dummy 1
[   12.156679]   #1: Loopback 1
[   12.157322] 
[   12.157531] ======================================================
[   12.158111] WARNING: possible circular locking dependency detected
[   12.158694] 5.6.0-rc4-00010-g17e5888e4e180 #1 Not tainted
[   12.159215] ------------------------------------------------------
[   12.159795] swapper/1 is trying to acquire lock:
[   12.160230] c0011e70 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x41/0x70
[   12.160961] 
[   12.160961] but task is already holding lock:
[   12.161580] c3326f90 (&port_lock_key){-.-.}, at: serial8250_do_startup+0x527/0x730
[   12.162277] 
[   12.162277] which lock already depends on the new lock.
[   12.162277] 
[   12.163030] 
[   12.163030] the existing dependency chain (in reverse order) is:
[   12.163728] 
[   12.163728] -> #3 (&port_lock_key){-.-.}:
[   12.164249]        arch_stack_walk+0x52/0x90
[   12.164656]        __lock_acquire+0xdbf/0x1160
[   12.165070]        lock_acquire+0x9a/0x130
[   12.165455]        serial8250_console_write+0x74/0x230
[   12.165934]        _raw_spin_lock_irqsave+0x28/0x40
[   12.166387]        serial8250_console_write+0x74/0x230
[   12.166862]        serial8250_console_write+0x74/0x230
[   12.167348]        console_unlock+0x172/0x5d0
[   12.167755]        univ8250_console_write+0x0/0x40
[   12.168198]        console_unlock+0x373/0x5d0
[   12.168604]        register_console+0x37e/0x3b0
[   12.169024]        univ8250_console_match+0x0/0x100
[   12.169511]        register_console+0x1f2/0x3b0
[   12.169955]        univ8250_console_init+0x0/0x20
[   12.170422]        univ8250_console_init+0x1d/0x20
[   12.170866]        console_init+0x131/0x1c9
[   12.171261]        start_kernel+0x4fc/0x603
[   12.175485]        startup_32_smp+0x164/0x170
[   12.175890] 
[   12.175890] -> #2 (console_owner){-.-.}:
[   12.176393]        check_usage_forwards+0x0/0x120
[   12.176828]        __lock_acquire+0xdbf/0x1160
[   12.177238]        lock_acquire+0x9a/0x130
[   12.177619]        console_unlock+0x172/0x5d0
[   12.178021]        console_unlock+0x1c4/0x5d0
[   12.178424]        console_unlock+0x172/0x5d0
[   12.178827]        vprintk_emit+0xd6/0x290
[   12.179221]        vprintk_default+0xf/0x20
[   12.179611]        printk+0xd/0xe
[   12.179925]        mask_and_ack_8259A.cold+0xb/0x5d
[   12.180376]        handle_level_irq+0x24/0x100
[   12.180788]        resend_irqs+0x4b/0x60
[   12.181156]        tasklet_action_common+0x3c/0x80
[   12.181726]        __do_softirq+0xd2/0x440
[   12.182111]        __do_softirq+0x0/0x440
[   12.182488]        do_softirq_own_stack+0x1d/0x30
[   12.182928]        irq_exit+0x66/0x80
[   12.183280]        do_IRQ+0x59/0xe0
[   12.183607]        common_interrupt+0x113/0x120
[   12.184028]        memset+0xa/0x10
[   12.184347]        memset+0xa/0x10
[   12.184668]        kmem_cache_alloc+0x21c/0x2c0
[   12.185088]        __kernfs_new_node+0x3b/0x180
[   12.185508]        __lock_acquire+0x8f5/0x1160
[   12.185918]        __lock_acquire+0x8f5/0x1160
[   12.186329]        kernfs_new_node+0x27/0x50
[   12.186724]        kernfs_create_dir_ns+0x1e/0x60
[   12.187158]        sysfs_create_dir_ns+0x47/0x90
[   12.187592]        kobject_add_internal+0xa4/0x310
[   12.188032]        kobject_init_and_add+0x36/0x40
[   12.188467]        bus_add_driver+0x7d/0x200
[   12.188863]        i2c_device_shutdown+0x0/0x30
[   12.189280]        i2c_device_shutdown+0x0/0x30
[   12.189697]        driver_register+0x4e/0xd0
[   12.190099]        i2c_register_driver+0x39/0x90
[   12.190526]        rcu_read_lock_sched_held+0x3f/0x70
[   12.190992]        ds1621_driver_init+0x0/0xc
[   12.191403]        do_one_initcall+0x5f/0x250
[   12.191897]        parse_args+0x1bf/0x310
[   12.192270]        rcu_read_lock_sched_held+0x3f/0x70
[   12.192741]        kernel_init_freeable+0x12d/0x24a
[   12.193194]        kernel_init_freeable+0x1e9/0x24a
[   12.193647]        kernel_init+0x0/0xe5
[   12.194006]        kernel_init+0x6/0xe5
[   12.194362]        kernel_init+0x0/0xe5
[   12.194719]        ret_from_fork+0x19/0x30
[   12.195098] 
[   12.195098] -> #1 (i8259A_lock){-.-.}:
[   12.195663]        __lock_acquire+0xdbf/0x1160
[   12.196166]        lock_acquire+0x9a/0x130
[   12.196628]        unmask_8259A_irq+0x16/0x60
[   12.197126]        _raw_spin_lock_irqsave+0x28/0x40
[   12.197670]        unmask_8259A_irq+0x16/0x60
[   12.198084]        unmask_8259A_irq+0x16/0x60
[   12.198486]        irq_enable+0x27/0x60
[   12.198840]        irq_startup+0x89/0xa0
[   12.199231]        __setup_irq+0x64e/0x6e0
[   12.199609]        setup_irq+0x39/0x80
[   12.199960]        start_kernel+0x48f/0x603
[   12.200345]        startup_32_smp+0x164/0x170
[   12.200745] 
[   12.200745] -> #0 (&irq_desc_lock_class){-.-.}:
[   12.201297]        print_circular_bug+0x4d/0xa0
[   12.203541]        check_noncircular+0x116/0x140
[   12.203975]        check_prev_add+0x6c/0x930
[   12.204375]        check_noncircular+0x60/0x140
[   12.204798]        __lock_acquire+0xdbf/0x1160
[   12.205214]        lock_acquire+0x9a/0x130
[   12.205602]        __irq_get_desc_lock+0x41/0x70
[   12.206037]        _raw_spin_lock_irqsave+0x28/0x40
[   12.206493]        __irq_get_desc_lock+0x41/0x70
[   12.206925]        __irq_get_desc_lock+0x41/0x70
[   12.207367]        __disable_irq_nosync+0x13/0x60
[   12.207809]        serial8250_do_startup+0x628/0x730
[   12.208275]        uart_port_startup+0xcd/0x250
[   12.208700]        uart_port_activate+0x5b/0xa0
[   12.209124]        tty_port_open+0x64/0xb0
[   12.209511]        _raw_spin_unlock+0x16/0x20
[   12.209920]        uart_open+0x12/0x20
[   12.210273]        tty_open+0xcb/0x450
[   12.210628]        chrdev_open+0x5a/0x170
[   12.211006]        do_dentry_open+0x1a3/0x380
[   12.211497]        chrdev_open+0x0/0x170
[   12.211866]        do_last+0x386/0x860
[   12.212217]        path_openat+0x73/0x1f0
[   12.212590]        do_filp_open+0x58/0xb0
[   12.212963]        _raw_spin_unlock+0x16/0x20
[   12.213368]        __alloc_fd+0xbe/0x1b0
[   12.213734]        do_sys_openat2+0x1ef/0x280
[   12.214138]        do_sys_open+0x49/0x80
[   12.214502]        console_on_rootfs+0x16/0x2d
[   12.214923]        kernel_init_freeable+0x206/0x24a
[   12.215361]        kernel_init+0x0/0xe5
[   12.215699]        kernel_init+0x6/0xe5
[   12.216038]        kernel_init+0x0/0xe5
[   12.216378]        ret_from_fork+0x19/0x30
[   12.216738] 
[   12.216738] other info that might help us debug this:
[   12.216738] 
[   12.217432] Chain exists of:
[   12.217432]   &irq_desc_lock_class --> console_owner --> &port_lock_key
[   12.217432] 
[   12.218380]  Possible unsafe locking scenario:
[   12.218380] 
[   12.218895]        CPU0                    CPU1
[   12.219301]        ----                    ----
[   12.219697]   lock(&port_lock_key);
[   12.220005]                                lock(console_owner);
[   12.220551]                                lock(&port_lock_key);
[   12.221099]   lock(&irq_desc_lock_class);
[   12.221805] 
[   12.221805]  *** DEADLOCK ***
[   12.221805] 
[   12.222353] 3 locks held by swapper/1:
[   12.222703]  #0: f6c8e8d4 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x34/0x170
[   12.223402]  #1: c02c7954 (&port->mutex){+.+.}, at: tty_port_open+0x40/0xb0
[   12.224009]  #2: c3326f90 (&port_lock_key){-.-.}, at: serial8250_do_startup+0x527/0x730
[   12.224706] 
[   12.224706] stack backtrace:
[   12.225092] CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0-rc4-00010-g17e5888e4e180 #1
[   12.225780] Call Trace:
[   12.226003]  ? check_noncircular+0x116/0x140
[   12.226380]  ? check_prev_add+0x6c/0x930
[   12.226771]  ? check_noncircular+0x60/0x140
[   12.227157]  ? __lock_acquire+0xdbf/0x1160
[   12.227543]  ? lock_acquire+0x9a/0x130
[   12.227892]  ? __irq_get_desc_lock+0x41/0x70
[   12.228289]  ? _raw_spin_lock_irqsave+0x28/0x40
[   12.228708]  ? __irq_get_desc_lock+0x41/0x70
[   12.229102]  ? __irq_get_desc_lock+0x41/0x70
[   12.229497]  ? __disable_irq_nosync+0x13/0x60
[   12.229900]  ? serial8250_do_startup+0x628/0x730
[   12.230323]  ? uart_port_startup+0xcd/0x250
[   12.230708]  ? uart_port_activate+0x5b/0xa0
[   12.231094]  ? tty_port_open+0x64/0xb0
[   12.231642]  ? _raw_spin_unlock+0x16/0x20
[   12.232017]  ? uart_open+0x12/0x20
[   12.232334]  ? tty_open+0xcb/0x450
[   12.232653]  ? chrdev_open+0x5a/0x170
[   12.232999]  ? do_dentry_open+0x1a3/0x380
[   12.233374]  ? cdev_init+0x50/0x50
[   12.233692]  ? do_last+0x386/0x860
[   12.234010]  ? path_openat+0x73/0x1f0
[   12.234351]  ? do_filp_open+0x58/0xb0
[   12.234691]  ? _raw_spin_unlock+0x16/0x20
[   12.235062]  ? __alloc_fd+0xbe/0x1b0
[   12.235404]  ? do_sys_openat2+0x1ef/0x280
[   12.235777]  ? do_sys_open+0x49/0x80
[   12.236109]  ? console_on_rootfs+0x16/0x2d
[   12.236491]  ? kernel_init_freeable+0x206/0x24a
[   12.236908]  ? rest_init+0x17b/0x17b
[   12.237239]  ? kernel_init+0x6/0xe5
[   12.237562]  ? rest_init+0x17b/0x17b
[   12.237894]  ? ret_from_fork+0x19/0x30
[   12.238643] Freeing unused kernel image (initmem) memory: 540K
[   12.239343] Write protecting kernel text and read-only data: 24424k
[   12.239944] rodata_test: all tests were successful
[   12.240400] Run /init as init process
[   12.240751]   with arguments:

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v5.7 v5.6 --
git bisect  bad ceb1adbacb4971cd47533d667f91ed06a38d7d4a  # 23:43  B     11     2    0   0  Merge tag 'mtd/fixes-for-5.7-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect  bad 6f43bae38269a55534e1f86a9917318167de6639  # 00:04  B      3     1    0   0  Merge tag 'dma-mapping-5.7' of git://git.infradead.org/users/hch/dma-mapping
git bisect  bad dfabb077d62552797ca0ae7756cb30d3e195ead5  # 00:13  B      2     1    1   1  Merge tag 'mmc-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 642e53ead6aea8740a219ede509a5d138fd4f780  # 00:23  G     40     0   13  13  Merge branch 'sched-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 9589351ccf47a85a75180a430627c16bc28da929  # 00:34  B      0     1   17   0  Merge branch 'x86-boot-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2853d5fafb1e21707e89aa2e227c90bb2c1ea4a9  # 00:44  B     12     1    3   3  Merge tag 'x86-splitlock-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 992a1a3b45b5c0b6e69ecc2a3f32b0d02da28d58  # 01:06  B      2     2    1   1  Merge tag 'smp-core-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 673b41e04a035d760bc0aff83fa9ee24fd9c2779  # 01:43  G     40     0    8   8  staging/octeon: fix up merge error
git bisect  bad 2d385336afcc43732aef1d51528c03f177ecd54e  # 01:51  B      0     1   17   0  Merge tag 'irq-core-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 00760d3cd9de2ccee6b73e30b53e71704a99209e  # 02:11  G     37     0    9   9  irqchip/stm32: Retrigger both in eoi and unmask callbacks
git bisect good 771df8cf0bc3a9a94bc16a58da136cad186cea27  # 02:28  G     40     0   13  13  Merge branch 'irq/gic-v4.1' into irq/irqchip-next
git bisect good 9ae0522537852408f0f48af888e44d6876777463  # 02:56  G     37     0   15  15  PCI/AER: Fix the broken interrupt injection
git bisect  bad e13b99f3005829acc64287271fa6cacec6e3aeab  # 03:07  B      2     1    0   0  c6x: Replace setup_irq() by request_irq()
git bisect  bad 17e5888e4e180b45af7bafe7f3a86440d42717f3  # 03:21  B      1     1    0   0  x86: Select HARDIRQS_SW_RESEND on x86
git bisect good 87f2d1c662fa1761359fdf558246f97e484d177a  # 03:48  G     38     0   12  12  genirq/irqdomain: Check pointer in irq_domain_alloc_irqs_hierarchy()
# first bad commit: [17e5888e4e180b45af7bafe7f3a86440d42717f3] x86: Select HARDIRQS_SW_RESEND on x86
git bisect good 87f2d1c662fa1761359fdf558246f97e484d177a  # 04:11  G    113     0   26  38  genirq/irqdomain: Check pointer in irq_domain_alloc_irqs_hierarchy()
# extra tests with debug options
git bisect  bad 17e5888e4e180b45af7bafe7f3a86440d42717f3  # 04:24  B      3     1    1   1  x86: Select HARDIRQS_SW_RESEND on x86
# extra tests on head commit of linus/master
git bisect  bad 92ed301919932f777713b9172e525674157e983d  # 04:24  B      0     3   20   0  Linux 5.8-rc7
# bad: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
# extra tests on revert first bad commit
git bisect good f58225ec2998b6ce80864fcb609b369eac45c36c  # 04:55  G     37     0    1   1  Revert "x86: Select HARDIRQS_SW_RESEND on x86"
# good: [f58225ec2998b6ce80864fcb609b369eac45c36c] Revert "x86: Select HARDIRQS_SW_RESEND on x86"
# extra tests on linus/master
# duplicated: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
# extra tests on linux-next/master
# 119: [e9a523ff8f76de0768857f02ea76437d3b39d151] Add linux-next specific files for 20200727

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--qFgkTsE6LiHkLPZw
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-9:20200728032859:i386-randconfig-r034-20200727:5.6.0-rc4-00010-g17e5888e4e180:1.gz"
Content-Transfer-Encoding: base64

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
uGa+/fkXcHnyv4fzygy4CgIA

--qFgkTsE6LiHkLPZw
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-13:20200728040454:i386-randconfig-r034-20200727:5.6.0-rc4-00009-g87f2d1c662fa1:1.gz"
Content-Transfer-Encoding: base64

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
173/Dy3IZ4m5EgIA

--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vm-quantal-9:20200728032859:i386-randconfig-r034-20200727:5.6.0-rc4-00010-g17e5888e4e180:1"

#!/bin/bash

kernel=$1
initrd=quantal-i386-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

# make INSTALL_MOD_PATH=<mod-install-dir> modules_install
# cd <mod-install-dir>
# find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
[[ -f modules.cgz ]] || echo "warning: can't find modules.cgz"
cat $initrd modules.cgz > final_initrd.cgz

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd final_initrd.cgz
	-m 16384
	-smp 8
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--qFgkTsE6LiHkLPZw
Content-Type: application/x-xz
Content-Disposition: attachment; filename="04b7e575e6be598b8d358b42d6f59447a94831c1:gcc-9:i386-randconfig-r034-20200727:WARNING:possible_circular_locking_dependency_detected.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4riJTihdABecCWaK1+kyVIEaR/kmEpdcz26pQiVM
AdrLsSEtEUGTHXtjulB9zGwKv2KVkyFBwjv2K/6EoAufj03L3SG3EGsH7cinM2ycCkVfRixS
w8KPg6d+nsMjdb0uUJMgZCIl71v+TfV3/cOQ7Rl/eCNgWSIYMO+4yMfCcGRlvY6QhGRXpJ3d
sqjYhgsucpuRzSZdlxY4DRBXBTHf10TrKwtcXQy6uzEMvHm3WVm+E85X8hynwA2cSHexhA8O
J1M8/AwIw2koOiBS75v1ehg48Tob0B7kFoZXm5BJJ88+LKsDUwB9s9buEfZxeH2FjSOaZNpn
/DEmcGfc2EnpBtRNyzqRN2/PtWruuxHqu9UI11u8j3Xni17MpipT9VYmLfFA3hyhdUA9OlU7
kc095TEuA8dsUuxtT0kjzDJYbeqTJsNtT5v4P7JgGqDbGcg3g7vZ+9nM8s/6VzTLX4oqg3eg
vQjoLAgVv0yqQSF7cGn/X1a0Fn9F1f7OHDSJo2aDYfZ25ZgccMXsY0fdNEQX8t0SUNRIlDUX
pdNFXUUg1Ro6WhI9q2/G9Ct5cN9yk6+O+omj5wdfqoPoOggfZB7nmI0F8qn/Fb6DlMSE/Dgg
hQr1J2TrjPD/gPcGS5Au71N09x6vsC0/MGjbc41ZatxItEDYskMe3Vubk/+qTpsmTPwycxGx
SOKuB3qoFDXBNJNl61Lh3OBvFqmS1652FPQhP9b2azHGA8iBsaTbjshX2r2Gh7gNn6BpRvI6
7lt5VLyTTKhTAK5/IJs1dAB3urOrJ5uNoBqnmV+Abslgjz1a8DjOLsvmLjdrA7cYRe6+JDrs
ghnj+KfrPDPdCcjzymM+MtALuJoCkubYCCljuaCWdi7AApRVvmDfgswqwFe8o9Le2W3Plwuc
FlyDCRSHSGcxf8Dz2MvYTz+quJo4VlTZXoyRU2+MKaGAOxs1bxF9yGAc5yo5P2ELE16cPix6
e4t/hfmUuv0M6rAGdRqstzHHghnf/vuBEHvF5qkDjbSe2/X9/RaT5qCwfTvomTRrnFUGkBh7
LLVvYxcVcwtZJWzGgEFeJL7JEWdl4NfzVftCQVD1g+BeCHKXEM/ttKbE6k9Jp2sPyGI1JL8c
2aFOEPXUdwMDclH2fXwSSbusfrGh6jS/LWAb3AOFqRryU7mjh00vwfBo3FvuHKYdUmFHNMdg
EXsJVxRuIUaYWV7mybm6a5doo1FKElfVidbT9VzV04+B5ITdFTkR317iETWZZLXsE/YeZC4Q
3OctoiZzeKCteA85Oeep6xlTVsf4xWt+6VNYKZraTtkG6y3X7UcWII59SR9PZiwTlPhg3FQj
mVEdfIA+gFRkOUDua34f4wENJbYKiEjL8Mr07vFAIpFH4neP1oS1y1Wv/XhAwer409px9dht
BO+u4t7lxsglpIVkH2W2VlvHcRnvdP3uU6tZT0t42haafpNj0rtgs5TjH+wTDW0MeJ8zv7lp
ZrSOJgyPM5s4WqwzvXD4VZfMIjMq467mdsnN7WWTONHS81jLBjU8EZ2oaQ9BLUta7NHN9yvX
hiNJNJw81iKXRZ4rvGvrYjsRLpk+SffVDGZSY7BxGiyeRTOsVptaHf+PI3lzfXVn57HGC9rV
DYwpoW4D/YKQ+DL8fUoI1ZKPHMSVykJnUNqMqco/rhBm3FUCOm8mgWsvanOTTPKpGN97VzSW
SzA8iwipKDWC1thxN9lQMtlvwSv4b8s60A6Z2FFBl4JFWeXSZYRLJGH5yFAq5E/+sZk2CTM7
/p/jz4ThgnIZuRV0/TEUjAjDp+uyZf7cj5UPR7MkSv0gR8fLvf7uITqFF5bKJj8r/v3JJBXh
kKIFMhDs9NGA+LpZFSh4turTUtGhspaFC579EqB7jjI1hjHOkjmceED+f6Jvh0ADH8LYdM8v
0S4oSdLTUAcLaW09rGNl1PJBBIkmCW0zGus/i8Gn6GOel7oL89DMpV0VuFwmhckx9WxXpzFl
Uv0/5lIwkEZxSk4KX7u3+6Gt9fKyhTygYM//oYjsjb3hrXwCKcx6tZwH8ZS+ka9RcTDdtPlT
aRyUZYk654WUi3j3s/jJCNDReZ6zTv8t70bR0Xrl6IPcCs1i6PXQzEGs5JZDZ+Dl7+gXDb8k
DYjx3xNOCA8j4YJ0Dmg27TafX/WLCP6lG/PtPK4As93PBMWbyVaD9z3yb1rQMaHK0VXO9qN1
8hWS5LJgDNDVzN0m6x6G7xEqfS+7LqSZwDXmi7k/mBicj/cNd5xWCQyEMVMnu4QggyYuSxPe
yrQfb76gLntvCx1ATQ6U08ZekZkV8obq5yyIlVx86J9RzK+nI1uE+N4TtkMV+Mb+xXA6YjJ5
huPK9Vu5ad4pV2hVyjdD7qizvr/7CkzrXoUdlIEKjDspNE6knJuxsvfrErMDxzkQyd4j/OSW
BOLk69C3MhMNC6m3rTLen0ByxathIwI8fUp0USLrXlzPRY2kyubf1M1ZiGOGpuft7cHDgU6l
N7FmKyerPzfwKCeF+qqOvPD6ZzTfyBSUwx0xzAkt22BZCSypX0Abb2/lvKR6m01sYwqNBb97
FhWY+Q4mD54WjKlSRzSVkpL8XwcPzfJLfoYS3v5hPn5Wqul602hJqmx9glTA1PZBs/Mxrn0T
aScAZwWLsTUTa++s2vUukmj9h9t8vbcdl5kVCdax4L40akSw8E8dXPTt61GD3HIXBfp5LhmV
PhjozI1q3+X5LzX79nXAIFMQ/tY4n8QXxpPtsDKaUmMyGj5rYhO1BtTzQNCLZ8CzVRGcLdw5
v/Zs4QLwQ6Mq2bjCwB6S9hpeYSDD68zXgggfCvWz1MaRwDDf1I+B3zMxfg6iy+23vhpJV6vq
aognIsaBxa3SlL3r34rUBYBVZEF6bPunoZGMRyVXs5o8WE6XSNEnL8/J2UYR1URF3qiaz6Ks
EhGu1mI8aCOYQTq7xq1VVdBkMtPcHnIhzBrLOEcURQ6n1wb5pQb/YNCfq4O2kDNWoJH7bTEz
vdodveV6pdAqRgazOQLxYoiuIiVZSLIqFdP+jQSFUqaHFIUeAk3mdn7XSNb50j7PqYcvjSJ/
IqfDlW1iI0gSjaRPgQ9ZbEtDuZ6OroyO796qTKOx3nM7YwUFVqjxn99/tZBt0drLQIolkd1K
kPBoCUj3RG1XkDI6b0JLTaIBSh1xGvHmp4NadhHmX4qnAF3DuQZAiQ3WmgVndONONP889i/i
dpMb0DtneA8QVNxv9vizXha8ugXkDJ9pWwluH6es3xT0YxIXntJXlnyvQSmbmKPjBCOw6YIk
7pcqhIsKl60IxLd76vwsyM5wlUePp7JZd6xs7wIpYJ5XVuRDr+jQCJRihsWitWDBDmJDbOfd
wAhINXCMp0TAk1DUxyHLZD9G+88VWBbfT7XxhjDBqt7LjHLEIL1UWFGLP1pSMJOS2iRKjAQB
UG8761tDOP0BxFbDBvcCmrjIKnHJKNCSLUXYuw4PzWOWeZHpSLTLHjw++c4Pm5SalATdNPB2
1wG75AG9/PN8DmsAcjmBzU6x+5HYzXlCf5mqRoid6legYGGI6WcyghQg+pa6UtH3a1ncKo7S
FekqXI8wMvHpVEr4hMs8Dy7rlNeYERoVLHxwxBvWbozZbTb8gWVTxjZA96d4mcPcfsZZFBQx
3oQxhYO7g7paXInarjFrC+7daBRNDob4y79xHK6oOUJSl+pEj1YrCd7/Zi4ruY2XIXkDFOpb
xDaEz1BpOW9JVLjSDLKikGn+2zqB8td0k+taPj6miKGJsrjjxGCPawZx8cuFy82KiDkRj0qW
u8s7Z2155B+Frij/aXOl+tKIDK7WovYroLLoiSzXjB9qndgE33lmCHvYJo/KJS9I+UzHcgjK
2srtgESwqafqRWrRpkKRd9yxipB1wO8RmQxSH1wXLsoohy22wNQvZWvYTk5tWkZfqYwdBcV6
oB9ByZPFmO4Wb72w+cmNm/pZ5K1y+SBHa1vS+0t9npH5F/BOzXM0sC2Tiq+Wn9qjHu76dECs
PrlA1OMksFaKBEuRbHpUafcoVsEjQ88PJS8M3gIcGeN31f87Wqv8drfYC1hKIopdnytX9VIs
RnbPB+AfiY1ElJCO+4J8Pk+Evw4UD1X9JIMDDC0u/9Nt/FdqS5OtDqSbTYVnZWDeYonKxmzQ
irkk5LZ5GuC3dvQaPCjThgrcSfRmIsmNE4z9WeCvgusfGrh0XXXQ7Jhn/kk+mE8o2VuEXNDU
/5+PG7DpobjyLPsLDmrrqhKS9YXtMnOyOUhFYoRMwEm+7V2yQRpLMsaq5lQN5WFsZCCJsEXQ
aq0G+Yd42tm4nkZXXT77LfKvobPV8HR6UKk7LRTPJNwkEgVzUgaFvUxd2iFJgc55wI5hfCt0
8++p1QXHGKW+A0sJlW0aul+Oau25tH8StSHT3axm4vJJKR12eGf/eqQ4DpAqZgNb1SB87EZC
JDLdrUWT69SbskDZdXTHE3+FBzbPjKvVnmk7K6yJG4VCKvEzdWkIDpHZAs1m6jUQ7HF4/qEs
ZsTjdSPqg8r/pNLYlDwTR0tzQdGfJhk/d2MBDwoMV01oxPSnlJqslFRHlvvXpH2GABmxlKNz
wjEQNCfGbkACO2rRvJTExQG8XvNOd4q+LbXt4CrdMKKRA9yY/ZHuco6DvCptElF5W0e4BXOm
8YygN41ZmFePEUjiIbNOl+KzN7sPjV4XWx8nJkbgrTESYtjaAfFClKQ77zQB5gSBbs43oJMg
ASjAf3OpOMhbsGRMZfIkUe+h5NHoC1dryg4ajkCKNotpRh0PH72vNLZ8QL1CnnPFMT1BsDkr
GfHivq5130cHKwLEdLE9zakn/0z2tvyyGp3uhAZkMZRECMtLBhc718FfVg0v3+DlBRi1+wnB
GYZXPis+6Pfp6ASWzVD6ddyS3evOayDImGPhNDKiJN6MHRT4u4SFpJF6F3825WYfuPbmFMZs
NGe+LyFOAIh4izQhc4kn2tHQhnlp6xwzzQsmeVEAI9GC32RGLQxJa2VCV0hLFzvxQW3a8nEX
hAto/TlkPksZHfJ3R0MqA/8NGEaB0+7JT/CTq4jI4devxwPpF/SIaSUeSdBAUql/aNkyDRbC
QkubrJoJxbtQtXN51yNNVBf0voHYFxU+5HuRqBxEpdp9zkqn6CawyehElffbG6+r2OG13n2/
iXPxsquqJWX0f0bg1d8H+ETd3icNSjRHKVEdNaJOfI1WvRrb0N/0cajuVth+j+S5ThIc5i4z
I6Yr7qznBqsQVKo6TrTYGtkfzxGxLfkv0yrlBKLFr97ZqYSJNeT9lhIn+uibMqMnUIIZHQXt
E0IYIC4WLUHTefhAWoiQRILz7tEndRnX33BHKN70T4QBqW5Y4QFnz4u2eOifDsYQ0Lm4AT/i
WF0sdpEm9ewKSwXXkOYffrK9xdWvvlhkTq0bO8e/4nlZHGb5wPQ64ac50rx42ti1Q5PLFN4R
CxnBUjo0Rkw2R5rPQFSIMUdo8h/MTsLYPQrV+Qcshuh1K+5ybNOrYo3LdvcHAzaUSxE8B2XD
YOXKcZNbUyNbDTCGoCNbNJCLk1UqCInzJ3KpbI8z+3BukPByktsoj8QSbtAiO7HHE7PGCf6+
zUsfBnUXogjzRrCLqW3/ZkddpqrZ3mD5PlFnW2oZ1OG3eU6TO54AWAh36A/WnL4trKqkgaH/
0ztu4FmICnmIQe5mCMgE21ZURM4DKJze38zfNBv6kUZ/kVlv5SXIcJQsvEq6Sj7kM427R34b
ELQ0T15YiUPA493e2XxF5ElqV0rhIBfa7sZ//c8YRwvJw3mRL3gw21+A8Fee5eY+IDc71m8V
GmsZ96CXioOmzImHqHdprN4jnPE3xun+BpKUabFvpD9lYd7UM0gVIMhaZG4e0HHNhmY14jdw
ryZoC7FklY+z6Uz6uX6RpuYV1uPe9jbmUDw719SflBNwEa0pbp/bwci+0YbEp7eVgRJikkYC
zBFROEROaGlOYqo3LLa817R0FGvuxX40A/KOmhZJQ4mBFm7Afy67QzTICjtciivwXtKm6C/P
//GIkiM8fcFk/oyGDK/zJkW1atBjoXikKbAhdFLU0dVjjcKOSdj1kALu+ItpHC3jx0JscNOk
evHOxWX2vEnXIJm7MEDEFXK/85hxtDmoTG7GjJZ12yM2lQGXsucCcZwtU1xkcxbCCFkIRs7L
YSKjEvrwPcDfDR0EddQSUXkjVXStG0kSGnBJW5CPJjfS4jl0ES+8eVg2tCV0mvKmOFMD4xs1
ibAWPnu/2WcCcTrnHJA5x26oSL7EGCjjyk342ED/YfEyQonUGvUKC/ipfFa95eILCJkupNg8
pLMIGRXIa55IkK8YUYN2pUZLPqlfiMalVXv6CuDrGV7cfAj2ZscHUbpqUCZjxz3kWEekXEdx
dXXb0nRVmksGHIJoAPc6su4SeN3kRBbiolVcRsGrxyZFoMYTOjlvx+h3tb7LeMMTNVBJeLSR
6Vutc5J5HVBnk0rSH/ySXumcwdP0kfQYlyhJ37+lBRnVrbuY3wH1H6LP1WTM+gpZ18ljOJG4
A1iAuR6XNi8ghnlhkda7+KkpCz4RTRjNrCRQfefHaMVaY0ZjeXUAokAQMgX5pdgnVTsZQPrj
TYhUwbAMZCzyZ+Cgkzm1RQotaty6YlXel6xqpX2DCHfxCpheMbzwFFoUC3401SUXZjCNHQfI
t+yaSNRsvHlDpu0pB+wKD48NMZlEyy3Bv+B5TBWr9eC8fxIY51t1h8axt9Y5XIUewc7vfr/Z
AvG4N/njdPBeSvodqFPlOcDnmA+noCGfve4jCiegcOIcNuEaL1FCzF2S5eaN9EiYNVd95nQ+
UNVfox3Es8J10DKZUMSyfP3pNTcm3y+/X69sXKf4+nhxBginbPo9bJ5tz71KOGrJ8W6ABaIP
69uj74C3+z7lOarDhNdbl1BWPqiGEXj/TuwkPNagV0VjFXlkFgsVzW84yD27nGTgrk7NFuf+
/yn8YulwaLJKOBqp40TIa4Uw3abNfN5ml9X7LfNA9mevmcRTD0Vw2O+zt/g3hlu6FyRrweRO
lxD4AXkrn+zvRSYmCrUZ0BNJFh9nKrOgzB6Rvqg0QLRsgsHEcG5YJJLkIJpXCwqiKn8kZ9w9
iT/X0vhNPtkMNtru52ad/a7dGltiUHxwbq7SzNrRqIZzsw7hQhQoZc11cXzhJJdBR7yPCsmF
SW3qenWq3NdSicbCeBu+xwO1QEYZHjT7GYGJ6325CbZ3XNuZJ06YSu3Ct+u+iMaNPE8GnIe2
jydSgufahPE5zm0cFH+g41HgShhyvaDAYba5tEa/ukBkYTiRYlEOeX4uKZVgXUop0HoV/fNt
tMWzJtINH2AjeygwKmYxlq7EaZW8Ihayn3qrWS3VkrETRYtIYtO5wuCe9UfP9dhBNke06Q+s
59iQ6nn3F2f6l6ce/tQ/Y1c0N12wjfN2KjkWW/SQVExe4MNs6fo4Qj9+rNRRsWEnruhA7fcS
9WEZXTk+Pcm0q9beTFr8VNmjCUDlPosYcLaofHxbihCospSOwUUtYXXVf1Bu6U6tJgSPWLaC
0+YbZOxkMUCjgWGKRAPvJ1tbC7IxzMIgHc0gThkW6V2Nvv1LIZp66CKstb27C4ICDNt6oqt8
IaNPO9xZeDI3JyLnJrGrstuVbsSGpfChzVh6WzFium6Be5L1pZdn9kLJKiflke2nG7F583vb
qFYJsnzrCEDh0D9tK+mrk2NxN2ivOz1/yJ9KT/xsTFjv/PSYiYLT8oZ3d6qT8UAmnG6miKTt
+msf8xPSssZC25dFr0mkauD2C3zz9Zc4ockbMdQwNQQaZuOw5UAW6sfj4jImpGtynBbNpqVO
FUTYHezOFHpglIxf73LYe1omKEo8SxPHzLrC+BhDGEurdiU/6pdh0o7H1/e5XhJw8X/TT9hW
lSILG3SFkc8yl/WH2zh/B3qWay1XfezD6R4TPG9SXPTtnh/sm9ZU/B+68JeXvIMoojd7Y3yD
J2VZNRAmWO0uI09/kspdsy+O04imoQFQ72iYdcFwbatlOxqOGsuoCj/ZzFptB4Z5LkflKYaU
xgg+zO0rXJnxk8O2beXlFhuDZUSG8stnIf1mZ7Q6bqeDCy1IvZ9HnKju3Cr45/jDNus+6G55
/hHlp/DYGhXKK7GdsNKk9+f4qpy7+TnI5F64QqT80uksr7KCmVZ6nh0kbV8pbrTXlBbBII77
2T5owQFxNRBMOl5gXPv/AOooKRppfQrDgDKEWp0+qfJZVNOgg91wg4QzivCZvHJ7m13kr63m
y0HioiRlT05n+NjGA/nQp5CbI4ehzT7KsSPHYAXTWcwcjnLHrhxTTk2bHaQGg2HXVsAtUcrp
aNZbI7M92Ti1kI5bLq3Bb/Dv+nyP15LlIMFYSVD2NlfcN4gxOgoFgZ4znqUeGewy8KuqGSMl
UyCO5Jf5H+iYD4JfJ6I79NQ3La/8KnB5xjEiszQBgx9bvkDAIbDfCkh4A/x1l961yDrTwIz0
ORm00nkAOuBe3pVhOROmhW6x71zcHTPzdz4M3RBW8iMD06Lz/9aYMJxhf7Q3yMwEYRpAqre8
xq+4DQyyGQYq86tKHu/a5n++18rOm0GghN4z8WOEkKD1Z906+HfWrd+WHKesSQ+E5wFN518i
7tlmA59MX3Z+hsHvKcF3WtJC63VZbqyMNU2kQ6BNDspfNany6nMOYMqz1yiovgDZNkyTr144
r+G2/cWQFUdi+eIPv/mtoRKZ8YYqVR16U1mKl3dX9s5A00z9MED2QQ3kP1vwUTa15cHch+YY
mWV6R3FELJq7XlI2TxlgZSuB/WoVuFEKy2Jt5ITN2gk0W5d1WrnYPk5tlFfDaSLFpKUwEEhV
LNXKxgZW8XK3tD+wDZ42mlDsnXsd7zsUfxkAnpBGbwoYvt0J8wYOe+0B/2Vq4oG8y4agBdLe
uAnA281QjTByY5+L5h/UVCneyuuumE4HXTrec/93BU794jlt0tosQLX9NyqongNopYj9Mg5/
eNuvbHCqjTMkDQKbnlnedveUCH0yuN+7CymimUxYp/MfEno7mVkCFXuo2nmzayZFGTgbWOSU
NHlfrJA4XzZzbS2WOq4UG6UUaGoor1Y22fFhyuPtVBz/WdOuYORPAA8/rVO/WNtPRvrDDNzX
0C2q9Y4eVvBkrfKdL8uaxWMPtcYzej35Tk/PW+MJnwdW1vmymS7+nhoC6tiw/ecZtS0TylC6
fHJ312czryYCqm1lpfeaXEN/9stVpjtCYyVII3wggTLYkEaBII2scSrzOHYtJfFeIYPAnmza
FBciVkbYqrYejo4pmwsPVblMuHqsj0hfomWj7jELjdIRwZidClSx7GP5+I2d66DBj96Ts0Iq
ON01CF4F4jdQ0db1uKOufCis6MNHfGVdG3SBK9Qki+GDFXiko+wwJQuz0o05XQdK99w6jcoX
I178MhSe2PgcmVZWIMk8zpjFaFRZHwIACgTLBv7yYMMq4lxIXmub9R9684Xmx+dvs/bXxWko
j+hVk3ybDRDrpz8a+3mEpOL9mh/9K++FjpS4/fhiokHk0cWjw7uQNmljfvnA0P+/4kzLVeO3
AMMsIl1BZxse3eli7oGZMe0PdTnZ4nWpis3MolC+7peG6zRpVaV0QRJokREXzmA4Fb/cnX5e
AJboaOE3y3CQD0Xam5ze9LvFzxcG55VxRQ4NAmy3BZfTpcPWgRrUkySo+7NvHUN6vSLRMVDe
bDzOgaKpu3bzM6AVCSF5Y9FCzCrILZpfFP4AdpWeuO/LV2hTEaDi7bxpERLykWBq9GJDlvf3
D4SEsUtN6WSq+SAe5mrYAcYGZyRQLm1NiU35BMtU2vadWiIEmzEAPsmNakfadAPW1qBU2iRk
WH76HmN5RQaUkpCdB+vzI7bPqgOy4J0QflLJW3pZd5b1qD1P2aUCZqVCxHalltX0HqXkA7qt
hpU6Jl4ypYS4p+9zVDi/hSMu9pldiOjSCjITJaZ1c5fQFf/co0I0bx5aapkFGdoiiNcLzgpM
qb4bjVg/MdplIRDrf9ueUXC/aRyYK7RCGkWKEBgBjbMd3he6ekkGjfqvEueIIwbwoueQ2qnn
92/5JnDtN4bGCxygDcYFTDxPadyhfiaP9lrmBXgkCN08MR/r6d8Wqp7zAKNLhI00dfbpzhyj
2br25+5L4pvriB0cEG/yLWbakhLM5kqnFK0rerFYk0aYhpRUYkpFKeSLmGdyQ2brp7e1zatb
2hqrDSbBhphErCgvMyd7slsNdibeIqvt1W3woMIWqExyfzXgJ2VKae2A41g5qvAP1vAN9Ulx
a9aubQrlyZ6GvlOiwR1AnckfEqz8vCc8mOX0LzYtp6W6hCU+HsNDnngZI84a67R19Y7vY2k4
2BXHOyfriH95n1TS5q0UEu9TIgvwhg4VpMq1SqCcugRoqJZSPtKo1Gq1NlQg9URKkGjoweI3
oYkK761HvDZsy+CAKZ3MDLn+bzmR4rqseigCftnEhrvJuA/sVQV6QbiZe9CwJ3BfzwDrzfTd
qn91LZ+Kl+YjTo7KsGzZyj3WUxfNWKbgsPjFQC7Ro4//s/DrJ8u6KNkY5E7CWaNHF+wjsx3t
qCa5bnIOIg3eQYYQ2+5g4ZSJubGT64zhFwLeZcaR2LMPOEXCLKOHOAox+l+rvQD17EI5NrCU
Ap8WeZ5GnE4Di4Z81pwLk1vctG7Q++Dw2lwe4OzpoIRzwOFjWoCFwn4ZSXpMcJChVJXaPyz2
jIbQfxGd1VfpG8eUrH3l5i/iNpZsgl0WBTcpEiczwSZtPuNAohhhNVX20QBrHfK5/tog2ZJ7
B3Ea8zT/vlOUOHvOXUTZduygSW+BwL00ezIwSv3mQQyoDnf/jXEGAwbjd4gTDp8aIUnNcw5h
V2jVdegy7ptWJY7IUnDiQoyqsb4zcuGiGIHr1/ldMJn2VEaQTQFRFjWVprk7a9AGnjqiJSeA
N8zbFvSrLfbYKGk0KiPjffDm5x1C3qy26C2NYXe9Gv/TtzKBcOgUyF6YgI2OciKDsPv19ULO
aqBMAK6juEDf4MmpLjHmHpphtG1y7MaPgUHzOQRWPpjga38iOTlaihSy21YuQef4LWyrlSxI
5i0UsVa7IAEc0cI28cxQ4ASIEALvzSP7/qHJqLpcR3L4fi/4fYjbjzPcDRxuwLI0apSn/d2G
DO+y7Oii1hG5zDLg6Yjv5eIHCvVyIrgDvUaf1KbhbFgob7N5a0eKcIxm1A4WcyQovPyaInPT
X9n91cY7uYxN+jfD8M1DrlfdYLT/TwlI4FH4CTDUAshVcbFr3LEh2eX6vde74b0UXxBTcEpv
nqPueqXJ12m/AxEc28YJH7Z+dRpbvzh4ZtJkwlrZ+OPEgWNQBSM1pKF01vlqWHSjdzbCxAxY
i1Fu1FkG3bC1OGpc29lyL9dMa3NI616CPfnloApFVHm5zsvrjjhV3PVhqtskFG0QdJSIpPFf
6G1gcAD8VUNIwwSYBD1hBTJKvWWEUkwu7Utg7JiyWdbVzFztSyfTbScJTZcNG8u8ESL35dHo
S8BNLhjA3tt7PY0ZylSVkvTfem979mn/0yeLwks8ALUMy7MQLdvBGFZAsRrS7VwxtUreTuCX
2j2qDZS1wY/6GTjZc6mKw+UoSr189G9iyGuGKvS3yzV1GbVjSsW7neQSp+j5eR85qB/k/IGj
cAeRyDcm9lyCtS4aRtHrA+OxYEhXH2kTW1wVTX8f0InJ1B24znO9xFxU4cp6ObRIA93hGTM2
WyELSleYRic8FP8KBrL32bsSJ30Jw697VOY3M/RX40ZbQMq7092H1LA6Ezbz1dy5sub59tGs
9PUIpxMcWXZdleGVqBM0YCbDCJNxq5Lr2byPIspjcrJhiSVYMQp6raHo6LJQBWEMZ8pqSLIz
S1rEsMhdZLohU0qkWuzIfvbhE5/fGyboKS+rhmDI8rdQ6H8yx9JyIDtugubqJEAb/t9eGHDT
2/netH3MUrxNWfwJAKkACC6BxA6o/iSrWpQiHTckgEl0ZyHyQK55eMHyrUYCljqrW89qSkHv
h0l6SmaLNXZqwPFf7xRHr7v5H6lnITSG+DTJgP8DCiEUZg8G337ElyGIk2b+kAsfAZnrtT2u
Kp/2W6lU1PETDmNGtUweuphmfcg+EmaqAwOmiillQxzpov9wkv5H4LDmK0POjrBIau27NPTV
JANWZzh/qBow719nfH8UMT/YEb9raKIVM/KU7LIJOQWrrSHsSxs5BsUyQM1lhBuJn//VYn+2
CSPKH/7fP8QlL/AAytOJjs5ltDfq2jfIuAkVMjinNZ1SvptUpTx6OkjuW+cEIfZNNEG72DTd
0XIiHp5IHQUN/h4qdqqodP7F/25uU66GGAigvRcLR45i/UF9aCAU5ndtKTBmmAj5dI/9zLFk
RMav/4F5ptIYClhhQBpgj42yLHI1aipAZz63+rcLmz5uBL8PkMvOE/Y6CiaO8GrkdByuwti0
yluIOXhxxZawT+V5GlZiUbrDh+Itz+WYg1N6eV1sevs22g1CNYuvbaXQOQ2l9EkWyYf2jeNW
yXDxnhAcHvfagLFgKZer0Svn5fYOin+piiKxE/32xCnQyNHdpeai10jQ/3XsRZzbdmo00B+3
cSoQ9fC7q5X2d+DE9mTmlG9hVO7l86kUU+U0vAW9k1HpWsMQ3Nb35ofrHX1bAuqhBvn2BYPl
sThbLxGCP0RRg3aHJJnZ87qvoo2StlsEuQMH1SHDpAa8aKfkr0q8qj2cGGUd4o31hF1YvjXY
Dt9HHPwj+brLxMM3QhgmUSHiLUlT5ykFHPaHapKFi6yjXq/XnQI2teOpXkl/vUubT2L1Uj2V
u7KjTlXKKywutzN1Vg4DbGSl11jnMOiJwSxx5CfC1XBtgG3+VrvpyYW82mvLwIm7WNhKXixQ
hXjU3TYj2wetawv9uGoaYv380kLI3u4CMhitaANyQRs3F/qV9n09MULuGAwlEhPDkWLkklOX
Yrk00BnJpfzL932Qtmr4nLN7SAoSwuhZdryc6HudHloiYJcBjT3kRzQ7Qfz8le/7aNVB8ltg
ko4ogkQYH1b6Oppplo7LQJCcJ0LjOpSD61u7Prer0PLtWe4EmoNh/Mf2MgZ8Dt2woYD5RBAt
xPbnKUpPP+9T736pCJjF6SPD+TV0tGNZFtl/UcgttY9IfVx3hfXHw/Bw7jyw5dAGSU+d0I4k
/j5jfKLYZrQd1038V68fHT2qRrF3xuwJeDhVbCAC5Q/bOlmwBYMkRsve4FjcRJwMQWiJ8wQ9
qtUD6809xk96wuCmvmdgo4LIgtVAkyPEtjGRxaXOkAF7aFu/JVNPNGnMU81R2BxiccZp0XCn
y9s6tXFcwghTOhw3qlSwfTBazaeiIQDlLiAynhDlojos4GTnxOHYonrRRR0/v5H8cXRoVAuB
PXE+nCpKnqFMRH7+TVxcUT3W26OJspk6p6QWZBHaNf0DqNvIf2YgRn5TUS6fHc2R6PAkUj2z
zfkU4qNax95Ytq3PJuerdrxt/YxG4LshpUvfuM2yuOmmM2XKCyDq6rzLxP0pPNoA0ipBmdKF
reA7vDtefsEgNGrrKOdsnHJfh9vNKypmzygyUN9t1n5XfcMvimOvkDTQoR5gQYe0tol8jQzS
Zygda4emw+xCYWHzoCHcZFVinzj8yWeZ0U7WMyj5X2HMAuDHxes98MTS3d53AnjrU9EhWycP
XSDi+CiQVqhrhLA86B3T+azdxXL1UdPro4hk4seczRk8lBZZ0KXZ6sIPBcKeHbMIRb6yso56
s2DaPKhcjTXlS5+M0XD2h9MsvDiNl0dJuhDO1Tu1EQbzwGXVYeogzrcmWL81ZmJGoEiXMoNN
65iusKmdm16OPV24hfVOa5dPuFyIW0wLHDv/YuzegLjwInogEzX9s7iSOsS3nDOkCzFYb/0m
PxDh6VWu18lTWLGcuoLzuSufldpmlAowspyW6Mw+F8g3vIFCZAbXB6b8SF/p1ecapxInxpaG
7ptyCge2ynKZY5H5Ss5I2tAbwa7SgrMm7wNHpFqzywYJEvuqzeA/hLcVi2BDRgLd6uIDchkS
Gy5YchclLaRhs5cUWtRqah80gNkP/TDVl3kjd1eG7Z23WMCOWIvyAcGm+oLTGLpAYSQ+mZIo
SLhZogQajo+feOEKciOMI46UqZoRxzujNa6G4rTul9OaYEBpx2OSpMCqgHY5JSLl5eft9kXi
8YX7W9Os3Rsbo0kSECuv9TABVE161YWZmarfF4X80/IC6nc8vPIjTZRZl5a2jTi2Q/TOrSk1
4UVr63pA5ukyvXdwt5fnX5/1C2b/eQzcZ0tmDnOnz45CtQMLy5DlC1JCjEDXUekUV75xXylI
AT5pcqOa2TptJIBFew+Kd/t7lsn0NfqrWS52gBAA7Bxbs1kRsWFgvbjX/Gj6hq6aD8yBF19A
iLsNS0XBp1ifXhVJKWBXgA1RVs/ufe+ht2aO/8a5RjL2wRMzoYBVO5Lez/AY1pVmIU3WtRzV
Tbi+ghtoK6r0A2nI27v2OJOrBCG/DTY2dO3lg5cPMftMHXV+brtP3JSjw9l8IpV9Czot+SzX
CZ2Ha7UDeGn4TKRWpnb3CxbLYFNwSIrYwxFPBv2ovaYSwE248eSCzS9DdgXz7Ysc5frOgH/X
JL7WcpRSmcBrzWNWLEeEKUd5DSJD/gQeHhWMdJ+Dydtwmc0U7SeJiou+kNBwEKUW+0Srh+pL
Mg1ZMQg5Sr102fp/tIpK6soBgj4xNaY7xeGXE3n4JdcRVVti8CWgg5xoztiOC5D7TjGof2SY
ZfR3NsmSRXK8KFktGZJZdBOaUrd+JpO+VJ3U7rWLl8UW70SSJTwjqTkaSf2zENOaiyXT0gH4
TN3gOck21M0UxkmpOeHTJerrd8Fq1uFQpqymwFqP3Z0YvegAc/uHXy4s/AaMoVX9DSFZiDqL
wZKvwNW+08qbILFkfUXBDin6OzzM4BMECpbKnCfpDh9QoYenDURFdCCaKhoNCmtV9EKOPDUN
jhzz9vVitUWDLdE8ycWtFoyAR8yA8Z7m4cND3m7U2by0iYGm74FFmKg03+viEFXE38IPV3uQ
AbSoDPiHNqL+XOl1zyr6SlvPyCG/une1v9fugXguODsXQL9xPtvJSAy2HQ3MxULYgHB1SFeo
LVtYDRzdSZ+FVQQak+WxsNjoatmhTiM05ZiD7KhoMWsqdNLeF4c6fNmIgkEWFkUrsRu1xrGU
SDfuRqvQ0PxTyix6/zW2LN8PQiglqAfz2Geeo1mANrA6kBmShyyTM3XpoGnCFTNKlAqWbvFo
aU7tmgWZZ5N1bjN9vEkb1pbw/pkZm+Yn6tCdPuscgewdROKRkCtxfH1vHFrm9B3KajBK8XDm
Lu5ktnmOpjB0BWb5p/W/WzDBy+g3t3KxF1HxIiT4tCs3Jteduj1XN392knZXyPX4acscqr/J
XIBmNUVVGWCd/9xi+Hn0b7zWYA2ux+nQIrGimpPDm9DtQ+8yDYRHIcuWjVzlIksRJPd+mjvQ
EpzfDI9PcpKtnl3qqJH3ms331hlO4cD12PIa6MAwolykryfsabdeJbgrHHwPR/IabYTl1na1
Ob/0IxgbcTQZtbzkmeXS1WlHRGf6xfN+VYc8O1Ekcg/IS7UHFZi39zimq+Klj6Vih5JVO/fv
G6FF37IFsMZUkqO7TD0cC/8qO2/5e+qm2YLe7YBR/uyaq9Zr4JkukZFG6pbbbfw83Dey0QuY
QzkDWHhuVcFPs04NCk2ofRI/Y304zbyXas2LJE36B5fYWjTUEE9WyymVtjFNZ9PweoJZFPiy
I4GhXdNafRowkZQLD5jYaTqlnnMJS8qDWXmgpxeMj9FQwXz0cag6f7E5YiQpi/PpdBVElpxu
q7m0xgy4tTVYdnYVPBUZkp0WStcldmeNtPbdgTxVjOHcXuXTg6IoFChOKnOZxU6wkiIiwSOo
czrh5P9CTpc06QUQ8jKUnC+uPlGfNXsDshOiN5euecUD1C/nZCneQmG7w3aRqhPTz9KjsAyI
icTrcIknMzu7TeHGGmaED+I5AhFGF3G5xGvkTd66xHfGyLiC+nzf85YQngTA6mUdMY1YpJul
fSMSJ0dC/jRELxGvb8WZCM128KrrHT/0L88gG8lVjFwqWiJPOOqwVy30syQ6xj4i7RR3STI1
QxPnkUlwLiL8fRSNibyw4FvZZlm6cTwmirDHmBMXxUhwoTEeF5ZsQAhKEPx8amg8tGgcTHum
ZT/fhxljhHqp9u25/UljLTe09dGK96XJjXckpHvgzyKw0AUjf+Xqi/GCEfoWog/yBtV0dQGK
k4r+s3REs0yHN2vNJYqWpXv4nlCvqjULHOE2hXIU8SrvfnqsgThMSIG1eHy6opg1eGBqOrmV
/otJvx4Qs8Oo3+FpObDYNsI3D24/IsBBP39s/PUppEY4Oz96lGrl9h2Q9bUwfaSLSJ7giioP
krIsbupgxPUNEfe6IkMBG7HSfcZ5elFZ129AbulyAkEk+tLaXLLKh7JfK3BvrfAMA3o1LW+2
0ixkxodAIrR1H1fMmEaTRpMOwL+ORUJsu3NKpkwHWnXCHk5XyGjF7xn+PlTo4uP/WDgzlvve
t987FbrmtuymVhotQma0sGwB86qzP1uOrfqDbfWU7jCwy5azS78yhOcC0vaTE5StITJ3IvzD
2VcQEcb2f7hMGWSgHhxphQagg85z+hl6yrRk8SNNGG2xptLmicMR4oFgHLhWENTFLY3dxMos
C74dvPbhVWU3VeEwJJLMZZIt9HSxfThIbRAHFauhZhzUTbHnmcQ2C9vfvykFk1v8fItxpr17
H+OurC+Hkw+qROTSoOhHpdJzyezHKSPh1c1mZ54J8IVGZk1qCW8T0Z5+wIYun1/zOdluvbU6
k8WXRc3Z/hovF1om6vX2LNRXyJgsxubhPQlNrZ5Ru8k+pQWV7yoo5gFTOtwet37PG+ZfVhBG
AenY/U0HPSvDo5FNHR5ZiKsIyBO9DDYS5at+x2DxEIseMwxj3wp6+sDoI0ktw1IkdLvB50wN
DLXBDCyKBKbxADLrh8YaU9pGabdIQBm7G3416wSFmALQwkdKmA4Y9jaYHNqd1T50ws9ddLeV
boRnmfS0TCcbYhlX+M52s/g9OiznTFhUCLaVPh8XwhHz2p9hZd9wrVL4VKVW4qFTOi5A6pm3
fa7BSBXQ66MPNh78EHQFoBN0qvXYsfAQ6gT8GEcR+sQT7dZiYzqx4X/EdNZAVhUoyvY5tx2r
0eLnVzVkz3eh25WYU84PTHR6wV5upwswFf1H2ban7WkyB8sBcGoC25LItsg21wQaFsGyMqkS
yZ33SWljngcDZcGbIA1Qm+0/PUGCKNkuvSEd4Y09NydwWbAmgvukTLicQaxkz/OHOZuTd0rO
qgNzfXPyvgtptfYVdnctC+tfFHNLExkRrJ3Aukygar2gL9FAaQiCjeCTRuUaX5VvTF7em/mu
7E+s6TGVT4O1AmrHUIVvsr/amGc2ymV6w9omOJmKyJ7L2vLG68T6gBi01E7pLk7M2Ukr60Eh
3EmezpNaZzz7Tb6b6HGC2QwzV+RaBK61JkNYh+hf9JPCorQdfkGOL6/yuWb54dEBlL67+o3i
P3+ETI4kHgC8Xsytep64RZbJj3kpVGZenryIAlqoHH3hNW2gur6+hVkmTOLn0EPiHKr3F/pP
z3/r6V6PtWZTYnVo2Go8UmdA8bJDCRDviQJQ0+BWGFrnFbpcQS6cGkZYH91Qouv5UbRq1dTv
0iVG4lELJJxB7BEKkN0oZhEqF6rDh+cxnuF5JUHXImzoHCI4iyauvHG8tlLKXi3iVqw2kGBt
x14R8jxjjvkHZM3w9JirYeLpQrsTyex7ejjFxfu5eX4WMRhXv06I/EA01y0CHiAJb+WOJbq6
Ct7zY7KFuaTKK/WZtNhn1+44QLx0b+JUL6TbUSQ/Js93RTpEDgMbs5o6y8DUJdsusehO6QGE
Msh/AdfA13dl0rCpJ4SdVHEIa5MPrDSFMvnN047WveBvDU852iBomSTZAArHb+aP1wkaZ3xA
ekYGK2IQCOD9nYgyvtqXiD4SGGdMH83ORjs/RRy90VDuS/dQxrceZ2ouMtqDfgf3LvXCAAO/
HCUWUAFGFLs8CUDc5W6C58w/ed4ZWAtxvsAYyBkCCvzWGp/T+yzjgnFyTbsrjZqe/5As6AMh
ntAg4dUOomUK/Y8atm2D1iNg8taHNYBeuqEeOmBD6wTVgOy4eYC7wqgro7X3VO7HMDV1M7bN
W/Z/sCQIy8cA51K+tzIblj2GXC1LzJgzC3yaz44Ix8UGvXibMDO62TSWptVuofWhZ7Xq5ZA4
LaVXM8QjyjEZKA38HVxcmDA2k0mQpbetg2PC+OEfJns3Ek99mchhFYnsP2Mdqn4lpcsfieXD
nkmAE4djkI4dJ6fpjG0hRXVT72TWEGeILhnLbgxJnFRC1H5TtwU7vgCRpx/kRCDPjefiBSWS
mCzTTrrkMsVTsrBt5kGppF0ZZnJvX/oVTzaiRJzHYTX35S41MUDFNApWfpaoGAPR4O0U3/9i
l0HEJFxFh2v3+HepgQ1fCGoD7hGDcrCPqRS7DDc0gCoH4LdC5ETLaY9o5lcZTGvfisKqaAQy
ItI88NZEFcGro9B7+vpNi4vgFDz+ItDMK9L/v/KXZ9DwTs2RI5Y2GP3Dagi8ncQAeJ1iPATH
oKgOBZFhb+2Fws17wiqmGzS6R8pWk/uU4MA8Fi0PEzPoFVSNeRtfuhcxi9othwsJAmsfaXk2
9gFaF5rGROFBZ2YvSii7oonrnHZy65c7y8a1S327WtzNjWjuV3gqyQYGknAjrPOPzuWh6jMb
Iiy/Ih2ash/ZzhjtW8WzSwthMtbE9oxh4xxnd43BUBz+qH9fVr1qtSlqOMmiUuF43E3uYblc
oo0/bP/q21HGxlsmg48N4q6HCjQL1CRDeEDrFJt/Re5i3jZuPvpHlB4S+p2h5SanNAsqDKGr
Hzdl8muRDyFMkHXRYsidKtqexEVBI07NeIk/TFdrGXkUu0r92emfQLWILux9RJDUKh8RCtDp
StCgp2KeZrVqJ56CX41w2vMoxitLCecI90NxFgwmK1U6CrqJ+jU5oRVkrnt/5PeqBXBvsUnN
2AudsJrJR/dXATK8OvQtbVByMtY6+GfPh6SXUfhjC5mBg/pb6WtA73B1Yv+NlAsDflh8nagQ
4HoG3syBdq7Le6k9809B0nBiZMRBe2XkpskotWDRmlrMIXWrJR6Q0bSX5rvVKRsvqzmsZgUO
mrWilnE9AcJCAWd9E7mMpuLbeZ6o3v+yLd2W62XXrNrlSzny7nYkAolN4aM/lRPKXIHqt2Qy
Sgb/DMwJ6so4ndixTRYwa6THW5rEEJZ2/GFJnT612BKlwc83aDX/0v29LBe7y0ULgTQtUI4E
di45+fJHiWOQMZwVqNbzOfTLdgjnCaxdjzRrOIzZNewGFunoa0wgSsBbm9OeY81/kaN3wT3O
7FU3n9PnOEe4uMkikuN8jwMvVI2Z6KceQaYWTa8Mc18bKBDrPdKC8atRyphHtzKiICcwVati
IY5lsXBQrK/jd0AFIXZrdpkV18S7Zt54rgsVMOyVD+s+7vxw8VLY/GTSLQLghFOdPZB0xZwj
CqoC4Z8guvFc27tjh5ldqEwf0LO0khv6zd5LhYpFfxpCvkK6pMY5XflXlPQ2CvXe3+LiiRlR
9SGcr2+fOaHeXwh1T++QCpptYiGBq7QacGH8ounq6fFZ0/POUDAf+YUhDF28Tf0ugHn/UTfw
e9OPP04e0N4XTALnk/neKPIc/BC3ZVpsI1P812qipSa8WuRk29L3WTU7DUyB7+SuKXEhE2mN
X7ZEthTSabJlywUaDXRAEHuEAsvgn9Y4SXXUL99usvfyHbkeIWWjx22QFr1l9c0RcpwoALuf
PA6wc93adNjuCXOtXn5OqfOZ7eCWWelA+On/pQfctIaRt9TzUKBqk59j095rIjHxYWG/KDaf
7wso2zV2CCsVym8V360Os/AK+QQVYX5oOXWNA8aPP3BZikJ6aLpJb7dJA1Jsbrm2tYHqMElx
DRs4WQfif/upC+cTQ+eVRKKJxRbYwBcKAsl8z5FOT7PhRAo454PhnVDeUIdngTX4m9TAQOqu
I8tkr7EiuBMiMArr16MLgI1SGs6lLRFTzF4yWfR6VnK4D/jVLCHobNdJp+NIfdgEyHN9l62C
weWaJAo/bnqpsxRBG/DVFQIZWpC4DSBHRH5WEtIAhoyMuDF6qYMhEs7pGvXZCu8t1pEyFLjs
4NJDAROyQlfqcl5zMIkvIt2P/uX+iCU2x/VRfJcSulr54JOaJDdpBubV8BAtkm7mx4qKBnBB
X64Ap/a8R7RzKRH153HIE91E+UOrLbEAPsemvsjtHxSXvm06h/yqE346FrxmfXPriGM8fO4d
Z3XVYeNDZZqFvYKyA/cwDiMzZFchZr00hwsblt8OsqhA99A3/UFejq3JHKcwoCFK8N9IoydI
Lv8NLGt05xgCQp0v+1e3tTyDY7ezKVJr2f3p87u+GSGcSUr9m6Uu7nsAmJuStUF1pWH6/PkN
Iq/pNQx+vXqxaUAcIZ3IbFGGAjzjZ5nLReaaYNdTKVl2AOCj0YhcBkwbexr5cR1FquIWvfcu
/kjzM35KCFgKqro1X/+PotIaDkkZ1E/hECvnHT1oibSTZ7xJfg0Dvh1NnosgoNnmtGllstP7
Wk3AkZQAxidH+ggjrai+YcQ4mc9YJbNDXok36otJmevQXwdaRshU665/D/gmyxEE63Vh9cjw
AynXhCBhF2cSpM3F5AFqHKvSCRMOECh544zI2FBPIqnvB+yfXqgiO62MFNxnY88mwiRMZ90I
UkpTmVB1YJJ++pojLZUKC7aVheAVMZ3Ty5l+yrZUTec8kW98Bso9EcOtUy4fH+yDjH9GSnDR
udlpB6uuWxDxvZpj3Fd9/zv86aSodf8NzcstE+S2lqh8fX3ItGMkTF+8JGRVWyMZfqItHp6M
HZ9AdGuO8r5cvyF9/jcUl186rqKX2olJNKMkaZBTulEcX1k08aENC6jNuLgSBycMnBoLYpIE
pDsm176aSbk2KtoW5ljLsd5Yr/8eyHAc1VWBGkXy+cHOH3Lsqagoq5XRKk9CyFJnQV2lLXHF
jqGes4UQXmpvWmXg3yt8pBp7/5OzJn3Euargv91bJZ7HvObAij+6FKvUiUOoDxLxy96RSPBb
JwVK7hefWqT5KcmDg+T7Wm2jZ+shzLcx/93Qq0JDpuzZF6vKxZxFyucIETUTjZKKHpR36EAj
yJWHDckcZ/VbzZYuuYpVwehz8OMRFENfUjky5xk8hfzVofUDGd4AVnp8smfy7JA6QNzzt/IH
eqGA+cta2o+VhMuBOQD6GfDlBCN9E/1ONuE7eaK7pZROc8GKGJCBihTCdg/Jetf+ma1/FEPr
x6JLAy1NvtgZsBdDy0fzsrM7GvlUzqBOXKb2TE3N9q6p1KKTzMANNwwMDI38puzUmSEPB5rK
Yis5rJApU2LAFcGaHQfIaLa9ZJGbuwETsLPywlGJzPE5LUaS9fQGl27R1QmjbXeu0Jh4SjAp
fcYerpsNNQWJ/b7agru7zP+fUAbMY4ur9+0sgcawc1QhIOY3ylQbK0IX8SR4Jz9EvZeZzeZ8
tX5uupXKNMvr5m6nsdDvSYM+PjlTYv97otFOS8Pga4UuWgV8BcKaRVfHMdGVvx2NyZwfpUTa
jwON786gs9RyRbqymQ0RwPtx0CGWKxTFWKx11qc+ExoJuKHY8XWhEQXnEJtasN59jT1SrouE
9PGGp7KGIaVJl6VyeKbB4dVOs4nKTws7BSyREW7YO2fxNe50y3gv3wVlyLJuoU6lgnFMO0je
LpXkuJzRJwQzqbkpzagIsuCQ0Gi00mBBA4Y+PMpJ8woZIYCsC+U1QW9P0HspxwDGQbN5tSaw
7c2GVFl7WJFOKS0CNBwDJhVPzy1gdc5u5J2ydiz5RslYlx3gWwK2JR921LQ5zxie/bCblZTy
gLLSE9bquCKjNkQNIIQKEevQv8AbyaJzvEjpqJjZz5Pa0PrYk0HGqI5xux885p5t/qKUyYpi
Ljb3F5vbS1OL/oSrIX76ATVUmXkvoHe61mbnUFI2Y1cTegQwQN6hlWVosJh7BAtOplEVihRb
oBwcRYA3GmEc2b9TYU/SXpXhN2MxRsoKaMSxU8Ck6RxluDhFG7lMQnE869fVBzjJrmBvi3iM
Lrg5fWN7oHWGp0cKhu28WIlTwc2xZNwJPz4QKTMF7xW5MitM5ipIx/a06uPCa6I3zxfmxjsu
U5Ope/cwdPcM0SNByfMaeBEN1EGifgm2aygyoHzh6ejQP2/oAyhws/4PrdFVEYjKMUZ3t52u
5icXUMytTluOJvcovpApL9Urnc1rBLmI0ovB/24RO7M1XWCAKga0QmZkKy2ttqNW3ML2YwZa
yUKYKjooSE8S4RwvFKayX/sxeL+p0sA+8QOx9AsKDPbdXKsZlQ529wmodcjv/vjQdvDkdgp9
i8GaRXKfVlNAFXqczHoMrFDTlWjQ5fP32RHCBMHpxlJcYRPCcfINdKAUisQUdqAtD00kQtg1
cSexvfi5fFmnzPkLHFHvuSLfAkBGtnCKYjRsYsx6pBHFDU+td21fRcWY+GZtEys7QQwQucnj
zdVGTEnhpShVZU8QFEmh0Wi6l4H5J/nuii70ZzoJkujZ5PEvn2R4snY7L/EaUwpTbhyBqLn2
ZjmftAsUvARuDvm6/UqGdtJ6HepdHOadckcVwmLePMwT6i+rALQ8UxYlpsKZvwnnijKZHmxu
nS+IrSQ6VU8z39ltG2arSmVjEN3SEYuf4FZvwPiyTcYbW9bBliRDtlKVXQ2TKQhJOzg8teyC
Jl/3lsEN/3JoW17+aIi5dEYAbVznzj5N/Qo9AR3bpqBdBGiK8Bp9LuoGhQ5O5+ns7D/hdT/y
o/9UaHpd8ixeaRs0qf1rYD3k32jeQ+/9EsmmTJrkgCBBkv04UA8Ugoqzh8ffzL5Mxm2MHNct
MIlzaNF5bb4eTUH3Im6kFqpD74pApyUBWcXQlsauKmvbqgMRHUWPGIp8RVW/l6HHVitZgDGA
9Buc4Me36V6kjQkhZDSA8MwWhbpmKnMq/CObYFhAO9KhRS00nboAEGazC11f7y3YyzIvmDWI
JaHZMXdZyDSwBHvNM21JRNQSI05IFqVLfmGO1to5CuNgLdoZTijoxrOYbejMKbS10gcU9/28
gB4ruWjDVBp/p98/dCwDZRcrtSMa2eLy7a9xWTu0C2Ihz9og9IReWgaJFzs7MGgz4nuFljna
h7d+irNJVGOCQnCosFOAj33Z9ncFhgXV9NkzMScBxiiIb6MJhum+F6smLPCCYEsYo/VI0ng3
J28C8xhdKFTUT3c8B5V1y3wikkiDmGe0hc3YE1VpCinIHJSxaWfbiZoKV0NA70jCFkmsYkim
djISRb0F/GqMpSKBCq+GZ5EiVLvzD9z0rRcjx+KnsnEYkiAgOVFinwAS3NYCCWHUkwqPY3T3
7dYNVqck6TZdfHNPsV/qFPJVBSzkMZHK19lr/iFTyNUJB8D/3b8733Dpj7RYpXzdLHjveO7O
QSdO1RE4hMxoK0SpkrZRtlTy2ryGebKQfGkUmCnMnjNnWeJsJoCCGpfwwhpK0MUQ4n6pi4FW
gfjoB9NQN/uyiBiK1kVg4g+wDi2jKDGtCb9tNg6lWBNev9+XZLkuB9dzOYKyYG204cA+I+M4
1N2ETOjpXHisqUBPouVAoiO582VDAZps5hwzilJUwCrXgln+MlG2emKovwYU9IbTtaPDDCB3
oHbe0X3XvS0/mOtNJEP3V672RWucbZsTqurBNlR+ZOjE1tg722Z8BBe6kBGQaWJyKdd1nLJL
ODxRczf3b4CBsiZjnPuuWTuqpSe3PZgw0wQTkp7g0N4RXkJQYxSQcgZ2puXcwZKQlj67QgSH
Wg2PMEACtdS3GEXhIPjlln64nGWNhKOdtAMno7g7sjhNxdA6n8kgSVtko4hf7T74Cd97iB8s
ShbsSG/gwERuGh9px8A6zvao0zyc4TDcSJUenBKGoy493F58r05STC+VyqTILc5+uX7dPfSj
QVhCw9T2L3gJQXz2DTp1ajSvJ0mGqizQFvX88lbuk0Zw+MhqM0hIM1FiX19H6f3pilkK7XNL
z9ZNfmksPqhq0+3Eqq+QB13Haq/hbWOd2XZoZbuxAgjDmij2b9bF0u0lLSxoZjTvAuW1j3sN
zWGJJ4Zq0a10QYWBZuOfzaEcxD1n8iMrr2VRGpAKozt5Rj9ago5lxTVUXc3+VXtehLizWqf2
NzVHNrEUl0o5cXaI5SsZQMsRU7KHZHKZBI/Dr30DFERPgPtlPlp8d4eCB/H7rm9W/L5htGPe
cbDa5gvXX3vQXcH6ti3o7WHXCm4biDcVCScTRBwEYjHATcfmuerUmjSW1x4hVgOfP2LzC4gl
GDCb3f5zy71X5JXm+kERyGLUuVMexr8qtkRkgH4EFLovHEQiM598DY0kY2OLYcaleGmr+m3q
HXb0oMVwZZcaqRFMwkR+huYp8zRON4HRJH0ytosQKXShvAvUkSPnf//lNg8LX1DWnMxTYatx
0xw7J++xCxt3f2joUFhJ3w3/bJiQIQgLd6aCIa2kBDfsgjJHNHiNOYULQ1sKKAhgdezetHqI
NkSZzuLAlDP33SA5CaP5E9LzZCNCPrUplLeTg3skSvDyq2gZKHikyooAIB7Z8A9/7i89j6BA
KSAqC6ul55S4NxUfkEcGYX5FdboSF3WKjuQb1tJvKiMfxThyA4XqfbhK1lpqWhpjqtKHyOkg
C/JQS3gMJ1N1ujL6khvhCSKwhYyAl2kcDc6TYM10IQrtUU4MMlZaYGQQvbio+RJ1N1Tpet99
nbGLhFCNOpgM8NbqFavauY+YigsN31f2Lx+KeTtzGdDArdWvqR11AW3o3dKhjCTnX/by5+kM
sGKtQaTZMMV5cLc24Qcf3iPPwt0VIkvjgn65qXJEEfX3qRPxmD4njvSPFlWbBdLatITaE4iG
tIuMacUtD7dpY51+EIU/dGbZGE0KYfr2P4turk77vHjXZBOJWUMqrd6LiShhcwT6w5oyhd3n
q9eHWcfSeX2Q9DZsrM2tyQYAZ7b4qwp5UfZxXT4XqHCsjdvVUHPgulIMxASh/OpM6P2sjzOc
O9SfvvT6B6ESDUq7iZIZQXQkSIZOP+OYIPnAHd0W9Ihqid0MedPgGVvAiF6fvhBc9U4zlsNr
XIcvTaeyVaS+q4LEq9elLkWa93uk+zRG6wRHGOzsb44bQQk9KjfrD0N21xZH9llPhy5qmfYn
njyNxBHfu+qtHKN7ArgD5ZwbaDnPbZsqliSPHXyPR0SY/9t5XGylNmyCP5XdRbXAnmgTpR1R
FGZldg58nygZhHhA5hT9dKkrm7SAscUUgZGdVvTKJTadWX5wud6eyTUUfBgzJp4wgmBAUEpw
w8dDW8SOlV/qj06d4BI/+mkVhNAJsKdyzR1Kc86hBYsY85aR9iPB/O1twlLY9rJt/WkdMJZK
uH1cQ6Jww7oKOT5A+2fv3qNZMEwUVZfUF3ZO2KSl1h1tDwmkAdCpQ/50THL6lhaHxClZN41m
opBrhR9Z1xFCwn/la0X3tllYhKK12Q5QMbpy+HIID5mpwZwOj3sf30CHHaQVqYVxMlaHpKom
80tZ25Eube/tt2DSQCxFicNpcdjwil/tWP7P5W0JK9bR+O89r7bySdBh1usq/H+/nXKbk42/
eol8chSNOwXDyx9qWCYetso5Q1E1uE0ihjFe7CGrpgYMf+PsG9KX+3LGGiWJv5YLCXaswaWf
au52TRor4ejlhlopyYS42HeW6lownHjmAgA64RYky7Ih6q8uwT9/CMKz3miA0fbpFXJSsZfF
te81ewYsO3l0g++b6UBMSK1PLtCFNdryb+ecUajR433A/xnwlvypHPixyxIHHl5w09zK6fZg
dysgFqwi96EUEkV0/XNiTPIlnPp2kRI30qNmrd/beHby9SI0jU+/KdzwwwhMufwRmDpV2NNJ
guuDfUpTK1xt5fDy4QALQCZRgtNxavU+oe6kn/ed6CvPGmv8XdNSzb7I4Zjz3EAtufxrTjlg
1iUrP8ktUYyk+M2erbAYASbROiKTZK9w0VVTRQBfVyCmwYHqA7qcYEvbO+Ff/ZAdBKQ+C01o
s5WCvS9oSTEGLw6ApQAgzjfo4qOYDdUAisnNi+sfoRMZm4kk0Ix5/m2gOxZYJO/txRtONey7
kRt/Evrfl1EPNmCVSvbxDDYJXqFDIkGoLj1MId5Pj3sSnGbl2UpOdbOhoeHyJJXP4beJX2eF
msC0uBaXKp/LdQjytwS4/oWr6DSAMd6jVHEv/SOpixzqOVq9Xf0a2JEfMTPPWQsiYkNQse+f
bIF3+OyVkxc42/xjU9heMN5pURu+E9sa3NXenpL27B8ZpuYn7GUG8FzDg+leSV6JttbmmI6q
p9B6VD5Fqtco4QG1WqYhQojPifg44esX6siB6Gr8u0mlXgDv2nJWCywuSvFaNsAT3svZIaQN
Y8FRu/Z1GPGiOFwxeiYdTQTVr+dKlI52nqV7S9GN9+Denh7rFdVlnQwV7s81ZEp36h8S3wxs
k4NHmxlPb1J/GjdEYAQr4flcrcz2gHBlPXGWB56sSZcZceOFqxQT23jmv+qwex+mriB+rore
ov5cByeqrYBhNOBt7odDlqJXoNFw67+a4C41jytnqCeTDM20U9/RYp3/EPTt3FyJeRvPlBA3
3ekn1AsAg0kkdwUa6uQAAcScAYrxCr+CtuSxxGf7AgAAAAAEWVo=

--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-rc4-00010-g17e5888e4e180"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.6.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_SLUB_MEMCG_SYSFS_ON=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
CONFIG_MVIAC3_2=y
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_ANCIENT_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_UMIP is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_AMD_FREQ_SENSITIVITY=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=y
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM_WERROR is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=""
CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_BFQ_CGROUP_DEBUG=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
# CONFIG_NET_DSA_TAG_AR9331 is not set
# CONFIG_NET_DSA_TAG_BRCM is not set
# CONFIG_NET_DSA_TAG_BRCM_PREPEND is not set
# CONFIG_NET_DSA_TAG_GSWIP is not set
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
# CONFIG_NET_DSA_TAG_MTK is not set
# CONFIG_NET_DSA_TAG_KSZ is not set
# CONFIG_NET_DSA_TAG_OCELOT is not set
# CONFIG_NET_DSA_TAG_QCA is not set
# CONFIG_NET_DSA_TAG_LAN9303 is not set
# CONFIG_NET_DSA_TAG_SJA1105 is not set
# CONFIG_NET_DSA_TAG_TRAILER is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
CONFIG_VOP_BUS=y
# CONFIG_VOP is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.rst for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPNP=y

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_B53 is not set
# CONFIG_NET_DSA_BCM_SF2 is not set
# CONFIG_NET_DSA_LOOP is not set
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
# CONFIG_NET_DSA_MT7530 is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=y
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_AR9331 is not set
# CONFIG_NET_DSA_SJA1105 is not set
# CONFIG_NET_DSA_QCA8K is not set
# CONFIG_NET_DSA_REALTEK_SMI is not set
# CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set
# CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
# CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_LDISC_AUTOLOAD is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_SPI_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPMI=y
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD70528=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_MAX77620 is not set
# CONFIG_GPIO_MAX77650 is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
# CONFIG_QCOM_CPR is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_FUEL_GAUGE=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_TWL4030_MADC=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD70528=y
CONFIG_CHARGER_WILCO=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=y
# CONFIG_QORIQ_THERMAL is not set
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD70528=y
# CONFIG_MFD_ROHM_BD71828 is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD70528=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PCAP is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_SONY_DECODER=y
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_RCMM_DECODER=y
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=y
CONFIG_IR_HIX5HD2=y
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=y
# CONFIG_IR_FINTEK is not set
CONFIG_IR_NUVOTON=y
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# end of Backlight & LCD device support
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
# CONFIG_SND_SPI is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_X86 is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=y
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX8925 is not set
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
CONFIG_RTC_DRV_TPS80031=y
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_PCAP is not set
CONFIG_RTC_DRV_MC13XXX=y
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_RTC_DRV_WILCO_EC is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=y
CONFIG_DCDBAS=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=y
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_TC1100_WMI=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WIRELESS=y
CONFIG_HP_WMI=y
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=y
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_ALSA_SUPPORT is not set
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=y
CONFIG_INTEL_MENLOW=y
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_XIAOMI_WMI=y
CONFIG_MSI_WMI=y
CONFIG_PEAQ_WMI=y
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_XO15_EBOOK=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_MXM_WMI is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=y
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
CONFIG_I2C_MULTI_INSTANTIATE=y
CONFIG_HUAWEI_WMI=y
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SYSTEM76_ACPI=y
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_SPI=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=y
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
CONFIG_WILCO_EC_TELEMETRY=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7266=y
CONFIG_AD7291=y
CONFIG_AD7292=y
CONFIG_AD7298=y
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
# CONFIG_AD7768_1 is not set
CONFIG_AD7780=y
CONFIG_AD7791=y
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
CONFIG_HX711=y
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
CONFIG_MCP3422=y
CONFIG_MCP3911=y
# CONFIG_NAU7802 is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=y
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=y

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
# CONFIG_AD5758 is not set
CONFIG_AD5761=y
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_CIO_DAC is not set
CONFIG_AD8801=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
CONFIG_ADF4371=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_IIO_CROS_EC_BARO=y
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_DP is not set
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_TEE=y

#
# TEE drivers
#
# end of TEE drivers

CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
# CONFIG_F2FS_FS_LZ4 is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_TEMPLATE=y
# CONFIG_IMA_NG_TEMPLATE is not set
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_APPRAISE_BOOTPARAM is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN_NO_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--qFgkTsE6LiHkLPZw--
