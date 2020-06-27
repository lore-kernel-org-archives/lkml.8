Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6884C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E1120656
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8Yg4X4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgF0E7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgF0E7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:59:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A1C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:59:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so5054013plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8NKTX8nvqvvpwDNqscc3f+sNP0CS2ggbCM49q8PTvA=;
        b=i8Yg4X4kJ/kFg2eeCj4JxRInDiI7JofmtmH6FfftXww0T06jcYljYGOP9A7lJshnHA
         r6WMDuGe1mnI/3TWhuPKu7iAjXqESroM+lRT7Xb9DbAw7Kfan7qV7stxuDhDRl9kXPYw
         iLNvQIpqJ6mIbVZKm2cFRm8O8NTQzcw/tda+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8NKTX8nvqvvpwDNqscc3f+sNP0CS2ggbCM49q8PTvA=;
        b=T+5OaHv9jAVHc/S+sIv19hTHSGloyCy/EwC+PsJCqwDWZHzTnXs2gsTm6U7+l/S/oH
         EB26HzqgNaL+hvMhTUoonWDNFK5B3keurpU3glIwoth4MLrwoc7s0GcA+saFOe6XNQX8
         GI9cemlfrVnC5HqNdQctq0+yttYSPRuo6HlHFxkyY8w6y7ARoaLlkwsWrfdFVaaMlyZ6
         u2gUBObgdDInyVEg14H1a5JUuG3G/m67jqZ1ywrpxxBAE/ofBtsuvbg1k3Q+cxrg5+kT
         DcVYtqqv9EqiAEEAt2xpn7tG/yOX9LBuQa54/gSrDjflPossquOtdsDaGWL8IhSr358A
         wGUA==
X-Gm-Message-State: AOAM532PGBrUgiCSBxx4sdpYzM0P2O6rNpSCKM5R0hPRmzS8RzH2HZAG
        ma7aLrzya70vv5XfEYTiYzPHnt3Q0Qs=
X-Google-Smtp-Source: ABdhPJyQgE7G3YzL6kt3qNVNlB/2osg2mVqldxnXQoMHOBT5Wd3NQEFdkH6XL2/joNJ8oxBox1OELg==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr6352237pjq.44.1593233941159;
        Fri, 26 Jun 2020 21:59:01 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id a33sm16123185pgl.75.2020.06.26.21.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:59:00 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Add PM support
Date:   Fri, 26 Jun 2020 21:58:41 -0700
Message-Id: <20200627045840.1314019-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200627045840.1314019-1-pmalani@chromium.org>
References: <20200627045840.1314019-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define basic suspend resume functions for cros-ec-typec. On suspend, we
simply ensure that any pending port update work is completed, and on
resume, we re-poll the port state to account for any
changes/disconnections that might have occurred during suspend.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 630170fb2cbe..68f15a47450c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -725,11 +725,45 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int cros_typec_suspend(struct device *dev)
+{
+	struct cros_typec_data *typec = dev_get_drvdata(dev);
+
+	cancel_work_sync(&typec->port_work);
+
+	return 0;
+}
+
+static int cros_typec_resume(struct device *dev)
+{
+	struct cros_typec_data *typec = dev_get_drvdata(dev);
+
+	/* Refresh port state. */
+	schedule_work(&typec->port_work);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cros_typec_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
+};
+
+#define DEV_PM_OPS	(&cros_typec_pm_ops)
+
+#else
+
+#define DEV_PM_OPS	NULL
+
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver cros_typec_driver = {
 	.driver	= {
 		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
 		.of_match_table = of_match_ptr(cros_typec_of_match),
+		.pm = DEV_PM_OPS,
 	},
 	.probe = cros_typec_probe,
 };
-- 
2.27.0.212.ge8ba1cc988-goog

