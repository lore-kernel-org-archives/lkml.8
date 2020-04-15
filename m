Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232B720767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFCbZn13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393319AbgDOFaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728378AbgDOFaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:30:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r20so1021775pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5F1ivu8bKWWnJrjjiXuZBTfPE0k8evszytlqKDOfgs=;
        b=lFCbZn13J68GyyPyZp1UixYLR3DcI9OCF2gWoiToMR5IxjBif/rsDZInc9SvchcnJH
         4bhqQisKzxF4y0fkzYnM+CwiRVTDIjN6vgwAr6btW87w2SH2M/PkLw+KOa9PUSVH5Eye
         TQehZOr9g21UPJI9N4/0atF1HjpcjpK9+EUB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5F1ivu8bKWWnJrjjiXuZBTfPE0k8evszytlqKDOfgs=;
        b=JBQf+7/r6XarNsdg+Zs6aJIOssC9LpkcMhLPp3RQHdde4hP2fPv3DAw0mKfqVkSNus
         mCP7F/NIrIT+QhaWCQFMSbMYRgKx0/cCKuDrlV9ioDDIo8gBmVwmPRx4QsTCU816v3NE
         f5LHZIWAXivWrCY3uih/h20in/dh+FqhgZtYTGz/4IpHkP/eZVRrsPBqp9aI5ueiT+Tb
         VV/Pwb3RXkCd99OQYcIkfPeAr9QCWgDT6vpRxaZgYKmt0E1ayO91/G2nypjBktY/F4dZ
         IM6qC6OiJ6iqwKNxM9KKZQJRczRN/CG+eBsLpA9eHb6RDnKvdbL3DbLpVr9fYzYwLUgJ
         skKw==
X-Gm-Message-State: AGi0PubCvLXq6lOv8NRm8MpDIH9HljYRntFjBUFMrOg4A/6Qsq9veBfk
        T+V/2s2cPjiyLQfb34EnXBIWCm/eh9k=
X-Google-Smtp-Source: APiQypINZnx4esKN7vvm7YJOWpPTftaGyUrAaor6f9v8pF5S6hsDY03Gmh72NA54PzXlgJeTE3B0Tg==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr25884533pfl.290.1586928606067;
        Tue, 14 Apr 2020 22:30:06 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p1sm13314213pjr.40.2020.04.14.22.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:30:05 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 1/3] platform/chrome: typec: Use notifier for updates
Date:   Tue, 14 Apr 2020 22:29:41 -0700
Message-Id: <20200415052943.93009-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415052943.93009-1-pmalani@chromium.org>
References: <20200415052943.93009-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a listener for the cros-usbpd-notifier, and update port state
when a notification comes in.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v4:
- No changes.

Changes in v3:
- Fixed ordering issue in Kconfig dependency.

Changes in v2:
- Added Kconfig dependency to CROS_USBPD_NOTIFY.
- Fixed spacing error.
- Removed superfluous devm_warn() call.

 drivers/platform/chrome/Kconfig         |  1 +
 drivers/platform/chrome/cros_ec_typec.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 03ea5129ed0c..a484ab2c91ff 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -217,6 +217,7 @@ config CROS_EC_SYSFS
 config CROS_EC_TYPEC
 	tristate "ChromeOS EC Type-C Connector Control"
 	depends on MFD_CROS_EC_DEV && TYPEC
+	depends on CROS_USBPD_NOTIFY
 	default MFD_CROS_EC_DEV
 	help
 	  If you say Y here, you get support for accessing Type C connector
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 874269c07073..d444dd7422a2 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/usb/typec.h>
 
@@ -26,6 +27,7 @@ struct cros_typec_data {
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 	/* Initial capabilities for each port. */
 	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
+	struct notifier_block nb;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -272,6 +274,22 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
+static int cros_ec_typec_event(struct notifier_block *nb,
+			       unsigned long host_event, void *_notify)
+{
+	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
+						     nb);
+	int ret, i;
+
+	for (i = 0; i < typec->num_ports; i++) {
+		ret = cros_typec_port_update(typec, i);
+		if (ret < 0)
+			dev_warn(typec->dev, "Update failed for port: %d\n", i);
+	}
+
+	return NOTIFY_OK;
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_typec_acpi_id[] = {
 	{ "GOOG0014", 0 },
@@ -332,6 +350,11 @@ static int cros_typec_probe(struct platform_device *pdev)
 			goto unregister_ports;
 	}
 
+	typec->nb.notifier_call = cros_ec_typec_event;
+	ret = cros_usbpd_register_notify(&typec->nb);
+	if (ret < 0)
+		goto unregister_ports;
+
 	return 0;
 
 unregister_ports:
-- 
2.26.0.110.g2183baf09c-goog

