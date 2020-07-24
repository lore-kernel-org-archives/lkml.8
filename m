Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D83C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E6220674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q695YtLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGXSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGXSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:11:47 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A3C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:11:47 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so7949335ilk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7boAqxbklIVoCOnNruyfDwdmhhUZeF1tVmDe3wmYFhY=;
        b=q695YtLLUW2jGWrcpOR07frj1vx0/pDEM4tWRTcoGmwigFYvujTVBIYICnTxDkHIK0
         zsSOjSWLrhTtS6VRrNGL9hVJ/sRoNh/uz8T6ux9XQJOncsYKlKeWb/dHhFncm29UaBPL
         PTSGEG7YbJL7xu0FMRdQJKb2uwgyCqUqFkh/OvUNhN/481YWqFeiWxoiQpFPRTvHh1K1
         Q8Oe+rtmzE2xqwESYZ9h53cV3nklUA2IdFbOaZutpLM6VLbmHrT6XVc1u8GdeDkxsHdU
         xL7asHmE37waWeGAVGWYxZ9Urm0XKmFQDQI2QdF2TvrqFHBS2gHrERTo8JJ5ZmadDnOM
         PoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7boAqxbklIVoCOnNruyfDwdmhhUZeF1tVmDe3wmYFhY=;
        b=rjz5hNqyXHhSMXLLfj+BGkRZkNY47G+BZMCngveEHBvLPUPcV/NT2UR4X/gJnEhw6v
         ONKF8tRX/VLPL0/ONwoQLfmBVC8FLSVTsJlowRoqySCPkp679edtlWxwWLDItKeAnbJ3
         MmD6JN/7XjbpO2MUA+3As4WAVJUFhD9dwkd08Zu0EdHcITRwoV2OcHQOpncOoKwYcCwU
         wWGdMYqFW9F1c5A09OdqEJfUUgjdaD+/sQg2CHrNU18N0eEcn2cOvIjfX6mDfW7MUJpu
         15+Jr3+esv4s4Df83av3eJ8S2HgYf0TlDNG8MS5o/LYdBGGdX3PBHELE8/K6OOV3dXo2
         n22g==
X-Gm-Message-State: AOAM530tPxerINdH2TIEas//olntLCUfPEBou7QPP0WbHdX3WT33zH6l
        44s3CsO6gEsOS6UzzZxQRyDYhA==
X-Google-Smtp-Source: ABdhPJykvocW2yX0jIN90Id6omnMQGqwx0w/GZ6CBNVtdbWC21x0QiVL9KpJPIECVv6fEC6l3hv4WA==
X-Received: by 2002:a05:6e02:ec4:: with SMTP id i4mr9088302ilk.121.1595614306996;
        Fri, 24 Jul 2020 11:11:46 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id b13sm2407802iod.40.2020.07.24.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 11:11:46 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: ipa: new notification infrastructure
Date:   Fri, 24 Jul 2020 13:11:41 -0500
Message-Id: <20200724181142.13581-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724181142.13581-1-elder@linaro.org>
References: <20200724181142.13581-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new SSR notifier infrastructure to request notifications of
modem events, rather than the remoteproc IPA notification system.
The latter was put in place temporarily with the knowledge that the
new mechanism would become available.

Signed-off-by: Alex Elder <elder@linaro.org>
---
David:  If you approve, please only ACK; Bjorn will merge.

 drivers/net/ipa/ipa.h       |  3 ++
 drivers/net/ipa/ipa_modem.c | 56 +++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index b10a853929525..55115cfb29720 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/pm_wakeup.h>
+#include <linux/notifier.h>
 
 #include "ipa_version.h"
 #include "gsi.h"
@@ -73,6 +74,8 @@ struct ipa {
 	enum ipa_version version;
 	struct platform_device *pdev;
 	struct rproc *modem_rproc;
+	struct notifier_block nb;
+	void *notifier;
 	struct ipa_smp2p *smp2p;
 	struct ipa_clock *clock;
 	atomic_t suspend_ref;
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index ed10818dd99f2..e34fe2d77324e 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -9,7 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/if_rmnet.h>
-#include <linux/remoteproc/qcom_q6v5_ipa_notify.h>
+#include <linux/remoteproc/qcom_rproc.h>
 
 #include "ipa.h"
 #include "ipa_data.h"
@@ -311,43 +311,40 @@ static void ipa_modem_crashed(struct ipa *ipa)
 		dev_err(dev, "error %d zeroing modem memory regions\n", ret);
 }
 
-static void ipa_modem_notify(void *data, enum qcom_rproc_event event)
+static int ipa_modem_notify(struct notifier_block *nb, unsigned long action,
+			    void *data)
 {
-	struct ipa *ipa = data;
-	struct device *dev;
+	struct ipa *ipa = container_of(nb, struct ipa, nb);
+	struct qcom_ssr_notify_data *notify_data = data;
+	struct device *dev = &ipa->pdev->dev;
 
-	dev = &ipa->pdev->dev;
-	switch (event) {
-	case MODEM_STARTING:
+	switch (action) {
+	case QCOM_SSR_BEFORE_POWERUP:
 		dev_info(dev, "received modem starting event\n");
 		ipa_smp2p_notify_reset(ipa);
 		break;
 
-	case MODEM_RUNNING:
+	case QCOM_SSR_AFTER_POWERUP:
 		dev_info(dev, "received modem running event\n");
 		break;
 
-	case MODEM_STOPPING:
-	case MODEM_CRASHED:
+	case QCOM_SSR_BEFORE_SHUTDOWN:
 		dev_info(dev, "received modem %s event\n",
-			 event == MODEM_STOPPING ? "stopping"
-						 : "crashed");
+			 notify_data->crashed ? "crashed" : "stopping");
 		if (ipa->setup_complete)
 			ipa_modem_crashed(ipa);
 		break;
 
-	case MODEM_OFFLINE:
+	case QCOM_SSR_AFTER_SHUTDOWN:
 		dev_info(dev, "received modem offline event\n");
 		break;
 
-	case MODEM_REMOVING:
-		dev_info(dev, "received modem stopping event\n");
-		break;
-
 	default:
-		dev_err(&ipa->pdev->dev, "unrecognized event %u\n", event);
+		dev_err(dev, "received unrecognized event %lu\n", action);
 		break;
 	}
+
+	return NOTIFY_OK;
 }
 
 int ipa_modem_init(struct ipa *ipa, bool modem_init)
@@ -362,13 +359,30 @@ void ipa_modem_exit(struct ipa *ipa)
 
 int ipa_modem_config(struct ipa *ipa)
 {
-	return qcom_register_ipa_notify(ipa->modem_rproc, ipa_modem_notify,
-					ipa);
+	void *notifier;
+
+	ipa->nb.notifier_call = ipa_modem_notify;
+
+	notifier = qcom_register_ssr_notifier("mpss", &ipa->nb);
+	if (IS_ERR(notifier))
+		return PTR_ERR(notifier);
+
+	ipa->notifier = notifier;
+
+	return 0;
 }
 
 void ipa_modem_deconfig(struct ipa *ipa)
 {
-	qcom_deregister_ipa_notify(ipa->modem_rproc);
+	struct device *dev = &ipa->pdev->dev;
+	int ret;
+
+	ret = qcom_unregister_ssr_notifier(ipa->notifier, &ipa->nb);
+	if (ret)
+		dev_err(dev, "error %d unregistering notifier", ret);
+
+	ipa->notifier = NULL;
+	memset(&ipa->nb, 0, sizeof(ipa->nb));
 }
 
 int ipa_modem_setup(struct ipa *ipa)
-- 
2.20.1

