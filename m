Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBEC433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA91206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivufnweq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgGVJ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgGVJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:27:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C365C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:27:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so894763pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDsj9nZdzBG+5WY/yle5GyRO0Zn2RK3XNjk1nxrgETU=;
        b=ivufnweq8/EvEjbxrMe0YH2cjWUQrZ6lhGmtZXxqhuYGPmPGChoQMTCHIh8NYU9P19
         0N3NAqzNvWndc7/XaiIClaXDvSjHp4IekSB/ukqBTM7pK7pONsQ6rLaB/3NH5ZNBqX06
         ktC+mzxaCE6f0m/kv5CJbPJjBcK0Qx59Lgh4yhoK+jUlLxK/Lq6EJvI7gbX5fb/CGrt0
         +pG6uFSXIvGtZhZtlojtoAqVp0v04L5wbesesC/kLdRcDquF2b3lg07jV/LRdwkwCMNH
         bQ0VROmUB4NqQ2eDa1eMo6F7+AkWrAl7FoKRi8c639M1H+9ZeZpIoUBmafdxQnBvnX0g
         0SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDsj9nZdzBG+5WY/yle5GyRO0Zn2RK3XNjk1nxrgETU=;
        b=KewHuoo5ZFUbppubxHwxLOELZbzE35psxhG5LLL7z/DcAmPp/JRjbmOqHTpTruwvRj
         k0oNHkx5c589E/90L0xKYHxtFD44KzivQbQwHIZnKn+waYbANQjCETaVBwWwHm3DUGNu
         ENRZtwnrgCO1mDLYUmo4K8bEglb/Td9RJQzch2EojgLBG2aP7bOcuHV5pT+i+boUyP0S
         1W5kltfCpmEIx+7ODyYoZuhwyOe3Pm1eIPIyihMjI+DhCwbJc8PXw8wHwarSn89IuHbA
         MJnwfaD8bjiIy7Luj11qeLV6+lN9UzVl9T36dhjtGzXFewo/yj8jtJ4dcnVEz5BaZvRb
         tVDw==
X-Gm-Message-State: AOAM532A2dHVb/dn8o4v8vY1fpowStImcbprGJAIGHVv/BSIACTm+tWI
        lI0Hmx+lchZjRThwt6bLRiU=
X-Google-Smtp-Source: ABdhPJzuVPnpKl5F1C6P4pwhs2f3+/uvCOmyD7+7Vl6Kp/JWpOQNKGGNoJm9+c5wes3QNpR2nLSdmA==
X-Received: by 2002:a62:ceca:: with SMTP id y193mr26982626pfg.11.1595410058758;
        Wed, 22 Jul 2020 02:27:38 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id z26sm23275414pfr.187.2020.07.22.02.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:27:37 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] sysrq: use only one slot for loglevels in key table
Date:   Wed, 22 Jul 2020 17:26:09 +0800
Message-Id: <20200722092610.11504-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, sysrq_key_table[] has 10 slots for same interface to change
console loglevel. No specific purpose to do that. Let's use only one slot
to save memory space. Also, update the key2index calculation. And remove
needless code in help message print path to make the logic simpler.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/tty/sysrq.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7c95afa9..3f12910 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -442,17 +442,8 @@ static void sysrq_handle_unrt(int key)
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
-static const struct sysrq_key_op *sysrq_key_table[36] = {
-	&sysrq_loglevel_op,		/* 0 */
-	&sysrq_loglevel_op,		/* 1 */
-	&sysrq_loglevel_op,		/* 2 */
-	&sysrq_loglevel_op,		/* 3 */
-	&sysrq_loglevel_op,		/* 4 */
-	&sysrq_loglevel_op,		/* 5 */
-	&sysrq_loglevel_op,		/* 6 */
-	&sysrq_loglevel_op,		/* 7 */
-	&sysrq_loglevel_op,		/* 8 */
-	&sysrq_loglevel_op,		/* 9 */
+static const struct sysrq_key_op *sysrq_key_table[27] = {
+	&sysrq_loglevel_op,		/* 0 - 9 */
 
 	/*
 	 * a: Don't use for system provided sysrqs, it is handled specially on
@@ -507,9 +498,9 @@ static int sysrq_key_table_key2index(int key)
 	int retval;
 
 	if ((key >= '0') && (key <= '9'))
-		retval = key - '0';
+		retval = 0;
 	else if ((key >= 'a') && (key <= 'z'))
-		retval = key + 10 - 'a';
+		retval = key + 1 - 'a';
 	else
 		retval = -1;
 	return retval;
@@ -577,16 +568,8 @@ void __handle_sysrq(int key, bool check_mask)
 		pr_info("HELP : ");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
-			if (sysrq_key_table[i]) {
-				int j;
-
-				for (j = 0; sysrq_key_table[i] !=
-						sysrq_key_table[j]; j++)
-					;
-				if (j != i)
-					continue;
+			if (sysrq_key_table[i])
 				pr_cont("%s ", sysrq_key_table[i]->help_msg);
-			}
 		}
 		pr_cont("\n");
 		console_loglevel = orig_log_level;
-- 
1.9.1

