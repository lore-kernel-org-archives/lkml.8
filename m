Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0775C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CA121841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LYwsa1/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgDQAU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:20:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41630 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgDQAU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:20:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03H0KggD001366;
        Thu, 16 Apr 2020 19:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587082842;
        bh=oOw75QBlpG6pb5O0bLrWeNZVrUQRVB6S4zef2wEvNww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LYwsa1/ZbpUDLhWUwjm55cR6Go531gQBBWc/ZrEVGak8g7Vk1LXVfmnEUAwYavQBF
         JJYFGKFEQ8Ag+IsmPubwW/Ma1ay+/eH58ooTGiN08oGy5xVIImlnpD/atjdqfVcB2B
         JpSCuEENe6ryyqVu4S4cxntsDJs55jX25Rn6mpJQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03H0KgSR060172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Apr 2020 19:20:42 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Apr 2020 19:20:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Apr 2020 19:20:41 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03H0KfbN020917;
        Thu, 16 Apr 2020 19:20:41 -0500
Received: from localhost ([10.250.70.56])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 03H0Kfkk060529;
        Thu, 16 Apr 2020 19:20:41 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] remoteproc: Use a local copy for the name field
Date:   Thu, 16 Apr 2020 19:20:36 -0500
Message-ID: <20200417002036.24359-3-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200417002036.24359-1-s-anna@ti.com>
References: <20200417002036.24359-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current name field used in the remoteproc structure is simply
a pointer to a name field supplied during the rproc_alloc() call.
The pointer passed in by remoteproc drivers during registration is
typically a dev_name pointer, but it is possible that the pointer
will no longer remain valid if the devices themselves were created
at runtime like in the case of of_platform_populate(), and were
deleted upon any failures within the respective remoteproc driver
probe function.

So, allocate and maintain a local copy for this name field to
keep it agnostic of the logic used in the remoteproc drivers.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v1:
 - Patch baselined on top of Mathieu's rproc_alloc() refactor
   series, and so addresses Bjorn's simplified cleanup comments
 - Switch to {kstrdup/kfree}_const variants
v0: https://patchwork.kernel.org/patch/11456385/

 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e38f627059ac..3cebface3f26 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1984,6 +1984,7 @@ static void rproc_type_release(struct device *dev)
 
 	kfree(rproc->firmware);
 	kfree(rproc->ops);
+	kfree_const(rproc->name);
 	kfree(rproc);
 }
 
@@ -2069,7 +2070,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc)
 		return NULL;
 
-	rproc->name = name;
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
 	rproc->elf_class = ELFCLASS32;
@@ -2081,6 +2081,10 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->dev.driver_data = rproc;
 	idr_init(&rproc->notifyids);
 
+	rproc->name = kstrdup_const(name, GFP_KERNEL);
+	if (!rproc->name)
+		goto put_device;
+
 	if (rproc_alloc_firmware(rproc, name, firmware))
 		goto put_device;
 
-- 
2.26.0

