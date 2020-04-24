Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267DEC55196
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003C6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/j9BvpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgDXUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgDXUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F801C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so4123183plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACPRkKaJUyZo8C7iIU0IKcYFjC5Ccd7f4ibW90mBkI0=;
        b=r/j9BvpKD2+h7VVgkG6ZqnvbwTKfJUON8chtw0D9EhgYbrohwaxbHnSVC6DKEdMEoe
         oUXUi8/KX/T7uSpfkE4CekO3PnJenQRoXtAgul+AqPvsi9ow75wBY9tjEYhz6nTdaqVv
         4rG72mUD5zmnY1U56LkaTOIe79apgYVIYuaDdelF24YVNO12eYio7lJ/BvWIwgM/Dfjc
         oTm1k2Zqjev5iWhdRYVG1o2lZQ0HszP/yehulR/satJVmmY7IK32kv4qPzMJgc5Ip3DC
         c0kEPOPrsCds0d6wzib3xL7J3JBfcXPJbr9I1gFyucTNRsTuVHqP+okYgh+Uapw2Eot6
         sUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACPRkKaJUyZo8C7iIU0IKcYFjC5Ccd7f4ibW90mBkI0=;
        b=ILhjuM5hOXQSLBvFYuUuKX6RCVo4hjMuZmmz4O1lqQmK4cC3jPEkfiErTR1bBbs8RG
         24D2YA69oR3TmK4RF0OOs1N01rEk7kTCo5SJulNfnt4UWuXJFFUWN2dZF2ZW4K9pMrZU
         vzJWK5AOyH0N4SsUJhq6zLl4w5LdysCS5++mICpZ9k2sXoKWIVfevzMFIhGHZF2zXj+J
         kHaZBcnoF0EPRZGJ6ZiqG/Rpy0PbpucKa3z3DD5XKiiAQUilAj+ATTrNVQRMqJeyi3HB
         bOIzUQAr/QNjps2ezAQntz45A6nFDQ/Qqd18o3dG2VbUpZ6gNRS/OUQMwYGXoNj2aZIE
         RtEg==
X-Gm-Message-State: AGi0PuZvEk+mrA6naiFx1Jo/KtxrsR8oan/ti+e/YrIqKJpj2thpWmmj
        +cdgwf0KNSSN4M4mIDS1L9bRyQ==
X-Google-Smtp-Source: APiQypKfmGSdN3v0D8zcRUOZanqmk0b+MRKxMtXLO8IYCYWXEgvCIFclKnMbij53lOKaXmiqTriYqA==
X-Received: by 2002:a17:90a:276a:: with SMTP id o97mr8248471pje.194.1587758507788;
        Fri, 24 Apr 2020 13:01:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] remoteproc: Call core functions based on synchronisation flag
Date:   Fri, 24 Apr 2020 14:01:29 -0600
Message-Id: <20200424200135.28825-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the right core function based on whether we should synchronise
with a remote processor or boot it from scratch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_internal.h | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index dda7044c4b3e..3985c084b184 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -72,6 +72,12 @@ static inline bool rproc_needs_syncing(struct rproc *rproc)
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->sanity_check)
+			return rproc->sync_ops->sanity_check(rproc, fw);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->sanity_check)
 		return rproc->ops->sanity_check(rproc, fw);
 
@@ -81,6 +87,12 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 static inline
 u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->get_boot_addr)
+			return rproc->sync_ops->get_boot_addr(rproc, fw);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->get_boot_addr)
 		return rproc->ops->get_boot_addr(rproc, fw);
 
@@ -90,6 +102,12 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 static inline
 int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->load)
+			return rproc->sync_ops->load(rproc, fw);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->load)
 		return rproc->ops->load(rproc, fw);
 
@@ -98,6 +116,12 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
 
 static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->parse_fw)
+			return rproc->sync_ops->parse_fw(rproc, fw);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->parse_fw)
 		return rproc->ops->parse_fw(rproc, fw);
 
@@ -108,6 +132,13 @@ static inline
 int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
 		     int avail)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->handle_rsc)
+			return rproc->sync_ops->handle_rsc(rproc, rsc_type,
+							   rsc, offset, avail);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->handle_rsc)
 		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
 					      avail);
@@ -119,6 +150,13 @@ static inline
 struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 						   const struct firmware *fw)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->find_loaded_rsc_table)
+			return rproc->sync_ops->find_loaded_rsc_table(rproc,
+								      fw);
+		return NULL;
+	}
+
 	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
 		return rproc->ops->find_loaded_rsc_table(rproc, fw);
 
@@ -127,6 +165,12 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 
 static inline int rproc_start_device(struct rproc *rproc)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->start)
+			return rproc->sync_ops->start(rproc);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->start)
 		return rproc->ops->start(rproc);
 
@@ -135,6 +179,12 @@ static inline int rproc_start_device(struct rproc *rproc)
 
 static inline int rproc_stop_device(struct rproc *rproc)
 {
+	if (rproc_needs_syncing(rproc)) {
+		if (rproc->sync_ops && rproc->sync_ops->stop)
+			return rproc->sync_ops->stop(rproc);
+		return 0;
+	}
+
 	if (rproc->ops && rproc->ops->stop)
 		return rproc->ops->stop(rproc);
 
-- 
2.20.1

