Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37533C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3ED24696
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lAnsoNzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgB0Lb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:31:29 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55890 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbgB0Lb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:29 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 58A8C43B5E;
        Thu, 27 Feb 2020 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582803088; bh=0syuIutiUjjVU8By23MObQ0rqTkTVnHNZjjdVWTlCqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lAnsoNzvlDmMDq0uoorCMIboX8tc9QBfiOgezLXHISO68H7eBIyVjG9X7p58hnkHp
         A8wz6YpeeGHrKO2Z2KlDK1dHG07dlWBcMtWfQihxne9AmTcVc/SYVPQ0WFAULDjiCB
         PtZQVoHyc0GUxso8Q2Xh7WJ7QcHcAPmugXRC6EsbhpLgLnAIFEZcXkRWi/ImLBkc0s
         VeUj6mjHqz9Gy8p8KFJW7fRuz78AsLYRduTR74sR7Wmf7u1xumv8Ni4GNun1i2tPDf
         cdz2oEoKFmj9Z18y2xZZV1OzPQlaOKqiZQzE1czLOh/nrL7plvmEoNvRqPyIGE8d3N
         EoJPEglN+nIGQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 94C1BA005F;
        Thu, 27 Feb 2020 11:31:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 7EF5D3E9EB;
        Thu, 27 Feb 2020 12:31:26 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 4/4] i3c: Simplify i3c_device_match_id()
Date:   Thu, 27 Feb 2020 12:31:09 +0100
Message-Id: <8c5d6523e1c161783db834a3447954f7fd6267e6.1582796652.git.vitor.soares@synopsys.com>
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

Simply match against ->match_flags instead of trying to be smart and
fix drivers inconsistent ID tables.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/device.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 9e2e140..bb8e60d 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -213,40 +213,34 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 {
 	struct i3c_device_info devinfo;
 	const struct i3c_device_id *id;
+	u16 manuf, part, ext_info;
+	bool rndpid;
 
 	i3c_device_get_info(i3cdev, &devinfo);
 
-	/*
-	 * The lower 32bits of the provisional ID is just filled with a random
-	 * value, try to match using DCR info.
-	 */
-	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
-		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
-		u16 part = I3C_PID_PART_ID(devinfo.pid);
-		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
-
-		/* First try to match by manufacturer/part ID. */
-		for (id = id_table; id->match_flags != 0; id++) {
-			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
-			    I3C_MATCH_MANUF_AND_PART)
-				continue;
-
-			if (manuf != id->manuf_id || part != id->part_id)
-				continue;
-
-			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
-			    ext_info != id->extra_info)
-				continue;
-
-			return id;
-		}
-	}
+	manuf = I3C_PID_MANUF_ID(devinfo.pid);
+	part = I3C_PID_PART_ID(devinfo.pid);
+	ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
+	rndpid = I3C_PID_RND_LOWER_32BITS(devinfo.pid);
 
-	/* Fallback to DCR match. */
 	for (id = id_table; id->match_flags != 0; id++) {
 		if ((id->match_flags & I3C_MATCH_DCR) &&
-		    id->dcr == devinfo.dcr)
-			return id;
+		    id->dcr != devinfo.dcr)
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_MANUF) &&
+		    id->manuf_id != manuf)
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_PART) &&
+		    (rndpid || id->part_id != part))
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
+		    (rndpid || id->extra_info != ext_info))
+			continue;
+
+		return id;
 	}
 
 	return NULL;
-- 
2.7.4

