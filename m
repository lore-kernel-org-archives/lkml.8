Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A5E206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggTz5Yh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgGOXti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:49:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:49:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so3775077pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnY25f3xKxvnucN24PYy68sMkiT/GStHrAMkI/Vdf8g=;
        b=ggTz5Yh+TfVJlYfDOzLu592eNQskGEZRmumjTBvwsNzVL62VrkVUCUyanQxabxfpzI
         MiT0FhbLWCMkAsAqNYZs+iGO1ddB3GzqUhdUQwSudgjGpxKD1OqkGLZd6XMlVNmgcFJj
         IoLA7TaoQajpYRAVsU+u5A3vV1SizxvVZADxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnY25f3xKxvnucN24PYy68sMkiT/GStHrAMkI/Vdf8g=;
        b=TStCk2GvRrR4bgrsxTFqaIHbwxCiP1ygkwobQiUQkjdDa0T5iSTDuLCqB1IFY9baBV
         SVQGdpaWKuscJOq/WpiwH0wFmTGkvGnZcF+czFFe9tV8pF8k36b53TMoYgtI4RykW+Qp
         1RrKhnmA/md2xoZ8T+cu/nWuynkb+UEniRuclvPgOmByPbPHTV9e7qE/n2BcirxuPv7s
         IQiqx2Mt4nl/QNhwDbe86p6NmY7EBt0f2JGUToEMKI4WIPY/hhQYhPzWBGoXGSmc2azR
         KqhbMYLibcMgfTlKWu9bVwUEAKK5jg8Kfctxy2EpCyl4QngN0VPun/2OytWsXZikFLBr
         PxrA==
X-Gm-Message-State: AOAM5312zOxOwHRCf3ZLh2hBsKHLW0xJOnf8Tu2VfK6fB7vVQdZmr3q3
        34g8KgyHFj3EuEaLWB/r6/IER5NPDIk=
X-Google-Smtp-Source: ABdhPJzy12ejJD/X5OflbpT+RhzpF6wd2yvkZRCc7hMp8lz/ey/PfBFsdeAkmEqe/6VupYCxWFp2VA==
X-Received: by 2002:a17:902:c391:: with SMTP id g17mr1508535plg.330.1594856976810;
        Wed, 15 Jul 2020 16:49:36 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a26sm2978157pgm.20.2020.07.15.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 16:49:36 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Unregister partner on error
Date:   Wed, 15 Jul 2020 16:49:28 -0700
Message-Id: <20200715234928.3090367-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When port update is called during probe(), any error with setting the
Type C muxes results in an errno being returned to probe(), which promptly
returns that itself. Ensure that we unregister any registered partners
when doing so, to prevent orphaned partners on the Type C connector
class framework.

Move the cros_typec_add_partner() and cros_typec_remove_partner() code
together to higher up in the file, so that they are together, and we can
call cros_typec_remove_partner() from cros_unregister_ports().

Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 83 +++++++++++++------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbba..43e7cf367a07 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -140,6 +140,47 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	return -ENODEV;
 }
 
+static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
+				  bool pd_en)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct typec_partner_desc p_desc = {
+		.usb_pd = pd_en,
+	};
+	int ret = 0;
+
+	/*
+	 * Fill an initial PD identity, which will then be updated with info
+	 * from the EC.
+	 */
+	p_desc.identity = &port->p_identity;
+
+	port->partner = typec_register_partner(port->port, &p_desc);
+	if (IS_ERR(port->partner)) {
+		ret = PTR_ERR(port->partner);
+		port->partner = NULL;
+	}
+
+	return ret;
+}
+
+static void cros_typec_remove_partner(struct cros_typec_data *typec,
+				     int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+
+	port->state.alt = NULL;
+	port->state.mode = TYPEC_STATE_USB;
+	port->state.data = NULL;
+
+	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
+	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
+	typec_mux_set(port->mux, &port->state);
+
+	typec_unregister_partner(port->partner);
+	port->partner = NULL;
+}
+
 static void cros_unregister_ports(struct cros_typec_data *typec)
 {
 	int i;
@@ -147,6 +188,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 	for (i = 0; i < typec->num_ports; i++) {
 		if (!typec->ports[i])
 			continue;
+		cros_typec_remove_partner(typec, i);
 		usb_role_switch_put(typec->ports[i]->role_sw);
 		typec_switch_put(typec->ports[i]->ori_sw);
 		typec_mux_put(typec->ports[i]->mux);
@@ -285,47 +327,6 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
-static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
-				  bool pd_en)
-{
-	struct cros_typec_port *port = typec->ports[port_num];
-	struct typec_partner_desc p_desc = {
-		.usb_pd = pd_en,
-	};
-	int ret = 0;
-
-	/*
-	 * Fill an initial PD identity, which will then be updated with info
-	 * from the EC.
-	 */
-	p_desc.identity = &port->p_identity;
-
-	port->partner = typec_register_partner(port->port, &p_desc);
-	if (IS_ERR(port->partner)) {
-		ret = PTR_ERR(port->partner);
-		port->partner = NULL;
-	}
-
-	return ret;
-}
-
-static void cros_typec_remove_partner(struct cros_typec_data *typec,
-				     int port_num)
-{
-	struct cros_typec_port *port = typec->ports[port_num];
-
-	port->state.alt = NULL;
-	port->state.mode = TYPEC_STATE_USB;
-	port->state.data = NULL;
-
-	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
-	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
-	typec_mux_set(port->mux, &port->state);
-
-	typec_unregister_partner(port->partner);
-	port->partner = NULL;
-}
-
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
-- 
2.27.0.389.gc38d7665816-goog

