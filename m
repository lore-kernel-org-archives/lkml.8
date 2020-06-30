Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ABD20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCptlGP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgF3NwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbgF3Nvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD78C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so19688028wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnszQP2mk8a9Zq/MXSfFAa0Z6TG4Q6FByatEINovmEo=;
        b=UCptlGP89mz89UrYfXQefNW8+e4ZQEEx97tpWiKPBMfS4wNL0irneBp0jrTF9ByhBp
         r3sH1OSHEMiwFz/5r7EkY9kOTSEF5j3ZoqwRqWJb8vbVNW1skrkKsOZTP5gEp9oREz8g
         AbeUF9AZHhUcmH/ZNDNbXyX/tcNDJePdqaFSBzXZh+af/Hh0ljo857xNngaLb/5M6uvM
         FDyUkltnD8NJFywjYlMdE/rEgEs1gwt7Lotc5q/rX00mU0keywb2yCIfDaovLph8enxA
         OTfjHeNk1H1rosvo8UqtJ7TZT8tY+d+i9r5YkK3hUsAjwQZILkkV5knsYgiZKcO7geQh
         9ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnszQP2mk8a9Zq/MXSfFAa0Z6TG4Q6FByatEINovmEo=;
        b=s4oZuEuFJ0ReS7t1heZ4IoRJ7N6NQswvvludKULG8ys77+pK+Z2Zhii1kDJj1ewk/Y
         mQZtfiap6Mj6CcyykFC8waX6pVzjBrDJ5YGk+bygji91C/JiUJIMSj1/lwA1qxGYAtKo
         HD6TSP1s/IgRTya9xA/6LODqT1sZSq9Qxd3xA5xCIPWLposD//3X7U5g+XVic3miFM/l
         TFpjBIxxCnD1wSbRjt8yZzV/f+cbUyD5JBl3bOl4isl7pqZPPocf94oXdO+4CS6wbKVp
         4idqWdIT2yMVRTB0X8Mq4voy+Q9K7c+pDiOi9JJh4/H2ZR7Y/0z9aluYtyiddNXIGPuL
         nFrQ==
X-Gm-Message-State: AOAM531fs3WF7DfzW7HDHtMoWVvkDeN22NOsmiMkFUGynPbOFKlR+6Xp
        KLLQTBNHL8i52vFtJrWmzRQP8g==
X-Google-Smtp-Source: ABdhPJxAVcr7BMBgpDdFrMsgoyDTsXOxDXBRszKa7Wa69xRKWCYbNprLZlHUJCgW8CUodbxVKwRxlA==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr21535111wmh.175.1593525106136;
        Tue, 30 Jun 2020 06:51:46 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 30/30] misc: cxl: flash: Remove unused pointer
Date:   Tue, 30 Jun 2020 14:51:10 +0100
Message-Id: <20200630135110.2236389-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

