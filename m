Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27824C54E8D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091BD2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWUJzpjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgEJVjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729286AbgEJVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 17:39:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB226C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:39:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so3609552pgb.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iANHJ7e8F5rDDMVEjkVBLCo69M1YwvfzRbabUbcHS0=;
        b=KWUJzpjb8WH9ULV3vl9koElUYI7lAPqQklNc9+B5rhLu1VpuK4IJw6cmnSXeqEnSv3
         zhgs5jwJ2TAJqjE8UGd5rvJaFlHPvr2ZIoUCBSC/HMuXMQDDe9TgmmzZO/aSu8FKzpIg
         KYykPqbQDAyERQRSKplXsZtz7OiX7RF5IJP6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iANHJ7e8F5rDDMVEjkVBLCo69M1YwvfzRbabUbcHS0=;
        b=OFno4yZA9oneVfyCT+TABbtoCcaH+Up5IDRaC2t5nTGj1aasIp1Kac9L/fQRhdY8eA
         EePYaZ6+wSeajBi+xAbxGi1prQYwKvaH7Q1vntaAIvEYRKmnfL6KGqdzlXqcvDy85X6e
         27dSRkxoPYha3HfX4q2rh0Z+1cKii6Ph3XqT5xsGkTfwinqMZUvnxV51yXdHLg7TWEKV
         TIWOnc49HWH6O2SWvI5phnmmYTjkiGsPNpis4JCanXf/j8si0695hubhA2X+whCHeD/a
         1MR32F0kIINamBhlxgPJLb99VK7vF+831MQKEXWLnAU7Lsf3NgkEKfMe51eAGA5faQSg
         THSA==
X-Gm-Message-State: AGi0PuYvkLZO5hKyT/KU51lSCdicex5BLVk1s8LAHyt+FZFBidz8/5/2
        Bko/eQnBpT7hF5jgRH8FKSR0DIL55x0=
X-Google-Smtp-Source: APiQypJJVDX5qnULq73bi9k/KREKzStiDcOJ9/EvkpsbfF7ziV55GHM9UIoV9qrUL8dmKXrJ8x6e6g==
X-Received: by 2002:a63:742:: with SMTP id 63mr11894197pgh.33.1589146781125;
        Sun, 10 May 2020 14:39:41 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id c1sm7463314pfo.152.2020.05.10.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 14:39:40 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC CLASS)
Subject: [PATCH v2] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
Date:   Sun, 10 May 2020 14:39:30 -0700
Message-Id: <20200510213934.146631-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
0.6, the PMC HPD request LVL bit field is bit 4.
Fix the definition here to match the programming guide.

Since this bit field is changing, explicitly define a field for the
HPD_HIGH mode data bit.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
Reviewed-by: Benson Leung <bleung@chromium.org>
---

Changes in v2:
- Fixed bit error in commit message.

 drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 67c5139cfa0d..15074aec94eb 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -63,6 +63,7 @@ enum {
 #define PMC_USB_ALTMODE_DP_MODE_SHIFT	8
 
 /* TBT specific Mode Data bits */
+#define PMC_USB_ALTMODE_HPD_HIGH	BIT(14)
 #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
 #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
 #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
@@ -75,7 +76,7 @@ enum {
 
 /* Display HPD Request bits */
 #define PMC_USB_DP_HPD_IRQ		BIT(5)
-#define PMC_USB_DP_HPD_LVL		BIT(6)
+#define PMC_USB_DP_HPD_LVL		BIT(4)
 
 struct pmc_usb;
 
@@ -158,8 +159,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
 
 	if (data->status & DP_STATUS_HPD_STATE)
-		req.mode_data |= PMC_USB_DP_HPD_LVL <<
-				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
+		req.mode_data |= PMC_USB_ALTMODE_HPD_HIGH;
 
 	return pmc_usb_command(port, (void *)&req, sizeof(req));
 }
-- 
2.26.2.645.ge9eca65c58-goog

