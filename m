Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A0B206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0Gn/DiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGIAY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGIAY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:24:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E4C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 17:24:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so299759pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CxPOUUi/VbatXi14/IdiolcKlTmPYq8+lcAvYMRRs8=;
        b=f0Gn/DiROddgQ0JOGDsL/zcY8e5gJXQ8wjtLQMEVX/E3zlaxESrwNVOFUxxVMdDRcs
         zvw7m60HZ337fPgv5XDmOSJlclWpicJTIrMZHrJ44f+Kx5iL2vKKsFytVukYBeYotzPI
         +KdIu08a5h497ORTYdb7Z6vDFsCtei0lodH0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CxPOUUi/VbatXi14/IdiolcKlTmPYq8+lcAvYMRRs8=;
        b=akYg3kjvEC12IX/rJiQe6dt+KaYgd7VK7XUmpuLP3THOYCm0g+YOR2nRwYxtoljhTC
         CZd6WHTZ/HA2a5/2bsGMHt7q/TAeuGdOrkDu41SGqGxscPZoGWiA3rbPERP3u0mBB7yi
         Fj+lzoenEBQjmlLHPF1aIFVYvMYHxiGLqcgUaK4hY8HidbqWAcIfjR4BSYLHpxbrGrom
         Wtwxt1AEWXTqdlY2+TL6AgTY2ohyWNIiVvCH3wrPeT2tP5KF1YOiEbyoi8n0+n9CShCB
         pWVY/I83Dh2EgsbkQV4BJl8GS7tBOhNS6bwsIum7u/bzhBDeMUBHAdCj2t+qZbLfkAwG
         8kRA==
X-Gm-Message-State: AOAM533bcbJUBPnHN646HBbAOac56LiotKboDLhSR+dOoPbHkuQTveu0
        HgSupNoaL9UW6aBCNuHXkuo9ZPmUfQI=
X-Google-Smtp-Source: ABdhPJwH24Hq43xyUPIKQoirRhi89n1ZnZIWcNdyQ4OjdOq/VNjzcHD/Lpc8U13AKmMahPw/SjftuQ==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15mr15105881plr.329.1594254297879;
        Wed, 08 Jul 2020 17:24:57 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b18sm589184pju.10.2020.07.08.17.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:24:57 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC INTEL PMC MUX DRIVER)
Subject: [PATCH] usb: typec: intel_pmc_mux: Avoid connect request on disconnect
Date:   Wed,  8 Jul 2020 17:24:41 -0700
Message-Id: <20200709002441.1309189-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pmc_usb_mux_set() is invoked when a device is disconnected, a valid
scenario is for state->alt == NULL and state->mode == TYPEC_STATE_USB.

In such cases, if a pmc_usb_disconnect() has already been issued (from
either pmc_usb_set_orientation() when orientation ==
TYPEC_ORIENTATION_NONE, or pmc_usb_set_role() when role ==
USB_ROLE_NONE), a pmc_usb_connect() will be issued despite no peripheral
being present.

This confuses the PMC and leads to all subsequent PMC IPC requests
returning errors due to timeout.

To prevent this, return early if the port orientation or role is already
set to none.

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>
Fixes: f3c1c41ebc67 ("usb: typec: intel_pmc_mux: Add support for USB4")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 2aba07c7b221..e4021e13af40 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -310,6 +310,9 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
 	struct pmc_usb_port *port = typec_mux_get_drvdata(mux);
 
+	if (port->orientation == TYPEC_ORIENTATION_NONE || port->role == USB_ROLE_NONE)
+		return 0;
+
 	if (state->mode == TYPEC_STATE_SAFE)
 		return pmc_usb_mux_safe_state(port);
 	if (state->mode == TYPEC_STATE_USB)
-- 
2.27.0.383.g050319c2ae-goog

