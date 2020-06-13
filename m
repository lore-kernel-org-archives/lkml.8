Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4022078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhMh8QdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFMWjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgFMWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:39:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50792C08C5C6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:39:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so13591054ejd.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUdOHKBSFKpTj40WJgkPwcDzGagUihc/mu7zxNsYZ+k=;
        b=OhMh8QdAKsM/LD7FzRgfTPN/VXAc/bfcsd/Jg+yegVvqkiw0ZQQ1ZFUpO1z6Zg3f3c
         3umiBiw5vRmNhJvxwIv2BRS0N6QIiCUm2YkZMvE4edfNg/wTRNBGQ93PnmylKJTlouGd
         2G4q2igvurJXoQLCJNFkq1onnfm80LAH68015hanO/XNpStK/wI7ro/50FJCncYabfzE
         br3OOrcsNlw+g075/h01a9KB12j2L7sQameavQ1HCT4M6rF4/XhSlB9LgjBo0SESuPiw
         /PvzHHSDjvc2E3cMDocR2Nsl9PGw+veeI72B2UYxioKOz0PfNaJ9DK1OwLr38YvMV92A
         CiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUdOHKBSFKpTj40WJgkPwcDzGagUihc/mu7zxNsYZ+k=;
        b=hCSEIstEQN4kp+4ORffbpAn2PAyWX+fZHtsY3gwj9aNCqVsjA8F1OXRLYtOYl+V9Bs
         fuH43Q9z55Mg0NOsLSFz2tfmmRGYMpWA1X7E8+G/yaRTQxOsCihY9m5cyUMmhsnucXST
         oxeGoiETvKU44xbnJQaZBjErmkz6BF59p2XgrSrKDFm6CMPXgpJsz7wFGcLzi/AdEvgQ
         jtu1+jxmdM5n26rOy6pQi/tlT6aMuq5o4aGtKuWTx/9ejYlypkrS65a3wWMZIp3tDRB0
         uEJMZRR3g0aU5Pg1AyMC6BZMVQvd8DMXStVSb2MFn76+JEglt1lvLuDRrmi4ouVvTdUc
         uLSw==
X-Gm-Message-State: AOAM532Hp7vaNZtnVcpJsbUO2QIkRMUVK0XU1VscTIhqqTfOi2gDoMsJ
        eRkDs25kQVeN2fyj0bD5yQ1JdQDvl9PByw==
X-Google-Smtp-Source: ABdhPJzxj8C/3hik/vFIz1gDDlvyUI4ojVSG5W2uxMyvgh/o8BwnQmqSRtEzHERwF/L+vXseZu70oQ==
X-Received: by 2002:a17:906:6d3:: with SMTP id v19mr6626238ejb.306.1592087980907;
        Sat, 13 Jun 2020 15:39:40 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.gmail.com with ESMTPSA id u3sm5581606edx.25.2020.06.13.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 15:39:40 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 3/3] venus: Add a debugfs file for SSR trigger
Date:   Sun, 14 Jun 2020 01:39:19 +0300
Message-Id: <20200613223919.7038-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200613223919.7038-1-stanimir.varbanov@linaro.org>
References: <20200613223919.7038-1-stanimir.varbanov@linaro.org>
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

