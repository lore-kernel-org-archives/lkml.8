Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAD62070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjBow3uM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERHRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgERHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:17:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF8C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:17:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so1251726pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkqkwhOV2kALvGF4g6te/6iFt9fJLPzgBLr4Dh309IQ=;
        b=fjBow3uM65SvUJ2AOHJJF2RYAe1lI+uMVzeMus+VEQSA7o48J55Hweb0r2UJFpeB0T
         9waYZtXRQIT4/7D4lcEhgEJRAZ9cGEWCQkfD639aX6NHxGacYe2YvTpUTpelxbHDqVF6
         UVShJY/n1l0yjqbjGYw36vT4b11nKKwigo28Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkqkwhOV2kALvGF4g6te/6iFt9fJLPzgBLr4Dh309IQ=;
        b=hGzF6mAezE0nkT4b+hxk1BZ6k7f+nFiXxsTSGJGIEZ+szUdu9WTLhPk243X7BJH2N8
         tB5rUcyV1kD7r9RtFB+bla0J3GLAs1EXybOAzyl5XLwY833ARzFVgQExexm2Onl0LGM1
         VKzYH+DgzKqCaXu2zDRa1ssl/UoLHv4LMbGq4TQRBt5bqjJ4iYm7Uhv8//G67mCbNAXN
         Qo94PVlI/SJPUH+W2tEhnKOa+FHhObC3WiFXPwYr9xjI/7TfUAPuSkKL64x6EUokbDH6
         U6EFz56pTc8uG6D4fiBgUd0/fj3nAC1IoH3yBLZsqxf48Eeg8lkh1xyr2+h+jzsGRsDR
         nvRQ==
X-Gm-Message-State: AOAM531CzuWexL2SNEoUlpHQPCyQk5zpByrbbaYar1zb8xkxSdItqO96
        3cxYnD4EWgOOG1FEo2d/hnWw7b/RokA=
X-Google-Smtp-Source: ABdhPJwkE7QUQ0Fwv/p5TijHgeFhyYyl+mN1cy8yiU0qSBUVm0/vkOGOi++LpzUO5bQoLZtjnb7uHw==
X-Received: by 2002:a17:90a:b10f:: with SMTP id z15mr16669746pjq.188.1589786255806;
        Mon, 18 May 2020 00:17:35 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 30sm6928590pgp.38.2020.05.18.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 00:17:34 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@intel.linux.com>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] platform/chrome: typec: Register Type C switches
Date:   Mon, 18 May 2020 00:17:06 -0700
Message-Id: <20200518071707.161843-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200518071707.161843-1-pmalani@chromium.org>
References: <20200518071707.161843-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register Type C mux and switch handles, when provided via firmware
bindings. These will allow the cros-ec-typec driver, and also alternate
mode drivers to configure connected Muxes correctly, according to PD
information retrieved from the Chrome OS EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@intel.linux.com>
---

Changes in v2:
- Changed dev_info prints to dev_dbg.

 drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 66b8d21092af..6e79f917314b 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -14,6 +14,8 @@
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/usb/role.h>
 
 #define DRV_NAME "cros-ec-typec"
 
@@ -25,6 +27,9 @@ struct cros_typec_port {
 	struct typec_partner *partner;
 	/* Port partner PD identity info. */
 	struct usb_pd_identity p_identity;
+	struct typec_switch *ori_sw;
+	struct typec_mux *mux;
+	struct usb_role_switch *role_sw;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -84,6 +89,40 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 	return 0;
 }
 
+static int cros_typec_get_switch_handles(struct cros_typec_port *port,
+					 struct fwnode_handle *fwnode,
+					 struct device *dev)
+{
+	port->mux = fwnode_typec_mux_get(fwnode, NULL);
+	if (IS_ERR(port->mux)) {
+		dev_dbg(dev, "Mux handle not found.\n");
+		goto mux_err;
+	}
+
+	port->ori_sw = fwnode_typec_switch_get(fwnode);
+	if (IS_ERR(port->ori_sw)) {
+		dev_dbg(dev, "Orientation switch handle not found.\n");
+		goto ori_sw_err;
+	}
+
+	port->role_sw = fwnode_usb_role_switch_get(fwnode);
+	if (IS_ERR(port->role_sw)) {
+		dev_dbg(dev, "USB role switch handle not found.\n");
+		goto role_sw_err;
+	}
+
+	return 0;
+
+role_sw_err:
+	usb_role_switch_put(port->role_sw);
+ori_sw_err:
+	typec_switch_put(port->ori_sw);
+mux_err:
+	typec_mux_put(port->mux);
+
+	return -ENODEV;
+}
+
 static void cros_unregister_ports(struct cros_typec_data *typec)
 {
 	int i;
@@ -91,6 +130,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 	for (i = 0; i < typec->num_ports; i++) {
 		if (!typec->ports[i])
 			continue;
+		usb_role_switch_put(typec->ports[i]->role_sw);
+		typec_switch_put(typec->ports[i]->ori_sw);
+		typec_mux_put(typec->ports[i]->mux);
 		typec_unregister_port(typec->ports[i]->port);
 	}
 }
@@ -153,6 +195,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			ret = PTR_ERR(cros_port->port);
 			goto unregister_ports;
 		}
+
+		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
+		if (ret)
+			dev_dbg(dev, "No switch control for port %d\n",
+				port_num);
 	}
 
 	return 0;
-- 
2.26.2.761.g0e0b3e54be-goog

