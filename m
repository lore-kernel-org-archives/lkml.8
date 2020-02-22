Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1850C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC1A208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBVK1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 05:27:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38800 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgBVK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 05:27:22 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D05502912E5;
        Sat, 22 Feb 2020 10:27:20 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 2/3] i3c: Generate aliases for i3c modules
Date:   Sat, 22 Feb 2020 11:27:10 +0100
Message-Id: <20200222102711.1352006-3-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222102711.1352006-1-boris.brezillon@collabora.com>
References: <20200222102711.1352006-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part was missing, thus preventing user space from loading modules
automatically when MODALIAS uevents are received.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 scripts/mod/devicetable-offsets.c |  7 +++++++
 scripts/mod/file2alias.c          | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 054405b90ba4..d3c237b9b7c0 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -145,6 +145,13 @@ int main(void)
 	DEVID(i2c_device_id);
 	DEVID_FIELD(i2c_device_id, name);
 
+	DEVID(i3c_device_id);
+	DEVID_FIELD(i3c_device_id, match_flags);
+	DEVID_FIELD(i3c_device_id, dcr);
+	DEVID_FIELD(i3c_device_id, manuf_id);
+	DEVID_FIELD(i3c_device_id, part_id);
+	DEVID_FIELD(i3c_device_id, extra_info);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index c91eba751804..1754de3f119f 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -919,6 +919,24 @@ static int do_i2c_entry(const char *filename, void *symval,
 	return 1;
 }
 
+static int do_i3c_entry(const char *filename, void *symval,
+			char *alias)
+{
+	DEF_FIELD(symval, i3c_device_id, match_flags);
+	DEF_FIELD(symval, i3c_device_id, dcr);
+	DEF_FIELD(symval, i3c_device_id, manuf_id);
+	DEF_FIELD(symval, i3c_device_id, part_id);
+	DEF_FIELD(symval, i3c_device_id, extra_info);
+
+	strcpy(alias, "i3c:");
+	ADD(alias, "dcr", match_flags & I3C_MATCH_DCR, dcr);
+	ADD(alias, "manuf", match_flags & I3C_MATCH_MANUF, dcr);
+	ADD(alias, "part", match_flags & I3C_MATCH_PART, dcr);
+	ADD(alias, "ext", match_flags & I3C_MATCH_EXTRA_INFO, dcr);
+
+	return 1;
+}
+
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
 			char *alias)
@@ -1386,6 +1404,7 @@ static const struct devtable devtable[] = {
 	{"vmbus", SIZE_hv_vmbus_device_id, do_vmbus_entry},
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
+	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
 	{"platform", SIZE_platform_device_id, do_platform_entry},
-- 
2.24.1

