Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA3EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14539206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBB4BI63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgCQIvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:51:44 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44639 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:51:43 -0400
Received: by mail-qv1-f67.google.com with SMTP id w5so10398611qvp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=INqhK7Tn9oxQPBAc7BD8ij5pQ/ONv1O3XGwD9BE+Z9w=;
        b=YBB4BI63VmgXBGwknUi+l/UnuhFHAmxziyw5LWEGE+I+r2mfw4Q1hMXXTS0Z/eMes1
         9/67uhRS7+tgxeAonxh+FJ9zVhokwRmmBqrLVgR6Wx+jJrDl9OMVX90Tpy2sVyQUwb3H
         fLY1ui5Voy9IQwPYdToPVAernh6dcDYc9+hF0FQwQhJB1LM3jDgB6sG3bPW2ZmSV4msp
         5PH+qntCQ9AghfFU0veJXJOHxVMiD6/6HWPi7b6D5WOz9dMDRMumwjM+9BO1YrvEtcUK
         R0mGzuLBO5rVH17y4yeekdQBgqNrQSi0pU3dM1e40qpvFJd3MfZdxmXwvzU8YwZq1nXX
         xpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INqhK7Tn9oxQPBAc7BD8ij5pQ/ONv1O3XGwD9BE+Z9w=;
        b=K5/pdKire6hNZ4T9+U+ORjgyNU8JHFAw6zCh8QsuXOBe4IW9ynCHEyAv+bYAWaT/K8
         9OaFG+X2VoSer6oRtYZu+R8n/MwPrsBzNXbU5Ya0AYhMDo/DTO4WIk5oXXGd6rydlRbF
         exI0pfF46aD+0KvTr8oZKVuUO9Xu6p4XpTRkh49HN799vR3v2kiC0kK2q82VnMnSJD4e
         M53cIPiuwhxYYi4lZWE2x2MI0tVr0doWn0Y9otSXcQQDDQnLklJv+sv6kU6wW8pNTlBQ
         iMWSFs+CNUtKyAumvvq67NEuE+6lxlQUXUfcgggBsJ8fEeZjihSwNbRIIakKM2FALaSQ
         9p1g==
X-Gm-Message-State: ANhLgQ2l2uFeEb0S6hrjWmOAQ3Epr65xmCCTA7XAcnfDrTKNQQTFF/bT
        9oU0yirbZVm+zfoWfY2vyTE=
X-Google-Smtp-Source: ADFU+vtx16r3AcVpqLf2rctzR7/WHQ2N5K0LRyGWfhAEQo+pLWj5aDNdNqlOk2On1kNVCS3K5a3J8w==
X-Received: by 2002:a0c:f601:: with SMTP id r1mr3744281qvm.91.1584435102383;
        Tue, 17 Mar 2020 01:51:42 -0700 (PDT)
Received: from localhost.localdomain (179.186.61.135.dynamic.adsl.gvt.net.br. [179.186.61.135])
        by smtp.gmail.com with ESMTPSA id s4sm1884404qte.36.2020.03.17.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:51:42 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH 2/2] staging: rtl8192u: Corrects 'Avoid CamelCase' for variables
Date:   Tue, 17 Mar 2020 08:51:30 +0000
Message-Id: <20200317085130.21213-2-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317085130.21213-1-c.cantanheide@gmail.com>
References: <20200317085130.21213-1-c.cantanheide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables of function setKey triggered a 'Avoid CamelCase'
warning from checkpatch.pl. This patch renames these
variables to correct this warning.

Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 52 +++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 93a15d57e..fcfb9024a 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4877,50 +4877,50 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
 	write_nic_byte(dev, SECR,  SECR_value);
 }
 
-void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
-	    u8 *MacAddr, u8 DefaultKey, u32 *KeyContent)
+void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
+	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
 {
-	u32 TargetCommand = 0;
-	u32 TargetContent = 0;
-	u16 usConfig = 0;
+	u32 target_command = 0;
+	u32 target_content = 0;
+	u16 us_config = 0;
 	u8 i;
 
-	if (EntryNo >= TOTAL_CAM_ENTRY)
+	if (entryno >= TOTAL_CAM_ENTRY)
 		RT_TRACE(COMP_ERR, "cam entry exceeds in %s\n", __func__);
 
 	RT_TRACE(COMP_SEC,
 		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
-		 __func__, dev, EntryNo, KeyIndex, KeyType, MacAddr);
+		 __func__, dev, entryno, keyindex, keytype, macaddr);
 
-	if (DefaultKey)
-		usConfig |= BIT(15) | (KeyType << 2);
+	if (defaultkey)
+		us_config |= BIT(15) | (keytype << 2);
 	else
-		usConfig |= BIT(15) | (KeyType << 2) | KeyIndex;
+		us_config |= BIT(15) | (keytype << 2) | keyindex;
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
-		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT(31) | BIT(16);
+		target_command  = i + CAM_CONTENT_COUNT * entryno;
+		target_command |= BIT(31) | BIT(16);
 
 		if (i == 0) { /* MAC|Config */
-			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
-					(u32)(*(MacAddr + 1)) << 24 |
-					(u32)usConfig;
+			target_content = (u32)(*(macaddr + 0)) << 16 |
+					(u32)(*(macaddr + 1)) << 24 |
+					(u32)us_config;
 
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
+			write_nic_dword(dev, WCAMI, target_content);
+			write_nic_dword(dev, RWCAM, target_command);
 		} else if (i == 1) { /* MAC */
-			TargetContent = (u32)(*(MacAddr + 2))	 |
-					(u32)(*(MacAddr + 3)) <<  8 |
-					(u32)(*(MacAddr + 4)) << 16 |
-					(u32)(*(MacAddr + 5)) << 24;
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
+			target_content = (u32)(*(macaddr + 2))	 |
+					(u32)(*(macaddr + 3)) <<  8 |
+					(u32)(*(macaddr + 4)) << 16 |
+					(u32)(*(macaddr + 5)) << 24;
+			write_nic_dword(dev, WCAMI, target_content);
+			write_nic_dword(dev, RWCAM, target_command);
 		} else {
 			/* Key Material */
-			if (KeyContent) {
+			if (keycontent) {
 				write_nic_dword(dev, WCAMI,
-						*(KeyContent + i - 2));
-				write_nic_dword(dev, RWCAM, TargetCommand);
+						*(keycontent + i - 2));
+				write_nic_dword(dev, RWCAM, target_command);
 			}
 		}
 	}
-- 
2.20.1

