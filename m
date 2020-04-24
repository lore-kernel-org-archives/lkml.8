Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462AEC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F64C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSxZwEFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgDXUCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgDXUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AE8C09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so4135078plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSQAs1pyeXSdHFfEklHiIPoOPEI9zHd+d7BuRSs6Od0=;
        b=eSxZwEFfKnuIM0S/KHiUNpAB3J8WWlQRENNwDJ3lqJc/7J33wR1YPhhk53Pp6qnaxE
         /v2zf/xJXZIfyukH+kyvCiHWsu7QqW9DLaWPrizPuEeKbWJsm4MyMEikpEeOTUC/N8ze
         ChYX37s65pO9fY/CiXSTPAPGy7qPgIv+Gravd8fWDxZ9NnbRetZF0zdQdoZ3aL18D7SQ
         yq9uYf0q4upNgi6GQziPpQ7BL34H2YIvrdxKcMP8lzKv1M1IQ+2gGPxhK7pAzXFxv8Om
         UGtzjl0KknzzrE2wNmg55XjvePichK/mfGiVNygI0me1yuTh47CJkbldpxLTDkZfV8Dw
         sjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSQAs1pyeXSdHFfEklHiIPoOPEI9zHd+d7BuRSs6Od0=;
        b=naMtIST1TPbhHNHoqnqWWj63741S3CXW/vHERzvmcyIGlo5XEbq65suq/XTj69YVPE
         2dw0qCowtm+wbbt0cCeSu9IENoUExTQBQA6gbIpsQJldmUsDNdANr4PU/smVvVt9ZS/A
         jhWXGaOkOrL5Pu5nH8BBgLaOkgiiKYorZO/hn3ct6g3wRo5DfhqlX51DwSbYIn5mGeC3
         4yhpP1bDsO6UvSYxV15WQn9Uy80n00q5BDH71r/XaYzbF0BlMKJLy4PcoODOE2FbvI3+
         wskNtpQzOO0cSgL45/GXveOcmrqE1ebEFep7ucXIs0OsECUe7IQCCmpu/Mjb5zpsSa0t
         4Yqw==
X-Gm-Message-State: AGi0PuYhiCzmUoJkRmgm51ShlyPT6DLla2+xoA3bF6hRMSAt5IcwdaWb
        ovW1Co3ESFvzOfIjUprDwjnkkA==
X-Google-Smtp-Source: APiQypKc2PEovjUbAPLQNBF63e7xg2Xir211PVAlvWUrPr2CEuv5H4vtH+D1u1ORnTvWTNYECb8U8Q==
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr8196049pjw.175.1587758501177;
        Fri, 24 Apr 2020 13:01:41 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] remoteproc: Add new operation and flags for synchronistation
Date:   Fri, 24 Apr 2020 14:01:24 -0600
Message-Id: <20200424200135.28825-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sync_ops to support use cases where the remoteproc
core is synchronising with the remote processor.  Exactly when to use
the synchronisation operations is directed by the flags in structure
rproc_sync_flags.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/remoteproc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ac4082f12e8b..ceb3b2bba824 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -353,6 +353,23 @@ enum rsc_handling_status {
 	RSC_IGNORED	= 1,
 };
 
+/**
+ * struct rproc_sync_flags - platform specific flags indicating which
+ *			      rproc_ops to use at specific times during
+ *			      the rproc lifecycle.
+ * @on_init: true if synchronising with the remote processor at
+ *	     initialisation time
+ * @after_stop: true if synchronising with the remote processor after it was
+ *		stopped from the cmmand line
+ * @after_crash: true if synchronising with the remote processor after
+ *		 it has crashed
+ */
+struct rproc_sync_flags {
+	bool on_init;
+	bool after_stop;
+	bool after_crash;
+};
+
 /**
  * struct rproc_ops - platform-specific device handlers
  * @start:	power on the device and boot it
@@ -459,6 +476,9 @@ struct rproc_dump_segment {
  * @firmware: name of firmware file to be loaded
  * @priv: private data which belongs to the platform-specific rproc module
  * @ops: platform-specific start/stop rproc handlers
+ * @sync_ops: platform-specific start/stop rproc handlers when
+ *	      synchronising with a remote processor.
+ * @sync_flags: Determine the rproc_ops to choose in specific states.
  * @dev: virtual device for refcounting and common remoteproc behavior
  * @power: refcount of users who need this rproc powered up
  * @state: state of the device
@@ -482,6 +502,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @sync_with_rproc: true if currently synchronising with the rproc
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  */
@@ -492,6 +513,8 @@ struct rproc {
 	const char *firmware;
 	void *priv;
 	struct rproc_ops *ops;
+	struct rproc_ops *sync_ops;
+	struct rproc_sync_flags sync_flags;
 	struct device dev;
 	atomic_t power;
 	unsigned int state;
@@ -515,6 +538,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool sync_with_rproc;
 	struct list_head dump_segments;
 	int nb_vdev;
 	u8 elf_class;
-- 
2.20.1

