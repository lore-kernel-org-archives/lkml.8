Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1142C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E52206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8TK5lRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgD1JQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD1JQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:16:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6CFC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:16:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so23718481wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kol2KnUcVyH0F7Ix7H0VZWG4kz6cZK2B84uPA/+NLmw=;
        b=b8TK5lRu2zdjHITUnvvgSNq0/t93vnrQav69WlFUmdAImx/QVnBdaMJhSSstXj/vmp
         c4vsNZG6H64f48aO3ug9CSBci33QqvxxEmV/nUCvNBeJsf1O9+Jze6a/ky7hUtRzM94+
         fBfpv3prrsqZsGudTQmxieV6v1qUSaQqYxufroh+dxH0D/UgWt6Xl7gmr5K7qcRX91VB
         NR2iqxHu0A6YnnsZPfeTPUyvKsVhrPfYzgIRmB0L7BIxJbke+HopvQbMi84lOyKf0WiI
         B0cg6zstCm5gE4ikZjVuET9oxlAqknEE4s2x+LI1ua0BBG1G+4gp87qCSWDK9zYghAVL
         S46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kol2KnUcVyH0F7Ix7H0VZWG4kz6cZK2B84uPA/+NLmw=;
        b=ORLAfY5owI9O7Fxzrwt2IbBXguxWG8CqoU2EA7nHlWTcVgNEZfhv1znHzC4s23MG/0
         LmtMLm9RxRMhd+w5EFYAziNwgpGpKQP7kv6I5rtPB31osXBmLp8CDtCfZIErGbxRMCRE
         wLrLxhTJaK0EobiKzAbqH8dLOT0K2BWloUO4Gy4YKS1rYz/Yg040GlVTD/JteTj+cJYC
         Vnv9zDNQQE4WAnUd74yhoi5w6GSVCck0+sBkSG8JBwgwx84M5mwAGAYSIBCT+b58m37m
         BhYX3Wv5a3Y5V749og/vX4d33T9i6vWNPcwVO+WxDL4YcKGE8nDvA41fmNeyJRl3F7DO
         z+1g==
X-Gm-Message-State: AGi0PuZUcphptAcgIz6x6ULtgUKHbh2pHhl/YqlxxY2diydKp1Q1X6vc
        gxGkxcks2EhzhPqDYHysxoxoOQ==
X-Google-Smtp-Source: APiQypI1NaFanMBSA/9TXktEMwg92qBduRtE849bebURjum+Ps+JfDCHR5BF5kVxyiG6aXCkG+KrrQ==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr31480285wrs.7.1588065412820;
        Tue, 28 Apr 2020 02:16:52 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id k14sm25005543wrp.53.2020.04.28.02.16.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 02:16:52 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     akashast@codeaurora.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] interconnect: Add helpers for enabling/disabling a path
Date:   Tue, 28 Apr 2020 12:16:50 +0300
Message-Id: <20200428091650.27669-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a repeated pattern in multiple drivers where they want to switch
the bandwidth between zero and some other value. This is happening often
in the suspend/resume callbacks. Let's add helper functions to enable and
disable the path, so that callers don't have to take care of remembering
the bandwidth values and handle this in the framework instead.

With this patch the users can call icc_disable() and icc_enable() to lower
their bandwidth request to zero and then restore it back to it's previous
value.

Suggested-by: Evan Green <evgreen@chromium.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 50 ++++++++++++++++++++++++++++++++-
 drivers/interconnect/internal.h |  2 ++
 include/linux/interconnect.h    | 12 ++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2c6515e3ecf1..6af68e506ac2 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -158,6 +158,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
 		path->reqs[i].node = node;
 		path->reqs[i].dev = dev;
+		path->reqs[i].enabled = true;
 		/* reference to previous node was saved during path traversal */
 		node = node->reverse;
 	}
@@ -249,9 +250,12 @@ static int aggregate_requests(struct icc_node *node)
 	if (p->pre_aggregate)
 		p->pre_aggregate(node);
 
-	hlist_for_each_entry(r, &node->req_list, req_node)
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		if (!r->enabled)
+			continue;
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+	}
 
 	return 0;
 }
@@ -546,6 +550,50 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 }
 EXPORT_SYMBOL_GPL(icc_set_bw);
 
+int icc_disable(struct icc_path *path)
+{
+	int i;
+
+	if (!path)
+		return 0;
+
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
+	mutex_lock(&icc_lock);
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].enabled = false;
+
+	mutex_unlock(&icc_lock);
+
+	return icc_set_bw(path, path->reqs[0].avg_bw,
+			  path->reqs[0].peak_bw);
+}
+EXPORT_SYMBOL_GPL(icc_disable);
+
+int icc_enable(struct icc_path *path)
+{
+	int i;
+
+	if (!path)
+		return 0;
+
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
+	mutex_lock(&icc_lock);
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].enabled = true;
+
+	mutex_unlock(&icc_lock);
+
+	return icc_set_bw(path, path->reqs[0].avg_bw,
+			  path->reqs[0].peak_bw);
+}
+EXPORT_SYMBOL_GPL(icc_enable);
+
 /**
  * icc_get() - return a handle for path between two endpoints
  * @dev: the device requesting the path
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index bf18cb7239df..f5f82a5c939e 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -14,6 +14,7 @@
  * @req_node: entry in list of requests for the particular @node
  * @node: the interconnect node to which this constraint applies
  * @dev: reference to the device that sets the constraints
+ * @enabled: indicates whether the path with this request is enabled
  * @tag: path tag (optional)
  * @avg_bw: an integer describing the average bandwidth in kBps
  * @peak_bw: an integer describing the peak bandwidth in kBps
@@ -22,6 +23,7 @@ struct icc_req {
 	struct hlist_node req_node;
 	struct icc_node *node;
 	struct device *dev;
+	bool enabled;
 	u32 tag;
 	u32 avg_bw;
 	u32 peak_bw;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index d70a914cba11..21dd232d81ff 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -29,6 +29,8 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
+int icc_disable(struct icc_path *path);
+int icc_enable(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
 
@@ -50,6 +52,16 @@ static inline void icc_put(struct icc_path *path)
 {
 }
 
+static inline int icc_disable(struct icc_path *path)
+{
+	return 0;
+}
+
+static inline int icc_enable(struct icc_path *path)
+{
+	return 0;
+}
+
 static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	return 0;
