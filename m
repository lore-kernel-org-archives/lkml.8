Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ACEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C2020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoO2jf+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCZHYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:24:25 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40268 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:24:25 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so2044754pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BXK0Ybv0Ff8GRV44Ga8y/XnD49MB5LzE/XQSrDJ7g6w=;
        b=AoO2jf+ly/IQleJvavn+VZ0yGqRVfh12bum+lRwwjNqC/vNbZi9kZMwLPtDWZJMMwt
         TOam4DRXS41FaDdS2te/+K3qoLgPJ2Dq5kIQnXe+EKXsDnPBIFD5Ee0KFwTmNO/NEKrQ
         DF7lWRvIzJoP7Vk0zHs8egRVR18NpKCIBdSOFbHbeMDUJgPd/b52RETuE4PJ+LhZOI1e
         xPwQEvPpkgmmtEVeZ+ES8N8Q4rGD+moIbQt6Bs7UVbKbp0zWXu509wYIZRPuOSUBcDtk
         dWgY6eXh5q04omXxZWqYYBgBGf6jFqskSrrRFxDX6qTtI+JhgfJLxBRTPp5v5uGlT7NF
         KR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BXK0Ybv0Ff8GRV44Ga8y/XnD49MB5LzE/XQSrDJ7g6w=;
        b=llCqIl1RpIIXeZZXVS/1TERv0V1XvCNsLgV9LlYQKYjgvfrMQeuCc3zatW1kIc2HLY
         a+uDHK5hhZvmikE3nyRCAn26uZ8jw4TSe8ehJYdWouU8pvO6wHpX4Xj/+AMH+YDEojDJ
         zEx/JkbUc5rGsN7unyZrtaSHmcqc4xfyag5ExMfiM6zIzi760RVtPllEFtWFiDu1IcHI
         2kr1EDWXbihUPU9Ju34vYHf6nOKTcHQWEKfUxu5xca+DDKFZpwtq+3m/g8l9UeLoG4ij
         KivROuz0+5fErWIygCGihC9aTZ/RqpjZ9sEjAXfJ8ldxpLh2wRXnkAO1wuUl/KPZaDyj
         uHew==
X-Gm-Message-State: ANhLgQ28HH400pZhM46Q7FI8sbvvmAJ+AJeluyrNY4++VMvMk137nKmQ
        wzIKuKGYfqHvgmSD5mBcqGPwTA==
X-Google-Smtp-Source: ADFU+vu9amVchbkjT5S+m8W1vjYWqwtq4hINmq6AlgOhRHSce1HPRv3aBJhG218NrFOQq5rL1blYag==
X-Received: by 2002:a17:90a:757:: with SMTP id s23mr1625288pje.166.1585207463636;
        Thu, 26 Mar 2020 00:24:23 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id e80sm979504pfh.117.2020.03.26.00.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:24:22 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/2] tee: add private login method for kernel clients
Date:   Thu, 26 Mar 2020 12:53:49 +0530
Message-Id: <1585207429-10630-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
References: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use-cases where user-space shouldn't be allowed to communicate
directly with a TEE device which is dedicated to provide a specific
service for a kernel client. So add a private login method for kernel
clients and disallow user-space to open-session using GP implementation
defined login method range: (0x80000000 - 0xFFFFFFFF).

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c   | 6 ++++++
 include/uapi/linux/tee.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 37d22e3..533e7a8 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 			goto out;
 	}
 
+	if (arg.clnt_login & TEE_IOCTL_LOGIN_MASK) {
+		pr_debug("login method not allowed for user-space client\n");
+		rc = -EPERM;
+		goto out;
+	}
+
 	rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
 	if (rc)
 		goto out;
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 6596f3a..19172a2 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -173,6 +173,14 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_LOGIN_APPLICATION		4
 #define TEE_IOCTL_LOGIN_USER_APPLICATION	5
 #define TEE_IOCTL_LOGIN_GROUP_APPLICATION	6
+/*
+ * Disallow user-space to use GP implementation specific login
+ * method range (0x80000000 - 0xFFFFFFFF). This range is rather
+ * being reserved for REE kernel clients or TEE implementation.
+ */
+#define TEE_IOCTL_LOGIN_MASK			0x80000000
+/* Private login method for REE kernel clients */
+#define TEE_IOCTL_LOGIN_REE_KERNEL		0x80000000
 
 /**
  * struct tee_ioctl_param - parameter
-- 
2.7.4

