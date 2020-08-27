Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0A12177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5MszEw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH0FRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgH0FRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:17:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B4C061240
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:17:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so2006728pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8GXnJXl8TLJXZ/C3Q5ufg1HhDTpQh5b6PeHT2a+5RQ=;
        b=M5MszEw7GIhIHpXDZJAh6hGnlrzdCdHpVXRuHR737FiQz5BYo5G4v7Dm8vjqhVCtz6
         o4vAtFdDmDLRp3hx2CUY5+sy7W1mc9iXrOa8UVNlHCzO/BYJyNUBDVBa3Zff0fLLh8yU
         jibsIm7cfSPi68hL2EDrvwval8nwFO1wCyqXpbMmxrB2YREvTR4qUkqvcUJOMYVKXzQ7
         asfwVy5c2PGgte8ngiEF8+/eGSugds+pzHT2thGxyZgofmUHT8Op0F65dNUbaQ4UXcWQ
         W402WMynm1RXE0W5BvwpKprqob098kf8s/yX6O2He2jM638emKRfvF5VZ6DZtvJSTewT
         +jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8GXnJXl8TLJXZ/C3Q5ufg1HhDTpQh5b6PeHT2a+5RQ=;
        b=Mrgki9xwtqVnKn7MnHwVUibze9ZbHYfmhtbBunKCpmkNn354z4MABmHmmquxd3byYC
         XUEJgYdMyhuhjedbSSANXd8NcyZc7b5l7Bl8BGFYdjV4TJ/+OvWXD5GgeJXh8hzoQO5I
         kf8aFbBsokaJAVbkLHMIq5I+D9iXmsV6JqvLqEKlUzcYWeUJVJtKwEe6sIbLwccLufYu
         7gOgHHc/DsN4NgtWS/NbKFCl5IH+yEx38wt5GSNwfAfgCv9NzgUSU7nj/TF6uULV4p2u
         GEF6k2i2/ibbaRi+KrFPK/E0TdMUrWGa0svU0Pncp2ZHoyEnh8DAI2M3fYIzRWpGWQny
         3Dtg==
X-Gm-Message-State: AOAM530q65qxq3snBGN7Y5x5luBvny2JTD5zmoD1+VzBA581BL7SpODS
        gUrNfe2fCj3GSLD4WxMCDJlfFAQwHuzxD/nlTRYnyDSk9F2P6w==
X-Google-Smtp-Source: ABdhPJwTphU9ND4uRJd9AKy5yg8uPKtJhjMsNQemZhxADES9wnSfSYS+VkjjmN7H3KoEkSROwIW4ArFDXCNNs7CjYKQ=
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr9077797pjb.91.1598505472556;
 Wed, 26 Aug 2020 22:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
In-Reply-To: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 26 Aug 2020 22:17:16 -0700
Message-ID: <CAGETcx8Ums+mkD54BCkCvBtU1qx13VZH=DOPqepyiQz62REfCw@mail.gmail.com>
Subject: Re: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
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

On Thu, Aug 20, 2020 at 8:50 PM Dong Aisheng <dongas86@gmail.com> wrote:
>
> Hi ALL,
>
> We met the below WARNING during system suspend on an iMX6Q SDB board
> with the latest linus/master branch (v5.9-rc1+) and next-20200820.
> v5.8 kernel is ok. So i did bisect and finally found it's caused by
> the patch below.
> Reverting it can get rid of the warning, but I wonder if there may be
> other potential issues.
> Any ideas?
>
> Defconfig used is: imx_v6_v7_defconfig
>

----- 8< ----- Snipped text that was a bit misleading

>
> Error log:
> # echo mem > /sys/power/state
> [   39.111865] PM: suspend entry (deep)
> [   39.148650] Filesystems sync: 0.032 seconds
> [   39.154034]
> [   39.155537] ======================================================
> [   39.161723] WARNING: possible circular locking dependency detected
> [   39.167911] 5.9.0-rc1-00103-g7eac66d0456f #37 Not tainted
> [   39.173315] ------------------------------------------------------
> [   39.179500] sh/647 is trying to acquire lock:
> [   39.183862] c15a310c (dpm_list_mtx){+.+.}-{3:3}, at:
> dpm_for_each_dev+0x20/0x5c
> [   39.191200]
> [   39.191200] but task is already holding lock:
> [   39.197036] c15a37e4 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x90/0xd4
> [   39.203582]
> [   39.203582] which lock already depends on the new lock.
> [   39.203582]
> [   39.211763]
> [   39.211763] the existing dependency chain (in reverse order) is:
> [   39.219249]
> [   39.219249] -> #2 (fw_lock){+.+.}-{3:3}:
> [   39.224673]        mutex_lock_nested+0x1c/0x24
> [   39.229126]        firmware_uevent+0x18/0xa0
> [   39.233411]        dev_uevent+0xc4/0x1f8
> [   39.237343]        uevent_show+0x98/0x114
> [   39.241362]        dev_attr_show+0x18/0x48
> [   39.245472]        sysfs_kf_seq_show+0x84/0xec
> [   39.249927]        seq_read+0x138/0x550
> [   39.253774]        vfs_read+0x94/0x164
> [   39.257529]        ksys_read+0x60/0xe8
> [   39.261288]        ret_fast_syscall+0x0/0x28
> [   39.265564]        0xbed7c808
> [   39.268538]
> [   39.268538] -> #1 (kn->active#3){++++}-{0:0}:
> [   39.274391]        kernfs_remove_by_name_ns+0x40/0x94
> [   39.279450]        device_del+0x144/0x3fc

Rafael/Greg,

I'm not very familiar with the #0 and #2 calls stacks. But poking
around a bit, they are NOT due to the device-link-device. But the new
stuff is the above two lines that are deleting the device-link-device
(that's used to expose device link details in sysfs) when the device
link is deleted.

Kicking off a workqueue to break this cycle is easy, but the problem
is that if I queue a work to delete the device, then the sysfs folder
won't get removed immediately. And if the same link is created again
before the work is completed, then there'll be a sysfs name collision
and warning.

So, I'm kinda stuck here. Open to suggestions. Hoping you'll have
better ideas for breaking the cycle. Or point out how I'm
misunderstanding the cycle here.

-Saravana

> [   39.283467]        __device_link_del+0x4c/0x70
> [   39.287919]        device_link_remove+0x5c/0x8c
> [   39.292464]        _regulator_put.part.0+0x104/0x1dc
> [   39.297436]        regulator_put+0x2c/0x3c
> [   39.299731] regulator regulator.5: Failed to increase supply voltage: -110
> [   39.301544]        release_nodes+0x1b4/0x204
> [   39.301553]        really_probe+0x104/0x3b4
> [   39.316881]        driver_probe_device+0x58/0xb4
> [   39.321506]        device_driver_attach+0x58/0x60
> [   39.326217]        __driver_attach+0x58/0xd0
> [   39.330499]        bus_for_each_dev+0x74/0xbc
> [   39.334863]        bus_add_driver+0x150/0x1dc
> [   39.339227]        driver_register+0x74/0x108
> [   39.343599]        i2c_register_driver+0x38/0x8c
> [   39.348227]        do_one_initcall+0x84/0x3b4
> [   39.352598]        kernel_init_freeable+0x154/0x1e4
> [   39.357485]        kernel_init+0x8/0x118
> [   39.361415]        ret_from_fork+0x14/0x20
> [   39.365518]        0x0
> [   39.367883]
> [   39.367883] -> #0 (dpm_list_mtx){+.+.}-{3:3}:
> [   39.373740]        lock_acquire+0xe0/0x4ec
> [   39.377848]        __mutex_lock+0x94/0x9d0
> [   39.381952]        mutex_lock_nested+0x1c/0x24
> [   39.386405]        dpm_for_each_dev+0x20/0x5c
> [   39.390769]        fw_pm_notify+0xa4/0xd4
> [   39.394795]        notifier_call_chain+0x48/0x80
> [   39.399420]        __blocking_notifier_call_chain+0x48/0x64
> [   39.405003]        __pm_notifier_call_chain+0x20/0x3c
> [   39.410063]        pm_suspend+0x1ac/0x438
> [   39.414080]        state_store+0x68/0xc8
> [   39.418013]        kernfs_fop_write+0x10c/0x22c
> [   39.419741] cpu cpu0: failed to scale vddpu up: -110
> [   39.422551]        vfs_write+0xbc/0x1d8
> [   39.422559]        ksys_write+0x60/0xe8
> [   39.427529] cpufreq: __target_index: Failed to change cpu frequency: -110
> [   39.431362]        ret_fast_syscall+0x0/0x28
> [   39.431368]        0xbeec8958
> [   39.431372]
> [   39.431372] other info that might help us debug this:
> [   39.431372]
> [   39.431375] Chain exists of:
> [   39.431375]   dpm_list_mtx --> kn->active#3 --> fw_lock
> [   39.431375]
> [   39.431390]  Possible unsafe locking scenario:
> [   39.431390]
> [   39.431394]        CPU0                    CPU1
> [   39.431398]        ----                    ----
> [   39.431401]   lock(fw_lock);
> [   39.431412]                                lock(kn->active#3);
> [   39.490528]                                lock(fw_lock);
> [   39.495934]   lock(dpm_list_mtx);
> [   39.499255]
> [   39.499255]  *** DEADLOCK ***
> [   39.499255]
> [   39.505181] 6 locks held by sh/647:
> [   39.508675]  #0: ecf48a84 (sb_writers#4){.+.+}-{0:0}, at:
> vfs_write+0x14c/0x1d8
> [   39.516007]  #1: ed2ced48 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write+0xd0/0x22c
> [   39.523684]  #2: ec1ff960 (kn->active#90){.+.+}-{0:0}, at:
> kernfs_fop_write+0xd8/0x22c
> [   39.531620]  #3: c151c4e8 (system_transition_mutex){+.+.}-{3:3},
> at: pm_suspend+0x11c/0x438
> [   39.539991]  #4: c151e3f4 ((pm_chain_head).rwsem){++++}-{3:3}, at:
> __blocking_notifier_call_chain+0x2c/0x64
> [   39.549753] usb_otg_vbus: disabling
> [   39.549755]  #5: c15a37e4 (fw_lock){+.+.}-{3:3}, at: fw_pm_notify+0x90/0xd4
> [   39.553264] wm8962-supply: disabling
> [   39.560214]
> [   39.560214] stack backtrace:
> [   39.560225] CPU: 0 PID: 647 Comm: sh Not tainted
> 5.9.0-rc1-00103-g7eac66d0456f #37
> [   39.560230] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   39.560260] [<c0112270>] (unwind_backtrace) from [<c010bfd4>]
> (show_stack+0x10/0x14)
> [   39.560287] [<c010bfd4>] (show_stack) from [<c05af3a0>]
> (dump_stack+0xe4/0x118)
> [   39.597365] [<c05af3a0>] (dump_stack) from [<c0185390>]
> (check_noncircular+0x130/0x1e4)
> [   39.605386] [<c0185390>] (check_noncircular) from [<c018880c>]
> (__lock_acquire+0x161c/0x31b0)
> [   39.613923] [<c018880c>] (__lock_acquire) from [<c018ad00>]
> (lock_acquire+0xe0/0x4ec)
> [   39.621772] [<c018ad00>] (lock_acquire) from [<c0db0bfc>]
> (__mutex_lock+0x94/0x9d0)
> [   39.629445] [<c0db0bfc>] (__mutex_lock) from [<c0db1554>]
> (mutex_lock_nested+0x1c/0x24)
> [   39.637463] [<c0db1554>] (mutex_lock_nested) from [<c07892dc>]
> (dpm_for_each_dev+0x20/0x5c)
> [   39.645828] [<c07892dc>] (dpm_for_each_dev) from [<c0794a60>]
> (fw_pm_notify+0xa4/0xd4)
> [   39.653762] [<c0794a60>] (fw_pm_notify) from [<c0152c7c>]
> (notifier_call_chain+0x48/0x80)
> [   39.661954] [<c0152c7c>] (notifier_call_chain) from [<c01532a8>]
> (__blocking_notifier_call_chain+0x48/0x64)
> [   39.671709] [<c01532a8>] (__blocking_notifier_call_chain) from
> [<c0192498>] (__pm_notifier_call_chain+0x20/0x3c)
> [   39.679740] cpu cpu0: failed to scale vddpu up: -110
> [   39.681897] [<c0192498>] (__pm_notifier_call_chain) from
> [<c0194424>] (pm_suspend+0x1ac/0x438)
> [   39.686859] cpufreq: __target_index: Failed to change cpu frequency: -110
> [   39.695473] [<c0194424>] (pm_suspend) from [<c019235c>]
> (state_store+0x68/0xc8)
> [   39.695490] [<c019235c>] (state_store) from [<c035af80>]
> (kernfs_fop_write+0x10c/0x22c)
> [   39.695506] [<c035af80>] (kernfs_fop_write) from [<c02b0e38>]
> (vfs_write+0xbc/0x1d8)
> [   39.695524] [<c02b0e38>] (vfs_write) from [<c02b10a0>] (ksys_write+0x60/0xe8)
> [   39.704844] VGEN1: disabling
> [   39.709627] [<c02b10a0>] (ksys_write) from [<c0100080>]
> (ret_fast_syscall+0x0/0x28)
> [   39.743035] Exception stack(0xed573fa8 to 0xed573ff0)
> [   39.748098] 3fa0:                   00000004 01d3caf8 00000001
> 01d3caf8 00000004 00000000
> [   39.756286] 3fc0: 00000004 01d3caf8 b6f40340 00000004 b6ed6c8c
> 00000000 00000000 00000000
> [   39.764470] 3fe0: 00000004 beec8958 b6e75d4f b6e01d16
> [   39.770874] VGEN2: disabling
> [   39.776106] VGEN3: disabling
>
> [   69.590256] cfg80211: failed to load regulatory.db
> [   69.590312] Freezing user space processes ... (elapsed 0.008 seconds) done.
> [   69.606341] OOM killer disabled.
> [   69.609599] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [   69.619021] printk: Suspending console(s) (use no_console_suspend to debug)
