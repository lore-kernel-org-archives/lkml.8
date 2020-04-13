Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD1C2BB85
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:01:37 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D0820678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSycNdF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D0820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDMDBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgDMDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:01:34 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA571C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:01:34 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id bu9so3774358qvb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iBamg6b+a8xdsXs8Iaan2CedZk8W62JWzS+doU1fNjA=;
        b=kSycNdF5dc1ojI+1otX03hnu3Kr1uHBZTSwUPC6GcLWDJedYRNgEV6CnMHk8kzkjpp
         zV9nE9uqJoU+5/7nEtJAf3rq/SlhPDHpGWI6UzNqzvuM20C7deThGBzBJ6ZHmBIBhLVA
         W8aOQ08IyXJVcf1+XDY+v4cyjq9f2uJncDmdP5GXqeYBssLLleqIxN9EYvw93wOCb3M/
         smcwu6+MzNYS7ftckYDsoTN+JXvcwzMo/dbYV9euHdA53EmNFRvVGA7JZ9rrXP8b9HLL
         CFv5xDzqO/mahGDkgwLxCI2piNsr69dTkCimmkzB7jebycPIp2ggPO4ZQi1XydPNayvQ
         V6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBamg6b+a8xdsXs8Iaan2CedZk8W62JWzS+doU1fNjA=;
        b=M0z5C7b7NZvzR4eEGX/M/RitrquGxvf3v+LQhEzY51ZculcDUgQhE4C+zztF8stHzL
         /VOxg33fBvwLHioaYxB26IKes7EK3wt19NYL/keMMtELzy2j6JJMVFWPPW6uVUMmezvV
         xiAEZtaSLBW2zyCz2nQempQHacKWtgXE4k9CR/6QG//MOIUl1i3G+l01eBeUGf8txFv5
         I1eybHZ0oiYofI+iAFEJFSRkPd+cVDMLzsNM9fglvUCn0kUM6BaKjR3M/OxNytfaSng0
         kUCXDX2VDZOqMu3+wkIli74Nr5tL1rBMbmgJbsThY93z10HGaBTpQZ+RZKubGBy0lRkk
         IzJQ==
X-Gm-Message-State: AGi0Pub9dzfC+N7fXl4/mb1qgDPccbNpb2q0MaFJxD3XYNWwxrjuG066
        gLAd+U7Bj0fMKiSGUh/LbhM=
X-Google-Smtp-Source: APiQypKyKsPE1udzaBgRtq8WySzkjFESxDLp4oQm6bTnXYTS0SwxGjyCLpqbAl18kaFeFN0CD/oiPA==
X-Received: by 2002:a05:6214:183:: with SMTP id q3mr15807286qvr.234.1586746894071;
        Sun, 12 Apr 2020 20:01:34 -0700 (PDT)
Received: from localhost.localdomain ([189.78.178.135])
        by smtp.gmail.com with ESMTPSA id i20sm7208754qkl.135.2020.04.12.20.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 20:01:33 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, navid.emamdoost@gmail.com,
        sylphrenadin@gmail.com, nishkadg.linux@gmail.com,
        stephen@brennan.io, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH 2/2] staging: rtl8192u: Renames variables in setKey function
Date:   Mon, 13 Apr 2020 03:01:29 +0000
Message-Id: <20200413030129.861-2-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413030129.861-1-c.cantanheide@gmail.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames the local variables of the setKey
function, making them explicit.

Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 48 +++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 87c02aee3854..cc02c3b1eb91 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4877,48 +4877,48 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
 	write_nic_byte(dev, SECR,  SECR_value);
 }
 
-void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
-	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
+void setKey(struct net_device *dev, u8 entry_no, u8 key_idx, u16 key_type,
+	    u8 *mac_addr, u8 default_key, u32 *key_content)
 {
-	u32 target_command = CAM_CONTENT_COUNT * entryno |  BIT(31) | BIT(16);
-	u32 target_content = 0;
-	u16 us_config = 0;
+	u32 cmd = CAM_CONTENT_COUNT * entry_no |  BIT(31) | BIT(16);
+	u32 content = 0;
+	u16 config = 0;
 	u8 i;
 
-	if (entryno >= TOTAL_CAM_ENTRY)
+	if (entry_no >= TOTAL_CAM_ENTRY)
 		RT_TRACE(COMP_ERR, "cam entry exceeds in %s\n", __func__);
 
 	RT_TRACE(COMP_SEC,
 		 "====>to %s, dev:%p, EntryNo:%d, KeyIndex:%d, KeyType:%d, MacAddr%pM\n",
-		 __func__, dev, entryno, keyindex, keytype, macaddr);
+		 __func__, dev, entry_no, key_idx, key_type, mac_addr);
 
-	if (defaultkey)
-		us_config |= BIT(15) | (keytype << 2);
+	if (default_key)
+		config |= BIT(15) | (key_type << 2);
 	else
-		us_config |= BIT(15) | (keytype << 2) | keyindex;
+		config |= BIT(15) | (key_type << 2) | key_idx;
 
-	target_content = macaddr[0] << 16 |
-			 macaddr[0] << 24 |
-			(u32)us_config;
+	content = mac_addr[0] << 16 |
+		  mac_addr[0] << 24 |
+		 (u32)config;
 
-	write_nic_dword(dev, WCAMI, target_content);
-	write_nic_dword(dev, RWCAM, target_command++);
+	write_nic_dword(dev, WCAMI, content);
+	write_nic_dword(dev, RWCAM, cmd++);
 
 	/* MAC */
-	target_content = macaddr[2]	  |
-			 macaddr[3] <<  8 |
-			 macaddr[4] << 16 |
-			 macaddr[5] << 24;
-	write_nic_dword(dev, WCAMI, target_content);
-	write_nic_dword(dev, RWCAM, target_command++);
+	content = mac_addr[2]	    |
+		  mac_addr[3] <<  8 |
+		  mac_addr[4] << 16 |
+		  mac_addr[5] << 24;
+	write_nic_dword(dev, WCAMI, content);
+	write_nic_dword(dev, RWCAM, cmd++);
 
 	/* Key Material */
-	if (!keycontent)
+	if (!key_content)
 		return;
 
 	for (i = 2; i < CAM_CONTENT_COUNT; i++) {
-		write_nic_dword(dev, WCAMI, *keycontent++);
-		write_nic_dword(dev, RWCAM, target_command++);
+		write_nic_dword(dev, WCAMI, *key_content++);
+		write_nic_dword(dev, RWCAM, cmd++);
 	}
 }
 
-- 
2.20.1

