Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CCE2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KL86JpV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgEOKn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:43:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41492 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589539426; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMoSFxE1HAT004D0LAk6GHlJldx5Vsx+cEoqJH5QPsk=;
        b=KL86JpV/5wViERrHFIJtZYx6A0OwXo6PE0deNJQTcBBgrLX8JjN6rp3GOua5q551GlaP4Y
        v/8iCGzwikaF1CBk52w46rNqyxu61L+ue/u8f+JVKgmcuw4EuFpl691Fj7FP+va38dvESO
        3bVa4ICp5LHxX87iqHn7cQaQ5PhryZY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 2/5] remoteproc: Add device-managed variants of rproc_alloc/rproc_add
Date:   Fri, 15 May 2020 12:43:37 +0200
Message-Id: <20200515104340.10473-2-paul@crapouillou.net>
In-Reply-To: <20200515104340.10473-1-paul@crapouillou.net>
References: <20200515104340.10473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API functions devm_rproc_alloc() and devm_rproc_add(), which behave
like rproc_alloc() and rproc_add() respectively, but register their
respective cleanup function to be called on driver detach.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Notes:
    v3: New patch
    v4: No change
    v5: - Fix return value documentation
    	- Fix typo in documentation
    v6-v7: No change

 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  5 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e12a54e67588..a7f96bc98406 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1949,6 +1949,33 @@ int rproc_add(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_add);
 
+static void devm_rproc_remove(void *rproc)
+{
+	rproc_del(rproc);
+}
+
+/**
+ * devm_rproc_add() - resource managed rproc_add()
+ * @dev: the underlying device
+ * @rproc: the remote processor handle to register
+ *
+ * This function performs like rproc_add() but the registered rproc device will
+ * automatically be removed on driver detach.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+int devm_rproc_add(struct device *dev, struct rproc *rproc)
+{
+	int err;
+
+	err = rproc_add(rproc);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_rproc_remove, rproc);
+}
+EXPORT_SYMBOL(devm_rproc_add);
+
 /**
  * rproc_type_release() - release a remote processor instance
  * @dev: the rproc's device
@@ -2171,6 +2198,46 @@ int rproc_del(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_del);
 
+static void devm_rproc_free(struct device *dev, void *res)
+{
+	rproc_free(*(struct rproc **)res);
+}
+
+/**
+ * devm_rproc_alloc() - resource managed rproc_alloc()
+ * @dev: the underlying device
+ * @name: name of this remote processor
+ * @ops: platform-specific handlers (mainly start/stop)
+ * @firmware: name of firmware file to load, can be NULL
+ * @len: length of private data needed by the rproc driver (in bytes)
+ *
+ * This function performs like rproc_alloc() but the acquired rproc device will
+ * automatically be released on driver detach.
+ *
+ * Returns: new rproc instance, or NULL on failure
+ */
+struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
+			       const struct rproc_ops *ops,
+			       const char *firmware, int len)
+{
+	struct rproc **ptr, *rproc;
+
+	ptr = devres_alloc(devm_rproc_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	rproc = rproc_alloc(dev, name, ops, firmware, len);
+	if (rproc) {
+		*ptr = rproc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return rproc;
+}
+EXPORT_SYMBOL(devm_rproc_alloc);
+
 /**
  * rproc_add_subdev() - add a subdevice to a remoteproc
  * @rproc: rproc handle to add the subdevice to
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c07d7958c53..8c9c0dda03c3 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -599,6 +599,11 @@ int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
 
+struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
+			       const struct rproc_ops *ops,
+			       const char *firmware, int len);
+int devm_rproc_add(struct device *dev, struct rproc *rproc);
+
 void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
 
 struct rproc_mem_entry *
-- 
2.26.2

