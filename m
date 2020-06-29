Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369E4206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBAlCwYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbgF2VNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388530AbgF2VNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:13:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE00C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:13:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so3491115pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRy695NNutjkWd1uYy3p92+kIoqtEQ1wqPnA8Qq72ec=;
        b=gBAlCwYaw93vgah5OMWB/EfhiMgXFRXlXLA5HxszvAVQVuyb7Lu0/jFGDRcuFa3u0g
         cWVxou1F6nEGZfj9wME9gAVxff4lAzHJI0TkqoJufX20lHNqlxO8VPxLZ9HgOgv3yO7b
         9SkdYa9TJAaOUa9Jb67tLuGH7qcNIdHc6RF20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRy695NNutjkWd1uYy3p92+kIoqtEQ1wqPnA8Qq72ec=;
        b=joxZpHoOzNcpTjuTu6lyttg8bxtbHuucWi3Rh1MGE0fACmPEzAZLbKFfZKJcTTDcMy
         Cy6DMaWw4yUJyLcKdYBvGc43SA8B7qa2hdMj3ONQ2gNsW7sghUAVHcq5IQdimlVfmG96
         n1zB1OhalTcRYlzz0krVx/EWrn98YPWH0KPbDclNaUgIk4ApzzBd2txhEZ0zPDIXw9fe
         QAXRD4aqHQ7a4QYenHcLTQsmlvOglocZF4zFXGHEed78ePwoVzucmTfXxsG3YcE60YZG
         PEDXcj/uXxbLo35xWuryQxqTFOCbQgkLyx9Qz7ULQ9+w/UdxdAz44Oec6H13VLA0L75l
         N7SQ==
X-Gm-Message-State: AOAM5316LuehR/zOyeTPxHd7ETm0xDz9H7Rt8AWH3Aj5mBJB8+OScPBQ
        3qfyE2aSsIQ7vt0+KVBkEFVmDdVyxLM=
X-Google-Smtp-Source: ABdhPJxS+l3NYCg9wNzlqats8szYRiVB103lQe+sgqzJ43XJlnSjOsoVXDCoxuMA78yx6TwlEy/4Rw==
X-Received: by 2002:a17:90a:338a:: with SMTP id n10mr20386747pjb.50.1593465222835;
        Mon, 29 Jun 2020 14:13:42 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id y19sm508354pfc.135.2020.06.29.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:13:42 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 2/2] platform/chrome: cros_ec_typec: Add PM support
Date:   Mon, 29 Jun 2020 14:13:29 -0700
Message-Id: <20200629211329.2185342-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629211329.2185342-1-pmalani@chromium.org>
References: <20200629211329.2185342-1-pmalani@chromium.org>
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
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4:
- No changes (added Reviewed-by received in v3).

Changes in v3:
- Remove superfluous DEV_PM_OPS #define.

Changes in v2:
- Remove #ifdef-ery, add __maybe_unused tag to functions.

 drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 69c4118e280c..cb95d190f06a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -720,11 +720,35 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused cros_typec_suspend(struct device *dev)
+{
+	struct cros_typec_data *typec = dev_get_drvdata(dev);
+
+	cancel_work_sync(&typec->port_work);
+
+	return 0;
+}
+
+static int __maybe_unused cros_typec_resume(struct device *dev)
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
 static struct platform_driver cros_typec_driver = {
 	.driver	= {
 		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
 		.of_match_table = of_match_ptr(cros_typec_of_match),
+		.pm = &cros_typec_pm_ops,
 	},
 	.probe = cros_typec_probe,
 };
-- 
2.27.0.212.ge8ba1cc988-goog

