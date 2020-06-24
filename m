Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9793E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SeoLUlor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390357AbgFXIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388818AbgFXIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:09:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84093C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:09:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so803315pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crvfktu8sEfr9ASy3+ZnYnRxLtYlgrfMM9zKDqUyH4w=;
        b=SeoLUlorTbj6lTAD4Vr24Bi8/1rQd0SAnf7nC3Qyk9Lj8uXkE/biq8pOMkLKzO6W3e
         5d9ON3GRJ715Iu+3+LS+SuFVnPBeYR8yo1CdA+UvIs2yLOJ8BgDZY6OPg0jYqZ9uwBYa
         bNeKIHznnZu7pxWYfIj9Rdo+LGyIrdrLIvAHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crvfktu8sEfr9ASy3+ZnYnRxLtYlgrfMM9zKDqUyH4w=;
        b=uGxvMVJyE9NB3Of47vdbhcfT5z++UKKhOTEwRt48X5tzru5kWPq9wYkzAHyAMayU0n
         anbn+oMQQxgKx34rNwh7CXUgio25WC1fski5DP2hYEeCglBSLGMCCmy5ldu5O+OafFVy
         iAhfxT3c6KziWTjWN7gFIbCYbc+zRbQLSEO6/XaGOf0y5bDHroc5vCYmyWsLaVP/bvkE
         kpbrEFpDppZWBd0CDl8GoAR2acBbdzW7iZ2MIgGkVT/ILFiHobQtpBOMkU3V8ik9PFEJ
         Dj5d4rrxk7YTK+lTeuH9A0+xtAh865jsrY1ynRJQDgOx3oVHV2DYufrPv3SpxGcy0YAG
         KgkA==
X-Gm-Message-State: AOAM530JVk/w9l2EEXDKg1tFofDyX/P7yVJ/lqr4FXfq368RECXSzYsj
        ov5ZkS44grchPzyF0t+UnvGu+7wLj5c=
X-Google-Smtp-Source: ABdhPJy5qpZ1fllZp0yPrDdvVQH61oz4iXwtvyjde2p+2SnvM1R1/OJQrDu6H/KoiqEwzFD0EfAw0A==
X-Received: by 2002:a05:6a00:7c6:: with SMTP id n6mr26662788pfu.120.1592986174511;
        Wed, 24 Jun 2020 01:09:34 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id r1sm4421684pjd.47.2020.06.24.01.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:09:33 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Add TBT pd_ctrl fields
Date:   Wed, 24 Jun 2020 01:09:23 -0700
Message-Id: <20200624080926.165107-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support Thunderbolt compatibility mode, synchronize
ec_response_usb_pd_control_v2 with the Chrome EC version, so that
we get the Thunderbolt related control fields and macros.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../linux/platform_data/cros_ec_commands.h    | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index a7b0fc440c35..b808570bdd04 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4917,15 +4917,26 @@ struct ec_response_usb_pd_control_v1 {
 #define USBC_PD_CC_UFP_ATTACHED	4 /* UFP attached to usbc */
 #define USBC_PD_CC_DFP_ATTACHED	5 /* DPF attached to usbc */
 
+/* Active/Passive Cable */
+#define USB_PD_CTRL_ACTIVE_CABLE        BIT(0)
+/* Optical/Non-optical cable */
+#define USB_PD_CTRL_OPTICAL_CABLE       BIT(1)
+/* 3rd Gen TBT device (or AMA)/2nd gen tbt Adapter */
+#define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
+/* Active Link Uni-Direction */
+#define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
+
 struct ec_response_usb_pd_control_v2 {
 	uint8_t enabled;
 	uint8_t role;
 	uint8_t polarity;
 	char state[32];
-	uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
-	uint8_t dp_mode;  /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
-	/* CL:1500994 Current cable type */
-	uint8_t reserved_cable_type;
+	uint8_t cc_state;	/* enum pd_cc_states representing cc state */
+	uint8_t dp_mode;	/* Current DP pin mode (MODE_DP_PIN_[A-E]) */
+	uint8_t reserved;	/* Reserved for future use */
+	uint8_t control_flags;	/* USB_PD_CTRL_*flags */
+	uint8_t cable_speed;	/* TBT_SS_* cable speed */
+	uint8_t cable_gen;	/* TBT_GEN3_* cable rounded support */
 } __ec_align1;
 
 #define EC_CMD_USB_PD_PORTS 0x0102
-- 
2.27.0.111.gc72c7da667-goog

