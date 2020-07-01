Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9AEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9717C2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB4Hvt+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgGAIcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgGAIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:32:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E71C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:32:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so21493682wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnszQP2mk8a9Zq/MXSfFAa0Z6TG4Q6FByatEINovmEo=;
        b=IB4Hvt+xLQjh7eH1K3vHpPewhv/QSAS3XGMBecXxTdYAVW9QcYdtLk7UOYl3azpF+V
         40hSmK4rPCC5A6cnflmbpHGZW3V/0bY+a4YVir+5IDSrVSz0gTPgXhTuJ+ZuX7nCBFYt
         QvZXvcX3DpZJjDjhKolpvBrQq5qxHGLxX0/ou2lvhY9BS6M7eYCcy4urFScvi3a6w7sq
         AwZaht8IhrjmVMzouZuq0LcKMcXykZc7BqujAbcJuvWhoLoWHx0PnuNi2eKWzLg18Y/z
         aiTRKWS5Pi02jjk4tNb957wqb5EPgtZLf18VxrMiszOnySekKm3h/UH+OWQAY4Blkq8p
         Ygzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnszQP2mk8a9Zq/MXSfFAa0Z6TG4Q6FByatEINovmEo=;
        b=a1JodCOwGYC6tfto78va0gDuYOVBIOwzBL8isgVs6ymB+xEpFboJFj5SlOTetcMgP3
         2GXFEslKwgdMoUTLqRFSjP+d6ivMp7kAFxG5Efsn28I26C6u2GndqGtA0M+OZ1UI5KZU
         tyPh9EgDRrNau4noR50vVkdUyBBDqvXOprsnctiQvrt3SQYVeFGfRmzLvL693rHSz3R2
         Q3HG6YaQSOSQeE+aDN58gYdCa0+NMlhQ6ro2qVhSDr9LwmqQLJYfavVJqheD2vSlBRem
         4m4FszXdHUlhKic+j+tmVJQTmVvvJ/BMGU6XuWqR1kHh0AO2IqzuNBvJ5rY1KpB9jqg7
         L8Xw==
X-Gm-Message-State: AOAM531Jhy3wrhdQ27faSlg4e+PSSl51dtyeGIEDJgBd8b54R1ZVqyNk
        5Qmm7Z7Jc9bQfEbFJPJxlKNnBQ==
X-Google-Smtp-Source: ABdhPJy4sOV8stoOBzvTAvtFg8DBehh2mCfwoxjT94FkE4/HFkIXwq07UCxvviaLtD5CKsR0ap3+Rg==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr25297772wmg.88.1593592318888;
        Wed, 01 Jul 2020 01:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 30/30] misc: cxl: flash: Remove unused pointer
Date:   Wed,  1 Jul 2020 09:31:18 +0100
Message-Id: <20200701083118.45744-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRC index pointer us updated on an OPCODE_ADD, but never
actually read.  Remove the used pointer and shift up OPCODE_ADD
to group with OPCODE_DELETE which also provides a noop.

Fixes the following W=1 kernel build warning:

 drivers/misc/cxl/flash.c: In function ‘update_devicetree’:
 drivers/misc/cxl/flash.c:178:16: warning: variable ‘drc_index’ set but not used [-Wunused-but-set-variable]
 178 | __be32 *data, drc_index, phandle;
 | ^~~~~~~~~

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/cxl/flash.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index cb9cca35a2263..24e3dfcc91a74 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -175,7 +175,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
 	struct update_nodes_workarea *unwa;
 	u32 action, node_count;
 	int token, rc, i;
-	__be32 *data, drc_index, phandle;
+	__be32 *data, phandle;
 	char *buf;
 
 	token = rtas_token("ibm,update-nodes");
@@ -206,15 +206,12 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
 
 				switch (action) {
 				case OPCODE_DELETE:
+				case OPCODE_ADD:
 					/* nothing to do */
 					break;
 				case OPCODE_UPDATE:
 					update_node(phandle, scope);
 					break;
-				case OPCODE_ADD:
-					/* nothing to do, just move pointer */
-					drc_index = *data++;
-					break;
 				}
 			}
 		}
-- 
2.25.1

