Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709832064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXIw+f9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgGPEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPEk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:40:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:40:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so4059575pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2J4i4t4AqqHg8abobY7AVKVmdgd1ErGb3bLZRvuatJQ=;
        b=iXIw+f9F23HBSI+lrEcHMW0xaCByLYrJC4gl3jyk9ewL3WkDsfNlc3soJHus17C5ZO
         cePbmDbQ11W3tENXDJreVqYu5bEB+KO0l8P0BgVGR59xAIf2aOvRhoc7I4JRuT9aypnL
         0mCwqsWLTJGjHu/lS3xuloMnFhnxBLUa+zm4xOENxf6r/j+uuYZvZKKqLmUMZExcwTK7
         7Q/OoK8/uzt78mPteJP0TAvH9+562n7SDVxBz1iPiPkcQQjah43/BIgzfksJxz9e/8DP
         +v7WKuj1f1INvyJglQGKaKY/SyFHUN9nfX9GXNpeyfrxBFU7bOS8rb26aqStqD8FckRp
         QQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2J4i4t4AqqHg8abobY7AVKVmdgd1ErGb3bLZRvuatJQ=;
        b=emSxvBR+gxRqGTBLWZtP2oP6fRd8QDjW1PjwYWkLizrL7bSXYr8E7IGEV2l0PULv1P
         R69E+UH8boRwPUmzWRKNu5CSUFECzvMaOn3PdazsYe4wp24F1yRupF4LeGIdHtjlRgkb
         3Q0lpCm1jNvZIpc+bhB2FDM0vAwdfhQokrRNsD5wgpRiFVCrZ1G/FLj0COdoDcTZ+WOZ
         jZQQIdKhh4lQa4orBz6m0wsT6x6KYQX/N9HLy/f3Fc1BuqXG1RxcRibMl4YQ4Z8xuCZv
         uiQwig4UkhJXtLHcFnxV+JWS53ue/0xRX/HEqHwU40W2LYP+siRhlgmOh1M8ZfqibQUC
         zeDw==
X-Gm-Message-State: AOAM53295wx+qf/hr7WZhM+v+fPzS3/VM8MQNjUT4PXs7JUZcNk/8eFz
        ykBHBbf/tyOfmwjZFkWdKyM=
X-Google-Smtp-Source: ABdhPJynOeq6/gRIL7IyeVExIdv2EzkZDYGBv1lKgCDzwe4LF3f+PHCiALHXEEAygcqASaVOziGdZA==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr3050901pjb.199.1594874429284;
        Wed, 15 Jul 2020 21:40:29 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id v15sm3548603pgo.15.2020.07.15.21.40.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Jul 2020 21:40:28 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
Date:   Wed, 15 Jul 2020 21:39:53 -0700
Message-Id: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

This adds SiFive drivers to rv32_defconfig, to keep in sync with the
64-bit config. This is useful when testing 32-bit kernel with QEMU
'sifive_u' 32-bit machine.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/configs/rv32_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 05bbf52..8759501 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -14,6 +14,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
@@ -61,6 +62,8 @@ CONFIG_HVC_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_SPI=y
+CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
 CONFIG_DRM=y
@@ -76,6 +79,8 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
2.7.4

