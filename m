Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2067020714
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbJ9/g8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHUDuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHUDuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:50:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDFC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:50:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so333708edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VfRUxNe0v9ungW2Q4oPm5sMofYfp+0WBB84AMnNxuvk=;
        b=nbJ9/g8EO3PckYqqNKRJY3YXUsCQFfcV2oX4t9pBlcXpukqSKnMZSsfLr477xei5in
         sRK5D0f0kJM9fr6mrEzWy4lClKFjq6dA4F7RcD1nzwx0Yo7gafrMQNxlyl1ZQQg7IiJS
         76mV3gpYB2K5aP+skHGGDB2ycfNDpThJPquTB3lU/XyWC2I9edROAxcvBLpj9WWikc0V
         DjXgKx2YO2W96eZQ1+H0tn07OGl2Dayws0JAhTrfftAKXjPnJDU3tEnfhs5eSNzgp/GM
         tnuw96nJUlXAFnxDgOA6jVtNgBTO8k9TA1Dc9fd6UZZj03ZgqyrThuPveqF+Y9602Ilk
         Q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VfRUxNe0v9ungW2Q4oPm5sMofYfp+0WBB84AMnNxuvk=;
        b=pXJbwv3ltvOgW7YMOhMISh3qEoN3wvuF3mqWnZ/JyELLOlSJRV80PB6yqRVsHqRPl8
         dA+ezbBT3ZpSBpVhmNRKW0TSLGXBUQrp4+Qn94bPVBOsV0beSKVOjGJguLtQH3IpVSLE
         CU4xI+GiTE8k9BOOidB8fjdXOWv2zYn8MLpO/F9+Kyp/6nbymLkiSzbtAG7Wa/cS74fV
         10T4wdf0L5KJuqmLMaBbo4sOIWmDCnc5d6uSnRMqsmc5k7589IDCRnwqQ6w9pl1LiLVV
         SLL1by87hLBYJ6gJ0dtYacqh6ehkDgR9WNk8raXQ98xtcF3MJwuFX4BR3n4HE5l5oLQY
         qu2w==
X-Gm-Message-State: AOAM530N2amg50SzbjUt4IFr7+FkfMvFMeyMfY37Cete18RZKTCOYh5L
        SL/w+7pwA2s1BYgXpO6arKqpPpUlA5FILYbrIKpreIQQJ2Y=
X-Google-Smtp-Source: ABdhPJwxalfh/12TRMj5+1chPYV78FxBUlNirX1oC7wLr5eozOalU+cwrUljh9PebE9rFj9iBAV7k6WTEdrOWvj/7CE=
X-Received: by 2002:a50:fc02:: with SMTP id i2mr951234edr.121.1597981848303;
 Thu, 20 Aug 2020 20:50:48 -0700 (PDT)
MIME-Version: 1.0
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Fri, 21 Aug 2020 11:35:37 +0800
Message-ID: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
Subject: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
To:     open list <linux-kernel@vger.kernel.org>, linux@roeck-us.net,
        gregkh <gregkh@linuxfoundation.org>, saravanak@google.com,
        m.szyprowski@samsung.com, naresh.kamboju@linaro.org
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ALL,

We met the below WARNING during system suspend on an iMX6Q SDB board
with the latest linus/master branch (v5.9-rc1+) and next-20200820.
v5.8 kernel is ok. So i did bisect and finally found it's caused by
the patch below.
Reverting it can get rid of the warning, but I wonder if there may be
other potential issues.
Any ideas?

Defconfig used is: imx_v6_v7_defconfig

commit 843e600b8a2b01463c4d873a90b2c2ea8033f1f6
Author: Saravana Kannan <saravanak@google.com>
Date:   Thu Jul 16 14:45:23 2020 -0700

    driver core: Fix sleeping in invalid context during device link deletion

    Marek and Guenter reported that commit 287905e68dd2 ("driver core:
    Expose device link details in sysfs") caused sleeping/scheduling while
    atomic warnings.

    BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:935
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
    2 locks held by kworker/0:1/12:
      #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
process_one_work+0x174/0x7dc
      #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at:
process_one_work+0x174/0x7dc
    Preemption disabled at:
    [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
    ----- 8< ----- SNIP
    [<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
    [<c0645c9c>] (device_unregister) from [<c01b10fc>]
(srcu_invoke_callbacks+0xcc/0x154)
    [<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>]
(process_one_work+0x234/0x7dc)
    [<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
    [<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
    [<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
    Exception stack(0xee921fb0 to 0xee921ff8)

    This was caused by the device link device being released in the context
    of srcu_invoke_callbacks().  There is no need to wait till the RCU
    callback to release the device link device.  So release the device
    earlier and move the call_srcu() into the device release code. That way,
    the memory will get freed only after the device is released AND the RCU
    callback is called.

    Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
    Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
    Signed-off-by: Saravana Kannan <saravanak@google.com>
    Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Link: https://lore.kernel.org/r/20200716214523.2924704-1-saravanak@google.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Error log:
# echo mem > /sys/power/state
[   39.111865] PM: suspend entry (deep)
[   39.148650] Filesystems sync: 0.032 seconds
[   39.154034]
[   39.155537] ======================================================
[   39.161723] WARNING: possible circular locking dependency detected
[   39.167911] 5.9.0-rc1-00103-g7eac66d0456f #37 Not tainted
[   39.173315] ------------------------------------------------------
[   39.179500] sh/647 is trying to acquire lock:
[   39.183862] c15a310c (dpm_list_mtx){+.+.}-{3:3}, at:
dpm_for_each_dev+0x20/0x5c
[   39.191200]
[   39.191200] but task is already holding lock:
[   39.197036] c15a37e4 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x90/0xd4
[   39.203582]
[   39.203582] which lock already depends on the new lock.
[   39.203582]
[   39.211763]
[   39.211763] the existing dependency chain (in reverse order) is:
[   39.219249]
[   39.219249] -> #2 (fw_lock){+.+.}-{3:3}:
[   39.224673]        mutex_lock_nested+0x1c/0x24
[   39.229126]        firmware_uevent+0x18/0xa0
[   39.233411]        dev_uevent+0xc4/0x1f8
[   39.237343]        uevent_show+0x98/0x114
[   39.241362]        dev_attr_show+0x18/0x48
[   39.245472]        sysfs_kf_seq_show+0x84/0xec
[   39.249927]        seq_read+0x138/0x550
[   39.253774]        vfs_read+0x94/0x164
[   39.257529]        ksys_read+0x60/0xe8
[   39.261288]        ret_fast_syscall+0x0/0x28
[   39.265564]        0xbed7c808
[   39.268538]
[   39.268538] -> #1 (kn->active#3){++++}-{0:0}:
[   39.274391]        kernfs_remove_by_name_ns+0x40/0x94
[   39.279450]        device_del+0x144/0x3fc
[   39.283467]        __device_link_del+0x4c/0x70
[   39.287919]        device_link_remove+0x5c/0x8c
[   39.292464]        _regulator_put.part.0+0x104/0x1dc
[   39.297436]        regulator_put+0x2c/0x3c
[   39.299731] regulator regulator.5: Failed to increase supply voltage: -110
[   39.301544]        release_nodes+0x1b4/0x204
[   39.301553]        really_probe+0x104/0x3b4
[   39.316881]        driver_probe_device+0x58/0xb4
[   39.321506]        device_driver_attach+0x58/0x60
[   39.326217]        __driver_attach+0x58/0xd0
[   39.330499]        bus_for_each_dev+0x74/0xbc
[   39.334863]        bus_add_driver+0x150/0x1dc
[   39.339227]        driver_register+0x74/0x108
[   39.343599]        i2c_register_driver+0x38/0x8c
[   39.348227]        do_one_initcall+0x84/0x3b4
[   39.352598]        kernel_init_freeable+0x154/0x1e4
[   39.357485]        kernel_init+0x8/0x118
[   39.361415]        ret_from_fork+0x14/0x20
[   39.365518]        0x0
[   39.367883]
[   39.367883] -> #0 (dpm_list_mtx){+.+.}-{3:3}:
[   39.373740]        lock_acquire+0xe0/0x4ec
[   39.377848]        __mutex_lock+0x94/0x9d0
[   39.381952]        mutex_lock_nested+0x1c/0x24
[   39.386405]        dpm_for_each_dev+0x20/0x5c
[   39.390769]        fw_pm_notify+0xa4/0xd4
[   39.394795]        notifier_call_chain+0x48/0x80
[   39.399420]        __blocking_notifier_call_chain+0x48/0x64
[   39.405003]        __pm_notifier_call_chain+0x20/0x3c
[   39.410063]        pm_suspend+0x1ac/0x438
[   39.414080]        state_store+0x68/0xc8
[   39.418013]        kernfs_fop_write+0x10c/0x22c
[   39.419741] cpu cpu0: failed to scale vddpu up: -110
[   39.422551]        vfs_write+0xbc/0x1d8
[   39.422559]        ksys_write+0x60/0xe8
[   39.427529] cpufreq: __target_index: Failed to change cpu frequency: -110
[   39.431362]        ret_fast_syscall+0x0/0x28
[   39.431368]        0xbeec8958
[   39.431372]
[   39.431372] other info that might help us debug this:
[   39.431372]
[   39.431375] Chain exists of:
[   39.431375]   dpm_list_mtx --> kn->active#3 --> fw_lock
[   39.431375]
[   39.431390]  Possible unsafe locking scenario:
[   39.431390]
[   39.431394]        CPU0                    CPU1
[   39.431398]        ----                    ----
[   39.431401]   lock(fw_lock);
[   39.431412]                                lock(kn->active#3);
[   39.490528]                                lock(fw_lock);
[   39.495934]   lock(dpm_list_mtx);
[   39.499255]
[   39.499255]  *** DEADLOCK ***
[   39.499255]
[   39.505181] 6 locks held by sh/647:
[   39.508675]  #0: ecf48a84 (sb_writers#4){.+.+}-{0:0}, at:
vfs_write+0x14c/0x1d8
[   39.516007]  #1: ed2ced48 (&of->mutex){+.+.}-{3:3}, at:
kernfs_fop_write+0xd0/0x22c
[   39.523684]  #2: ec1ff960 (kn->active#90){.+.+}-{0:0}, at:
kernfs_fop_write+0xd8/0x22c
[   39.531620]  #3: c151c4e8 (system_transition_mutex){+.+.}-{3:3},
at: pm_suspend+0x11c/0x438
[   39.539991]  #4: c151e3f4 ((pm_chain_head).rwsem){++++}-{3:3}, at:
__blocking_notifier_call_chain+0x2c/0x64
[   39.549753] usb_otg_vbus: disabling
[   39.549755]  #5: c15a37e4 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x90/0xd4
[   39.553264] wm8962-supply: disabling
[   39.560214]
[   39.560214] stack backtrace:
[   39.560225] CPU: 0 PID: 647 Comm: sh Not tainted
5.9.0-rc1-00103-g7eac66d0456f #37
[   39.560230] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   39.560260] [<c0112270>] (unwind_backtrace) from [<c010bfd4>]
(show_stack+0x10/0x14)
[   39.560287] [<c010bfd4>] (show_stack) from [<c05af3a0>]
(dump_stack+0xe4/0x118)
[   39.597365] [<c05af3a0>] (dump_stack) from [<c0185390>]
(check_noncircular+0x130/0x1e4)
[   39.605386] [<c0185390>] (check_noncircular) from [<c018880c>]
(__lock_acquire+0x161c/0x31b0)
[   39.613923] [<c018880c>] (__lock_acquire) from [<c018ad00>]
(lock_acquire+0xe0/0x4ec)
[   39.621772] [<c018ad00>] (lock_acquire) from [<c0db0bfc>]
(__mutex_lock+0x94/0x9d0)
[   39.629445] [<c0db0bfc>] (__mutex_lock) from [<c0db1554>]
(mutex_lock_nested+0x1c/0x24)
[   39.637463] [<c0db1554>] (mutex_lock_nested) from [<c07892dc>]
(dpm_for_each_dev+0x20/0x5c)
[   39.645828] [<c07892dc>] (dpm_for_each_dev) from [<c0794a60>]
(fw_pm_notify+0xa4/0xd4)
[   39.653762] [<c0794a60>] (fw_pm_notify) from [<c0152c7c>]
(notifier_call_chain+0x48/0x80)
[   39.661954] [<c0152c7c>] (notifier_call_chain) from [<c01532a8>]
(__blocking_notifier_call_chain+0x48/0x64)
[   39.671709] [<c01532a8>] (__blocking_notifier_call_chain) from
[<c0192498>] (__pm_notifier_call_chain+0x20/0x3c)
[   39.679740] cpu cpu0: failed to scale vddpu up: -110
[   39.681897] [<c0192498>] (__pm_notifier_call_chain) from
[<c0194424>] (pm_suspend+0x1ac/0x438)
[   39.686859] cpufreq: __target_index: Failed to change cpu frequency: -110
[   39.695473] [<c0194424>] (pm_suspend) from [<c019235c>]
(state_store+0x68/0xc8)
[   39.695490] [<c019235c>] (state_store) from [<c035af80>]
(kernfs_fop_write+0x10c/0x22c)
[   39.695506] [<c035af80>] (kernfs_fop_write) from [<c02b0e38>]
(vfs_write+0xbc/0x1d8)
[   39.695524] [<c02b0e38>] (vfs_write) from [<c02b10a0>] (ksys_write+0x60/0xe8)
[   39.704844] VGEN1: disabling
[   39.709627] [<c02b10a0>] (ksys_write) from [<c0100080>]
(ret_fast_syscall+0x0/0x28)
[   39.743035] Exception stack(0xed573fa8 to 0xed573ff0)
[   39.748098] 3fa0:                   00000004 01d3caf8 00000001
01d3caf8 00000004 00000000
[   39.756286] 3fc0: 00000004 01d3caf8 b6f40340 00000004 b6ed6c8c
00000000 00000000 00000000
[   39.764470] 3fe0: 00000004 beec8958 b6e75d4f b6e01d16
[   39.770874] VGEN2: disabling
[   39.776106] VGEN3: disabling

[   69.590256] cfg80211: failed to load regulatory.db
[   69.590312] Freezing user space processes ... (elapsed 0.008 seconds) done.
[   69.606341] OOM killer disabled.
[   69.609599] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   69.619021] printk: Suspending console(s) (use no_console_suspend to debug)
