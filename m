Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EC420656
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEPxRX1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgF0E6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgF0E6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:58:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE6C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:58:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm23so5788945pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTXhqZ7TnzTvvD3MCRFk7Xtz6d7PKf4CLgE6fbNTgI0=;
        b=ZEPxRX1etLBNp9y8gpc6fC9lFfoALnqIbJ+RBxe3qCnzTIm4DGe/AAK94uu7pqBZ/u
         7KxbqQfv08JLP7Bzrn+/unGnDhPdBQsFf9ESatMwoSBgqzIKmo+o1HIM6sb3eamEg0yk
         0Pm8DqMmWI6gbTc03SvTwUUMyoA1G/Dgu3W1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tTXhqZ7TnzTvvD3MCRFk7Xtz6d7PKf4CLgE6fbNTgI0=;
        b=rnohsbpHQ47E38m+zCf6b+KtrRpty1FcE9qx2b3cR1tWUjF7QasIPov9nozBwS9DPK
         97D//4zETX18ueBJMllP9AD8U5fpL+LPAeQgNzC+z/c4ZTl0inPLgFN4FVuVLTUVd9Yj
         NSosok7JfARBzWhtkBovi88Z2xZw5bKIkRqUTW7b8IjlO8htdI7+0ShHr4mNuPNCwg3l
         BQ5i2594HDluzhUZ93Ul+zTu0BMcNAnD9aTGJGcYpLwJaS33xRo9ICwtH7hLwNWGwhak
         PXbYP0WYhQK68TjJ/y0CVESxxwi6d4YcYUhEPja/mNBygwz1z1jtyvQPPNwGtWyAkdMP
         8eLw==
X-Gm-Message-State: AOAM531SAif12bba0eSUcUbbFowI0JNUFsXk/R77WxNYKlV6vjQRApNX
        LA6Vt4HW/+ArvXqVtKGwBXAypC2TNB4=
X-Google-Smtp-Source: ABdhPJytEzOhayAeT4MyIb691roE7NPXZD6jU5xTOudCguT/4ZRmsPqMDxd3GWIL4roDGlYtNGyglA==
X-Received: by 2002:a17:90a:f0cb:: with SMTP id fa11mr6662805pjb.113.1593233926875;
        Fri, 26 Jun 2020 21:58:46 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id a33sm16123185pgl.75.2020.06.26.21.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:58:46 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Use workqueue for port update
Date:   Fri, 26 Jun 2020 21:58:39 -0700
Message-Id: <20200627045840.1314019-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 28 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbba..630170fb2cbe 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,6 +58,7 @@ struct cros_typec_data {
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
+	struct work_struct port_work;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -619,18 +620,29 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
-static int cros_ec_typec_event(struct notifier_block *nb,
-			       unsigned long host_event, void *_notify)
+static void cros_typec_port_work(struct work_struct *work)
 {
-	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
-						     nb);
-	int ret, i;
+	struct cros_typec_data *typec = container_of(work,
+						     struct cros_typec_data,
+						     port_work);
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
+	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
+						     nb);
+
+	schedule_work(&typec->port_work);
 
 	return NOTIFY_OK;
 }
@@ -689,6 +701,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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

