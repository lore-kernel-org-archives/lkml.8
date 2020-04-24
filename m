Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FC6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8FA20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpliri/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDXLLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:11:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665DC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so3624280plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C9PN16nlCbR73t00paMo9AAcjhtW4HbAszJmaJCFe6s=;
        b=lpliri/AOX1NKMV8T3cDtg94yI7PnQd3PoHBB7izJ05O3YNMrdp87cyKPoXoul1D2f
         GCDlSJpkivh7ZAXeOL5+rieJcE2DNN9iSZPIxLwZZVb+Qm3cbkQKJARpNBDhSn441Q3k
         EE/DwBZRapV8OrmjMMahX2q9Y0C4WMpX4hk69nu8xDguJ6RnB84CQH3MXOlLLg92wKDl
         Fb9TyMBzSej64Cl/TybB54K5NSjpfto9P+n7ojlR/5puv/zZibU+fu7Xw5J6BL+3Rqro
         Ug6iJYH3OeR6FNDoawewxo7/oN7WxIsHlFiqoKkwXBrWxLRU4Nn1LOjl8yBF9g1jLSa6
         /m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9PN16nlCbR73t00paMo9AAcjhtW4HbAszJmaJCFe6s=;
        b=WQZr7DRaneP6XBBAUUILHapLkGjjgvCs1Q+kB7yjwLCvgipTwSSIXf2ijPSpO3O8Ld
         J61N+RmguoyKG3Cz7gytHOKPJTHv6OO2BsZAH/y6ETNWjbTdwPS4Y8U6kHRRprhKd9Dq
         qQLF8BeUGZbjlRhiI0cOOVkdIdBPbGY8homI2a5oPK8ZKPA7edI4D+SoM3wj7aJwtc6y
         ezZZIjbH9jHZ1MoASs+IO4fsQazAOm5Nr63MZz9Jb2nqlUBzB4x7zwywW3tV2sCauh7J
         AxrWulu7fS64ftrm28P31MfaUhWst6EQ+c1+sMi+nirX7kFgdpKm0OoKFI9/fO4/qTBe
         8p+A==
X-Gm-Message-State: AGi0Pubrs4GXuKrCr+UlLxY9MPPCFa7ldaqracUax9dFpmdswYNrIF5V
        AwM6frvyVL+jPHOTqDnrzPHETA==
X-Google-Smtp-Source: APiQypJRiNBG/TsX5FoVn/NIsUMUkt59D0Cs90C2+w+JS9ApTI5yokyp2gpBXnHP+0nU4wDjA7zGYQ==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr5615679pjb.56.1587726681811;
        Fri, 24 Apr 2020 04:11:21 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id o11sm4637628pgd.58.2020.04.24.04.11.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:11:20 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC Patch v1 0/4] arm64: Introduce new IPI as IPI_CALL_NMI_FUNC
Date:   Fri, 24 Apr 2020 16:39:10 +0530
Message-Id: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
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
btc: cpu status: Currently on cpu 11
Available cpus: 0-10(I), 11, 12(I), 13, 14-23(I)
<snip>
Stack traceback for pid 623
0xffff00086a644600      623      622  1   13   R  0xffff00086a644fc0  bash
CPU: 13 PID: 623 Comm: bash Not tainted 5.7.0-rc2 #27
Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x18/0x28
 dump_stack+0xb8/0x100
 kgdb_cpu_enter+0x5c0/0x5f8
 kgdb_nmicallback+0xa0/0xa8
 handle_IPI+0x190/0x200
 gic_handle_irq+0x2b8/0x2d8
 el1_irq+0xcc/0x180
 lkdtm_HARDLOCKUP+0x8/0x18
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
<snip>

Looking forward to your comments/feedback.

Sumit Garg (4):
  arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
  irqchip/gic-v3: Add support to handle SGI as pseudo NMI
  irqchip/gic-v3: Enable arch specific IPI as pseudo NMI
  arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC

 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/smp.h     |  1 +
 arch/arm64/kernel/kgdb.c         | 15 +++++++++++++++
 arch/arm64/kernel/smp.c          | 36 +++++++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3.c     | 36 +++++++++++++++++++++++++++++++-----
 5 files changed, 83 insertions(+), 7 deletions(-)

-- 
2.7.4

