Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5631C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A2320756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="O9jcFWmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHKRzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgHKRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:55:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A84C061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:55:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so12287269wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tRnNNG+EOiqKnsOW3JVBYP08XhjCezeVkvW5W8pYVGc=;
        b=O9jcFWmVEfspmlgOb02iR4u1Q7xQgY1Md3YJprx0aU2Q6Hr8UjAYHga8I5V7E7uF6g
         js3ZaCDaoTJ6w3csCcN81SroXwFCsh3GGIdA7d9h1jaGMOzoYVnzpCy+JqJpVqCKO65I
         y2QqZ9zew4ZIrKvRhgIX/ZnOhn8Mslx/bgdG85caTrFnQ1oO2h37CraR71xFZEN70yqX
         nrRGe4rHj2c9AV+KQdV7XqegZrJV+xuMhzRwP018ytjJ76t+ucjD9I9SbP3X+9bR3Qia
         EfzB8ViTxMb+QeD1qRF1OhO4AYJTPKSBa5wgrLXhLDUgmSp6kVEfLv8vj6tQWnNZSGyA
         1h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tRnNNG+EOiqKnsOW3JVBYP08XhjCezeVkvW5W8pYVGc=;
        b=sEzXpTbExg5MdmBEq/rwks3DnYuBqq/Of5S0/2QTYFKaRQOa5A/oVRZ0R2TMMwvO1z
         4GttFVsxT+/8UC0Vs57KhZrsdxzYHKhH2LtkvuDL7Q1XMmw2z4YbwGH7ndOwYD68Rvhv
         vENgPGlExKe4dmrD/+AORBq5VYGRFUNpVu4iGm4AnklEBZ234FyKFRLMMfWNowdAJkkE
         RbLSqvV1e0g57BElD/Qm3tltCYpuPv+FmMMQpC8a0dZLS3Wt+aAbEQ9JjLk7nvLc91qo
         AWhqO3LE/VxWUd5HNuhD7IjgkxKv0XYl46MUbrPWhvuWojRsSceykLFtEdnHjY5yVpju
         Vm5A==
X-Gm-Message-State: AOAM533kLNAF8e7LNU63kcPJTWbY4EyCfWtrlShUzMia3aKUxTw1ja18
        holfjqot0RAkPTlGsOJr7vxbUA==
X-Google-Smtp-Source: ABdhPJwwSsYe5c7AVIdpdHaZ1eeCyhaua3DVghoLp4hfCbr9VUao0DIKHlnBdy3F4sH+HSlsgHGv6Q==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr29905083wrw.322.1597168535403;
        Tue, 11 Aug 2020 10:55:35 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id y203sm6958814wmc.29.2020.08.11.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 10:55:34 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCHv7] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Tue, 11 Aug 2020 19:55:31 +0200
Message-Id: <20200811175531.10771-1-jorge@foundries.io>
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
 v7: add support for ten bit i2c slave addressing
 v6: compile out if CONFIG_I2C not enabled
 v5: alphabetic order of includes
 v4: remove unnecessary extra line in optee_msg.h
 v3: use from/to msg param to support all types of memory
     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
     
 drivers/tee/optee/optee_msg.h | 21 ++++++++
 drivers/tee/optee/rpc.c       | 95 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

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
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index b4ade54d1f28..b6178761d79f 100644
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
+	int i, ret = -EOPNOTSUPP;
+	uint32_t attr[] = {
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
+		if ((params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK)
+		    != attr[i])
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
+		arg->ret = TEEC_SUCCESS;
+
+		if (optee_to_msg_param(arg->params, arg->num_params, params))
+			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
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
+	arg->ret = TEEC_ERROR_COMMUNICATION;
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

