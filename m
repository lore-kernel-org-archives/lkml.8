Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F05020719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7GECrWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDGBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:10:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:10:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so897712pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=457RnyMVsNvg8Pb1hIw/s7Bb+SCmATGSkt0Iz3XVsxs=;
        b=T7GECrWCy8XAulyaDsK2tqRBlLFxksZ+je7TjvdZ1UOQupgdgcUiH6Xl2T7+y4gwFy
         hjIdDlbmSJVKuUW3BliZZ8Fy/CwPZnS8UBEx9MznEqAYkgE2aiJKa8YG5Ccqi+oTGVAM
         i4Do+Padob4TvBOeiYql+199n2j7VlCbW42Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=457RnyMVsNvg8Pb1hIw/s7Bb+SCmATGSkt0Iz3XVsxs=;
        b=HMCHk9YZ93VbILxbV11YzFfqDgTnYdTpqgXjEqGskvjanhdGouEjRNxCpqyCCz62iF
         uhsTnZf1SVkywqv4fTtoBvt10/kRyio9SgGgG86486TIMCZ/vWOqwsyKNr2d54axgzcT
         cxGAirDL/bqwrQFbpSsQpxcJhqL2J/hdjjuUyiabQUcfQPjoz6r4M8VhGnlHf4Ol6+AQ
         zo+lhjn2ruDSDBUChvHB80O5aRdsCYVDJMlmFqofbygYtFpqDHHYhEWMlZopsuXPYVHv
         vEzQbilyUu7/fZzAEfNtJ0dTGF3nte7KJ9XWJMsrFlctoaL10vFAe1REcTDJUZGr0mQv
         WpUw==
X-Gm-Message-State: AGi0PubwL2v1eJSlxf30vqLrm9Ugkg3L97tV8twUxW7C6m1r7A54tO4g
        323vGwzdYIGqkkbpR3iU0fD7kRFD8to=
X-Google-Smtp-Source: APiQypJrWDBYen9zUgyHuE4Ba/xcgJ/8hpj3pkazsseqDpkOjBFR1eyr1NCAASBtd/3ph+D01Oz/rg==
X-Received: by 2002:a63:c345:: with SMTP id e5mr1673380pgd.403.1586221805707;
        Mon, 06 Apr 2020 18:10:05 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s27sm12086500pgn.90.2020.04.06.18.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:10:05 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/3] platform/chrome: typec: Use notifier for updates
Date:   Mon,  6 Apr 2020 18:09:38 -0700
Message-Id: <20200407010940.155490-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407010940.155490-1-pmalani@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 874269c070739..cf7c2652a1d6d 100644
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
+			dev_warn(typec->dev, "Update failed for port:%d\n", i);
+	}
+
+	return NOTIFY_OK;
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_typec_acpi_id[] = {
 	{ "GOOG0014", 0 },
@@ -332,6 +350,13 @@ static int cros_typec_probe(struct platform_device *pdev)
 			goto unregister_ports;
 	}
 
+	typec->nb.notifier_call = cros_ec_typec_event;
+	ret = cros_usbpd_register_notify(&typec->nb);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register notifier\n");
+		goto unregister_ports;
+	}
+
 	return 0;
 
 unregister_ports:
-- 
2.26.0.292.g33ef6b2f38-goog

