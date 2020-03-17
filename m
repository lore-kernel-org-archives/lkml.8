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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF8C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFZztaS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgCQIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:51:42 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35916 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:51:41 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so4265443qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XgwzraBXqz3SI/6EeJQ6wiwE5blj9E+h6o+6iDLuN0=;
        b=tFZztaS15QYMv2CWkVdEJLs5MHgmxDHOXk+I1BSGN+mc48dCfDTDDdldGg+T2u/1u9
         5rwNbdaCkxGrvmySw3Ebhd/2uPNFeIUUDSYsa6Xp6VsmJJT9ejeyNgJFnNbcAdoPLBva
         aFdt6hhKgp8gEUvT7RBfMrUFV4KNV28AtsKl6XCiODRLMTq0XB/opu8AINFupxZjCoVx
         3jisyKWUst4nJqFpZWxYAhiEvA4U69FNNNtPkK+NHiCIiHP+BjPfRYRh4okIpHDVNqgI
         nIkhgG1uOdSbvAkpassLYs0czYVUvRr8zvrGhm00AQShENeO4WEkjAHepxiz0bEPyvbd
         CmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XgwzraBXqz3SI/6EeJQ6wiwE5blj9E+h6o+6iDLuN0=;
        b=qHeaNNOvVRsjH0YM0aq8uBzJqztOvYcVs2x95li5848eBJNbV7vTPQSwgqfFea0kmI
         5TOkFyYkOixud6zKxuT4ZPh59Il7PnfnvexsTHVmCE/NzvYySF3slIGMCTgJu8b5xNQ1
         hBcDErQBQgIU5QPmZHt836IRFyv8uROYebxasNTZaEPjxA88BAu6xMF4xNtfOWb59brd
         lLYegn1/xP8+Wx4BHDxzvJXhLM7eGcssuTe+Ag8co5OlAQcHKRIqZ9EQQ4XYnTXjsEI1
         8GigMqAM5p7RKvYMdwiskJ8/w/XKhfufdIDpA/nEoAnGtJptwEyPjWd0zyE/X/GLWtm4
         /NYQ==
X-Gm-Message-State: ANhLgQ1yFHdiyy+DGb/EPMJuxBaoezgdJBZ7ary2r430gVbAGdBBSe+2
        Wa8NY4wxnBWIRIgxU+H4f+Y=
X-Google-Smtp-Source: ADFU+vsIUZ7aRiWg2Ed6kZ2zMiaUflakk/CUUD23qWtnXcEz4rF+TMW8LpNsQANfqjpjBk+SwtTf8Q==
X-Received: by 2002:ad4:5222:: with SMTP id r2mr3888131qvq.178.1584435100486;
        Tue, 17 Mar 2020 01:51:40 -0700 (PDT)
Received: from localhost.localdomain (179.186.61.135.dynamic.adsl.gvt.net.br. [179.186.61.135])
        by smtp.gmail.com with ESMTPSA id s4sm1884404qte.36.2020.03.17.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:51:40 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH 1/2] staging: rtl8192u: Using function name as string
Date:   Tue, 17 Mar 2020 08:51:29 +0000
Message-Id: <20200317085130.21213-1-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves the following checkpatch.pl for a triggered function:
WARNING: Prefer using '"%s...", __func__' to using 'setKey',
this function's name, in a string

Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 9e222172b..93a15d57e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4886,11 +4886,11 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
 	u8 i;
 
 	if (EntryNo >= TOTAL_CAM_ENTRY)
-		RT_TRACE(COMP_ERR, "cam entry exceeds in setKey()\n");
+		RT_TRACE(COMP_ERR, "cam entry exceeds in %s\n", __func__);
 
 	RT_TRACE(COMP_SEC,
-		 "====>to setKey(), dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
-		 dev, EntryNo, KeyIndex, KeyType, MacAddr);
+		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
+		 __func__, dev, EntryNo, KeyIndex, KeyType, MacAddr);
 
 	if (DefaultKey)
 		usConfig |= BIT(15) | (KeyType << 2);
-- 
2.20.1

