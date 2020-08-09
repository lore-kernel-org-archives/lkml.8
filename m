Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6030C206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Xh+2o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHILx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgHILxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:53:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC6C061A29
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:53:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so5653635wrf.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 04:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gLH3rxmq6SA0vJLpOm/l6ISUF8lxjBSN26xUmqfwMEw=;
        b=G4Xh+2o+TXmHY1eiqrSdSZptKAXGu9Z0Ws4UqXeUuj7wVtXwzXnzINvWsmFAV/Ebxj
         9aDCSaaQaoOgKKPxHsXX1STwe4V08tWIDUhzeq3uJURnGvZXMs6wQtdGYQTynwwMlqua
         NjOhE/YnKRh6hkhmEj8qPk2rHUxBcvPBp5MfzJuMMJsnS/Kj5jo6rRrDMO03zxY+d25q
         qooWJMIy73k6yBOvVSj15dudTR1eqc3HQUo9DEYN2MfHlbJvGLfVKs7RQ9WThlvHmaA0
         2VAZC3QMd7avaIvzGykdgi7/EfD/M22REjH4umSD5xQnZj1Cp7dVUBxUiGxF+xxf4Bhb
         gauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gLH3rxmq6SA0vJLpOm/l6ISUF8lxjBSN26xUmqfwMEw=;
        b=osjQIQ/wGqJzKvRxhYs67GAXuJcOhpB912+SeGuTRFb1d2vXUo2QqKEg82uen7OPoP
         kE5YtBAXoEKG3H5pzfeGiHL+eRsGiun9WLDkZ3kR6dZRBNC0P8OnIsCbJDOETwXpJbuj
         5d7Tmgk0R2dqfUCw7fShkgOfnzj+6Jt6U51Eb5qv+nVj6Nyrp7jUUV2+Dbb/DLyf93Zb
         nYFpIJyqrE2VYFXF5YKBrqbD57A5/bnURu4naK0L9rGT2AktR37li5ZST6ap06KoHGWV
         cqpMj6+Y/LT0w1aExLNmw8tNdtDpam83TNGtL7wOakWWqTZ8T42Vn/dXVMcdZgtzeh5v
         XGDw==
X-Gm-Message-State: AOAM531TSgfqk5PkwadyWqrHRarmAMqWaUfAaBRD8wGtKFk0dDo7jxTF
        OT6i/wu4F8W+XqfYhX8vJhN4n4LK
X-Google-Smtp-Source: ABdhPJw5Dtr6dIdhB360+uP3YD1KSRXzyYLtN47v7wGzU4al+uvluIr1BncT9b3O44LfXDAJxOjQtA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr21215097wrw.358.1596974025937;
        Sun, 09 Aug 2020 04:53:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id f12sm17376932wmc.46.2020.08.09.04.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:53:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 4/4] habanalabs: set max power according to card type
Date:   Sun,  9 Aug 2020 14:53:37 +0300
Message-Id: <20200809115337.23402-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200809115337.23402-1-oded.gabbay@gmail.com>
References: <20200809115337.23402-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Gaudi, the default max power setting is different between PCI and PMC
cards. Therefore, the driver need to set the default after knowing what is
the card type.

The current code has a bug where it limits the maximum power of the PMC
card to 200W after a reset occurs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/device.c     | 7 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 drivers/misc/habanalabs/common/sysfs.c      | 7 ++++---
 drivers/misc/habanalabs/gaudi/gaudi.c       | 9 ++++++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h      | 3 ++-
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index be16b75bdfdb..8e34c39380a9 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1069,7 +1069,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			goto out_err;
 		}
 
-		hl_set_max_power(hdev, hdev->max_power);
+		hl_set_max_power(hdev);
 	} else {
 		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
 		if (rc) {
@@ -1318,6 +1318,11 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto out_disabled;
 	}
 
+	/* Need to call this again because the max power might change,
+	 * depending on card type for certain ASICs
+	 */
+	hl_set_max_power(hdev);
+
 	/*
 	 * hl_hwmon_init() must be called after device_late_init(), because only
 	 * there we get the information from the device about which
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 13c18f3d9a9b..5864c6adfc52 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1858,7 +1858,7 @@ int hl_get_pwm_info(struct hl_device *hdev,
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value);
 u64 hl_get_max_power(struct hl_device *hdev);
-void hl_set_max_power(struct hl_device *hdev, u64 value);
+void hl_set_max_power(struct hl_device *hdev);
 int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index b3cb0ac4721c..5ae484cc84cd 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -81,7 +81,7 @@ u64 hl_get_max_power(struct hl_device *hdev)
 	return result;
 }
 
-void hl_set_max_power(struct hl_device *hdev, u64 value)
+void hl_set_max_power(struct hl_device *hdev)
 {
 	struct armcp_packet pkt;
 	int rc;
@@ -90,7 +90,7 @@ void hl_set_max_power(struct hl_device *hdev, u64 value)
 
 	pkt.ctl = cpu_to_le32(ARMCP_PACKET_MAX_POWER_SET <<
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.value = cpu_to_le64(value);
+	pkt.value = cpu_to_le64(hdev->max_power);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						0, NULL);
@@ -316,7 +316,7 @@ static ssize_t max_power_store(struct device *dev,
 	}
 
 	hdev->max_power = value;
-	hl_set_max_power(hdev, value);
+	hl_set_max_power(hdev);
 
 out:
 	return count;
@@ -422,6 +422,7 @@ int hl_sysfs_init(struct hl_device *hdev)
 		hdev->pm_mng_profile = PM_AUTO;
 	else
 		hdev->pm_mng_profile = PM_MANUAL;
+
 	hdev->max_power = hdev->asic_prop.max_power_default;
 
 	hdev->asic_funcs->add_device_attr(hdev, &hl_dev_clks_attr_group);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7e0f9f64ffcb..c58343608cc7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -456,7 +456,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->num_of_events = GAUDI_EVENT_SIZE;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 
-	prop->max_power_default = MAX_POWER_DEFAULT;
+	prop->max_power_default = MAX_POWER_DEFAULT_PMC;
 
 	prop->cb_pool_cb_cnt = GAUDI_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GAUDI_CB_POOL_CB_SIZE;
@@ -6055,6 +6055,13 @@ static int gaudi_armcp_info_get(struct hl_device *hdev)
 		strncpy(prop->armcp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
+	if (prop->armcp_info.card_type == armcp_card_type_pci)
+		prop->max_power_default = MAX_POWER_DEFAULT_PCI;
+	else if (prop->armcp_info.card_type == armcp_card_type_pmc)
+		prop->max_power_default = MAX_POWER_DEFAULT_PMC;
+
+	hdev->max_power = prop->max_power_default;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 5dc99f6f0296..182eaf6193a3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -41,7 +41,8 @@
 
 #define GAUDI_MAX_CLK_FREQ		2200000000ull	/* 2200 MHz */
 
-#define MAX_POWER_DEFAULT		200000		/* 200W */
+#define MAX_POWER_DEFAULT_PCI		200000		/* 200W */
+#define MAX_POWER_DEFAULT_PMC		200000		/* 350W */
 
 #define GAUDI_CPU_TIMEOUT_USEC		15000000	/* 15s */
 
-- 
2.17.1

