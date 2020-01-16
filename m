Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C9F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193732;
	bh=pV551vx0ulCMeADAYiBYKCrBZla4a6rIQKNbZZa1XFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gt1Lq1XoLdYtPo51fPVGu2nXJNxER2meIivPOPxvh44BnpjKBf70Q6mk/ZFadlFuM
	 V6i1ZKdDwFS84TJ33Z1GbyKFRd43IAk7wdM4d0nThlhnKCU5muxtmt7p0yrwU9rBpK
	 0MCjO91j6B2UQ5qh03KdeE3WWikGjazz7+zLgzbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgAPQzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731354AbgAPQzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C7D22464;
        Thu, 16 Jan 2020 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193716;
        bh=pV551vx0ulCMeADAYiBYKCrBZla4a6rIQKNbZZa1XFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLQhTP3PgDDQQ8/A6/0IONuqVu+3uCxK2uV6ehqKe+BQFItUFY/ri6geO+++P0TrA
         oKjV6nhPQJf6RmQO5DjR4BXNKdMoQ1pKP50BYMnhGO8EATsVpUHkan+Nyy4LrP31zH
         4LZ0b3/+1RYzjLr/2SZn9Gr6CxKamx9akJ4eDs4U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 011/671] firmware: coreboot: Let OF core populate platform device
Date:   Thu, 16 Jan 2020 11:44:02 -0500
Message-Id: <20200116165502.8838-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 09ed061a4f56d50758851ca3997510f27115f81b ]

Now that the /firmware/coreboot node in DT is populated by the core DT
platform code with commit 3aa0582fdb82 ("of: platform: populate
/firmware/ node from of_platform_default_populate_init()") we should and
can remove the platform device creation here. Otherwise, the
of_platform_device_create() call will fail, the coreboot of driver won't
be registered, and this driver will never bind. At the same time, we
should move this driver to use MODULE_DEVICE_TABLE so that module
auto-load works properly when the coreboot device is auto-populated and
we should drop the of_node handling that was presumably placed here to
hold a reference to the DT node created during module init that no
longer happens.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Reviewed-by: Sudeep Holla <Sudeep.Holla@arm.com>
Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/google/coreboot_table-of.c | 28 +++------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firmware/google/coreboot_table-of.c
index f15bf404c579..9b90c0fa4a0b 100644
--- a/drivers/firmware/google/coreboot_table-of.c
+++ b/drivers/firmware/google/coreboot_table-of.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include "coreboot_table.h"
@@ -30,7 +29,6 @@ static int coreboot_table_of_probe(struct platform_device *pdev)
 	void __iomem *ptr;
 
 	ptr = of_iomap(fw_dn, 0);
-	of_node_put(fw_dn);
 	if (!ptr)
 		return -ENOMEM;
 
@@ -44,8 +42,9 @@ static int coreboot_table_of_remove(struct platform_device *pdev)
 
 static const struct of_device_id coreboot_of_match[] = {
 	{ .compatible = "coreboot" },
-	{},
+	{}
 };
+MODULE_DEVICE_TABLE(of, coreboot_of_match);
 
 static struct platform_driver coreboot_table_of_driver = {
 	.probe = coreboot_table_of_probe,
@@ -55,28 +54,7 @@ static struct platform_driver coreboot_table_of_driver = {
 		.of_match_table = coreboot_of_match,
 	},
 };
-
-static int __init platform_coreboot_table_of_init(void)
-{
-	struct platform_device *pdev;
-	struct device_node *of_node;
-
-	/* Limit device creation to the presence of /firmware/coreboot node */
-	of_node = of_find_node_by_path("/firmware/coreboot");
-	if (!of_node)
-		return -ENODEV;
-
-	if (!of_match_node(coreboot_of_match, of_node))
-		return -ENODEV;
-
-	pdev = of_platform_device_create(of_node, "coreboot_table_of", NULL);
-	if (!pdev)
-		return -ENODEV;
-
-	return platform_driver_register(&coreboot_table_of_driver);
-}
-
-module_init(platform_coreboot_table_of_init);
+module_platform_driver(coreboot_table_of_driver);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
-- 
2.20.1

