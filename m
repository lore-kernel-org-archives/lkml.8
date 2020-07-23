Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E352C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1640207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvaotbhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgGWNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgGWNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:09:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F96C0619E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so5092349wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWTfVRkR79Imko0PPqnIzVcER9nAarkHmVQCWvBzyCc=;
        b=tvaotbhgbQViqsspi5Ia9TKg2g2+k8ZHJrq+MuqBEc7x4WaXGNGGEy7nerdKRpdySD
         AUFA0aEvde2ok3vmf3f7d032hQhoI/FwgRbVHeBsMzKfqIKacX8ch/8XktFVE7ixAXtp
         xLPPa/8uJemD/71lkS+de69byXAyLhqC1PhLMys6VruIqacBVqXH1r76V/IELKpOtb5f
         MbmEuoZdf2Cxe3mEMy4KFrMZ/td+/Pf/fhpk43Hc+Pe3hg36IZUe7lFHn+SwTrv6OCDC
         JLe0q+Pv2lnwhN3rYTWg6KicxVM0cM0TcLWDijyfCSFstREF/FY4UvOhbaLNUcz+I8fS
         sMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWTfVRkR79Imko0PPqnIzVcER9nAarkHmVQCWvBzyCc=;
        b=LSZeNr+U9LwM3Ux2bXCfZxO8jD1M/Xi/Lf6JQxV70MoZc1eeS2p82Lmrmmt0ORqEn8
         muU7FScY2qT+4ruivDzEjeQLqmmHV3yQwIP+rc5vwA0hzTqI1HN8X3IamHR8x9ig6H8c
         fUsM9RS/keedRiupfRnAxkTBR65AAjuCrOQcgwp1ZB8nLqfW57ru1zPMv1OtGgS7q5Jk
         SRUQ2DmNMtXK5Co2MuaQ3nxbxwlz0UZ5qq60GbD1tgtmCAIyYTdj4B47g9Hyjcn9mFqy
         163okTWnlj9haLqcLgz7lklhHprY75FL5FlWL8EMtCn63g/gc7ZniQAhjw2dJVkkU3aQ
         XMew==
X-Gm-Message-State: AOAM533pTsgOKVCxtOv73sUvGDo0sFpNm84G/cmulMOw03iS61xzoelE
        sz1QVCOLWU1UfTYUFz1hdocQhQ==
X-Google-Smtp-Source: ABdhPJypdAbK/l+XgBOALRGgJMjOLyLZ37pF8MBqln+MJ+cdCucrwML/MuWtdw1EdWissbAnd5A8rQ==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr3970548wrr.299.1595509784758;
        Thu, 23 Jul 2020 06:09:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] interconnect: qcom: Implement xlate_extended() to parse tags
Date:   Thu, 23 Jul 2020 16:09:38 +0300
Message-Id: <20200723130942.28491-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a function to parse the arguments of the "interconnects" DT
property and populate the interconnect path tags if this information
is available.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3ac5182c9ab2..44144fabec32 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -6,6 +6,8 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
@@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+{
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	if (!spec)
+		return ERR_PTR(-EINVAL);
+
+	node = of_icc_xlate_onecell(spec, data);
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+	if (!ndata)
+		return ERR_PTR(-ENOMEM);
+
+	ndata->node = node;
+
+	if (spec->args_count == 2)
+		ndata->tag = spec->args[1];
+
+	return ndata;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
+
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 903d25e61984..1dac39bc255d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -143,6 +143,7 @@ struct qcom_icc_desc {
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 
