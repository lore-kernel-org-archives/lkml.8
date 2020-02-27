Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788FC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C124693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="URetjbda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgB0Lbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:31:32 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:40720 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0Lbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:31 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5B4D6C0AD1;
        Thu, 27 Feb 2020 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582803090; bh=nnsAv9kQ8j3lGYt/imLE7LxPTTFBc+oOVMrkSeC4fMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=URetjbdaQJuKFWZwAWWsxk24JtycNe7lMt715a7o3mbnSwc7B0prMJMUMYx6bRO8N
         3JMS6WkgBFd8HrhMN62qbuoBGZvtEkJ153KZbv/5r83GkH37mmFV42PFv+EZLMHvq7
         YKc/NLbH8W42KDLTlJGtQozymUwYjaMX3jwr68dC7N0FPTcEeFe0uZlN/ND91Deodr
         9x47ohEDpCwCrn5AlmXsJOJIdC5tXKVpmrxlOfnIKGXjnlH+SuBLVBcYxxXkaSJlaV
         K0EKjMwi1ST8KdL8cj+X9mdzf48YhzxIRFBTOXwETSNj3REybPbhUlxvnrczm5yBC/
         XuNHZg1UEc7Iw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 817A5A005C;
        Thu, 27 Feb 2020 11:31:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 6FBB83E9E7;
        Thu, 27 Feb 2020 12:31:26 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 3/4] i3c: Generate aliases for i3c modules
Date:   Thu, 27 Feb 2020 12:31:08 +0100
Message-Id: <79687073b915182e06fccfb18adcedfd0fadbc99.1582796652.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

This part was missing, thus preventing user space from loading modules
automatically when MODALIAS uevents are received.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 scripts/mod/devicetable-offsets.c |  7 +++++++
 scripts/mod/file2alias.c          | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 054405b..d3c237b 100644
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
index c91eba7..f81cbe0 100644
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
+	ADD(alias, "manuf", match_flags & I3C_MATCH_MANUF, manuf_id);
+	ADD(alias, "part", match_flags & I3C_MATCH_PART, part_id);
+	ADD(alias, "ext", match_flags & I3C_MATCH_EXTRA_INFO, extra_info);
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
2.7.4

