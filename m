Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA498C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F542067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YI3YebB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgAaF21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:28:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37887 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaF20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:28:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so2719379pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 21:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxgxLw1nnPY/CgfeiMFFCg6vQUHvoQpIfG4OaW4fgW0=;
        b=YI3YebB6HSLQ7pebDbgDP1p5gfABhA/3/u87vRsUet2WPvg0mURPloomP/N60o1MzM
         i1cUl0XUJj8QAZfgCCPTbsUg4yEKjt2D+K+v3eW7116tEWMqM6M9jdhSy2qtspzDDzvN
         FdNNajOIhmxHZqDB5u7M85rIYvIHObYGLE2t/RJLZJ2w5+kFwWolxEw2SDjRgaLwFeJ8
         UuNz6qfNrisR+TXS+UooEuMz8HO94pAt8sgO1eR0daK++L98j2TdVjzyEWA/v56YbTOV
         nXrqNG4ZxS7w/oP4iZRBk7wRfMl/8/1ti4jHaIgR8hkZdeOFkKqE7IUpAWRPsr/7FuSB
         C/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxgxLw1nnPY/CgfeiMFFCg6vQUHvoQpIfG4OaW4fgW0=;
        b=EncXUnn5NZDv4GQT+kE2HzVYc5eRxk3P/y48gCBL9CADVo/szS47NNqlT2hIr/ucVe
         u6s4bNVxWGA+YeERj+lbgFbXsya/wRsrsnMs0QtLZzAT4UNc7ek0Mz61M+GKF6nY9dzj
         FJpTNW5sksTiIAdqnqauAjn9GuFdmOfrushK93WHuNyXOgz0rPot53ZtB4H8Kl0IX13J
         BHn1JGtL2Mtwas+E6jRe10AlQsPN2GIbTb/PfnTa9nVeprleMmr/EVMWuszgPNruEw0l
         LnFBrp4XTOyu+Z1TKupxxfuoHk8wwDXpSVFa9k3EkM1mcKJyjEQT8LhgaCC/zcPzKYeR
         CTcQ==
X-Gm-Message-State: APjAAAUvTV4oNsdF5kwSBobLRAbPIQisF3BRN70gO9D5PJaDnBy+n8dJ
        CjQF2Q+6jAsbXI+wTuBwJ6DmHw==
X-Google-Smtp-Source: APXvYqyxrPWuHU5s/+tNr3ypkUHKblSmVAbtWVe7/168BQU+asPnSNYY3ohaGm6un7M6L78u/pBVYw==
X-Received: by 2002:aa7:82ce:: with SMTP id f14mr8901575pfn.167.1580448505501;
        Thu, 30 Jan 2020 21:28:25 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id x197sm8552703pfc.1.2020.01.30.21.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 21:28:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, jassisinghbrar@gmail.com,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/3] firmware: arm_scmi: Move macros and helpers to common.h
Date:   Fri, 31 Jan 2020 10:58:12 +0530
Message-Id: <6615db480370719b0a0241447a5f3feb8eea421f.1580448239.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1580448239.git.viresh.kumar@linaro.org>
References: <cover.1580448239.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move message header specific macros and helper routines to common.h as
they will be used outside of driver.c in a later commit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/firmware/arm_scmi/common.h | 40 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 40 ------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 227934871929..934b5a23f10b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -47,6 +47,19 @@ struct scmi_msg_resp_prot_version {
 	__le16 major_version;
 };
 
+#define MSG_ID_MASK		GENMASK(7, 0)
+#define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
+#define MSG_TYPE_MASK		GENMASK(9, 8)
+#define MSG_XTRACT_TYPE(hdr)	FIELD_GET(MSG_TYPE_MASK, (hdr))
+#define MSG_TYPE_COMMAND	0
+#define MSG_TYPE_DELAYED_RESP	2
+#define MSG_TYPE_NOTIFICATION	3
+#define MSG_PROTOCOL_ID_MASK	GENMASK(17, 10)
+#define MSG_XTRACT_PROT_ID(hdr)	FIELD_GET(MSG_PROTOCOL_ID_MASK, (hdr))
+#define MSG_TOKEN_ID_MASK	GENMASK(27, 18)
+#define MSG_XTRACT_TOKEN(hdr)	FIELD_GET(MSG_TOKEN_ID_MASK, (hdr))
+#define MSG_TOKEN_MAX		(MSG_XTRACT_TOKEN(MSG_TOKEN_ID_MASK) + 1)
+
 /**
  * struct scmi_msg_hdr - Message(Tx/Rx) header
  *
@@ -67,6 +80,33 @@ struct scmi_msg_hdr {
 	bool poll_completion;
 };
 
+/**
+ * pack_scmi_header() - packs and returns 32-bit header
+ *
+ * @hdr: pointer to header containing all the information on message id,
+ *	protocol id and sequence id.
+ *
+ * Return: 32-bit packed message header to be sent to the platform.
+ */
+static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
+{
+	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
+		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
+		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
+}
+
+/**
+ * unpack_scmi_header() - unpacks and records message and protocol id
+ *
+ * @msg_hdr: 32-bit packed message header sent from the platform
+ * @hdr: pointer to header to fetch message and protocol id.
+ */
+static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
+{
+	hdr->id = MSG_XTRACT_ID(msg_hdr);
+	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
+}
+
 /**
  * struct scmi_msg - Message(Tx/Rx) structure
  *
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 978eafb53471..716423063b14 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -32,19 +32,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
-#define MSG_ID_MASK		GENMASK(7, 0)
-#define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
-#define MSG_TYPE_MASK		GENMASK(9, 8)
-#define MSG_XTRACT_TYPE(hdr)	FIELD_GET(MSG_TYPE_MASK, (hdr))
-#define MSG_TYPE_COMMAND	0
-#define MSG_TYPE_DELAYED_RESP	2
-#define MSG_TYPE_NOTIFICATION	3
-#define MSG_PROTOCOL_ID_MASK	GENMASK(17, 10)
-#define MSG_XTRACT_PROT_ID(hdr)	FIELD_GET(MSG_PROTOCOL_ID_MASK, (hdr))
-#define MSG_TOKEN_ID_MASK	GENMASK(27, 18)
-#define MSG_XTRACT_TOKEN(hdr)	FIELD_GET(MSG_TOKEN_ID_MASK, (hdr))
-#define MSG_TOKEN_MAX		(MSG_XTRACT_TOKEN(MSG_TOKEN_ID_MASK) + 1)
-
 enum scmi_error_codes {
 	SCMI_SUCCESS = 0,	/* Success */
 	SCMI_ERR_SUPPORT = -1,	/* Not supported */
@@ -210,33 +197,6 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
 	memcpy_fromio(xfer->rx.buf, mem->msg_payload + 4, xfer->rx.len);
 }
 
-/**
- * pack_scmi_header() - packs and returns 32-bit header
- *
- * @hdr: pointer to header containing all the information on message id,
- *	protocol id and sequence id.
- *
- * Return: 32-bit packed message header to be sent to the platform.
- */
-static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
-{
-	return FIELD_PREP(MSG_ID_MASK, hdr->id) |
-		FIELD_PREP(MSG_TOKEN_ID_MASK, hdr->seq) |
-		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
-}
-
-/**
- * unpack_scmi_header() - unpacks and records message and protocol id
- *
- * @msg_hdr: 32-bit packed message header sent from the platform
- * @hdr: pointer to header to fetch message and protocol id.
- */
-static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
-{
-	hdr->id = MSG_XTRACT_ID(msg_hdr);
-	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
-}
-
 /**
  * scmi_tx_prepare() - mailbox client callback to prepare for the transfer
  *
-- 
2.21.0.rc0.269.g1a574e7a288b

