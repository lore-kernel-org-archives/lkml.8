Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF52C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFBC20724
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iU+T52/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgCPI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:29:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:29:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so9329629pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJTNnQMVnN5ncpWAOlzehz8dsdNEt0BVgmpsICUkc+E=;
        b=iU+T52/D1cDGl2VhHjSH/+5Xhqv+kPxQajLHOpTZTw4uFM/z9/9q9Hn110Pi3FKc3J
         xwz7bcsiqUjARLtUrkHIDz7LXy1kI82ZDPxUx00U42yIcq1xct3qt+py3qPUlSPFX5qt
         mgXH2kTk+ji7Qp3zE4giAAnBPJtmwQV6MbgMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJTNnQMVnN5ncpWAOlzehz8dsdNEt0BVgmpsICUkc+E=;
        b=jpy3CNpQgOeNv14kuxbzVweG0u8zXslm9JGXbXQmVHgfk4FGLnE4GqfGpScvkT+T5n
         A56l1ESQNsx4Dhm8ZobcEDAlKuiPn3w1yrE34scaHHroOWE4juu5n4paQXCZcJP9/wCJ
         /uS0UL3OpPcpNlqO5C/qriLuTbHbVHwyuuJc/ZdISUl62feN9BvkfpcYMMKzBn6CtJXu
         ipuHoxxX6/dLBJJ+DP3alBzwkuwVQkaxHyzLFSbyOYeqmSY0Pkqvn85wrry19xMC1wvy
         t5OLd9GGHR/iNx7w/wWefJO/u94i0Lb7gPjaeYGUhQcuGkNJR+dkDIz3iS0qrRnxqVZu
         a8jg==
X-Gm-Message-State: ANhLgQ2GRF9T4n2BbwZHMgIW6jJCcFcPLsLSf7PuIwRIwWE8/UtR5JIJ
        bEFVO1KIrNKj1Gbrn8z7u+Fwy4S7sbs=
X-Google-Smtp-Source: ADFU+vvxyh97TI+CoevlPOLmPV80vCMY2zPQ3f4LxIbqKaykZYJpUD3CeaUVXfzHVi0hhnD1kLgtsQ==
X-Received: by 2002:a63:5f92:: with SMTP id t140mr26421777pgb.109.1584347352815;
        Mon, 16 Mar 2020 01:29:12 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p8sm7867846pff.26.2020.03.16.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:29:12 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 3/3] platform/chrome: notify: Pull PD_HOST_EVENT status
Date:   Mon, 16 Mar 2020 01:28:34 -0700
Message-Id: <20200316082831.242516-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316082831.242516-1-pmalani@chromium.org>
References: <20200316082831.242516-1-pmalani@chromium.org>
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

Changes in v2:
- Fixed variable declaration ordering.
- Updated cros_ec_pd_command() to use standard Linux error codes.

 drivers/platform/chrome/cros_usbpd_notify.c | 86 ++++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 5507d93c0ce7b..59df762b5e6d7 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -53,11 +53,90 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
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
+ * Return: >= 0 on success, negative error number on failure.
+ */
+static int cros_ec_pd_command(struct cros_ec_device *ec_dev,
+			      int command,
+			      uint8_t *outdata,
+			      int outsize,
+			      uint8_t *indata,
+			      int insize)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
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
@@ -133,6 +212,8 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 				  unsigned long queued_during_suspend,
 				  void *data)
 {
+	struct cros_usbpd_notify_data *pdnotify = container_of(nb,
+			struct cros_usbpd_notify_data, nb);
 	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
 	u32 host_event = cros_ec_get_host_event(ec_dev);
 
@@ -140,8 +221,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 		return NOTIFY_BAD;
 
 	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
-					     host_event, NULL);
+		cros_usbpd_get_event_and_notify(pdnotify->dev, ec_dev);
 		return NOTIFY_OK;
 	}
 	return NOTIFY_DONE;
-- 
2.25.1.481.gfbce0eb801-goog

