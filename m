Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B8C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456F920857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHNLIcrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgDXUCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgDXUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE3FC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o15so5135900pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KtUuv8wxKYeUMEMfd8cqZZsyE2X/a3TCFtZ9LiwPgw=;
        b=qHNLIcrp17ncZ7tnqZas6mqCu4R32bRGgjFzeM/nXSxBxQxPd4xlqXM/ryo6VRXwvu
         uoA6s1kueOmbPWyJXv5Jw0Cj9Jqa7NDKDTIt1b1eIqlL5uNJ2alrOusFzleBjalPaB/A
         Qnh+jFLQg+3oRD7gv7PNKUlQUMUjwJKPJtnfDYOoohcRhTVPnEhnbu15RO+9zVjYZhxM
         p6Vcb0g1FsQx1JQh1DWNinCWR2ayqPIEs1H4qO+GDcwis+wpM2OIv//7323uCQ8M7X2c
         ijYozKLcfgtb6a+qy9wTOGE2WcVvujOz0HBOicN3e1zrDmZs1reAkEx3Jyp8Zem3I4ZA
         PLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KtUuv8wxKYeUMEMfd8cqZZsyE2X/a3TCFtZ9LiwPgw=;
        b=j9FjH0xc0oaRSv1oBswEFwYR+Tad4WYiLjW41+iqEyAY216TgnZKzS4Z4seWn2TA1R
         CkwnDpGbeWE68c80zXtxHORPXVVUivbBAwEgmCBCtP27A+6A25ZBt4U91bVbMLpeudtd
         Sgg8dU68/M9R8GB/E5BEASaUeu58w06CObZOkS0ouCv1XV2gbrfY3OPHUfIa+F4KsDiN
         t/7ds4v87HZErHcMyQtdOdUFMW0Cpd4ZlANLOg3/2IjwFQ1ITNsAx3KIUq6u7Y88DMdX
         yGjVbyVgPlFgPlFTZ9rV5vonYNibtYwWLQTLBLama48km1hjyhbniC9jepkp/aT/zt7S
         pRoA==
X-Gm-Message-State: AGi0PuafNEM+fsBec2poBt9b3Kj+JDLuSgPZfLam8w7rFuEsvbdbRNUi
        Yoe2wtp7cwVD4nll3ZI8s/saRw==
X-Google-Smtp-Source: APiQypID6xmKC+2YIB8cnOB/Aes9uvT8JmBrhPiyr9CKzPytdnzwMZiL3/8V5pnpJFtOoW6Ey2PGnQ==
X-Received: by 2002:a62:b40e:: with SMTP id h14mr10763306pfn.88.1587758513048;
        Fri, 24 Apr 2020 13:01:53 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:52 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] remoteproc: Introducing function rproc_set_state_machine()
Date:   Fri, 24 Apr 2020 14:01:33 -0600
Message-Id: <20200424200135.28825-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducting function rproc_set_state_machine() to add
operations and a set of flags to use when synchronising with
a remote processor.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c     | 54 ++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h |  6 +++
 include/linux/remoteproc.h               |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 48afa1f80a8f..5c48714e8702 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2065,6 +2065,59 @@ int devm_rproc_add(struct device *dev, struct rproc *rproc)
 }
 EXPORT_SYMBOL(devm_rproc_add);
 
+/**
+ * rproc_set_state_machine() - Set a synchronisation ops and set of flags
+ *			       to use with a remote processor
+ * @rproc:	The remote processor to work with
+ * @sync_ops:	The operations to use when synchronising with a remote
+ *		processor
+ * @sync_flags:	The flags to use when deciding if the remoteproc core
+ *		should be synchronising with a remote processor
+ *
+ * Returns 0 on success, an error code otherwise.
+ */
+int rproc_set_state_machine(struct rproc *rproc,
+			    const struct rproc_ops *sync_ops,
+			    struct rproc_sync_flags sync_flags)
+{
+	if (!rproc || !sync_ops)
+		return -EINVAL;
+
+	/*
+	 * No point in going further if we never have to synchronise with
+	 * the remote processor.
+	 */
+	if (!sync_flags.on_init &&
+	    !sync_flags.after_stop && !sync_flags.after_crash)
+		return 0;
+
+	/*
+	 * Refuse to go further if remoteproc operations have been allocated
+	 * but they will never be used.
+	 */
+	if (rproc->ops && sync_flags.on_init &&
+	    sync_flags.after_stop && sync_flags.after_crash)
+		return -EINVAL;
+
+	/*
+	 * Don't allow users to set this more than once to avoid situations
+	 * where the remote processor can't be recovered.
+	 */
+	if (rproc->sync_ops)
+		return -EINVAL;
+
+	rproc->sync_ops = kmemdup(sync_ops, sizeof(*sync_ops), GFP_KERNEL);
+	if (!rproc->sync_ops)
+		return -ENOMEM;
+
+	rproc->sync_flags = sync_flags;
+	/* Tell the core what to do when initialising */
+	rproc_set_sync_flag(rproc, RPROC_SYNC_STATE_INIT);
+
+	return 0;
+}
+EXPORT_SYMBOL(rproc_set_state_machine);
+
 /**
  * rproc_type_release() - release a remote processor instance
  * @dev: the rproc's device
@@ -2088,6 +2141,7 @@ static void rproc_type_release(struct device *dev)
 	kfree_const(rproc->firmware);
 	kfree_const(rproc->name);
 	kfree(rproc->ops);
+	kfree(rproc->sync_ops);
 	kfree(rproc);
 }
 
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 7dcc0a26892b..c1a293a37c78 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -27,6 +27,8 @@ struct rproc_debug_trace {
 /*
  * enum rproc_sync_states - remote processsor sync states
  *
+ * @RPROC_SYNC_STATE_INIT	state to use when the remoteproc core
+ *				is initialising.
  * @RPROC_SYNC_STATE_SHUTDOWN	state to use after the remoteproc core
  *				has shutdown (rproc_shutdown()) the
  *				remote processor.
@@ -39,6 +41,7 @@ struct rproc_debug_trace {
  * operation to use.
  */
 enum rproc_sync_states {
+	RPROC_SYNC_STATE_INIT,
 	RPROC_SYNC_STATE_SHUTDOWN,
 	RPROC_SYNC_STATE_CRASHED,
 };
@@ -47,6 +50,9 @@ static inline void rproc_set_sync_flag(struct rproc *rproc,
 				       enum rproc_sync_states state)
 {
 	switch (state) {
+	case RPROC_SYNC_STATE_INIT:
+		rproc->sync_with_rproc = rproc->sync_flags.on_init;
+		break;
 	case RPROC_SYNC_STATE_SHUTDOWN:
 		rproc->sync_with_rproc = rproc->sync_flags.after_stop;
 		break;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ceb3b2bba824..a75ed92b3de6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -619,6 +619,9 @@ struct rproc *rproc_get_by_child(struct device *dev);
 struct rproc *rproc_alloc(struct device *dev, const char *name,
 			  const struct rproc_ops *ops,
 			  const char *firmware, int len);
+int rproc_set_state_machine(struct rproc *rproc,
+			    const struct rproc_ops *sync_ops,
+			    struct rproc_sync_flags sync_flags);
 void rproc_put(struct rproc *rproc);
 int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
-- 
2.20.1

