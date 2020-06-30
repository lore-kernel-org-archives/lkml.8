Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595BE2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgF3KGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgF3KGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:06:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF00C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:06:52 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1jqDAB-00043G-0d; Tue, 30 Jun 2020 12:06:51 +0200
Received: from jbe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1jqDAA-00060X-Bw; Tue, 30 Jun 2020 12:06:50 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, kernel@pengutronix.de
Subject: [PATCH] regmap: debugfs: really fix memory leak in regmap_debugfs_init()
Date:   Tue, 30 Jun 2020 12:06:50 +0200
Message-Id: <20200630100650.23052-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A different approach tried to fix the memory leak in the
regmap_debugfs_init() function about one year ago. But it added the missing
kfree() at the wrong code path. Even with this approach applied,
'kmemleak' still finds this memory leak (at least on my i.MX6Q SoC):

  unreferenced object 0xec548c80 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937356 (age 3385.690s)
  hex dump (first 32 bytes):
    64 75 6d 6d 79 2d 69 6f 6d 75 78 63 2d 67 70 72  dummy-iomuxc-gpr
    40 32 30 65 30 30 30 30 00 7d cc fa 7c df bf 7d  @20e0000.}..|..}
  backtrace:
    [<703904e1>] __kmalloc_track_caller+0x1dc/0x43c
    [<523053d0>] kvasprintf+0x64/0xd8
    [<0d94bbe5>] kasprintf+0x38/0x5c
    [<4ba65bc1>] regmap_debugfs_init+0xa8/0x330
    [<dfcf84e9>] __regmap_init+0x890/0xd84
    [<750d0959>] __regmap_init_mmio_clk+0x50/0x5c
    [<02a69967>] of_syscon_register+0x194/0x2a8
    [<8d9f337a>] device_node_get_regmap+0x9c/0xa4
    [<97914327>] syscon_node_to_regmap+0x40/0x44
    [<b1677f4e>] syscon_regmap_lookup_by_compatible+0x30/0x3c
    [<0b2d4178>] imx6_pm_common_init.constprop.0+0x4c/0x7c
    [<76253dc8>] imx6q_pm_init+0x18/0x1c
    [<1d2cec28>] imx6q_init_machine+0x120/0x2bc
    [<7386bff5>] customize_machine+0x30/0x38
    [<bc13c21d>] do_one_initcall+0x68/0x2f8
    [<a31f6aea>] kernel_init_freeable+0x24c/0x2f0

For this specific i.MX device the regmap_debugfs_init() function is called
twice for the same object:

- first call: with name = "iomuxc-gpr@20e0000", but the underlying device
  has no name yet. So, regmap_debugfs_init() allocates the string
  "dummy-iomuxc-gpr@20e0000" into 'map->debugfs_name' (and this string is
  the one 'kmemleak' reports in its output).

- second call: with name = "gpr" and the underlying device now has the
  name "20e0000.iomuxc". So, regmap_debugfs_init() again allocates
  a string "20e0000.iomuxc-gpr" into 'map->debugfs_name'.

Since the underlying regmap structure is allocated via kzalloc() the
'map->debugfs_name' member should be NULL on the first call. So, it should
be safe to kfree() this member unconditionally prior allocating a new
string for this member.

Fixes: 2899872b627e ("regmap: debugfs: Fix memory leak in regmap_debugfs_init")

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/base/regmap/regmap-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 089e5dc7144a..81c8fff8c09f 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -577,6 +577,7 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		devname = dev_name(map->dev);
 
 	if (name) {
+		kfree(map->debugfs_name);
 		map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
 					      devname, name);
 		name = map->debugfs_name;
-- 
2.20.1

