Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CF920720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KooBIrBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgEKJTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgEKJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:19:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E44C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:19:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so1773819plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppxdbt3wg6MpIF6v81oAC87+g3QZ9WcD03ZvmbvZ7jo=;
        b=KooBIrBrKy2TJB19MW7e2qsWNTWX0dA100ZlIF0uciPLcyEUIJSs5f8ZptI3u3/f4X
         Q24IjVNjCwceInSJapWSqkGySEbcZXtbXccRUT+2/9jpb+1slxRqqDOOVGKMHMfHYmcy
         /G61tkg2Bf5s+qSA3A9YBqj2O49eh9L2nmDow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppxdbt3wg6MpIF6v81oAC87+g3QZ9WcD03ZvmbvZ7jo=;
        b=eBgyMSw/CHWLOgLvN9pJ0ts11d9hN6y3vfZhOwlf5T7FP8zQBKarhAVp+PCu6g3s/F
         R6WkimPe5UMNC3KjDGJF6GeQo04lLRmM+8c2NBhMcSNhcCBNv0xn6Wi4hsKg5UQhCr5t
         M5MGddCY5j5V2cO2VlKpb3efEQ2g0JTUGnpbvybTF1o0G1A2SLvJBeSlXQ++YWJtE7gt
         LnhcWV9oJiyCAteooupjd+jALPLhFW1fCjR/VCc2aqvB7Xv1lk7cLNNpdypsOyN7qYw2
         Oq1ZlD9+w0eyst1t+Ke6m2yrQNKRBe9PTCmyHp6te0RtCDuhpwuX1FEGq256JXszifyw
         hr0Q==
X-Gm-Message-State: AGi0Pubf7yrUcIUQRlRsSKZYNdti/cbAZm+7dgVAXEIC2E/g8DAj30v8
        Q0cIH8DGEHMkvL1bOCi5rZgEc/tFEvI=
X-Google-Smtp-Source: APiQypIKCKIALdTDo0hz8f0hTlj7IJPYcUvpahUaYzvMCI2N6KnD5vj3bMeXrtdgvZfoKMXX13Wf4g==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr14078504plp.148.1589188746465;
        Mon, 11 May 2020 02:19:06 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id x19sm8678535pfq.137.2020.05.11.02.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:19:06 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org (open list:USB TYPEC CLASS)
Subject: [PATCH v3] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
Date:   Mon, 11 May 2020 02:18:34 -0700
Message-Id: <20200511091837.102508-1-pmalani@chromium.org>
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

Changes in v3:
- Fixed sorting of the bit field after modification.

Changes in v2:
- Fixed bit error in commit message.

 drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 67c5139cfa0d..c22e5c4bbf1a 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -63,6 +63,7 @@ enum {
 #define PMC_USB_ALTMODE_DP_MODE_SHIFT	8
 
 /* TBT specific Mode Data bits */
+#define PMC_USB_ALTMODE_HPD_HIGH	BIT(14)
 #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
 #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
 #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
@@ -74,8 +75,8 @@ enum {
 #define PMC_USB_ALTMODE_TBT_GEN(_g_)	(((_g_) & GENMASK(1, 0)) << 28)
 
 /* Display HPD Request bits */
+#define PMC_USB_DP_HPD_LVL		BIT(4)
 #define PMC_USB_DP_HPD_IRQ		BIT(5)
-#define PMC_USB_DP_HPD_LVL		BIT(6)
 
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

