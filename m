Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E529C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFB222206
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJtKHlg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIKQZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIKP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6BC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so1716976pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oE/wqoSbsqv2hid7WyjqPh05UOp+PSXcBf5enraQNIw=;
        b=ZJtKHlg2+Qyk+e6flWMUPDf2R513o9k5cmLgzNedw2Fzrrg2TvxtrJhrtQv/G77XDE
         Awr//OH53K23djlIRJOaWvkuYt4BNrys6dltOmdfdT0r3PEjxPlZUwZCQtXxU/Moq40h
         q8tzl6VH/S4mA5HfogBAqoBkTH8j4JawYnEFxnfseyHNyeC6gpvg1rXdTzZtJ0cyA66x
         vXv3S3Xva5+PN0uK92naQ70TX8GNxmqirwEau2oaGnz4uFwuz6Bb1M0pbU0Qt7RI8S1X
         pNbcdHKdv6hOCuM8Oyy0CEmdKQ1YhIYInxuI9eXNHyE5CBXZnMMkByo1QrJPzvwwZnZs
         z8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oE/wqoSbsqv2hid7WyjqPh05UOp+PSXcBf5enraQNIw=;
        b=f57r52Z3nGzED1mk4FeAlLoIFrYSL5I8YO0OfENQU2ZO4WlbqToSP/nJv1bgMyNJZF
         LW+f09P8bJHnwb6XhBNcswHM1IvOF+6t5n6FAitEm0dUSrhWwiZFLQ+qSGa/4UsFtbKx
         ZsFTCxvYuodqfiG6zCibjKaa8Oj5Rra25bVyEHbH4PhluuA2IP63UwxcudJESqU4Lj/u
         5oiD4ROxIG/Y/NJUGTf66I+otVoVOOVsKCL2u5YJ6oXEKlC5m8HumuI8+COjyJLMdV7K
         JtOhoDVnvh4f7jkbBS8Hs/Yo16gBowe0V7zM1utTGlYUmuEbBxAp+ktmhH0SkK6gP8yh
         /AoA==
X-Gm-Message-State: AOAM531j74pD4eB4aDggR9h5P0Ca99EtNdhtMf/dAu5z5D2GmpSFK6Ne
        3KK/CmKismed9kltcobh2ddt1Q==
X-Google-Smtp-Source: ABdhPJxbjdUv3H0gL8OHcqKBS2SE0Vo7mVcMOQlitX0foG0MQcL6w/a4cRDFyo1GcgHsYfGc3CZIPQ==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr2392447pjy.172.1599830948206;
        Fri, 11 Sep 2020 06:29:08 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:07 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/5] arm64: Add framework to turn an IPI as NMI
Date:   Fri, 11 Sep 2020 18:58:39 +0530
Message-Id: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pseudo NMIs support available its possible to configure SGIs to be
triggered as pseudo NMIs running in NMI context. And kernel features
such as:
- NMI backtrace can leverage IPI turned as NMI to get a backtrace of CPU
  stuck in hard lockup using magic SYSRQ.
- kgdb relies on NMI support to round up CPUs which are stuck in hard
  lockup state with interrupts disabled.

This patch-set adds framework to turn an IPI as NMI which can be triggered
as a pseudo NMI which in turn invokes registered NMI handlers.

After this patch-set we should be able to get a backtrace for a CPU
stuck in HARDLOCKUP. Have a look at an examples below from a hard lockup
testcase run on Developerbox:

$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

NMI backtrace:
==============

# Issue Magic SysRq to dump backtrace

[  376.894502] NMI backtrace for cpu 8
[  376.894506] CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
[  376.894510] Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
[  376.894514] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
[  376.894517] pc : lkdtm_HARDLOCKUP+0x8/0x18
[  376.894520] lr : lkdtm_do_action+0x24/0x30
[  376.894524] sp : ffff800012cebd20
[  376.894527] pmr_save: 00000060
[  376.894530] x29: ffff800012cebd20 x28: ffff000875ae8000 
[  376.894540] x27: 0000000000000000 x26: 0000000000000000 
[  376.894550] x25: 000000000000001a x24: ffff800012cebe40 
[  376.894560] x23: 000000000000000b x22: ffff800010fc5040 
[  376.894569] x21: ffff000878b61000 x20: ffff8000113b2870 
[  376.894579] x19: 000000000000001b x18: 0000000000000010 
[  376.894588] x17: 0000000000000000 x16: 0000000000000000 
[  376.894598] x15: ffff000875ae8470 x14: 00000000000002ad 
[  376.894613] x13: 0000000000000000 x12: 0000000000000000 
[  376.894622] x11: 0000000000000007 x10: 00000000000009c0 
[  376.894631] x9 : ffff800012ceba80 x8 : ffff000875ae8a20 
[  376.894641] x7 : ffff00087f6b3280 x6 : ffff00087f6b3200 
[  376.894651] x5 : 0000000000000000 x4 : ffff00087f6a91f8 
[  376.894660] x3 : ffff00087f6b0120 x2 : 1aa310cec69eb500 
[  376.894670] x1 : 0000000000000000 x0 : 0000000000000060 
[  376.894679] Call trace:
[  376.894683]  lkdtm_HARDLOCKUP+0x8/0x18
[  376.894686]  direct_entry+0x124/0x1c0
[  376.894689]  full_proxy_write+0x60/0xb0
[  376.894693]  vfs_write+0xf0/0x230
[  376.894696]  ksys_write+0x6c/0xf8
[  376.894699]  __arm64_sys_write+0x1c/0x28
[  376.894703]  el0_svc_common.constprop.0+0x74/0x1f0
[  376.894707]  do_el0_svc+0x24/0x90
[  376.894710]  el0_sync_handler+0x180/0x2f8
[  376.894713]  el0_sync+0x158/0x180

KGDB:
=====

# Enter kdb via Magic SysRq

[6]kdb> btc
btc: cpu status: Currently on cpu 6
Available cpus: 0-5(I), 6, 7(I), 8, 9-23(I)
<snip>
Stack traceback for pid 555
0xffff000875ae8000      555      554  1    8   R  0xffff000875ae89c0  bash
CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
Call trace:
 dump_backtrace+0x0/0x1a0
 show_stack+0x18/0x28
 dump_stack+0xc0/0x11c
 kgdb_cpu_enter+0x648/0x660
 kgdb_nmicallback+0xa0/0xa8
 ipi_kgdb_nmicallback+0x24/0x30
 ipi_nmi_handler+0x48/0x60
 handle_percpu_devid_fasteoi_ipi+0x74/0x88
 generic_handle_irq+0x30/0x48
 handle_domain_nmi+0x48/0x80
 gic_handle_irq+0x18c/0x34c
 el1_irq+0xcc/0x180
 lkdtm_HARDLOCKUP+0x8/0x18
 direct_entry+0x124/0x1c0
 full_proxy_write+0x60/0xb0
 vfs_write+0xf0/0x230
 ksys_write+0x6c/0xf8
 __arm64_sys_write+0x1c/0x28
 el0_svc_common.constprop.0+0x74/0x1f0
 do_el0_svc+0x24/0x90
 el0_sync_handler+0x180/0x2f8
 el0_sync+0x158/0x180
<snip>

Changes in v4:
- Move IPI NMI framework to a separate file.
- Get rid of hard-coded IPI_CALL_NMI_FUNC allocation.
- Add NMI backtrace support leveraged via magic SYSRQ.

Changes in v3:
- Rebased to Marc's latest IPIs patch-set [1].

[1] https://lkml.org/lkml/2020/9/1/603

Changes since RFC version [1]:
- Switch to use generic interrupt framework to turn an IPI as NMI.
- Dependent on Marc's patch-set [2] which turns IPIs into normal
  interrupts.
- Addressed misc. comments from Doug on patch #4.
- Posted kgdb NMI printk() fixup separately which has evolved since
  to be solved using different approach via changing kgdb interception
  of printk() in common printk() code (see patch [3]).

[1] https://lkml.org/lkml/2020/4/24/328
[2] https://lkml.org/lkml/2020/5/19/710
[3] https://lkml.org/lkml/2020/5/20/418

Sumit Garg (5):
  arm64: Add framework to turn IPI as NMI
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: smp: Allocate and setup IPI as NMI
  arm64: kgdb: Round up cpus using IPI as NMI
  arm64: ipi_nmi: Add support for NMI backtrace

 arch/arm64/include/asm/irq.h  |  6 +++
 arch/arm64/include/asm/kgdb.h |  8 ++++
 arch/arm64/include/asm/nmi.h  | 16 ++++++++
 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/ipi_nmi.c   | 93 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kgdb.c      | 21 ++++++++++
 arch/arm64/kernel/smp.c       |  8 ++++
 drivers/irqchip/irq-gic-v3.c  | 13 +++++-
 8 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

-- 
2.7.4

