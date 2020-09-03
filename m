Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC68C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026A420716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvbGunJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgICPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgICMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:05:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:05:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t9so2151446pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FOLTzf/XO+P7QNOPhKxlSTfK9nSZlqcSxLohkx+kXno=;
        b=DvbGunJ3jVOhcpKidYgRLJomJssy0XrlfofrGt6ER9y6uEGB5CxvcxQ7m3YR7QmKzZ
         QHIleoxPUlkjZdjZHbbbWX85vS/A1jf8BglOTY5mxEskkB4Bjv9u5nv0/f+Fi86k27KQ
         ORkzIn9/NrlgdBdWzPUW4YGq8RQWVetEnkBGzDmjp/yXneZDAiR2ThMO91x3Kxo6+Q34
         ifFRwkmJa+7I16clQHdtc5GebdYH26Htu4SmECb1T1+QqINFKHYkIac1N7SzFgPql65t
         xnezWLYtG4rFo0nv0Nv1YD+PeGg42adBXMjErE6/A99Oo8art6QEoTmUId2MrXpyKxEf
         EDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FOLTzf/XO+P7QNOPhKxlSTfK9nSZlqcSxLohkx+kXno=;
        b=q43C7VA7sFU1GR2r0LowkSWpBEGOi6LflmQP3HZReAFPsOKkYTcezJD4GpbtxIRpHa
         2crJrjfePIksY4rVJMxT2PkKFdsydpvUY81ssiDM4IVUurUQr4aWUG4ZQFIIrCrjX5u9
         1q3VnPYyU1PAB7RLp8s5EEuQ0254aGJCRB3JNFbCrZLX80z0cYuY/+DfZ4UuRGvcd8H6
         0cbwZazqd0ZdnKTT4LwfbM75IF+YXRPh7TEDf+/b0EXFXv6qUanEBzKM2ZQ8VfLrG/m/
         kSTgRAp0OCzV4UO4/CH4shd3uRWUN5nVJt9r/JGKuJ1kuaAykHx9mEWAOykBDvEz6sVy
         Nl6w==
X-Gm-Message-State: AOAM532nv3/2evf/biJYhR++e0aYajN56abIOLHihx2oD7ZX27X4UYWj
        ashDipbs23w7X86cTEWj0r+mwQ==
X-Google-Smtp-Source: ABdhPJx69wueSgaulyBljwP5X2r7+JVhzDLt3bpKRIsvkt68un6f73FkRk63fK9P/WX/0/tFU0EDQA==
X-Received: by 2002:a62:cf04:: with SMTP id b4mr3500815pfg.84.1599134740520;
        Thu, 03 Sep 2020 05:05:40 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id s1sm2922022pgh.47.2020.09.03.05.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:05:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/4] arm64: Introduce new IPI as IPI_CALL_NMI_FUNC
Date:   Thu,  3 Sep 2020 17:35:08 +0530
Message-Id: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pseudo NMIs support available its possible to configure SGIs to be
triggered as pseudo NMIs running in NMI context. And kernel features
such as kgdb relies on NMI support to round up CPUs which are stuck in
hard lockup state with interrupts disabled.

This patch-set adds support for IPI_CALL_NMI_FUNC which can be triggered
as a pseudo NMI which in turn is leveraged via kgdb to round up CPUs.

After this patch-set we should be able to get a backtrace for a CPU
stuck in HARDLOCKUP. Have a look at an example below from a testcase run
on Developerbox:

$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

# Enter kdb via Magic SysRq

[11]kdb> btc
btc: cpu status: Currently on cpu 10
Available cpus: 0-7(I), 8, 9(I), 10, 11-23(I)
<snip>
Stack traceback for pid 619
0xffff000871bc9c00      619      618  1    8   R  0xffff000871bca5c0  bash
CPU: 8 PID: 619 Comm: bash Not tainted 5.7.0-rc6-00762-g3804420 #77
Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x18/0x28
 dump_stack+0xb8/0x100
 kgdb_cpu_enter+0x5c0/0x5f8
 kgdb_nmicallback+0xa0/0xa8
 ipi_kgdb_nmicallback+0x24/0x30
 ipi_handler+0x160/0x1b8
 handle_percpu_devid_fasteoi_ipi+0x44/0x58
 generic_handle_irq+0x30/0x48
 handle_domain_nmi+0x44/0x80
 gic_handle_irq+0x140/0x2a0
 el1_irq+0xcc/0x180
 lkdtm_HARDLOCKUP+0x10/0x18
 direct_entry+0x124/0x1c0
 full_proxy_write+0x60/0xb0
 __vfs_write+0x1c/0x48
 vfs_write+0xe4/0x1d0
 ksys_write+0x6c/0xf8
 __arm64_sys_write+0x1c/0x28
 el0_svc_common.constprop.0+0x74/0x1f0
 do_el0_svc+0x24/0x90
 el0_sync_handler+0x178/0x2b8
 el0_sync+0x158/0x180

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

Sumit Garg (4):
  arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: smp: Setup IPI_CALL_NMI_FUNC as a pseudo NMI
  arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC

 arch/arm64/include/asm/kgdb.h |  8 +++++++
 arch/arm64/include/asm/smp.h  |  1 +
 arch/arm64/kernel/kgdb.c      | 21 ++++++++++++++++++
 arch/arm64/kernel/smp.c       | 50 ++++++++++++++++++++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c  | 13 +++++++++--
 5 files changed, 81 insertions(+), 12 deletions(-)

-- 
2.7.4

