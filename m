Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E9C2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jNiNWESK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgF2Sto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgF2Smw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C8C030F06
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:13:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so3535933pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oa3EF7aSEKdwkHWtdSERQEKRvSSaqtA5gAFV/UpMSiI=;
        b=jNiNWESKoWrBIC7iQzZO+r/PpaaeHXKFyuEozVow4Hezk19h6rckiPRJfpN3iIDUk4
         jdAeRldMjXlB05SU3Up49L0iCNPvl97Ov0hhJdbTfJL0JoxHCeM1XzA3vOGJnY+BZfQ8
         lYNoEcwy3tMrEIE8KXm6O6fiHw0QEaiqKo4/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oa3EF7aSEKdwkHWtdSERQEKRvSSaqtA5gAFV/UpMSiI=;
        b=nO5LEZZ37Ln3wu2wGN6CdrgnV2DNg4c9v4TEPxFzOqHGGh3vJu46/jvfPKItg6GizQ
         c07xi5rhd884s0prkbuBdWBRnFnJbdQoaxOxw/bTjHDVLOOVdtbLf0Na6FjD5y2+T31f
         xrujB6lt6P1PpQw7uc/U4XTeYzUm9vHfJQsledI+3dteumZq8yJjUK29WlVy27oqziLn
         tI1uqO7Fdl3k5Cxjm+iQC1bQ746YGX/Lt9gISMtG2t96pkI/6lmFH8XZbzt76zDMlTku
         tnyIOsvjM494FgfAnkurxXTTNqubfbvv0TSTsYPD966GFZlDu1mZQcpWfJkiYVXSAq6d
         VzxA==
X-Gm-Message-State: AOAM532rjngnupdbl0/Lt0vLwvSjF0iozEycUE0fuh7cwF3xh4CXk9DM
        5sOVcNRwmfzlT1sM/MRmBI6G3TE/8fg=
X-Google-Smtp-Source: ABdhPJxM1bHZxn1EHxYc2I4vpLirV3kVQJSLJBy9TtZVsE0wPpOC9E8BQ5rZ/5Ap3Jlf3FLok5NuHw==
X-Received: by 2002:a63:3d42:: with SMTP id k63mr10987331pga.330.1593447218014;
        Mon, 29 Jun 2020 09:13:38 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id d5sm188462pfa.71.2020.06.29.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:13:37 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Use workqueue for port update
Date:   Mon, 29 Jun 2020 09:13:32 -0700
Message-Id: <20200629161333.2110327-1-pmalani@chromium.org>
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

Changes in v2:
- No changes.

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

