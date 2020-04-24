Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162B3C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E533220857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nt/55U5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgDXUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgDXUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DEC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so4306655pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WYYSWCoYertzlXmUk0igZ0mJKKLhDAn/b6CFJphVPg=;
        b=nt/55U5NI5dfKt9QvTQuHK0Y7/cYI4ooo/5w+CzvNdl9Z8saBzFkI/mr2tSG4RP3rQ
         pLWXLnh5BcW7YgVEE21CJeNsqmhb/8snQDpxuWsxxHqdm6fgDtTRK8VEanYY38SFcHLx
         +gcESSvV8mDPrpHO/B1S7ldXHkUrvHZtGRdRRw6qc8w0ynfU5T/DBhddEsHAOwfp6VAr
         O18fBTcY5nQOWanAv08pgL7f4s0TEs9nPch30CZ7MLNtqDCAvhv50psfcR2gkv+waNPM
         MCugBIa+HbthMXOflJQ1UX1if3A/VCIfOIWoFxtnQy8TvjPsuVNLDpO3YSACMMcKgsxE
         aDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WYYSWCoYertzlXmUk0igZ0mJKKLhDAn/b6CFJphVPg=;
        b=OWx7TJILVjQsWD6KAWYhjiysqlmjyGdH8hZvIlxw55ABSBEQWJv4sjzCG1e9WC+E+w
         NvitWByosw7THljFwYir89aQDXDMu8B6kSWWIPXqZww/2dYH5jed9Q7B71suFZVSEC/I
         KhtdzTNKDc7sZYAa6GjRrmuTomcbUVqpiNZ/PzwLBOhIm++MJbR7zyKFywCJ9TK7ua2M
         gAZDymTON85NafCexHlHFrKnOTOgBxZ85eUk6bATI6PKGmSv6/gmUFUbirk2N6AF63Oy
         zeCJSI12cVyrtdWU9ruQ/DEZzApHS4pxBEYtO1d4DpPCBsG/x/92RHSKXMCuWkCZSwOa
         zX5w==
X-Gm-Message-State: AGi0PuZgkl/2TBaXzk09s4joILK4z8fhJpQQJxmk5/zJ6jRKDBrNcV/g
        pBSLTwdzk2PY0fnyGpwUJuFANQ==
X-Google-Smtp-Source: APiQypIYhJnlilq+7BARS7IBMXCokCWqUiSZO2Lahmi5Xxyd4HmRHz5pBYNr1rXum+k7aGV77bK9Ww==
X-Received: by 2002:a17:90a:498a:: with SMTP id d10mr8507309pjh.194.1587758498612;
        Fri, 24 Apr 2020 13:01:38 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] remoteproc: Make core operations optional
Date:   Fri, 24 Apr 2020 14:01:22 -0600
Message-Id: <20200424200135.28825-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synchronizing with a remote processor, it is entirely possible that
the remoteproc core is not the life cycle manager.  In such a case core
operations don't exist and should not be called.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_internal.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index b389dc79da81..59fc871743c7 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -67,7 +67,7 @@ rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
-	if (rproc->ops->sanity_check)
+	if (rproc->ops && rproc->ops->sanity_check)
 		return rproc->ops->sanity_check(rproc, fw);
 
 	return 0;
@@ -76,7 +76,7 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 static inline
 u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 {
-	if (rproc->ops->get_boot_addr)
+	if (rproc->ops && rproc->ops->get_boot_addr)
 		return rproc->ops->get_boot_addr(rproc, fw);
 
 	return 0;
@@ -85,7 +85,7 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 static inline
 int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
 {
-	if (rproc->ops->load)
+	if (rproc->ops && rproc->ops->load)
 		return rproc->ops->load(rproc, fw);
 
 	return -EINVAL;
@@ -93,7 +93,7 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
 
 static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
-	if (rproc->ops->parse_fw)
+	if (rproc->ops && rproc->ops->parse_fw)
 		return rproc->ops->parse_fw(rproc, fw);
 
 	return 0;
@@ -103,7 +103,7 @@ static inline
 int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
 		     int avail)
 {
-	if (rproc->ops->handle_rsc)
+	if (rproc->ops && rproc->ops->handle_rsc)
 		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
 					      avail);
 
@@ -114,7 +114,7 @@ static inline
 struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 						   const struct firmware *fw)
 {
-	if (rproc->ops->find_loaded_rsc_table)
+	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
 		return rproc->ops->find_loaded_rsc_table(rproc, fw);
 
 	return NULL;
-- 
2.20.1

