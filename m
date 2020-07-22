Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE64EC433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C99E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="V9iKhNrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbgGVTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732647AbgGVTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:19:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:19:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so2980964wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2EIBszTzyv/AfyhPfuCemZqatYVBUAPBlZr4NfJGxfU=;
        b=V9iKhNrR2kb/bKZjFyD/LsNBZM007bp0nAQTEnzJfU1Qd6DHFLG0zbKlc/0G32RuOd
         l7OueXPFFx81C+FPgvaXcuSq6OeGTU5R5xlmwfj9SRwtkU53JpCjV4pPZBwsUiYYveYH
         yl/kaUL3zPSyghUMu7H02RV5Mw+lD9UtgUI8Q+VJ9UQJjLDk46Ma19iVCIfWxLVyGdmJ
         ZFv0mPbfpsnBeICG9JgCUsjWwmfCxmcLkyKC/fJ4U0h+i47hWFW3VBGZpymUJRkPalvu
         u3mhRQNSq7nbitzVqEv0bEbw9zLvkQeLm4Wr9OexhBIGXYS68+j5crDR4h1KaVORkpzk
         h7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2EIBszTzyv/AfyhPfuCemZqatYVBUAPBlZr4NfJGxfU=;
        b=kGm9kZqU0duww7ONHjPHJZ8RKs2BwTz1Pd/O7IcwLE0tprX5XUmMRYQYWL4cH+nLCg
         5SxGBwuDPSznfWf4BiAI15oEGxmjAr3pQ10cqXMKEyPafEsTirwReiTYYOcP+boeTkyN
         VhcQF3sYvahJo8OeRKq33n69O4suN4emsVabVIsPmpUneZsnqEOus02ZAj8FlqaGFQca
         wOVBGYUuscel0xUHVkinPBgIlaHPUoHRtG2JrXvlyZv1LEMZqaS7DQJ08nd14c9iYbbu
         xKtlw9rH+qYHpOmDR7zG/yyySJQLxIUaZEFJ6U+lfphsNKt1ykG7K0DzakFI94dhHQf8
         w+lA==
X-Gm-Message-State: AOAM531LVsNvq1SIQD1cRpbcAZcIm1tEIXYsmqefJyMT49BQ3lPo8lPn
        0jyBFT7wxO6ErsONDtLr2OSo4g==
X-Google-Smtp-Source: ABdhPJzVSzxp+nOgsuQpcv3GywMo830t1O68SbsZon5tHTziAr565LFeRX8mDBnnsLJyOgDVKr9mAQ==
X-Received: by 2002:adf:db86:: with SMTP id u6mr908211wri.27.1595445589526;
        Wed, 22 Jul 2020 12:19:49 -0700 (PDT)
Received: from localhost.localdomain (126.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.126])
        by smtp.gmail.com with ESMTPSA id n189sm671825wmf.38.2020.07.22.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:19:49 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org,
        sumit.garg@linaro.org
Cc:     ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv5] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Wed, 22 Jul 2020 21:19:45 +0200
Message-Id: <20200722191945.15157-1-jorge@foundries.io>
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
 v5: arrange includes alphabetically 
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
index b4ade54d1f28..df6250418235 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
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

