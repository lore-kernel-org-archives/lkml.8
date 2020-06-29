Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F85206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgH7HjBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbgF2VNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgF2VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:13:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B2C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:13:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so7577483plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sFF8DS0umZeNWR3A7XVhtrJ8Q+yiyanzVjLicQ+JyQ=;
        b=dgH7HjBAGSJvBsOEE9v9R4TD1e1BoBv6nV40psJt2v/1As5vgP62vWuaq8Bw2et23C
         tiqk9xc0o1ne4bZ7eGQ8NCKsJTdDKwxyJAIHyVx89Jqe1xKe2rGXE1R6T6WENXe6QO9V
         x4748h2V5i42cov7xOw9MWB7U6UKN7fcexNmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sFF8DS0umZeNWR3A7XVhtrJ8Q+yiyanzVjLicQ+JyQ=;
        b=bwU+5ACcsWQ8VfI0QF97rXDRKD9BGNrBeBogQQkA/YrKKiRvAOlQTnzsq37tzoYtGs
         IiZNoeh/1yN6lHLmG7+DVC3vqx0+0XU17Uzdmk3mgoJ0cwiDbUfv5rktN36QwMhWwsFD
         nUtIs1tPk9II3LJIUznVnYGEQ93XVSGHmaYXk5UcVMABPehiwldFgx4tiNUxjlXp5HeV
         1cjqkftmBJ368SYXFNdqSpxmm+DB1u93EY4rF1jo4dKNKpKfCsaOTPSo5Rxy74sHeu+F
         6Viv4ETxkPjlRUONlamyLFoRGCG3mJ86q/pMECnc7VesA2KSb2bTXASJX1SDqsls1062
         5tGA==
X-Gm-Message-State: AOAM530dZC/esV2lo40pWx+hx0ld43BAnB6Uq0WSjUdh8gw8HwfN61KO
        lqf0X4Q2w2BaVaA0mQWd6AJrJ4X5N3Y=
X-Google-Smtp-Source: ABdhPJz6hPLTB9yzjpuPFgL14JxzGbpCO7oNhOrdc5pZIC1WTxA5INoGX6eYf9tmV3W5HVJfzHNwEw==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr20513101pjc.117.1593465213098;
        Mon, 29 Jun 2020 14:13:33 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id y19sm508354pfc.135.2020.06.29.14.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:13:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Use workqueue for port update
Date:   Mon, 29 Jun 2020 14:13:27 -0700
Message-Id: <20200629211329.2185342-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a work queue to call the port update routines, instead of doing it
directly in the PD notifier callback. This will prevent other drivers
with PD notifier callbacks from being blocked on the port update routine
completing.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v4:
- Removed extra newline.
- Moved both variable declarations into one line.

Changes in v3:
- Use new 100 character line length limit.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbba..69c4118e280c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,6 +58,7 @@ struct cros_typec_data {
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
+	struct work_struct port_work;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -619,18 +620,24 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
-static int cros_ec_typec_event(struct notifier_block *nb,
-			       unsigned long host_event, void *_notify)
+static void cros_typec_port_work(struct work_struct *work)
 {
-	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
-						     nb);
-	int ret, i;
+	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
+	int i, ret;
 
 	for (i = 0; i < typec->num_ports; i++) {
 		ret = cros_typec_port_update(typec, i);
 		if (ret < 0)
 			dev_warn(typec->dev, "Update failed for port: %d\n", i);
 	}
+}
+
+static int cros_ec_typec_event(struct notifier_block *nb,
+			       unsigned long host_event, void *_notify)
+{
+	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
+
+	schedule_work(&typec->port_work);
 
 	return NOTIFY_OK;
 }
@@ -689,6 +696,12 @@ static int cros_typec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	INIT_WORK(&typec->port_work, cros_typec_port_work);
+
+	/*
+	 * Safe to call port update here, since we haven't registered the
+	 * PD notifier yet.
+	 */
 	for (i = 0; i < typec->num_ports; i++) {
 		ret = cros_typec_port_update(typec, i);
 		if (ret < 0)
-- 
2.27.0.212.ge8ba1cc988-goog

