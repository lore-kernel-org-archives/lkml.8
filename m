Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D07C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE9320716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="OSYeQ7af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHNLMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHNLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:12:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E2C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:12:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so7974240wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Vah3G7jvBPWVbyLXF3jUk7TcJwAqgRq5AxTkl2+el5M=;
        b=OSYeQ7affWIhfBWL2BS/FCZPq2YBcui/Q+WtD3BuiU47gcpT42JhDuaOosHeSUuuMf
         bI6sU4wSJ2frCd6sjXqGYj3EgM8YZDxalKvVtdFwHJQ5g25r9rISJ3H5Eqed+ro5tqCW
         6hS/tyBng0oER6zF4u5FGC56BLBB5cajBessl3aobSSUWeh6srJiZwRz9Npx+J+juPgo
         qpD4NnunWZ8SDUHavkHzD//ayHNOQXq2UvpDQK5blGGw77iDsqcTb2jgIdzSVVtsjtQu
         N5eWXCmTKNAHmzk8X9Wr4iSWu6YtgrLpQ8wu9jXq0siU4puBikFdaL6PE0OG9wz6SmkO
         YEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vah3G7jvBPWVbyLXF3jUk7TcJwAqgRq5AxTkl2+el5M=;
        b=H7NAZskmH4zV+b+6piZFKlljfGi15l4udMd9bYO4dwlBJ/YCRUCcX/ZxUItq7l6gvc
         aoZvOPG1E/HsFGEgB1UIRLype2XwwSoCcAUt1d08Ohg0sLXW2pJG3FsWPuLz7Rx1jvVh
         IGp/7Om/fXrqovIHAncHrACNtM1jBnYfHqYMCbKkZ6rQaQzQrH7RzhCzMc1DAu+29Tcx
         YqnFHJUtsdeAj4LpQa/2joMFsCRHjnFLOtmJ3unzcuwg1kNwEYuFYlOUdiy4Lmme0IXD
         cf1w3CKiDCmjw2thnm2fAPOf6MuvBqEdrXafVfwLXqd3wlNJ7Z2wbtSAGIuYSbV2PDY8
         uvTg==
X-Gm-Message-State: AOAM5304NrcOdd2pbl+di7ZTHv+WWI+J8K8d4vNax4b/Bio9mZPYyCza
        l9+OQoHpgW8sAIbEd2iOCbvvyQ==
X-Google-Smtp-Source: ABdhPJws7eBSeCgczGoa+F6YxIEyJqe1FHMvqAKslOJV11/FbE6O/yTiXsuVQzfZR1tmwkz3E+Jf+Q==
X-Received: by 2002:a5d:5641:: with SMTP id j1mr2289709wrw.399.1597403549000;
        Fri, 14 Aug 2020 04:12:29 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id y84sm14905528wmg.38.2020.08.14.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:12:28 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCHv9] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Fri, 14 Aug 2020 13:12:21 +0200
Message-Id: <20200814111221.5813-1-jorge@foundries.io>
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
v9: params return value must be written before optee_msg_to_param is called
v8: review fixes:
    fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
v7: add support for ten bit i2c slave addressing
v6: compile out if CONFIG_I2C not enabled
v5: alphabetic order of includes
v4: remove unnecessary extra line in optee_msg.h
v3: use from/to msg param to support all types of memory
    modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id

 drivers/tee/optee/optee_msg.h     | 21 +++++++
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 795bc19ae17a..7b2d919da2ac 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -419,4 +419,25 @@ struct optee_msg_arg {
  */
 #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
 
+/*
+ * Access a device on an i2c bus
+ *
+ * [in]  param[0].u.value.a		mode: RD(0), WR(1)
+ * [in]  param[0].u.value.b		i2c adapter
+ * [in]  param[0].u.value.c		i2c chip
+ *
+ * [in]  param[1].u.value.a		i2c control flags
+ *
+ * [in/out] memref[2]			buffer to exchange the transfer data
+ *					with the secure world
+ *
+ * [out]  param[3].u.value.a		bytes transferred by the driver
+ */
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
+/* I2C master transfer modes */
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
+/* I2C master control flags */
+#define OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT  BIT(0)
+
 #endif /* _OPTEE_MSG_H */
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 8b71839a357e..564116d6cc58 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -17,6 +17,7 @@
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_NOT_SUPPORTED        0xFFFF000A
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
 #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index b4ade54d1f28..64a206c56264 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -49,6 +50,97 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
+#if IS_ENABLED(CONFIG_I2C)
+static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
+					     struct optee_msg_arg *arg)
+{
+	struct i2c_client client = { 0 };
+	struct tee_param *params;
+	size_t i;
+	int ret = -EOPNOTSUPP;
+	u8 attr[] = {
+		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
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
+		if (params[i].attr != attr[i])
+			goto bad;
+	}
+
+	client.adapter = i2c_get_adapter(params[0].u.value.b);
+	if (!client.adapter)
+		goto bad;
+
+	if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
+		if (!i2c_check_functionality(client.adapter,
+					     I2C_FUNC_10BIT_ADDR)) {
+			i2c_put_adapter(client.adapter);
+			goto bad;
+		}
+
+		client.flags = I2C_CLIENT_TEN;
+	}
+
+	client.addr = params[0].u.value.c;
+	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
+
+	switch (params[0].u.value.a) {
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
+		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
+				      params[2].u.memref.size);
+		break;
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
+		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
+				      params[2].u.memref.size);
+		break;
+	default:
+		i2c_put_adapter(client.adapter);
+		goto bad;
+	}
+
+	if (ret < 0) {
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		params[3].u.value.a = ret;
+		if (optee_to_msg_param(arg->params, arg->num_params, params))
+			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		else
+			arg->ret = TEEC_SUCCESS;
+	}
+
+	i2c_put_adapter(client.adapter);
+	kfree(params);
+	return;
+bad:
+	kfree(params);
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+#else
+static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
+					     struct optee_msg_arg *arg)
+{
+	arg->ret = TEEC_ERROR_NOT_SUPPORTED;
+}
+#endif
+
 static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
 {
 	struct wq_entry *w;
@@ -382,6 +474,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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

