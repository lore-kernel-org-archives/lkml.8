Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AFBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B2A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgEKLMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:12:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:12:13 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MvrRB-1jI5N61pGZ-00svin for <linux-kernel@vger.kernel.org>; Mon, 11 May
 2020 13:12:11 +0200
Received: by mail-qk1-f181.google.com with SMTP id s186so7416566qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:12:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuaxPHUArvalBoG9zNyTLZV921jdryd+BmWM7R+rD19Pmbx2mQFb
        r3F3D51bwraFcQ5SoUesU2jP7Kzdf7Ci5Pwihmw=
X-Google-Smtp-Source: APiQypIbgYWPL1eVgmgt+OEJWotT/UG/zkDSEnVuKwkctZAoRbAMw0S2WG80n8rRO3MDFCAMjuoi/HTbAAfKE6vC/1o=
X-Received: by 2002:a37:4e08:: with SMTP id c8mr14873408qkb.286.1589195530292;
 Mon, 11 May 2020 04:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
 <CAK8P3a1BKGQjRDtdWB4h6Y6p6Usgr9ic45uH3w1H2v+N6g_gQA@mail.gmail.com>
In-Reply-To: <CAK8P3a1BKGQjRDtdWB4h6Y6p6Usgr9ic45uH3w1H2v+N6g_gQA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 May 2020 13:11:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Q3exE49Z=tLFb_j1T0CPFbKuE+o8265PMVuMmsqw72Q@mail.gmail.com>
Message-ID: <CAK8P3a2Q3exE49Z=tLFb_j1T0CPFbKuE+o8265PMVuMmsqw72Q@mail.gmail.com>
Subject: Re: I disabled more compiler warnings..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NnZcC6O0w2KGhut4wJKX9y9X9YySEiv+8WGtSKvWtwMngGCtk69
 vOWWJmXijK6OSbCMuh3pUWWszbiobN62Vf+zEoM7ou4kL3C0cDP2xpjOjXj0lCp6qMp4+n5
 150t1JZHepeBefb3v6MS3V7qsdIjZtf58staHNQLv5iU7aHOpl84TIaySf1/gXiWC8AkboL
 8zbvuuqCnfpfEZv+OC6Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZslyVnCmhA=:Svvq0d5y5kPdC5cu/Tc+sp
 sLJC5R3FHTLTkclNKqYlgi0XdWxwnhgME5FHaXeYw7aUy7iH3HlEQqBJ1xk2fuLf10WXJAXHG
 ZCzueVZMD0+fcl4XhRGZLmuCzAz06+LFY/i5fMKGF9nOGL0DanIEhMcz7q3boX483NtAHK2mN
 5ZZDuQkkQYgqa/FObpaq6dinDlxINsKM3T643zO4BrbJx4mLiNe1WoaIgja5oMttvwlzHetXz
 fvtPPGeKQiuHohiPel5m59M+j1P5CjTh9LZ6R/g3tGFiEa0o7ewVAmPYnuAatrzvEJ5LrzQay
 9f+zxlER8L7c1/It4iyV6AZfrOnBsLeov3bJYqdNPALz7wE45ianqZpwc93uqp7qoII0J7pqC
 LTPQmEesr69fpM0KpviWz9FUaVJZrMH2c8d6vOkFiHpDgTOOM8TdaPhsY7QpbLuf2y7wWrksF
 TBQN6LxQd9MkDByYO1uXCJ0lftSDy8vDQSmKrF0tpCDIhAFlz11aHiMIbvGvGJXB2s0J9XFcM
 lcarlVHskpA1xASXygujh/BgBvqZepaIdpF3AEDoJqP5dmtjAJZQTr1vyfpc2u6ysHMt0TSaN
 /ZBuNG3TiJ15YCvApcVIJmcXv+/YoSdAYz7eBwSxkTwSpKeTnboCXl9LIeNPht1CXLatNnVYK
 PoPifcX6K6DLHhA8XE21aygLko6W1je4iWdNB/95eQVMfkWZC6ERfK3VLgrdleo9sMz5wUOZd
 OPuPmJhbQ6k6A7iLqTTayg+eMTMJ8sgzvVYCA37+48zLG64YkiHODDXNw7xIoHaFxHfl2aNGA
 RX//K6pGXZtoXo0sHeFL0YQR5UpTD5Gi17HfUr+eWVaoq+EcCM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> - There is a good chance that some trivial difference between
>   mainline and linux-next, or between linux-next and my test
>   branch (with a couple hundred fixup patches) is causing you
>   to see many warnings that I don't get. I'll try to reproduce and
>   bisect what I find.

Update: I found a bug in my own patches, one of them tried to disable
the warning when CONFIG_GCOV_PROFILE_ALL is turned on, as that
caused some false positives. Unfortunately I ended up turning it off
unconditionally by testing for CONFIG_ARCH_HAS_GCOV_PROFILE_ALL
instead.

I do see 36 such errors in my tree now with gcc-10 x86 allmodconfig,
and there are probably a couple more in your tree that I had already
fixed locally, e.g. when clang found the same thing. See full (abbreviated)
list below.

Looking at some of those warnings, I find a roughly 50:50 split between
code that gcc should have warned about all along when there is a
path in which a variable is actually used without initialization (which
may be impossible for reasons the compiler cannot know), and code
that looks correct to me, but I can see exactly how gcc gets confused,
especially now that it warns about the first class.
It should be possible to avoid these 36 warnings while making the
code more readable in most cases, or adding fake initializations
for false positives without a better workaround.

For -O3, there are many more warnings (225 total in my tree), with
additional valid bugs but also a higher ratio of false positives
in the samples I looked at. gcc-9 -O3 had additional false positives and
also a few extra somewhat sensible warnings, 273 warnings in total,
though these had always been disabled already.

For the default -O2, gcc-9 prints only the three warnings from
kernel/trace/ftrace.c, all of which are false positives that the compiler
should have not warned about IMO.

        Arnd

8<---
/* x86 allmodconfig gcc-10 -O2 warnings */
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2441:42: error:
'nr_pages_avail' may be used uninitialized
drivers/video/fbdev/i740fb.c:332:9: error: 'wm' may be used uninitialized
lib/zstd/decompress.c:303:6: error: 'fParams.windowSize' may be used
uninitialized
lib/zstd/decompress.c:342:8: error: 'fParams.frameContentSize' may be
used uninitialized
kernel/trace/ftrace.c:7156:8: error: 'seq_ops' may be used uninitialized
kernel/trace/ftrace.c:7234:8: error: 'filtered_pids' may be used uninitialized
kernel/trace/ftrace.c:7251:22: error: 'other_pids' may be used uninitialized
drivers/i3c/device.c:227:41: error: 'devinfo.dcr' may be used uninitialized
include/linux/i3c/device.h:80:49: error: 'devinfo.pid' may be used uninitialized
fs/ext4/ext4_extents.h:226:8: error: 'zero_ex1.ee_start_lo' may be
used uninitialized
fs/ext4/ext4_extents.h:227:12: error: 'zero_ex1.ee_start_hi' may be
used uninitialized
fs/ext4/extents.c:3083:9: error: 'zero_ex1.ee_block' may be used uninitialized
drivers/input/touchscreen/hideep.c:373:14: error: 'unmask_code' may be
used uninitialized
drivers/media/i2c/tvp7002.c:691:11: error: 'val' may be used uninitialized
include/linux/spinlock.h:289:3: error: 'flags' may be used uninitialized
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:571:2: error: 'hi_base_addr' may
be used uninitialized
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:571:2: error: 'lo_base_addr' may
be used uninitialized
drivers/gpu/drm/i915/gt/selftest_lrc.c:2959:28: error: 'rq' may be
used uninitialized
drivers/gpu/drm/i915/gt/selftest_workarounds.c:492:17: error: 'rsvd'
may be used uninitialized
drivers/firmware/arm_scmi/driver.c:502:12: error: 't' may be used uninitialized
drivers/usb/serial/cp210x.c:948:8: error: 'bits' may be used uninitialized
drivers/usb/serial/cp210x.c:1194:8: error: 'bits' may be used uninitialized
drivers/platform/x86/acer-wmi.c:1440:9: error: 'value' may be used uninitialized
drivers/net/wireless/rsi/rsi_91x_sdio.c:1340:7: error: 'data' may be
used uninitialized
drivers/net/wireless/rsi/rsi_91x_sdio.c:238:12: error: 'resp' may be
used uninitialized
drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c:160:45: error: 'stat'
may be used uninitialized
drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c:160:45: error:
'stat' may be used uninitialized
drivers/ata/ahci_imx.c:369:30: error: 'dac_ctl_reg' may be used uninitialized
drivers/ata/ahci_imx.c:377:33: error: 'rtune_ctl_reg' may be used uninitialized
drivers/ata/ahci_imx.c:375:42: error: 'mpll_test_reg' may be used uninitialized
include/linux/printk.h:360:2: error: 'abs_ppfid' may be used uninitialized
drivers/media/dvb-frontends/drxk_hard.c:1026:5: error: 'wait_cmd' may
be used uninitialized
drivers/iio/imu/bmi160/bmi160_core.c:577:47: error:
'int_out_ctrl_shift' may be used uninitialized
include/linux/dev_printk.h:104:2: error: 'pin_name' may be used uninitialized
drivers/iio/imu/bmi160/bmi160_core.c:606:8: error: 'int_map_mask' may
be used uninitialized
drivers/iio/imu/bmi160/bmi160_core.c:599:8: error: 'int_latch_mask'
may be used uninitialized
