Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A682071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="1FfGlNl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgGVVVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:21:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1075C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:21:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so3323099wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RQ5EqUygspbnIShpkO6on2zzEAPxkgSj/dTotJ3WQQY=;
        b=1FfGlNl2FJ+MFxdOWkLcBC4eZNznbhFaRr/lU2r0GOYLIDhO8IxJfRVf/LYZWwPzIU
         Uvo0x8mH85vOFmu6dNazveYW/iSvLcAXW5ZTf+Hld57Arf/mgjB6UFhrbZ9lzzrdshNV
         GarqDA1XscxSyH3zp+3pMnkqsAYj8IeeJSYJyXVwBM8DOZR7QRl5VOCgB5UiP3IHCc4M
         rXb7+JY+yq/yKgLyP6SMmFtFCFsxDJngb9M7wtnskk44ncyohbEPDwmtxP/T7oSIBpqZ
         dtlun+YjvUkuAjXy39NKHcKsltozO8g96nYbVhnYrfX0moRgOS+wdM3q1euH8EI1HL08
         JYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQ5EqUygspbnIShpkO6on2zzEAPxkgSj/dTotJ3WQQY=;
        b=bSKkg3+ChBOZYBq5xnqw9QRrzsBK6iwYBLBRn/0QgDntGuMdsgIx4+XHx2NCnBSm7A
         ttbUEqoZhjlnlkWwCzXO8r6fgDE0cGtMVXBipuWIpOyk82stzIQ5naq9GlXyaVAmLYAu
         JplhNvobLiGnynhB4WhqW6AsmbleFSMUj4MCD36QtuoL1kP44aOalir47Hn8sYVEMPyy
         Nhcvvog9TgRsJxlulGM2aEOkvCmGt/cs6Wd06fSe6/nbpbpLoYEZ2sXmlDWGs4Wsaqnr
         lRTg1aR84/ixVtRxxTkhKvRZDDx+KRKMGYmwY7w6ckDMIKUjU71DHsFvrQMjgmucP0+f
         P8Bg==
X-Gm-Message-State: AOAM533hYGYGKtKZakd9yIFI9apobmFcxmxfVfxCi90opQ5L9O98GD9b
        pvqcm4J2cWVQzAJmV1atXlahThQ3wTs=
X-Google-Smtp-Source: ABdhPJyXCsZcy/QKlTnWnXKw6ZA9pdE0KdQq7iZD876JgXIdVco3K8ZGkjz84r7OaF21YFBeXa/uLw==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr1350566wmi.161.1595452870500;
        Wed, 22 Jul 2020 14:21:10 -0700 (PDT)
Received: from localhost.localdomain (126.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.126])
        by smtp.gmail.com with ESMTPSA id a11sm1346507wrq.0.2020.07.22.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:21:10 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org,
        sumit.garg@linaro.org
Cc:     ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv6] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Wed, 22 Jul 2020 23:21:05 +0200
Message-Id: <20200722212105.1798-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
control this type of cryptographic devices it needs coordinated access
to the bus, so collisions and RUNTIME_PM dont get in the way.

This trampoline driver allow OP-TEE to access them.
Tested on imx8mm LPDDR4

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 v6: compile out if CONFIG_I2C not enabled
 v5: alphabetic order of includes
 v4: remove unnecessary extra line in optee_msg.h
 v3: use from/to msg param to support all types of memory
     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
     
 drivers/tee/optee/optee_msg.h | 16 +++++++
 drivers/tee/optee/rpc.c       | 88 +++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

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
index b4ade54d1f28..5fd5c6c93896 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -49,6 +50,90 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
+#if IS_ENABLED(CONFIG_I2C)
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
@@ -382,6 +467,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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

