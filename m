Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 20:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9381F206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="FMseir3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgEaUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 16:38:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E37DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 13:38:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so9434276wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MSKw81CIpKDKe7tsT76tgn8J45GJOF2TLEjgKAxPZKc=;
        b=FMseir3ZK0UIn+xVtTzg/GxDHQOeEpJcAQPgNZcn1+ZyzcyXvnY7+lALskmfbwGORz
         cZhbMyb2Nsa7eq9GekBy1Hp8Fv+BQWAN9Aen6sPDnIlriKd5BVcAxwazbKdNo6qXnvNP
         DueCcrGxV5VH1Mqo0Jdz2YG1QtqVcoowJX1ac49CzqOhqcPLZ9GsxtPc8NmS7IUn+rml
         lybCCu2VNd9vdi+fs3G5y0DfWD5SmWHyWUvPiMEg0p/FC+x8K9eTsAmEES5Hi4aGTArr
         aIK5Mw054RkO1gzDBDzcZJZRCLBlTdgsSp/LN4LHy/TmkIHw3AWqFmmSXZXwy+dG37A8
         HtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MSKw81CIpKDKe7tsT76tgn8J45GJOF2TLEjgKAxPZKc=;
        b=fG7rtYq+SixophNKfvGwXySKb40nbi5ViZPiajeIRfvUudFAVOvrxYpVGfADZNILdw
         1m8NMRkwrT0uz/I1CtJ+bRaJm/uq9uniTBZ3jtmOL3g8OHPfWlX58zwF341is/+mxjhN
         BTvBBQ27E12Vwn2QGDMAC8C3fY3VXDefrFDvgRFW5gOPSSezJxrLn2HhNId11OveqCv6
         Rcl/Z/F0HAxEvcg641sRkBuGHRz/Lk8bZ3eEcfOQRPK1Bfe/8vWEexHnCveyVg/78iMt
         j6ehLX1LHNviJYSyb3ddS2f6G+jxEtm86UpqyDZxuapFz1slB1Uj+Pqla6GrRsMGuisZ
         yRoA==
X-Gm-Message-State: AOAM533LRpFRJEmLJ7XbhZ0mqAzaft1xsANJWmsuB/XTFWXt+JsCFQxo
        1NeRDAFDwIGpCYRI7psX166wLyzRQdg=
X-Google-Smtp-Source: ABdhPJwe22TySJsoyA+COVe3oKresfsze9otgYUs6d1W99OMNmFRwtImo9HaP+I0wSxD+QG+fctvOw==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr20136595wrv.392.1590957493042;
        Sun, 31 May 2020 13:38:13 -0700 (PDT)
Received: from localhost.localdomain (108.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.108])
        by smtp.gmail.com with ESMTPSA id y25sm9786613wmi.2.2020.05.31.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 13:38:12 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        ricardo@foundries.io, mike@foundries.io
Subject: [PATCH] drivers: optee: allow op-tee to access devices on the i2c bus
Date:   Sun, 31 May 2020 22:38:09 +0200
Message-Id: <20200531203809.3397-1-jorge@foundries.io>
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
 drivers/tee/optee/rpc.c       | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

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
index b4ade54d1f28..6c8457ac2524 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/i2c.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 
@@ -48,6 +49,58 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
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
@@ -382,6 +435,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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

