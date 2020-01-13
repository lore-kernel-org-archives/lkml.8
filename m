Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F056C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CB921569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAMQCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:02:08 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:13185 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728709AbgAMQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:02:08 -0500
X-Halon-ID: 0805e7d7-361e-11ea-b6d8-005056917f90
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 0805e7d7-361e-11ea-b6d8-005056917f90;
        Mon, 13 Jan 2020 17:02:02 +0100 (CET)
From:   Andreas Larsson <andreas@gaisler.com>
To:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32,leon: Stop adding vendor and device id to prom ambapp path components
Date:   Mon, 13 Jan 2020 17:01:47 +0100
Message-Id: <20200113160147.9254-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These extra fields before the @ are not handled in of_node_name_eq,
making commit b3e46d1a0590500335f0b95e669ad6d84b12b03a break node name
comparisons for ambapp path components, thereby making LEON systems
unable to boot.

As there is no need for the tacked on vendor and device ID fields in the
path component, resolve this situation by removing them.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/prom_32.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index ec244d1022ce..da8902295c8c 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -132,12 +132,13 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 		regs->which_io, regs->phys_addr);
 }
 
-/* "name:vendor:device@irq,addrlo" */
+/* "name@irq,addrlo" */
 static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 {
 	const char *name = of_get_property(dp, "name", NULL);
 	struct amba_prom_registers *regs;
-	unsigned int *intr, *device, *vendor, reg0;
+	unsigned int *intr;
+	unsigned int reg0;
 	struct property *prop;
 	int interrupt = 0;
 
@@ -159,18 +160,7 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 	else
 		intr = prop->value;
 
-	prop = of_find_property(dp, "vendor", NULL);
-	if (!prop)
-		return;
-	vendor = prop->value;
-	prop = of_find_property(dp, "device", NULL);
-	if (!prop)
-		return;
-	device = prop->value;
-
-	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
-		name, *vendor, *device,
-		*intr, reg0);
+	sprintf(tmp_buf, "%s@%x,%x", name, *intr, reg0);
 }
 
 static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
-- 
2.17.1

