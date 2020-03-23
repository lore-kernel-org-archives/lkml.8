Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E52C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0B820788
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4XaIoqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgCWMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:19:33 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54827 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCWMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:19:32 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so6093356pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BXK0Ybv0Ff8GRV44Ga8y/XnD49MB5LzE/XQSrDJ7g6w=;
        b=T4XaIoquLmgIolKBZUeNWCr0X7tdEsoVRLCLeVfHXazTUPXBG9V4KezxwTwei8RdNo
         VwWzmy8xvsNbUu2iizK3TR2Dcrp6xsnwbt3+9GorugC2KExGDshiu+gBbdQku2ta8mTt
         Uys0l3XJicGWlT+GtOk8xgesXsSfmhlX2Sg5cZdwWs9LXeFiNULVSUj8a5lc+tqYWKzs
         VqxI8UBrxYSCTdez2LXkcyYHdmGHr8XMV4oXD3nChQCw61N6ysJANQtLhbjq+SoLBBdj
         GzwxD9OWyjmkKp//j8ljKANTfv9OobDsIYmsjrlN+422x+GssjtVlF00L8ahE7NXMcIt
         zZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BXK0Ybv0Ff8GRV44Ga8y/XnD49MB5LzE/XQSrDJ7g6w=;
        b=AluWe5+c8zbVvG+vBKfU0H4FqcxHRiXYrJgl3XWz/iVvKDkZMBeUJDmyf96Ga2X6Aq
         5M2P+/6F9wp/H1ZYgztA4VT5OPBP9iBNZreJdw7LJv5CLVfRyckhZI48PsepidCOfLiI
         uGHBSTUUkswNyoZ75dg8tawb+6AqWAdTfPhN1AyKF6JO4n1d5vArRKs/iL1U4Ky9Vv0H
         +PofgBqYxtkNcVke61PVO6jCOsCsXTnnX89b3tRZI8JYcHuppaxc4H8yjpwGJpbjoL2J
         ywnlZvTgnCnjtjHz6BILi0y1Qhtw2FYwXRAlnPtigFg1CrDCtV5CeYro6RPCje/XTyPA
         tovQ==
X-Gm-Message-State: ANhLgQ0m//LrzB/a0PdSgMX5yphZKCr0BXh7lwTAyj/BtUG/FACdxtY7
        /hB6aNn5F4kNme0TgJomcFxmjw==
X-Google-Smtp-Source: ADFU+vs2umlBqfyVngD1C0HJfgmg44KkRHeDKfkXqwmtaKD9oVGYuZFMfaQAWZ8NlFG8fAzwDH/qGA==
X-Received: by 2002:a17:90a:628a:: with SMTP id d10mr25512782pjj.25.1584965972018;
        Mon, 23 Mar 2020 05:19:32 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id f15sm2964597pfd.215.2020.03.23.05.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Mar 2020 05:19:31 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/2] tee: add private login method for kernel clients
Date:   Mon, 23 Mar 2020 17:48:30 +0530
Message-Id: <1584965910-19068-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
References: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
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

