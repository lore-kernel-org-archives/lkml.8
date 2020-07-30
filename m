Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6852620672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfvJup6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgG3Jyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgG3Jyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:54:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A8C0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:54:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so5632253wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUdOHKBSFKpTj40WJgkPwcDzGagUihc/mu7zxNsYZ+k=;
        b=LfvJup6ovWiwAucvKZVQFk1CwI7buQN2T1r+dQ6oB6Y9OXRHdh2ia0LkWSZQm/HJGy
         28edLScXxl/nFAygtX+andMgAEDNdZzl294AwcOdk34IoozNgT+1XTlfbcQHE0bTO1g5
         6cmQV+vZo2eVuUx7lvUZ4zb9qHJvS/iMBf0ymbLFujgr46o9drobClO/VtKP6dnUFQ4w
         NnFIiKiXFJos9qfmi3OBbIROMi63tzS99nhh8SbMx7+I0J14pFLognQoy/3wpSlVjvAF
         mxHn5t0oEEAd9LDh6237j12wSQeZ0yvmlaJZ31q8hftrRcvypvmNNDv+Tq/SlsG0YXG2
         L2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUdOHKBSFKpTj40WJgkPwcDzGagUihc/mu7zxNsYZ+k=;
        b=dgpqCceSgjhByDKMFuw/B3SmN/vm3u4sTKdh2txy8Rj4vPE6gXrD3pKdk+ps1zs0L5
         NFUpDMJiYjoVax3K9+fWgk3QoWDZQf6D1m9+FLH34P+DayLudwPLAOUzyYeBtrWJjbc4
         tzhEWT3LVGyIjQ3RzOKa6N016PbC0058C33rHNUcKM3/d+/uyS010uc7AeCg+b4wy9eV
         WinLpihG1nQuf3+mUswMsYE5ixinDs7P0KsT6Ri1BIhK/Josp+b09I/h0F/v9vA3yZ8R
         etyq3n92PhdkVZIqlyTOTmKlG/F8BG6QqQ0GR3ZzytQdbJnADwsSa/YjQKDBWL+wlEuP
         e/bQ==
X-Gm-Message-State: AOAM532f3aaEYMNI8aS99r5TjiEx4JuEQwns6mYwLYcuemTRPI3QgE8a
        WpPKINHctJXwjpmIh2eDu2dCSjGmql3L+w==
X-Google-Smtp-Source: ABdhPJxl+zAauMo/NwX8D0vz10uVpUP3IZ/MMYh5A3LnBT6RWGbY47iRI70Rr003qXL238CNARVaXw==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr13612609wmi.180.1596102872621;
        Thu, 30 Jul 2020 02:54:32 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id u1sm10623139wrb.78.2020.07.30.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:54:32 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     jim.cromie@gmail.com, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 2/3] venus: Add a debugfs file for SSR trigger
Date:   Thu, 30 Jul 2020 12:53:49 +0300
Message-Id: <20200730095350.13925-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
References: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSR (SubSystem Restart) is used to simulate an error on FW
side of Venus. We support following type of triggers - fatal error,
div by zero and watchdog IRQ.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/dbgfs.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
index 782d54ac1b8f..f95b7b1febe5 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.c
+++ b/drivers/media/platform/qcom/venus/dbgfs.c
@@ -9,10 +9,40 @@
 
 extern int venus_fw_debug;
 
+static int trigger_ssr_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t trigger_ssr_write(struct file *filp, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct venus_core *core = filp->private_data;
+	u32 ssr_type;
+	int ret;
+
+	ret = kstrtou32_from_user(buf, count, 4, &ssr_type);
+	if (ret)
+		return ret;
+
+	ret = hfi_core_trigger_ssr(core, ssr_type);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations ssr_fops = {
+	.open = trigger_ssr_open,
+	.write = trigger_ssr_write,
+};
+
 void venus_dbgfs_init(struct venus_core *core)
 {
 	core->root = debugfs_create_dir("venus", NULL);
 	debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
+	debugfs_create_file("trigger_ssr", 0200, core->root, core, &ssr_fops);
 }
 
 void venus_dbgfs_deinit(struct venus_core *core)
-- 
2.17.1

