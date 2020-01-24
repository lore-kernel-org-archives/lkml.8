Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87757C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561732071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8T7f7GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgAXX1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:27:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36607 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbgAXX1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:27:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1409244plm.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMA+QteS/JKIrgzNNehkgXK6WKtqs9yO/7325HU0xxA=;
        b=J8T7f7GLnK78uiyRBnCLfOmhrZTQC9Snw78JgipV4iORMKkCyjpWK6Ywu969t4OCWn
         vHVgk8OMilaDg72I96iQnY49oKejS5E4WkIGj7sHU4H9yMdm7xTCLQ/pLUUUruZZOKSd
         5TxNBzu5M228WEMt7/FxGDohHhvzc8IdHhmw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMA+QteS/JKIrgzNNehkgXK6WKtqs9yO/7325HU0xxA=;
        b=QLG08TzaGNZikLuVzK9+XsReaCZGwsBPpY7CRKuCsuwqDL8Q/7G3bUsDg6Ih/H5jGU
         Y91/yG3godmE1Yu1dJ5CujLt/5DhqxiNGLtCUM6SBr9fwNKI7LzSpzKYcZ99mAr66gfT
         XsY28LbgJK9zz1nu/EXCXs7w3jU51PRLwC813t4wRYRCD3+l1RCBGPtX8CR5d97cWnu3
         +0yEAuvbk4/fpc4toJDGka/QeApKDajsKX3k/ggMvKVkGPyvBl7BKgH+QK+bEonAH8le
         ShLlhlxZq2c4k3gENS7oXwgKFrOtYbHxZKdi+MItsNwZJaLXfmYO6dR8YQ6+vClndL5J
         WRoA==
X-Gm-Message-State: APjAAAV/mMzgmLs3I3bepfl9Vz1fuSUbYfVk5EjtwusHsR69gdc0f4km
        Mrn0p6Sx/hsC385d72+T6jTxGQ==
X-Google-Smtp-Source: APXvYqwY0AaVqS2LMQRZ1k5/WiWlXd2hBWliRPyl4SxOhlErcaZ2nhCS1Or5k6hnLxc4GiBDU6wz0w==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr6070491plt.111.1579908454326;
        Fri, 24 Jan 2020 15:27:34 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id b12sm2823103pfr.26.2020.01.24.15.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 15:27:33 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v8 4/4] power: supply: cros-ec-usbpd-charger: Fix host events
Date:   Fri, 24 Jan 2020 15:18:38 -0800
Message-Id: <20200124231834.63628-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124231834.63628-1-pmalani@chromium.org>
References: <20200124231834.63628-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

There's a bug on ACPI platforms where host events from the ECPD ACPI
device never make their way to the cros-ec-usbpd-charger driver. This
makes it so the only time the charger driver updates its state is when
user space accesses its sysfs attributes.

Now that these events have been unified into a single notifier chain on
both ACPI and non-ACPI platforms, update the charger driver to use this
new notifier.

Reviewed-by: Benson Leung <bleung@chromium.org>
Co-Developed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v8(pmalani@chromium.org):
- No changes.

Changes in v7(pmalani@chromium.org):
- Alphabetize #include header.

Changes in v6(pmalani@chromium.org):
- Patch first introduced into the series in v6.

 drivers/power/supply/Kconfig              |  2 +-
 drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c4..ba74ddd793c3d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -659,7 +659,7 @@ config CHARGER_RT9455
 
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
-	depends on CROS_EC
+	depends on CROS_USBPD_NOTIFY
 	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 6cc7c3910e098..7eea080048f43 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
@@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
 }
 
 static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
-				       unsigned long queued_during_suspend,
+				       unsigned long host_event,
 				       void *_notify)
 {
-	struct cros_ec_device *ec_device;
-	struct charger_data *charger;
-	u32 host_event;
+	struct charger_data *charger = container_of(nb, struct charger_data,
+						    notifier);
 
-	charger = container_of(nb, struct charger_data, notifier);
-	ec_device = charger->ec_device;
-
-	host_event = cros_ec_get_host_event(ec_device);
-	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
-		return NOTIFY_OK;
-	} else {
-		return NOTIFY_DONE;
-	}
+	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
+	return NOTIFY_OK;
 }
 
 static void cros_usbpd_charger_unregister_notifier(void *data)
 {
 	struct charger_data *charger = data;
-	struct cros_ec_device *ec_device = charger->ec_device;
 
-	blocking_notifier_chain_unregister(&ec_device->event_notifier,
-					   &charger->notifier);
+	cros_usbpd_unregister_notify(&charger->notifier);
 }
 
 static int cros_usbpd_charger_probe(struct platform_device *pd)
@@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		goto fail;
 	}
 
-	if (ec_device->mkbp_event_supported) {
-		/* Get PD events from the EC */
-		charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
-		ret = blocking_notifier_chain_register(
-						&ec_device->event_notifier,
-						&charger->notifier);
-		if (ret < 0) {
-			dev_warn(dev, "failed to register notifier\n");
-		} else {
-			ret = devm_add_action_or_reset(dev,
-					cros_usbpd_charger_unregister_notifier,
-					charger);
-			if (ret < 0)
-				goto fail;
-		}
+	/* Get PD events from the EC */
+	charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
+	ret = cros_usbpd_register_notify(&charger->notifier);
+	if (ret < 0) {
+		dev_warn(dev, "failed to register notifier\n");
+	} else {
+		ret = devm_add_action_or_reset(dev,
+				cros_usbpd_charger_unregister_notifier,
+				charger);
+		if (ret < 0)
+			goto fail;
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

