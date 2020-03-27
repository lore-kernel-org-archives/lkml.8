Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA890206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihk9c3GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgC0FaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:30:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37453 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0FaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:30:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id a32so4059253pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GOQaQ2h+32fiJ9szn4v3ZPPg49Y/vAyId4H3BGQp9gM=;
        b=ihk9c3GW+fxEKI8IgrvVDNz8oNBduO0uPV3CFwlLAqj2CsGZX6kOJ2o8dfiEEDLmmS
         wW1kvXotSbjs4abgvpxCZaNBG17yTAEdvzGWa4D3E6W53+CEmSzto1o8JG6ztLSP58o/
         PZbq4kbayZeCPQWJUDZGfgD5NsHvg32gndsDI1TiOHq7PqL2m9uZpzMtskQSVwPdgq3G
         r+n/y2xNU6aC3ywsOSu7BAFfXjrd+hp6D8XKYecjbvfrhH79T7SjNyy7wbVsQZYI4oD4
         k94T6qHRU+szAQ2iClFthd00LF2AZbh6yvKkg69uKF6IouqM0ilBSt+/8pTqtR1nNnjZ
         gIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GOQaQ2h+32fiJ9szn4v3ZPPg49Y/vAyId4H3BGQp9gM=;
        b=cuBnc/t0e+5ZFwrKqqSdLt+j/xU55YWhbZQSVSo3MxTdGq1X95kllPknaH0eCFF+Ug
         jdZ+gYmKyHFpx6XD6X+4U4yio+hFf/Ijz75cEtsi7sbmCMqXxxVdW4fey6luItoxNLf1
         2KrVKvEMRc7Jt8aT5pBC+WXSSl0Q9tsSeUzRtziVYMk9fTNNq+ASimJdxEsdxaAz5EZU
         lf0zSyeftZ2nJF4yygXDL1QfoQzKw4uL16TK2P26xeseSr4cGAWuSplMv+TVyqJHo61B
         EqtQl3eYMA3GwZ0nCM2sTyeEt/NjI9sKtz6aXMnFRO8luRewEve4Q73adc/y28+/nraC
         VXUg==
X-Gm-Message-State: ANhLgQ0FTb95EAUEiHhmfiaZQValK94ZKorD3Cnj4wbx9YanRskXxWME
        DcfLTFjeIzh4A6+CQYaxKHUFrQ==
X-Google-Smtp-Source: ADFU+vsl89wR63kL1f1mu5vILE6+4zYYGgY3VT/v+esMNuek76WFMEoHu/NpEUZzP0Yn2ImYyS/zaQ==
X-Received: by 2002:a62:648f:: with SMTP id y137mr13245109pfb.199.1585287016034;
        Thu, 26 Mar 2020 22:30:16 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id l5sm3003637pgt.10.2020.03.26.22.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 22:30:15 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        jerome@forissier.org, stuart.yoder@arm.com,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 2/2] tee: add private login method for kernel clients
Date:   Fri, 27 Mar 2020 10:59:48 +0530
Message-Id: <1585286988-10671-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
References: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use-cases where user-space shouldn't be allowed to communicate
directly with a TEE device which is dedicated to provide a specific
service for a kernel client. So add a private login method for kernel
clients and disallow user-space to open-session using GP implementation
defined login method range: (0x80000000 - 0xBFFFFFFF).

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c   | 7 +++++++
 include/uapi/linux/tee.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 37d22e3..13a016e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,6 +334,13 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 			goto out;
 	}
 
+	if (arg.clnt_login >= TEE_IOCTL_LOGIN_REE_KERNEL_MIN &&
+	    arg.clnt_login <= TEE_IOCTL_LOGIN_REE_KERNEL_MAX) {
+		pr_debug("login method not allowed for user-space client\n");
+		rc = -EPERM;
+		goto out;
+	}
+
 	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
 	if (rc)
 		goto out;
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 6596f3a..b619f37 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -173,6 +173,15 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_LOGIN_APPLICATION		4
 #define TEE_IOCTL_LOGIN_USER_APPLICATION	5
 #define TEE_IOCTL_LOGIN_GROUP_APPLICATION	6
+/*
+ * Disallow user-space to use GP implementation specific login
+ * method range (0x80000000 - 0xBFFFFFFF). This range is rather
+ * being reserved for REE kernel clients or TEE implementation.
+ */
+#define TEE_IOCTL_LOGIN_REE_KERNEL_MIN		0x80000000
+#define TEE_IOCTL_LOGIN_REE_KERNEL_MAX		0xBFFFFFFF
+/* Private login method for REE kernel clients */
+#define TEE_IOCTL_LOGIN_REE_KERNEL		0x80000000
 
 /**
  * struct tee_ioctl_param - parameter
-- 
2.7.4

