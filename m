Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E503C54FD1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CDE208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rnjQeB+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCXUSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:18:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49458 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCXUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:18:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIQ1j104165;
        Tue, 24 Mar 2020 15:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585081106;
        bh=Yjhl9EQ14R/kACUXumM+AqugWYYqz1aQVf2tw0BsJh4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rnjQeB+exVSr4M4lObIpZlugcIYzXomQxbjz12iVw5J1x2A9D5GRSXbR47+tCzhLb
         YZLJXPYIM5OJlnQtbgY0OG+zPWmosPtk14JDryoPL2YgqEG8QKSMcXeyvW05oEXLxs
         MZBZz9PyjwJqSwOUbF1u5jSFfveLLfEBLDeZvKfg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02OKIQ12013610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Mar 2020 15:18:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 15:18:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 15:18:26 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIPGj124170;
        Tue, 24 Mar 2020 15:18:25 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02OKIPpq084965;
        Tue, 24 Mar 2020 15:18:25 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/7] remoteproc: use a local copy for the name field
Date:   Tue, 24 Mar 2020 15:18:14 -0500
Message-ID: <20200324201819.23095-3-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200324201819.23095-1-s-anna@ti.com>
References: <20200324201819.23095-1-s-anna@ti.com>
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
 drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
 include/linux/remoteproc.h           | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index aca6d022901a..6e0b91fa6f11 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1989,6 +1989,7 @@ static void rproc_type_release(struct device *dev)
 
 	kfree(rproc->firmware);
 	kfree(rproc->ops);
+	kfree(rproc->name);
 	kfree(rproc);
 }
 
@@ -2061,7 +2062,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	}
 
 	rproc->firmware = p;
-	rproc->name = name;
+	rproc->name = kstrdup(name, GFP_KERNEL);
+	if (!rproc->name) {
+		kfree(p);
+		kfree(rproc->ops);
+		kfree(rproc);
+		return NULL;
+	}
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
 	rproc->elf_class = ELFCLASS32;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ddce7a7775d1..77788a4bb94e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -490,7 +490,7 @@ struct rproc_dump_segment {
 struct rproc {
 	struct list_head node;
 	struct iommu_domain *domain;
-	const char *name;
+	char *name;
 	char *firmware;
 	void *priv;
 	struct rproc_ops *ops;
-- 
2.23.0

