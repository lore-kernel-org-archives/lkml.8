Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC54320899
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5LrA0hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgF2THq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbgF2THm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:07:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F6C030F29
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:38:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so734193plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwUSLGARJc0tc0i7e9PAJ1aEIwQmah2Mj+7/Lw4GWVQ=;
        b=O5LrA0hvh6pdSNYojIfuGO/VrkNKrM+IJqkHmMn4yck9UH4KIOfGZ880eO68An1QrF
         pqMdoHrQrlzvSd7H5nTCyPiX3zdnX4gvVQZCrr6gRBFxqzAcC4zmzK9J3FECjM1JAo4i
         tdb5Mpm6Rm+PiwgvaQZ3UxOSezJDzGlrQFIAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwUSLGARJc0tc0i7e9PAJ1aEIwQmah2Mj+7/Lw4GWVQ=;
        b=lpHlgJC7czyIXDbso2D3a+weSyKcpGP70IEqrtSxSjRyuC9Abtca69WIqAfnO8l7Cl
         C5fkJwtnyknMfWsi3YVzMg4EPgBuMiUzNZZ/gjFcL2EtKf2bhdtwZiatXMdiKkqRrzYq
         XBQRomaPDktLvTlgcaZ99ujOk/2n+knMyf2yD6G1nMlWur9qtBXYOHlKrumB0jtDIPTx
         UAttujJEx4DyD7ppaOScrodg3l6CYFvvu3M5Bo92u4y0EJPT6Ic1eyro954p5rqFtBh8
         RhnuYZW95G9mb5kYqmP9bJggBApcutMjbEBa9QLgaD0y6ur/K7PXf2+Rmd8GM/mBfnXW
         v1fQ==
X-Gm-Message-State: AOAM532zMw9KBcb5kw8FgrqaVg4kl8t8VB8H2Q3pplYvzhMtugyRtyXI
        CCY9RIWFM9ZgyTCi9zhl2atjwUztBCw=
X-Google-Smtp-Source: ABdhPJxiDSxzoFZlOF1LR3M+87QWIqODfOOJoQ3pC0z7sFyrqvYTX8eG16fEZIV3H1/WdJdnQ3CMfg==
X-Received: by 2002:a17:90a:d587:: with SMTP id v7mr7889439pju.29.1593448737198;
        Mon, 29 Jun 2020 09:38:57 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s6sm79060pfd.20.2020.06.29.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:38:56 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Use workqueue for port update
Date:   Mon, 29 Jun 2020 09:38:50 -0700
Message-Id: <20200629163851.2130450-1-pmalani@chromium.org>
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

Changes in v3:
- Use new 100 character line length limit.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbba..0beb62bf5adf 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,6 +58,7 @@ struct cros_typec_data {
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
+	struct work_struct port_work;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -619,18 +620,26 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
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
+	int ret;
+	int i;
 
 	for (i = 0; i < typec->num_ports; i++) {
 		ret = cros_typec_port_update(typec, i);
 		if (ret < 0)
 			dev_warn(typec->dev, "Update failed for port: %d\n", i);
 	}
+}
+
+
+static int cros_ec_typec_event(struct notifier_block *nb,
+			       unsigned long host_event, void *_notify)
+{
+	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
+
+	schedule_work(&typec->port_work);
 
 	return NOTIFY_OK;
 }
@@ -689,6 +698,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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

