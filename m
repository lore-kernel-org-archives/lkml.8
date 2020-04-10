Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA86C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7732074F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XV6TQi1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgDJAXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:23:49 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34835 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:23:48 -0400
Received: by mail-pj1-f65.google.com with SMTP id mn19so183967pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m26VU8kqB/DEHGOXzBmFr8CE11PxubWxWkwy9EMFTsY=;
        b=XV6TQi1+yyXeItytY1IFyJWSjQ86G5tgy2RJZEkg8R82FDoxDRYreDrajhbj+S2Ekj
         +a7at3nm9LfdG7I2rlgaPBaE9Ag8tPPFn0AIJ7+flphf3TvVkSl/OPXq+Q+tB8FZrxpT
         i7VjdBnSzGJJ9Q4S+2D5mGx13X75Wyj+Jhb8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m26VU8kqB/DEHGOXzBmFr8CE11PxubWxWkwy9EMFTsY=;
        b=p5jPeszNhs2LOa85hNQlC/Ez2atNxUJc+fLE1BRnYLr0VwvhO8PDS4oSget6Wj7OmV
         Y/1KypONq4iInqyxvYYIJtLyv2oyEt8yhshU2id2/1P05znR1lRQ0qCpoJy8UbS25OM2
         3mpGCAlVDqnx1Dzm/7HDqUIl+knr8Z3Yyzs677CWW+/YAePFzOUriID/vEfXOOwUeClt
         YNpzvC26+D2HH4eysV8Mp+wy06qVPdbCJKRtMZ6UbEu4V9T+OHVhcI6a23ywHWSaxEki
         jOy55j0Iehod1Q2fULunC/dobiv3sfawBhLBHlw7azEbhctGTVsN/YMcpA9nBnRy78km
         DrvQ==
X-Gm-Message-State: AGi0PuaHWecZTuGUDJ0bsq7o9dqQb3+0XBPhiN9yXMscqRlBUqTgnjyF
        GQklk9RRV77bG5SPf+Y5UcStQhWaP3k=
X-Google-Smtp-Source: APiQypLeKtU8auFkIcyrMGiyowQkSzg4jekaE+ffBjXY71Xv8CKuyxoIxvj6IXt524WENpglupXC7w==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr2128211plr.76.1586478227295;
        Thu, 09 Apr 2020 17:23:47 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z7sm286952pju.37.2020.04.09.17.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:23:46 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 1/3] platform/chrome: typec: Use notifier for updates
Date:   Thu,  9 Apr 2020 17:23:15 -0700
Message-Id: <20200410002316.202107-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410002316.202107-1-pmalani@chromium.org>
References: <20200410002316.202107-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a listener for the cros-usbpd-notifier, and update port state
when a notification comes in.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

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
index 03ea5129ed0c3..a484ab2c91ff0 100644
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
index 874269c070739..d444dd7422a2a 100644
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

