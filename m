Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDCE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j4NUFdDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgE1Lgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgE1Lgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:36:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF56C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so3002726pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aetmZffC/VYWhAoJiSWdaLxj5uMG1G0uzkG3yOEJQ4w=;
        b=j4NUFdDiSKNsuRK2Zrns9qso7FMbc4ESUgqYhKj0n5tdtMwsxXFfu/1amO5pnMJHMG
         LenVIQ5xvcqpTkBgIlaDHSJNUedAMRmbEYajjOH3oMuFljOPGHG0S7tSyctsNbzODtNl
         H0QR8NbfpOp0V6p9GRSKrtf9NAuzfGhtxAC28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aetmZffC/VYWhAoJiSWdaLxj5uMG1G0uzkG3yOEJQ4w=;
        b=LA7Cp7Hu4xoRyzxuW+zU1Omod8+R/FkztPGl7qxvyq77eeKCQqwnPdzwcWb781tQwa
         VB2gZOkT5AUuxERUf3OLV5uY/MMgWkU4D/+K9eEhRr56lA3iwKT1KH2KKxDtywC1CmtF
         X+Bdj3ipNvgr4RjtIHi557D+CBCXvIO6gcdqcT2pm1asiz8hFvufOz2ktN1U4TDUONQE
         aKqHjHOCTc/v5UJnxBS7eeoGh4WBeosi6JGGMghQkIAuSMG5p8fFZS65SuqesSeWnzHg
         Lr6EeDoQouv+5WCOntsyK8yY90miOBMmqAK9OMpWn3Hts74VILoCis1qoL7QniMm3qHL
         kMHQ==
X-Gm-Message-State: AOAM531TFkXJ0y1M0A4WvgRsTYSReNDxH+N74dFqZx/HMIJzDBcfczCP
        /HjDYBQEe4ngUSdf9bPVBPmIDdC/y78=
X-Google-Smtp-Source: ABdhPJzKSF3RqKXSmPf2z2Q/fKi9A7QtJp3kgNKwOWtcyN+SbT77tSAGVqTBbav2iPql87KLtdum1A==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7mr2955468pls.293.1590665796202;
        Thu, 28 May 2020 04:36:36 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id g7sm4519961pjs.48.2020.05.28.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:36:35 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 1/4] platform/chrome: cros_ec: Update mux state bits
Date:   Thu, 28 May 2020 04:36:03 -0700
Message-Id: <20200528113607.120841-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200528113607.120841-1-pmalani@chromium.org>
References: <20200528113607.120841-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync the EC_CMD_USB_PD_MUX_INFO mux state bit fields with the Chrome EC
code base. The newly added bit fields will be used for cros-ec-typec mux
control.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69210881ebac..a7b0fc440c35 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5207,11 +5207,15 @@ struct ec_params_usb_pd_mux_info {
 } __ec_align1;
 
 /* Flags representing mux state */
-#define USB_PD_MUX_USB_ENABLED       BIT(0) /* USB connected */
-#define USB_PD_MUX_DP_ENABLED        BIT(1) /* DP connected */
-#define USB_PD_MUX_POLARITY_INVERTED BIT(2) /* CC line Polarity inverted */
-#define USB_PD_MUX_HPD_IRQ           BIT(3) /* HPD IRQ is asserted */
-#define USB_PD_MUX_HPD_LVL           BIT(4) /* HPD level is asserted */
+#define USB_PD_MUX_NONE               0      /* Open switch */
+#define USB_PD_MUX_USB_ENABLED        BIT(0) /* USB connected */
+#define USB_PD_MUX_DP_ENABLED         BIT(1) /* DP connected */
+#define USB_PD_MUX_POLARITY_INVERTED  BIT(2) /* CC line Polarity inverted */
+#define USB_PD_MUX_HPD_IRQ            BIT(3) /* HPD IRQ is asserted */
+#define USB_PD_MUX_HPD_LVL            BIT(4) /* HPD level is asserted */
+#define USB_PD_MUX_SAFE_MODE          BIT(5) /* DP is in safe mode */
+#define USB_PD_MUX_TBT_COMPAT_ENABLED BIT(6) /* TBT compat enabled */
+#define USB_PD_MUX_USB4_ENABLED       BIT(7) /* USB4 enabled */
 
 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
-- 
2.27.0.rc0.183.gde8f92d652-goog

