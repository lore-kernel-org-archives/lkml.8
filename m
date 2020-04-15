Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A02C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992C9214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952986;
	bh=i3Ux0xyQDuBdGA7BktnWpwTgBU7SDcaAFTMtDViyrKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cyh60DyY9/CKEUTXb2k4uK2P0vv+x2kE8TSiuIjB9MO93AAbN2cKSS+y6fShKx5/4
	 /MhuAAtJv0/S/NeqYJatvO+Z8Frk49Y64XNf1HEmaJBFW7klfMzmnfbJnR/5nq6QSI
	 hcf6nk0e3fbA4ZwAGQymV+0bSWDWmM3WmDY3Enhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368748AbgDOMQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409302AbgDOLqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8022173E;
        Wed, 15 Apr 2020 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951195;
        bh=i3Ux0xyQDuBdGA7BktnWpwTgBU7SDcaAFTMtDViyrKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acciYqTntWjJuMkTaByEk9RifeO4FQV6W8oAwHSjHFi13PH+qzeDko9SKlFbwKPns
         Fgrib+QOmaUzHxGY4UkNuABaWo0rkEQpp/8DuvNyDQx4EKiplgkAKclEI5kdP4qMUA
         14IBitR8lfH42uQI8D0mkE2K8HvX+ZRIYOTwZhwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 10/40] powerpc/maple: Fix declaration made after definition
Date:   Wed, 15 Apr 2020 07:45:53 -0400
Message-Id: <20200415114623.14972-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114623.14972-1-sashal@kernel.org>
References: <20200415114623.14972-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit af6cf95c4d003fccd6c2ecc99a598fb854b537e7 ]

When building ppc64 defconfig, Clang errors (trimmed for brevity):

  arch/powerpc/platforms/maple/setup.c:365:1: error: attribute declaration
  must precede definition [-Werror,-Wignored-attributes]
  machine_device_initcall(maple, maple_cpc925_edac_setup);
  ^

machine_device_initcall expands to __define_machine_initcall, which in
turn has the macro machine_is used in it, which declares mach_##name
with an __attribute__((weak)). define_machine actually defines
mach_##name, which in this file happens before the declaration, hence
the warning.

To fix this, move define_machine after machine_device_initcall so that
the declaration occurs before the definition, which matches how
machine_device_initcall and define_machine work throughout
arch/powerpc.

While we're here, remove some spaces before tabs.

Fixes: 8f101a051ef0 ("edac: cpc925 MC platform device setup")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200323222729.15365-1-natechancellor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/maple/setup.c | 34 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index b7f937563827d..d1fee2d35b49c 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -299,23 +299,6 @@ static int __init maple_probe(void)
 	return 1;
 }
 
-define_machine(maple) {
-	.name			= "Maple",
-	.probe			= maple_probe,
-	.setup_arch		= maple_setup_arch,
-	.init_IRQ		= maple_init_IRQ,
-	.pci_irq_fixup		= maple_pci_irq_fixup,
-	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
-	.restart		= maple_restart,
-	.halt			= maple_halt,
-       	.get_boot_time		= maple_get_boot_time,
-       	.set_rtc_time		= maple_set_rtc_time,
-       	.get_rtc_time		= maple_get_rtc_time,
-      	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= maple_progress,
-	.power_save		= power4_idle,
-};
-
 #ifdef CONFIG_EDAC
 /*
  * Register a platform device for CPC925 memory controller on
@@ -372,3 +355,20 @@ static int __init maple_cpc925_edac_setup(void)
 }
 machine_device_initcall(maple, maple_cpc925_edac_setup);
 #endif
+
+define_machine(maple) {
+	.name			= "Maple",
+	.probe			= maple_probe,
+	.setup_arch		= maple_setup_arch,
+	.init_IRQ		= maple_init_IRQ,
+	.pci_irq_fixup		= maple_pci_irq_fixup,
+	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
+	.restart		= maple_restart,
+	.halt			= maple_halt,
+	.get_boot_time		= maple_get_boot_time,
+	.set_rtc_time		= maple_set_rtc_time,
+	.get_rtc_time		= maple_get_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= maple_progress,
+	.power_save		= power4_idle,
+};
-- 
2.20.1

