Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF873C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D639206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="CioDb35h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgANLNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:13:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51902 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:13:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so13267284wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+cDkBW6JIICKtoyKdzmXOh6XDLBBnv4mqwogrYCbfc=;
        b=CioDb35hyMGv8UWHjFSpoLKZDy9Q5v/GzmLIaCXf/dmJU8tO6BjKbuedIdYMkf8C1M
         tdvHBvvkfx3ZCqRlKFU26SkHpUkZJLejOebZ2Ux+nkHRBL0DuerByEyJASW+XrnmbCVO
         8lGmnh+68jJ7h9hVhMQW3wWgqF0U/24SIRhOQ6t8qpNutXt1cK9CUc6PgntAPrVD57vJ
         S26oeLUYx5iEyacC/OhNFXaLMtpfEzJs8M8P3/04sBquk3P43AoeNISFX3iVB8l1tVur
         fWYQHPQ/hc8lvpuRnsDxS7VzQSl3/IFGHCJybjuG43gJcH63jGwjvPnBLKroE/ys+Rvd
         g9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=O+cDkBW6JIICKtoyKdzmXOh6XDLBBnv4mqwogrYCbfc=;
        b=W6i+KKyyPNqJLHmnaFXxUwIVSK4Oyf6DSsD6pbEqrJVFhjEgcaEzi+twEb3LdaxYq+
         QmUsPEaafzTJMl2k5qnT9R1/LuYluJamk5kYYhReGAluaUdfcWbPHmE99MfiSIZEKQy3
         GdzIMKOskGLw8/KDwutTXLDInm4BbvjR5J1hlvmhLW69CxP12ogTI+7wI7Fc7QJBzM4s
         V22bLvX/AYPxf9RGV6P7XolGpqXv+WBnQc54y5rz3DS7PR+sx2cdQje0D/b5aNR+4QBT
         YLwozZIayD2b8LnP1GU7idwng/Zq4rF3awfSoHq9H4UJEI87Q+WHES3Xpzt77zEBvxpT
         rFpg==
X-Gm-Message-State: APjAAAXLjyhFrm/RSsFGv/6G3r+npOG9AZFVa9QTpCVYgDdvLjTIb58e
        V/kAIuBXGolH8E87ODkKJrE06hihm2Tm9A==
X-Google-Smtp-Source: APXvYqymBMlBAbfOG1JjFtpZUlDo4yUROuXAQ0lbrRZ/8+8razVKCLi7dyZSsNhxo5Ll1z9vRwUsJQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr24814509wme.121.1579000433451;
        Tue, 14 Jan 2020 03:13:53 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z3sm19059144wrs.94.2020.01.14.03.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 03:13:52 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>
Subject: [PATCH] microblaze: Sync defconfig with latest Kconfig layout
Date:   Tue, 14 Jan 2020 12:13:46 +0100
Message-Id: <4a229093aa94f3191810fc2671e43875bc1de3f5.1579000423.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Layout was changed by commit 6210b6402f58
("kernel-hacking: group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'")

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/configs/mmu_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 0e2f5e1fd1ef..dd63766c2d19 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -83,9 +83,9 @@ CONFIG_CIFS=y
 CONFIG_CIFS_STATS2=y
 CONFIG_ENCRYPTED_KEYS=y
 CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_SPINLOCK=y
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_KGDB_KDB=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEBUG_SPINLOCK=y
-- 
2.24.0

