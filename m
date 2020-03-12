Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNDXdnQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCLKJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:09:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42344 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:09:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so2661552pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zvlb+FvFd6kbdQoEVk7MAktkpupjBY4PDAWlePBUw3c=;
        b=dNDXdnQ1qE/HwYnjjnnNZoYKZirtiihAIwEltN5ws+SuQJeaZ4WwWdCnwJlJXWPnZs
         yp2xQGpOUXLrcMiXLv77Tkpd8SecEzsHPauCoo8nnuTGhOUxomINnpxpwGB4F4ZkntrH
         4fLuvwfZMyYBjFomHT71QuGRLK1Aou0EyXviQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zvlb+FvFd6kbdQoEVk7MAktkpupjBY4PDAWlePBUw3c=;
        b=ZVhz0AhXFnb9lsi4hx/xR8dacTEspy11IkGD47PNNhm37/6PSDPGojGZV1NaSxRXJj
         tiEqUAM196/6XlEAqfwTNA5oVbKm3BPWsjDSMMJCdvu90L6uxUjGZcSKs4Ih//m9hVuz
         546wrDAV3uAKuOVPiXKwfQH6tfFo3EO8zV2dFjAhKQZ/RYHsRFjZ1hGYVFfrtp5rcEXE
         k6sZPoCQUMGpemI905A+xuWU6zmYlMO8nooPOFDjUbTq5hBaIg/glrrQ9w61wdSQyLEM
         kP14X+BYo5lLSIzpWy8hS9zzdU0UAWQSWuxg9+S2iO2t9rIIRM+tcaR1inLbrj5Ocw47
         g4eQ==
X-Gm-Message-State: ANhLgQ2/NgpeGVNW0P4/hHvkc1QVdwlQrDqJLWvQ9IswsEzciul9nfgf
        2T1ym+J8uffiv5gbjpOFGFoTZmlFMR0=
X-Google-Smtp-Source: ADFU+vuGimrwiNkaxPmq90ULYN/QKiQzv6pgizkpAIcIX2eHZlxddsPV/aB43OuxX8qcPuzTz95khg==
X-Received: by 2002:a62:17d1:: with SMTP id 200mr7151259pfx.227.1584007771016;
        Thu, 12 Mar 2020 03:09:31 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s19sm3678368pfh.218.2020.03.12.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:09:30 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/3] platform/chrome: notify: Pull PD_HOST_EVENT status
Date:   Thu, 12 Mar 2020 03:08:11 -0700
Message-Id: <20200312100809.21153-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200312100809.21153-1-pmalani@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the PD host even status from the EC and send that to the notifier
listeners, for more fine-grained event information.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 87 ++++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index d2dbf7017e29c..3d9db4146217e 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -53,11 +53,91 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
 
+/**
+ * cros_ec_pd_command - Send a command to the EC.
+ *
+ * @ec_dev: EC device
+ * @command: EC command
+ * @outdata: EC command output data
+ * @outsize: Size of outdata
+ * @indata: EC command input data
+ * @insize: Size of indata
+ *
+ * Return: 0 on success, < 0 on failure.
+ */
+static int cros_ec_pd_command(struct cros_ec_device *ec_dev,
+			      int command,
+			      uint8_t *outdata,
+			      int outsize,
+			      uint8_t *indata,
+			      int insize)
+{
+	int ret;
+	struct cros_ec_command *msg;
+
+	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
+	if (!msg)
+		return -EC_RES_ERROR;
+
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outsize)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret < 0)
+		goto error;
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+	ret = EC_RES_SUCCESS;
+error:
+	kfree(msg);
+	return ret;
+}
+
+static void cros_usbpd_get_event_and_notify(struct device  *dev,
+					    struct cros_ec_device *ec_dev)
+{
+	struct ec_response_host_event_status host_event_status;
+	u32 event = 0;
+	int ret;
+
+	/*
+	 * We still send a 0 event out to older devices which don't
+	 * have the updated device heirarchy.
+	 */
+	if (!ec_dev) {
+		dev_dbg(dev,
+			"EC device inaccessible; sending 0 event status.\n");
+		goto send_notify;
+	}
+
+	/* Check for PD host events on EC. */
+	ret = cros_ec_pd_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
+				 NULL, 0,
+				 (uint8_t *)&host_event_status,
+				 sizeof(host_event_status));
+	if (ret < 0) {
+		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
+		goto send_notify;
+	}
+
+	event = host_event_status.status;
+
+send_notify:
+	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+}
+
 #ifdef CONFIG_ACPI
 
 static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
 {
-	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+	struct cros_usbpd_notify_data *pdnotify = data;
+
+	cros_usbpd_get_event_and_notify(pdnotify->dev, pdnotify->ec);
 }
 
 static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
@@ -144,6 +224,8 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 				  unsigned long queued_during_suspend,
 				  void *data)
 {
+	struct cros_usbpd_notify_data *pdnotify = container_of(nb,
+			struct cros_usbpd_notify_data, nb);
 	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
 	u32 host_event = cros_ec_get_host_event(ec_dev);
 
@@ -151,8 +233,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 		return NOTIFY_BAD;
 
 	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
-					     host_event, NULL);
+		cros_usbpd_get_event_and_notify(pdnotify->dev, ec_dev);
 		return NOTIFY_OK;
 	}
 	return NOTIFY_DONE;
-- 
2.25.1.696.g5e7596f4ac-goog

