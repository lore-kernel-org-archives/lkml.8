Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25EC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D9B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeJERwRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXF3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:29:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCXF3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:29:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7so8473616pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GksRJuQygj8iEw4+FLEhSTTKNuAXjcLxWomfet7/TQc=;
        b=AeJERwRSpJgnUUI1sktI8LwnrhuSGSz3vYH1BFGxcVqWMRFulqPzEU+WQgIDtowBid
         DY0kGUla4Ru00rBlZA6ZdZE8lKd1/wJoWuf0lfY+cj2pDSnteABWfDjOZQsvKM+QFXa3
         sMkhhNfGBHxaoBmA97f4vTJUIS1/CiwlZbeWU+TAt0eAlf/M7HCTuKV4oURSn8ECY4sC
         iX3F68HmPtaSvXgjFbClRcp4WaMOa4pIhb2bRBGX1JuaJ2bryB0/Lnge5pkrunV1IAMe
         3x+OLXURB5P9kmJSJkyX2vCL4/RwyaFE97vy31wFojuM9pWgkikB1TK966do/hubMOas
         w5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GksRJuQygj8iEw4+FLEhSTTKNuAXjcLxWomfet7/TQc=;
        b=S3z2G8y0U6qn6PVLgaIjK5YIjVieCnkEG0D6RSxiCpbxqJ+h3GsoOrftNDgLM1aV0E
         4wkD9ZKyOmnluwYv8Tp21q5U4vbd74klnbe1fdWntmpRzzyhY7jiFpJhArHMbsAqfS2W
         TNq+rTr6xSWSB8sXPGfd9D0BPQibl7hIvM8FJBacgyiIxGSh1LIqnAcpuCE9UM5Nqvl0
         w+ec/tc4igBe8OGp+brD2M+DuYiqZ4y7FYVgjylGPs/HEFtkmxub9LyCHszIIzH0cbi4
         DP6dBdmFGry1F8COGRVfazOvaLWMzD1kDCTDHNN3xjfmtNjqqSrsdbIx60EI/1Ydw+7L
         9N8w==
X-Gm-Message-State: ANhLgQ3Uvp2XkFRRB72knCFVNimt09HqFaHUP3Z1CV0C8wDgCXt2CtPJ
        ZOn26IBciVEgiNPOaQWeC1HtJQ==
X-Google-Smtp-Source: ADFU+vvQ57kvoZi+N9uQpIwZoXOTeauhh9IYgweVQ3UD9AqMO2B6kX+AF3DFoI0AvOUD007/H1wUOw==
X-Received: by 2002:a62:4e4c:: with SMTP id c73mr28422516pfb.254.1585027750135;
        Mon, 23 Mar 2020 22:29:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j14sm2795413pgk.74.2020.03.23.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 22:29:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5 1/4] remoteproc: Traverse rproc_list under RCU read lock
Date:   Mon, 23 Mar 2020 22:29:01 -0700
Message-Id: <20200324052904.738594-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200324052904.738594-1-bjorn.andersson@linaro.org>
References: <20200324052904.738594-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to traverse the mostly read-only rproc_list without
locking during panic migrate traversal to be done under rcu_read_lock().

Mutual exclusion for modifications of the list continues to be handled
by the rproc_list_mutex and a synchronization point is added before
releasing objects that are popped from the list.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Added rculist include
- Picked up Mathieu's r-b

 drivers/remoteproc/remoteproc_core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9ac1d01e09b..7ee976ee2044 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -26,6 +26,7 @@
 #include <linux/string.h>
 #include <linux/debugfs.h>
 #include <linux/devcoredump.h>
+#include <linux/rculist.h>
 #include <linux/remoteproc.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
@@ -1868,8 +1869,8 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	if (!np)
 		return NULL;
 
-	mutex_lock(&rproc_list_mutex);
-	list_for_each_entry(r, &rproc_list, node) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(r, &rproc_list, node) {
 		if (r->dev.parent && r->dev.parent->of_node == np) {
 			/* prevent underlying implementation from being removed */
 			if (!try_module_get(r->dev.parent->driver->owner)) {
@@ -1882,7 +1883,7 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 			break;
 		}
 	}
-	mutex_unlock(&rproc_list_mutex);
+	rcu_read_unlock();
 
 	of_node_put(np);
 
@@ -1939,7 +1940,7 @@ int rproc_add(struct rproc *rproc)
 
 	/* expose to rproc_get_by_phandle users */
 	mutex_lock(&rproc_list_mutex);
-	list_add(&rproc->node, &rproc_list);
+	list_add_rcu(&rproc->node, &rproc_list);
 	mutex_unlock(&rproc_list_mutex);
 
 	return 0;
@@ -2156,9 +2157,12 @@ int rproc_del(struct rproc *rproc)
 
 	/* the rproc is downref'ed as soon as it's removed from the klist */
 	mutex_lock(&rproc_list_mutex);
-	list_del(&rproc->node);
+	list_del_rcu(&rproc->node);
 	mutex_unlock(&rproc_list_mutex);
 
+	/* Ensure that no readers of rproc_list are still active */
+	synchronize_rcu();
+
 	device_del(&rproc->dev);
 
 	return 0;
-- 
2.24.0

