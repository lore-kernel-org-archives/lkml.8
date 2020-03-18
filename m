Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984EC4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5688520409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7yCOddT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRVMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:12:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41126 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCRVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:12:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id s11so30105269qks.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgdLXJV9Sew53vIF33iiBl+FIn8SK13ILaQIFn0dtRs=;
        b=A7yCOddTAxvmu3ZfcKABXAyalCetbzNFo1PbYvf5Vtok/l619b+6aE4phQmb6ehGD1
         ZtIKODXEJeJciqA82Ej7MDWt90U5ideGjywnFmDKJpP/BYrT19DMp/WL3FgwidHr3Ane
         oLqqwxTcUPg9NNber5HLvEu62Pco2vtYgaDWhssgl5Wp7Zee1rHtgRNRKpjf8uA7MhD5
         ycFY06PNxhOKFxc+KnCrYHQzsJBg2BL52yIzzLsmyZIfQkSYPIXG24oCL0JqMD6oEDMK
         aPDiwRGh1T+N8d5Sqyq7I7xa9xf+DuBBmWb8FbvLPfHOaRMDF+O7P3Mvb2KPt1Fdx1Zr
         KYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgdLXJV9Sew53vIF33iiBl+FIn8SK13ILaQIFn0dtRs=;
        b=LVkdILX9oh7kuKWItgfVN6eMFqX1a87KLwWrJORyB8KtF2LMHLlpgENHsuvt18vbID
         5xCBHTcjEGbyh80JMBOw6lB3TsJnq94o/GqlkZqNtxIaQXv3LBPJk/EXueztwuX224Re
         SV79LP/bk0HfceNsAihDalRBJnLuq1nLrJ1lOm5RG3WHUv07Z1Xim1GfHJNc98Uk4UJ3
         NNIXZNG6juLcUaiZ8ELILuRcwtJ9LALocgJVAYG8bTc/9JzcQEMoCW77J3db51zd0FMj
         Iu8g2zwhURt12X0Pd/JYo2VfEyQb0lC/e6eLOGUyBYCE/1X2k/Mxm0A5fHjoBkrMXOFB
         OAbg==
X-Gm-Message-State: ANhLgQ3ZmviIEz4/1/4ISe568FVQwjnnl3vB70ROzRTolAQDEy84D08u
        mizL6w6aPvvALPEnBEofxQo=
X-Google-Smtp-Source: ADFU+vu1iw2ZSFt5GSelwBEMi5Omquzp5UhqGTINJpM8WwES6bFo3XFbBKyvQ9hZDg1Za30NhXHynA==
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr6134610qkl.226.1584565933729;
        Wed, 18 Mar 2020 14:12:13 -0700 (PDT)
Received: from fd42afb33d44.ufabc.int.br ([177.104.48.2])
        by smtp.gmail.com with ESMTPSA id x188sm128304qka.53.2020.03.18.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:12:13 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for variables
Date:   Wed, 18 Mar 2020 21:12:05 +0000
Message-Id: <20200318211205.188-1-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
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
index 93a15d57e..3aa87296d 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4877,50 +4877,50 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
 	write_nic_byte(dev, SECR,  SECR_value);
 }
 
-void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
-	    u8 *MacAddr, u8 DefaultKey, u32 *KeyContent)
+void setKey(struct net_device *dev, u8 entry_no, u8 key_idx, u16 key_type,
+	    u8 *mac_addr, u8 default_key, u32 *key_content)
 {
-	u32 TargetCommand = 0;
-	u32 TargetContent = 0;
-	u16 usConfig = 0;
+	u32 target_cmd = 0;
+	u32 content = 0;
+	u16 config = 0;
 	u8 i;
 
-	if (EntryNo >= TOTAL_CAM_ENTRY)
+	if (entry_no >= TOTAL_CAM_ENTRY)
 		RT_TRACE(COMP_ERR, "cam entry exceeds in %s\n", __func__);
 
 	RT_TRACE(COMP_SEC,
 		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
-		 __func__, dev, EntryNo, KeyIndex, KeyType, MacAddr);
+		 __func__, dev, entry_no, key_idx, key_type, mac_addr);
 
-	if (DefaultKey)
-		usConfig |= BIT(15) | (KeyType << 2);
+	if (default_key)
+		config |= BIT(15) | (key_type << 2);
 	else
-		usConfig |= BIT(15) | (KeyType << 2) | KeyIndex;
+		config |= BIT(15) | (key_type << 2) | key_idx;
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
-		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT(31) | BIT(16);
+		target_cmd  = i + CAM_CONTENT_COUNT * entry_no;
+		target_cmd |= BIT(31) | BIT(16);
 
 		if (i == 0) { /* MAC|Config */
-			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
-					(u32)(*(MacAddr + 1)) << 24 |
-					(u32)usConfig;
+			content = (u32)(*(mac_addr + 0)) << 16 |
+					(u32)(*(mac_addr + 1)) << 24 |
+					(u32)config;
 
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
+			write_nic_dword(dev, WCAMI, content);
+			write_nic_dword(dev, RWCAM, target_cmd);
 		} else if (i == 1) { /* MAC */
-			TargetContent = (u32)(*(MacAddr + 2))	 |
-					(u32)(*(MacAddr + 3)) <<  8 |
-					(u32)(*(MacAddr + 4)) << 16 |
-					(u32)(*(MacAddr + 5)) << 24;
-			write_nic_dword(dev, WCAMI, TargetContent);
-			write_nic_dword(dev, RWCAM, TargetCommand);
+			content = (u32)(*(mac_addr + 2))	 |
+					(u32)(*(mac_addr + 3)) <<  8 |
+					(u32)(*(mac_addr + 4)) << 16 |
+					(u32)(*(mac_addr + 5)) << 24;
+			write_nic_dword(dev, WCAMI, content);
+			write_nic_dword(dev, RWCAM, target_cmd);
 		} else {
 			/* Key Material */
-			if (KeyContent) {
+			if (key_content) {
 				write_nic_dword(dev, WCAMI,
-						*(KeyContent + i - 2));
-				write_nic_dword(dev, RWCAM, TargetCommand);
+						*(key_content + i - 2));
+				write_nic_dword(dev, RWCAM, target_cmd);
 			}
 		}
 	}
-- 
2.20.1

