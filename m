Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74EC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749FC24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZR+41xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgCJNXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41681 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgCJNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14so2195804wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nL9Xh/WeV27boRWOFkfWejN3qF1VL9pfmFG/uXGr0Pg=;
        b=XZR+41xbtTqx5nATriE4XULQuOtBeRmdMVKMetUUk+8XuxONjqPqfsv9ChbiuegRnj
         OpDiZ56RoMnV9I8dhRYr4jkdkOkIqFwQCmxzVzXvuPM8Jd6vLAlVr+c1hyQbwI47bzf9
         B0EMHWCnmDBxOMhev0YT5Ouaj3yswImOI2YHTUOIP5OuPFHDbHgtWbCDLfk/i+3W9StX
         vOlp1sYJIynbnYn39mNbeLCPawUOuQmrYtY/bej7K6WD1NCzriz0k1daiMmW3WoB3ck1
         psoOF5qTXkblhIn8jVmH/1MN9IXlBs1xc+cHqW8Jr38Q02TZsOjUqfQeeBxhzhd7zBST
         hrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL9Xh/WeV27boRWOFkfWejN3qF1VL9pfmFG/uXGr0Pg=;
        b=Lv6NVNg0qR5WuKZXB66bkiww4wmc4K5dPVAf/7eN6jHhCmYJ+60zj18cEr/QzHK1l2
         PYeIqrI+ez9PgYHU4VWRPGxNBS7B5GE283mI0wT89omZULv3zoPOXpPRzQSdkg1bJEEH
         n7PUP76EzfgxRLk5BcOv7QPpE8M/BnjJkTbXUOV1YgwklGISRys6u6rxk5ciVTS1kqPJ
         46mhjX5orR3jLaZEIXNPde3MmI1xVyPAb46FJqJwg8oRh6Kd5ZpHAfSGSTYH4UuUiIf2
         jhBC0IJg8RZG1C3i2/HcwyIp2hF4YG7ujyHRG7gM7w5GZEksOnCrMk/kzucu5z/vdq1u
         7uUA==
X-Gm-Message-State: ANhLgQ29srFThU+L+WTGGZ8pF6cB9CUebWzFWOE/Dj1+GBq5AuJu/mrO
        p0e2aEGQeLZT4FVuke2pPteN3A==
X-Google-Smtp-Source: ADFU+vs5ZjtCqdDGIqV18VT66l9Lfoxq4k/7/RHz7BPg/ippDal3YzREkfrEQL2XWtESqmSmIJYx9A==
X-Received: by 2002:a5d:604f:: with SMTP id j15mr23696590wrt.35.1583846611127;
        Tue, 10 Mar 2020 06:23:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/14] nvmem: imx: ocotp: add i.MX8MP support
Date:   Tue, 10 Mar 2020 13:22:44 +0000
Message-Id: <20200310132257.23358-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP has 96 banks with each bank 4 words. And it has different
ctrl register layout, so add new macros for that.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 4ba9cc8f76df..794858093086 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -44,6 +44,11 @@
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
 
+#define IMX_OCOTP_BM_CTRL_ADDR_8MP		0x000001FF
+#define IMX_OCOTP_BM_CTRL_BUSY_8MP		0x00000200
+#define IMX_OCOTP_BM_CTRL_ERROR_8MP		0x00000400
+#define IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP	0x00000800
+
 #define IMX_OCOTP_BM_CTRL_DEFAULT				\
 	{							\
 		.bm_addr = IMX_OCOTP_BM_CTRL_ADDR,		\
@@ -52,6 +57,14 @@
 		.bm_rel_shadows = IMX_OCOTP_BM_CTRL_REL_SHADOWS,\
 	}
 
+#define IMX_OCOTP_BM_CTRL_8MP					\
+	{							\
+		.bm_addr = IMX_OCOTP_BM_CTRL_ADDR_8MP,		\
+		.bm_busy = IMX_OCOTP_BM_CTRL_BUSY_8MP,		\
+		.bm_error = IMX_OCOTP_BM_CTRL_ERROR_8MP,	\
+		.bm_rel_shadows = IMX_OCOTP_BM_CTRL_REL_SHADOWS_8MP,\
+	}
+
 #define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
 #define TIMING_STROBE_READ_NS		37	/* Min time before read */
 #define TIMING_RELAX_NS			17
@@ -520,6 +533,13 @@ static const struct ocotp_params imx8mn_params = {
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
+static const struct ocotp_params imx8mp_params = {
+	.nregs = 384,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_8MP,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  .data = &imx6q_params },
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
@@ -532,6 +552,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx8mq-ocotp", .data = &imx8mq_params },
 	{ .compatible = "fsl,imx8mm-ocotp", .data = &imx8mm_params },
 	{ .compatible = "fsl,imx8mn-ocotp", .data = &imx8mn_params },
+	{ .compatible = "fsl,imx8mp-ocotp", .data = &imx8mp_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.21.0

