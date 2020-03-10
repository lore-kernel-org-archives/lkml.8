Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27997222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7O49/VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCJRA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:00:59 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42373 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgCJRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:00:58 -0400
Received: by mail-pg1-f201.google.com with SMTP id m29so8951576pgd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=utC88xO/3DQklGM/YS6f9zgx+KbjPZZi5VnmSXETSAc=;
        b=C7O49/VNKptjw/lBpQwmcIz0a8sArXeQ42cXcwYltCRPre0Vtqll5m97ztrXC62a7W
         QUZTB4QvdtN4Bqoiss33Thm/ckIzSGOux1JMfrkRwZr9APo6equSusZ7s6DSNDwT+4cg
         NRVEPHW9sv3KKsX6+VQjMw0yqUw5Ki51pUJg6NvKOcEvW0VFt+5TSfgi6+0FNZPB/bMN
         u9uGqCZ+kLYV4MUdExkun7mKU3qfokzowai0+M3L7hwDVps2X/TDyuTA/+pPy14PLzRY
         EPgAlrIaMlmCSVJNVsvBpU+jNp+H+/aF+RvaII931y/cYa3tr4y15JqSmybv8MMeWauH
         NE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=utC88xO/3DQklGM/YS6f9zgx+KbjPZZi5VnmSXETSAc=;
        b=ddG3XE5N0VmMLGj/d5itXFJotWB6ns9O/j7vDRqNmYgLl1h4izoGsb3hDdDo14VdTX
         dbYdXAteCqK2kGFqv2sJXekjbeHbihlzQqkUWnYQ1yB2C/M2dBR85+mqcaCkXiuDSD44
         zNHhOpO/P4EDZHPp2f0P6658Lirj3eh9Mf0OYZptyFoR0dVfRa/nMel+yCd9DW6x9YmE
         6jBFT5HPDc1VvWjKdUvGu9Kc/TAYiodac3gKodfzFLkPDcoX9p2AgDa41tgBO6xVPnPT
         wG8GnM/e2FiIVts124m53Qx+F9akTqhB27sZE+XJqPtFZcAFhK+ZtqH0jrI2ZRKsKp+i
         jSmg==
X-Gm-Message-State: ANhLgQ2WvnOu5BzFAEclcvHP11Du4+Slw0JGXmYL5PuYYKlmA+hm2qpM
        pFQmMeBD5xWAvbimgJOLQBqjLhMzLAIADg==
X-Google-Smtp-Source: ADFU+vvxgNuaV6N0CUwbmim8in/d79uD6t3S+h+G7BS5M8JDfoSZw2XoErdStzAGhIWo2dEYhjudJLxlOBjruQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr2667641pjp.108.1583859655698;
 Tue, 10 Mar 2020 10:00:55 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:00:38 -0700
Message-Id: <20200310095959.1.I864ded253b57454e732ab5acb1cae5b22c67cfae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: include file and function names in logs
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

Include file and function names in bluetooth kernel logs to
help debugging.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 include/net/bluetooth/bluetooth.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a27732..2024d9c53d687 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -150,10 +150,21 @@ void bt_warn_ratelimited(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
-#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
-#define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
-#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
-#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+static inline const char *basename(const char *path)
+{
+	const char *str = strrchr(path, '/');
+
+	return str ? (str + 1) : path;
+}
+
+#define BT_INFO(fmt, ...)	bt_info("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_WARN(fmt, ...)	bt_warn("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_ERR(fmt, ...)	bt_err("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
+#define BT_DBG(fmt, ...)	pr_debug("%s:%s() " fmt "\n",		\
+				basename(__FILE__), __func__, ##__VA_ARGS__)
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
-- 
2.25.1.481.gfbce0eb801-goog

