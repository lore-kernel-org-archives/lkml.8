Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6C220775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqCkYlhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgGHM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgGHM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:57:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C71C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:57:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so48870169wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTuqyVT9cnuWmuZkR2avkoolSz/GKaORVGbqfOTz7Tw=;
        b=bqCkYlhYnCpQAHR1jCpg4zDsmvF7/yYY+dW4Ry8hSQ0ol6hlgM9RxlvgkLto7NQu5s
         SXp/EDHEhxl+WtlnQE+xeWiBsEgbG0avYbPfKcs3fKh90TWTpl3657DTRoFlcHS0lmrv
         7ERcbYLCIBCB+dlVGHCMZm8/s+8PcLN6rNLnhsJGomxu6akKrsW1Gs3MzNUg8R2DM8Uw
         P4YHkaMvjJqDKUr8l0a0yYdnA22JvmDESt/jJJtoE/+ULkUzyKAzorUCP8nUCaZtRmWV
         8JGxbZEPcoL+95Lp48vw6qXXBAJdLR8xqZGilGjfZ5k6ZeZQ5cnVFZ5cITwpJahCk7JF
         HJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTuqyVT9cnuWmuZkR2avkoolSz/GKaORVGbqfOTz7Tw=;
        b=XtwfcjmuBFVKqICUQs64gw7DFMdzqnJBLkgUIV51iEDdzdxVOZulGjy++xpy6YGQfv
         RevVPmeVGEyD/hIiF0SAMSgxTI0F/vLOyWnUX9R53+HMnMh/QDq/24Oe97zJLALdFXnV
         lX0y3yh62QN3kVk42YVjjjeRapOv8SSqAW8dlCjktDC06QpdWAuZJ/to2VHREMcRq+hT
         H598zolJg22DMhZ1Cxo2lvl4t9+cbUpCnX5DmEHEyF5AsE1OkDWFOrrDeYo/8ie/kbDb
         NKvXsZL9yylzbsih9E1i4pDgffSMOa2oYY19cY5EnnwhbZ2X5fITO707yYu8W+OROyw1
         ia6w==
X-Gm-Message-State: AOAM532Uo810ijh+3ZPnqwYzJG6qUbwe+p1Q4CkhnoqIOto7dPfiQZ8V
        pHkCirCiagekZygruM6iNFWPGw==
X-Google-Smtp-Source: ABdhPJxIHdPTQ+3Fj8EaoAnC4n0L/dO6qJOdSZK1Vn9FBMjAc28ucuEaecvFE3uBbNM6QZPL88lZuw==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr61733966wrq.358.1594213037108;
        Wed, 08 Jul 2020 05:57:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v9sm6993885wri.3.2020.07.08.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:57:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] misc: cxl: flash: Remove unused variable 'drc_index'
Date:   Wed,  8 Jul 2020 13:57:11 +0100
Message-Id: <20200708125711.3443569-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708125711.3443569-1-lee.jones@linaro.org>
References: <20200708125711.3443569-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the pointer increment though.

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
 drivers/misc/cxl/flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index cb9cca35a2263..774d582ddd70b 100644
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
@@ -213,7 +213,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
 					break;
 				case OPCODE_ADD:
 					/* nothing to do, just move pointer */
-					drc_index = *data++;
+					*data++;
 					break;
 				}
 			}
-- 
2.25.1

