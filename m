Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44AA20729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="JEBrXhHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgGVKYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:24:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1470C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:24:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so1377027wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2lBizFgvpBGZiH+LmbmGEwasxXVr1f56Z8RiFArAcvE=;
        b=JEBrXhHx4TayexsutA5GAcFIyWM6TfVzxFT8MKTLJ3YLvrf1ZjNcUWSy3+yp9DbpH9
         zDTyy62Uv6/b4zI/Jeg/xJlmeFJ+w1LKviUru/HE4oT6dAMHrXhcpfGLxu9wkAGl1BO5
         eZ54t/QSzI5Pz2It9RQLaQmsvjA/xaHPbxPuKjS+TUxHIA0BJIlbSP2lIHaYnwsj+lZw
         R6f6z1RN8a7260FhYzrab86cRrUwyEeCEozFLX6NBOia5QgJUGrMtvM8+b0xidJvMFow
         jBSbFkKZDhZc/scKFbvSwJJ1Ne6121svMmtkMaB3vfqAbDFPVQ4vfCD6HraG8rHNKzFN
         lDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2lBizFgvpBGZiH+LmbmGEwasxXVr1f56Z8RiFArAcvE=;
        b=ODNuMc/6Kqm/A1wSUpch0xhqYPBZEflZOgohdhONjEQD1nWAS9kEz0rMJpUP5eNc1E
         q0rG7imOyFG5YX7RNbZvWS/6yKCSelq1PRwMAjALCYlVBYb8Uhstc2GL+k5GtZdcS2t4
         FMs2EYm6SWDIkqrSOGs8CH/RyXqlq4zwugb3BlHwOhfICRKa1Hv7fzqCH4xgvteH3Nd5
         /vBp5CRxn7bgINmPTLu3ZqHzY7b5OvbNjCWuOaz9BuOgiTWEwQc+XiliwIdT2XyDSGCJ
         aKvMO6sGfftBN/QZ/OaZQ8HJS8qCcv87QR594KnFS2kcAwxb9p0V0PMRacUQSx+pla5a
         oBLg==
X-Gm-Message-State: AOAM533pHk+vjq389UVAMlHE2oGv+DOw41TyfFhaUUcFxh1QKXH8Wvaf
        2SplS4p6oJGrizseNNaBW4n+XurK3dY=
X-Google-Smtp-Source: ABdhPJzakX09Iql+Qkat5XWJ8BK5ohbl0Xxtpo4IlfUpekD8ppg+2C5bJbFrVKu0JCDdJFSNY6Yl+g==
X-Received: by 2002:adf:f248:: with SMTP id b8mr18278898wrp.247.1595413445513;
        Wed, 22 Jul 2020 03:24:05 -0700 (PDT)
Received: from localhost.localdomain (126.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.126])
        by smtp.gmail.com with ESMTPSA id e8sm39812096wrp.26.2020.07.22.03.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:24:04 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org,
        sumit.garg@linaro.org
Cc:     ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv4] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Wed, 22 Jul 2020 12:24:00 +0200
Message-Id: <20200722102400.5370-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
control this type of cryptographic devices it needs coordinated access
to the bus, so collisions and RUNTIME_PM dont get in the way.

This trampoline driver allow OP-TEE to access them.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 v4: removed unecessary extra line in optee_msg.h
 v3: use from/to msg param to support all types of memory
     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER id

 drivers/tee/optee/optee_msg.h | 16 +++++++
 drivers/tee/optee/rpc.c       | 80 +++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 795bc19ae17a..14b580f55356 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -419,4 +419,20 @@ struct optee_msg_arg {
  */
 #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
 
+/*
+ * Access a device on an i2c bus
+ *
+ * [in]  param[0].u.value.a		mode: RD(0), WR(1)
+ * [in]  param[0].u.value.b		i2c adapter
+ * [in]  param[0].u.value.c		i2c chip
+ *
+ * [in/out] memref[1]			buffer to exchange the transfer data
+ *					with the secure world
+ *
+ * [out]  param[0].u.value.a		bytes transferred by the driver
+ */
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
+
 #endif /* _OPTEE_MSG_H */
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index b4ade54d1f28..2b2939c538f0 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/i2c.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 
@@ -49,6 +50,82 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
+static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
+					     struct optee_msg_arg *arg)
+{
+	struct i2c_client client;
+	struct tee_param *params;
+	uint32_t type;
+	int i, ret;
+	size_t len;
+	char *buf;
+	uint32_t attr[] = {
+		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
+		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT,
+	};
+
+	if (arg->num_params != ARRAY_SIZE(attr)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	params = kmalloc_array(arg->num_params, sizeof(struct tee_param),
+			       GFP_KERNEL);
+	if (!params) {
+		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	if (optee_from_msg_param(params, arg->num_params, arg->params))
+		goto bad;
+
+	for (i = 0; i < arg->num_params; i++) {
+		type = params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK;
+		if (type != attr[i])
+			goto bad;
+	}
+
+	client.addr = params[0].u.value.c;
+	client.adapter = i2c_get_adapter(params[0].u.value.b);
+	if (!client.adapter)
+		goto bad;
+
+	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
+
+	buf = params[1].u.memref.shm->kaddr;
+	len = params[1].u.memref.size;
+
+	switch (params[0].u.value.a) {
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
+		ret = i2c_master_recv(&client, buf, len);
+		break;
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
+		ret = i2c_master_send(&client, buf, len);
+		break;
+	default:
+		i2c_put_adapter(client.adapter);
+		goto bad;
+	}
+
+	if (ret >= 0) {
+		params[2].u.value.a = ret;
+		arg->ret = TEEC_SUCCESS;
+	} else {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+	}
+
+	if (optee_to_msg_param(arg->params, arg->num_params, params))
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+
+	i2c_put_adapter(client.adapter);
+	kfree(params);
+	return;
+bad:
+	kfree(params);
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
 static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
 {
 	struct wq_entry *w;
@@ -382,6 +459,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
 	case OPTEE_MSG_RPC_CMD_SHM_FREE:
 		handle_rpc_func_cmd_shm_free(ctx, arg);
 		break;
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
+		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
+		break;
 	default:
 		handle_rpc_supp_cmd(ctx, arg);
 	}
-- 
2.17.1

