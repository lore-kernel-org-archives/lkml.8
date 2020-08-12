Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95355C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6753B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="WMlGWkVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHLMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgHLMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:07:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6116C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:07:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so1788388wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=POFkUl/SiRnZeGnvwK+VIX8MGXoBbpIwuCiT0MLK/Mo=;
        b=WMlGWkVEwgByM+12Cjk2V6iPaXiG9kt3R+yards51xJlxeV5vHR5O3nHEAhKFVAyCr
         Cd4wIgeoptORGygsRDhNDQkd11LYxHBd2AcTFxQ9hUpQilPP1SE6W754vPgH641Yugcy
         2GU7Ae5LAii32G447o/O4680YBnrVeD0xu6Eh0JtACwT4Bh1hdTjlM/kHjuLU2RTrWwj
         aU1Bkg1RQMnvlQyXXHxsPRpMx30yeleylS3EZ3bwJFfoSJAJpCt6vv1eLi5B/0Abk/3D
         VraWahQ5rr4CIrThhAFplxsMJ2OSqIRVDkh8BaOYYeDae8UHd28xcBLaBo4ruwhTKN0j
         4FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=POFkUl/SiRnZeGnvwK+VIX8MGXoBbpIwuCiT0MLK/Mo=;
        b=TduaFV4Kyl5BYA+Bm/b8JRyTMTvK57AiZIhAhDGoPWZAUYUy7IObkPg6NqG08n6Zzp
         JCcJEGaJJqy/kFX3WHn06Q0kpRZM2GRc7B/Yrg+eAw6LiWmeK5NAQUs5QADsTyBwf+9u
         ezNMqwO4w5gbFn+Atf4RosxszqvW6KFBiGI7KzrEkVaoDrmiuA/S5fDqgWloeFTQBPC4
         tC2X9g/34kk/+om/neLtg5PGNnoM3sn6Tkbtvlwx6Zr4Chuhf+aRmaBvsJ1Gfq5+awM8
         QJFiqQ2MJwocsOwjWnwoZRB8eO9r+dQlLCEcnR22TPwVtYa8JL1SFddScQ57LaQ5n4ei
         Y/kA==
X-Gm-Message-State: AOAM53274KA/vA8YbkRZw47N2wKZR6Ej5p2w3jfWEZNb/YG7Vz8XAjfr
        vP8oJDtLJ6yqtTk5iakGFzBWCg==
X-Google-Smtp-Source: ABdhPJz7vAgfxii66jDfQ111kX46HIFNKYyiHLkoDBo408bqtgnvkv6PfOMCNjcKv/bQNZobrcxwzQ==
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr10230369wrf.171.1597234019509;
        Wed, 12 Aug 2020 05:06:59 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id m1sm3511526wmc.28.2020.08.12.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:06:58 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCHv8] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Wed, 12 Aug 2020 14:06:52 +0200
Message-Id: <20200812120652.30012-1-jorge@foundries.io>
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

v8: review fixes
    fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
v7: add support for ten bit i2c slave addressing
v6: compile out if CONFIG_I2C not enabled
v5: alphabetic order of includes
v4: remove unnecessary extra line in optee_msg.h
v3: use from/to msg param to support all types of memory
    modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id

 drivers/tee/optee/optee_msg.h     | 21 +++++++
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/rpc.c           | 96 +++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

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
index b4ade54d1f28..cc9ad4b68d40 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -49,6 +50,98 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
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
+		if (optee_to_msg_param(arg->params, arg->num_params, params)) {
+			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		} else {
+			params[3].u.value.a = ret;
+			arg->ret = TEEC_SUCCESS;
+		}
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
@@ -382,6 +475,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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

