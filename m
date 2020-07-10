Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A42C2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1vDPUKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJKSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGJKSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:18:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7BC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:18:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so5835031ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aNlhWaUWCBPVhy661vfoazTLs0ZKDar97UjH0WY+K3c=;
        b=B1vDPUKoKnVTDDpNpciAZgi50kcfqil9mM+SxWS09qJ8zJV6qOL5inFmx3sUNU0h/+
         U+UyqOKwaFWkNqD1h2MrS1cFgKhFz6kGOVg/Kg4O6kBpXyiJF+SM64jgmBTBARbf2gCK
         FFnd0Y+617jScXRsnreCMmbuGkNZ8S253MA6MTZH2G2iy/6YodrxWLXfpyeTqL0YrhY5
         M1b2wGHTdxs56wg6BNgK3/RXNFs2011undw5YV4G1GhKHyWPBqv5JnJV/Q8a/N9Am6mQ
         psyctBEMvtmFwZWTmpelsPgm5C8GOZe9NKxyimfxpNHhPEmcpHqh4RRfVE6KCotHz58a
         YgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aNlhWaUWCBPVhy661vfoazTLs0ZKDar97UjH0WY+K3c=;
        b=qeMs6QaOTkk9BLVAC59BNqLuiDKCrow6uQ680jEI+8H43pL3NGv9zz3dhEnCwyNaJH
         e1y0FrRxVkHlhmCyPYajf+6NcafoBKYhC68AA9RuSxNATGij+anTdCyJ2sj5C1f3Ca5t
         2Cb7QZK6PenMUvA6m3+fnOESIitpUYyAUzXeLyCo9gAvgWTnUZ5xREh5LS3ClvyjTxy1
         SGtG8+OTAdM0CY9kKWTnANKqrimXGJZ9zZj8m5XZF5GYJxVCKIP0WL/WbW0YGH3wrPws
         R68/KZkrefYdR2s2G1bpcWApzl7HgCwOkpS9JhTumdMF/+Ehzq4fum3k5334cr/DTDyx
         mwIA==
X-Gm-Message-State: AOAM531OFyoiXIM+zo9zT7cwqn4VTmDSRy5+T5YTyZ9OSX8VVRnTeRBe
        4nylzpJ6rcMkazlsYyKrWdgn2SwSPYU=
X-Google-Smtp-Source: ABdhPJzkx9TpkYo2DZKCGkBnZL3bjt8a/XUFApAqKawWzy/CRsiVPSvoFzptSDJTMAfRN7OgX5ekaw==
X-Received: by 2002:a2e:b16c:: with SMTP id a12mr38815976ljm.146.1594376315304;
        Fri, 10 Jul 2020 03:18:35 -0700 (PDT)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id w19sm1746753ljh.106.2020.07.10.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:18:34 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Cedric Neveux <cedric.neveux@nxp.com>,
        Michael Whitfield <michael.whitfield@nxp.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] driver: tee: Handle NULL pointer indication from client
Date:   Fri, 10 Jul 2020 12:18:08 +0200
Message-Id: <20200710101808.1316522-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cedric Neveux <cedric.neveux@nxp.com>

TEE Client introduce a new capability "TEE_GEN_CAP_MEMREF_NULL"
to handle the support of the shared memory buffer with a NULL pointer.

This capability depends on TEE Capabilities and driver support.
Driver and TEE exchange capabilities at driver initialization.

Signed-off-by: Michael Whitfield <michael.whitfield@nxp.com>
Signed-off-by: Cedric Neveux <cedric.neveux@nxp.com>
Reviewed-by: Joakim Bech <joakim.bech@linaro.org>
Tested-by: Joakim Bech <joakim.bech@linaro.org> (QEMU)
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c      |  7 +++++
 drivers/tee/optee/optee_smc.h |  3 +++
 drivers/tee/tee_core.c        | 49 ++++++++++++++++++++++-------------
 include/linux/tee_drv.h       |  3 +++
 include/uapi/linux/tee.h      | 13 ++++++++++
 5 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..8ef66e75b65e 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -215,6 +215,8 @@ static void optee_get_version(struct tee_device *teedev,
 
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		v.gen_caps |= TEE_GEN_CAP_REG_MEM;
+	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
+		v.gen_caps |= TEE_GEN_CAP_MEMREF_NULL;
 	*vers = v;
 }
 
@@ -246,6 +248,11 @@ static int optee_open(struct tee_context *ctx)
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 
+	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
+		ctx->cap_memref_null  = true;
+	else
+		ctx->cap_memref_null = false;
+
 	ctx->data = ctxdata;
 	return 0;
 }
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index c72122d9c997..777ad54d4c2c 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -215,6 +215,9 @@ struct optee_smc_get_shm_config_result {
  */
 #define OPTEE_SMC_SEC_CAP_DYNAMIC_SHM		BIT(2)
 
+/* Secure world supports Shared Memory with a NULL buffer reference */
+#define OPTEE_SMC_SEC_CAP_MEMREF_NULL		BIT(4)
+
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
 	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES)
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 64637e09a095..ce0f0309b6ac 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -383,25 +383,38 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
-			 * If we fail to get a pointer to a shared memory
-			 * object (and increase the ref count) from an
-			 * identifier we return an error. All pointers that
-			 * has been added in params have an increased ref
-			 * count. It's the callers responibility to do
-			 * tee_shm_put() on all resolved pointers.
+			 * If a NULL pointer is passed to a TA in the TEE,
+			 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
+			 * indicating a NULL memory reference.
 			 */
-			shm = tee_shm_get_from_id(ctx, ip.c);
-			if (IS_ERR(shm))
-				return PTR_ERR(shm);
-
-			/*
-			 * Ensure offset + size does not overflow offset
-			 * and does not overflow the size of the referred
-			 * shared memory object.
-			 */
-			if ((ip.a + ip.b) < ip.a ||
-			    (ip.a + ip.b) > shm->size) {
-				tee_shm_put(shm);
+			if (ip.c != TEE_MEMREF_NULL) {
+				/*
+				 * If we fail to get a pointer to a shared
+				 * memory object (and increase the ref count)
+				 * from an identifier we return an error. All
+				 * pointers that has been added in params have
+				 * an increased ref count. It's the callers
+				 * responibility to do tee_shm_put() on all
+				 * resolved pointers.
+				 */
+				shm = tee_shm_get_from_id(ctx, ip.c);
+				if (IS_ERR(shm))
+					return PTR_ERR(shm);
+
+				/*
+				 * Ensure offset + size does not overflow
+				 * offset and does not overflow the size of
+				 * the referred shared memory object.
+				 */
+				if ((ip.a + ip.b) < ip.a ||
+				    (ip.a + ip.b) > shm->size) {
+					tee_shm_put(shm);
+					return -EINVAL;
+				}
+			} else if (ctx->cap_memref_null) {
+				/* Pass NULL pointer to OP-TEE */
+				shm = NULL;
+			} else {
 				return -EINVAL;
 			}
 
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index d074302989dd..cdd049a724b1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -47,6 +47,8 @@ struct tee_shm_pool;
  *              and just return with an error code. It is needed for requests
  *              that arises from TEE based kernel drivers that should be
  *              non-blocking in nature.
+ * @cap_memref_null: flag indicating if the TEE Client support shared
+ *                   memory buffer with a NULL pointer.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -54,6 +56,7 @@ struct tee_context {
 	struct kref refcount;
 	bool releasing;
 	bool supp_nowait;
+	bool cap_memref_null;
 };
 
 struct tee_param_memref {
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index b619f37ee03e..d67cadf221fc 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -51,6 +51,9 @@
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */
 #define TEE_GEN_CAP_REG_MEM	(1 << 2)/* Supports registering shared memory */
+#define TEE_GEN_CAP_MEMREF_NULL	(1 << 3)/* NULL MemRef support */
+
+#define TEE_MEMREF_NULL		(__u64)(-1) /* NULL MemRef Buffer */
 
 /*
  * TEE Implementation ID
@@ -200,6 +203,16 @@ struct tee_ioctl_buf_data {
  * a part of a shared memory by specifying an offset (@a) and size (@b) of
  * the object. To supply the entire shared memory object set the offset
  * (@a) to 0 and size (@b) to the previously returned size of the object.
+ *
+ * A client may need to present a NULL pointer in the argument
+ * passed to a trusted application in the TEE.
+ * This is also a requirement in GlobalPlatform Client API v1.0c
+ * (section 3.2.5 memory references), which can be found at
+ * http://www.globalplatform.org/specificationsdevice.asp
+ *
+ * If a NULL pointer is passed to a TA in the TEE, the (@c)
+ * IOCTL parameters value must be set to TEE_MEMREF_NULL indicating a NULL
+ * memory reference.
  */
 struct tee_ioctl_param {
 	__u64 attr;
-- 
2.25.1

