Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4EC54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8FC2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9gC3dB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgEJUcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729377AbgEJUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:32:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:31:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so3753507pfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KiTiJrfrc9OVCGuZbos3d47NLpXfJnte4vSA/u87SI=;
        b=A9gC3dB608EdDSmZiIs04DyzufuimTcBcTwntuIDBL7fRNDYiRum2ReDQQgmtsoABW
         ckocj4U/0MNHD1313IpNaF2kxU4zz3+jqLXcgSnVqpHCk7L5xfx67oW5cuky1x4i48+D
         hZhxpf+FPzamsqW7Km5npGqFwgUnoGP41i+8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KiTiJrfrc9OVCGuZbos3d47NLpXfJnte4vSA/u87SI=;
        b=qOIPzRcMRr6NuwwphPAzhBsyaFEBD9uyAYETlRp6A2aVrZR4kGKejTWBnBPvX5HukM
         2bqutGoVMAnn+6hziT9pUHReY/d5lCojdpSCPS4UiVKH5BpVBOZzLiUPAXMmIZfQA0Mm
         F9moJAEfqgSgPklrCdMJAQBH3zOu9wJpgCLSjMg3gBwffqiQdrKxKnEwYnYYmgCafnBv
         yDX9vlC5F6F008wZumN5ozCSTwNvILo0fC+swbfv4MLOBya4ErNSmY+/NOnosKy3IyyC
         fnofI8zqCX1geriGfRhSUwKPvqME3tVwXQeEt7O1z67jLm+xXaRQOrpc10kWJxWD6tyn
         Rezw==
X-Gm-Message-State: AGi0Pua4sIHT91KhFOWGPGPXDBxC6KgoYneoRYGu1u7St/SzrUNxt/GR
        rc6N6t+vV1ToDhi4HzTylAdDAyGFRV0=
X-Google-Smtp-Source: APiQypJCRQLdsw9Fe1HgOwYYJLrkhYfsqX1sxUkQfq3pTFPjcTycIcITLoMmcvS0/tuAMDUBYZhxUg==
X-Received: by 2002:aa7:8e8b:: with SMTP id a11mr12736041pfr.62.1589142718963;
        Sun, 10 May 2020 13:31:58 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p7sm6189094pgg.91.2020.05.10.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:31:58 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC CLASS)
Subject: [PATCH] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
Date:   Sun, 10 May 2020 13:31:43 -0700
Message-Id: <20200510203148.122364-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
0.6, the PMC HPD request LVL bit field is bit 5.
Fix the definition here to match the programming guide.

Since this bit field is changing, explicitly define a field for the
HPD_HIGH mode data bit.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
---
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

