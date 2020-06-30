Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886172073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+wUmVLb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lufC/IuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgF3KL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbgF3KLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:11:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E93C061755;
        Tue, 30 Jun 2020 03:11:54 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593511911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzC5ybQu8kVGHWLGBhWSXXbonkpooFQmrjPK+FrJ/08=;
        b=k+wUmVLb56qLBIu4uuNZ9DR6jOJisojB5fzPjAoPOqdWFplL2Wgc//LJ6Bq6FOLmCkRABC
        TXx/U96lX8Y9TeqEeFCIOo0nhUSUtpd++YQ5V+GiYarpH9Vs6H++vSLCkYBlKfXdAzS/Kb
        J3LY4tLC746gAlP6tkusdy5N/temxWHybLvpc9n8H6+Edo0a9k8P3O5fxCZ4pLGtYQgk5g
        +DAsgGR2rljFy3L5RiVksKBOvjorwp8809MqBpVZXq9H1ed/tHAAH8ZdimvIb36pYVmqoT
        yqwRh4nRWoOo95zRJ3NeLPAGKVNFLEmbc5mEqrM+urdV7cKLogPT7iosYogMZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593511911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzC5ybQu8kVGHWLGBhWSXXbonkpooFQmrjPK+FrJ/08=;
        b=lufC/IuRKE58yrb9Jtxaz50eWLh+e1PSwB0ZD8Wfi/2pyv4Sb14zEUezQRmRGig/LeKiPG
        rUcTUMYpzGXTGVAg==
From:   "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/loongson-pci-msi: Fix a typo in Kconfig
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200530121113.1797678-2-jiaxun.yang@flygoat.com>
References: <20200530121113.1797678-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <159351191099.4006.18157932896470485452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a23df9a4bd326fb4c7f160b72b0e0560b989ac29
Gitweb:        https://git.kernel.org/tip/a23df9a4bd326fb4c7f160b72b0e0560b989ac29
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Sat, 30 May 2020 20:11:12 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 21 Jun 2020 15:13:11 +01:00

irqchip/loongson-pci-msi: Fix a typo in Kconfig

PCH MSI driver's menuconfig entry was wrong. Fix it.

Fixes: 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200530121113.1797678-2-jiaxun.yang@flygoat.com
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 29fead2..216b3b8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -563,7 +563,7 @@ config LOONGSON_PCH_PIC
 	  Support for the Loongson PCH PIC Controller.
 
 config LOONGSON_PCH_MSI
-	bool "Loongson PCH PIC Controller"
+	bool "Loongson PCH MSI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
 	depends on PCI
 	default MACH_LOONGSON64
