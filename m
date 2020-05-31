Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69729C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5DB20707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="e0NU98U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEaXLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgEaXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:11:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D21C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 16:11:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so9676442wrv.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8HYqyHOxjN4Nup1GjMKGmfT9jPZpf5PtQ+Cg+oD267o=;
        b=e0NU98U9YquA/QzL6UpPiczODl19Rie3PpB6ztd9+TK0w/U+tqcWUy9ycQQUWDzn9i
         vXhcAzNpQSevyrgqGvKJwdCTHXp1t6/wdZ/6wNwRjyYYQJ9mrepwKp5MoYFaefAcVjK5
         XiXDU8vRo5Lojt6Bx2jdpdt/yShtRzzlIr/6vAl7oy1SyjHyWzBUt0D+ygqTE69Z23Hf
         K6kyfD/mby7T58tRJ2B0Z5fYJHby9OV0Pi0LVuMzffNd8bBIVmqtjECY/44zf/UdCBIr
         ypuq/w5mxD533ZkHQ6XPYp9YYx09Z40e2c3qSyfkshZESjT6YHMJ4KU4AA9iPCLIlaBU
         4CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8HYqyHOxjN4Nup1GjMKGmfT9jPZpf5PtQ+Cg+oD267o=;
        b=rg1/mindbWL3/383bpMLx7pyVQ+6EjmyArZe1s9bJz5ppU1gdbCBvbdCocoDCkaif5
         kEWSQcYRFs9D5y2NiglNimaCPpKqUNi1lCRi0sGz88RRDP9txfkcpB0GssbpjSh5+3zI
         4T/jT8ECLQHn6YLqkbhswQQPMdCOr1WpkfSPreeCQJ/QTTYJ0dleiYu4+PLJF8a97QFJ
         RgOL9zlUM026HCyCz4F2gJTYt/uMJYUnHxnDsZxL3byZM+F+lbfVF6TPq7Fd8r+TLAc1
         Zb2g7X1OLzWzGZpCjFlqvu6VlI7hkjBfABGSr6FfWekZLb3Vcte1wIIyNeXjbBhK43LF
         wI1Q==
X-Gm-Message-State: AOAM5301+pKeJawU6RugeFxpuEM/WdvkBuGPDTvOt6jqP6nlflLvZLri
        Ltww3hOIQ2iTStFKGi4R0JdEmw==
X-Google-Smtp-Source: ABdhPJyCyZ0QBAB8PWCi2LwcJy4yuZ0aOYlibvTdZksSdP4GN6qK/IT1GGOmN80HWUhkJlgCiF85EQ==
X-Received: by 2002:adf:e648:: with SMTP id b8mr19790350wrn.386.1590966699375;
        Sun, 31 May 2020 16:11:39 -0700 (PDT)
Received: from localhost.localdomain (108.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.108])
        by smtp.gmail.com with ESMTPSA id o8sm9159845wmb.20.2020.05.31.16.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 16:11:38 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        ricardo@foundries.io, mike@foundries.io
Subject: [PATCH v2] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Mon,  1 Jun 2020 01:11:35 +0200
Message-Id: <20200531231135.12670-1-jorge@foundries.io>
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
 drivers/tee/optee/optee_msg.h | 18 +++++++++++
 drivers/tee/optee/rpc.c       | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 795bc19ae17a..b6cc964fdeea 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -419,4 +419,22 @@ struct optee_msg_arg {
  */
 #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
 
+/*
+ * Access a device on an i2c bus
+ *
+ * [in]  param[0].u.value.a		mode: RD(0), WR(1)
+ * [in]  param[0].u.value.b		i2c adapter
+ * [in]  param[0].u.value.c		i2c chip
+ *
+ * [io]  param[1].u.tmem.buf_ptr	physical address
+ * [io]  param[1].u.tmem.size		transfer size in bytes
+ * [io]  param[1].u.tmem.shm_ref	shared memory reference
+ *
+ * [out]  param[0].u.value.a		bytes transferred
+ *
+ */
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 8
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
+#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
+
 #endif /* _OPTEE_MSG_H */
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index b4ade54d1f28..21d452805c6f 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/i2c.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 
@@ -48,6 +49,59 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 bad:
 	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
+static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
+					     struct optee_msg_arg *arg)
+{
+	struct i2c_client client;
+	struct tee_shm *shm;
+	int i, ret;
+	char *buf;
+	uint32_t attr[] = {
+		OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
+		OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
+		OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
+	};
+
+	if (arg->num_params != ARRAY_SIZE(attr))
+		goto bad;
+
+	for (i = 0; i < ARRAY_SIZE(attr); i++)
+		if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
+			goto bad;
+
+	shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
+	buf = (char *)shm->kaddr;
+
+	client.addr = arg->params[0].u.value.c;
+	client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
+	if (!client.adapter)
+		goto bad;
+
+	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
+
+	switch (arg->params[0].u.value.a) {
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
+		ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
+		break;
+	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
+		ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
+		break;
+	default:
+		i2c_put_adapter(client.adapter);
+		goto bad;
+	}
+
+	if (ret >= 0) {
+		arg->params[2].u.value.a = ret;
+		arg->ret = TEEC_SUCCESS;
+	} else
+		arg->ret = TEEC_ERROR_COMMUNICATION;
+
+	i2c_put_adapter(client.adapter);
+	return;
+bad:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
 
 static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
 {
@@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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

