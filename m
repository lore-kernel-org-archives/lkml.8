Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B656C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F5D206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZFl1+Jgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD2Fov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgD2Fov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 01:44:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512AC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 22:44:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c21so447976plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDFxg++eD1+RNatg0LEkYVk+fTXxx1+fMgnRzfGeuOc=;
        b=ZFl1+JgulcKUI4Z0turXxsq7c5UiKjHXVoMW4gqGdqvgC5/w/9mW4JfWjmr6/sTvkK
         ALmTcejusRpPD0UDoLgCrO97Fqh3ZZC9WKdgm1zH4uJO9Od1pbqbXBzYrJKUEEay3m9P
         B5iLs4A9nyz/fj+th00q+bnVie+LKBIUMYPZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDFxg++eD1+RNatg0LEkYVk+fTXxx1+fMgnRzfGeuOc=;
        b=oN/FAEjxiL+5A773wJcoLFvl/ODf/T0tFrHTN8FIa+mrHex2LNZZa8cFGgs2qd7XvE
         c550HKWPH6OUIfGF0Y4AMs79K5R0FVIylfWzvBVdEr2kMzxJB6qJoNZRYo7XmBPFZqsb
         XyMjapGX5GDMm9lqEoiikbAONYwuITg8/w20QhLWHrFvXbJZALhYhnoXwm2McDE2t8JZ
         R6Au66Ks86YU6U2do5sErrgbD/T1e52gSnEK2i+jfok8RHwBNIA5gn+1S8qBGyHGFLWI
         PKMUJ/O7eMwhM10YaC3boBA+DuXvUBDKSZ4gm8tm+rpayTk7KGencw2TFg+5zDA1yOQv
         j2mA==
X-Gm-Message-State: AGi0Pub7u2WA6TwPHz4URjZx8oh/xlDhM+QUOVrDuMsIjhXcFPOD4jSk
        3Q27a+AzRVhR7mVozizi0xAeb4Oygsc=
X-Google-Smtp-Source: APiQypL/MIbg/9tjxnw8dIUHOPEjuIZxgqb1N0yLpBKAcO7Cau6XF3Y87vR/NySCkF2shkCbsPnlqw==
X-Received: by 2002:a17:90a:e38c:: with SMTP id b12mr1158873pjz.102.1588139090096;
        Tue, 28 Apr 2020 22:44:50 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 141sm79944pfz.171.2020.04.28.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 22:44:49 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, bleung@chromium.org,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB TYPEC CLASS)
Subject: [PATCH v2] usb: typec: mux: intel: Handle alt mode HPD_HIGH
Date:   Tue, 28 Apr 2020 22:44:28 -0700
Message-Id: <20200429054432.134178-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
0.6, when a device is transitioning to DP Alternate Mode state, if the
HPD_STATE (bit 7) field in the status update command VDO is set to
HPD_HIGH, the HPD_HIGH field in the Alternate Mode request “mode_data”
field (bit 14) should also be set. Ensure the bit is correctly handled
while issuing the Alternate Mode request.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
---

Changes in v2:
- Clarified the commit message to mention the proper field names.

 drivers/usb/typec/mux/intel_pmc_mux.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index f5c5e0aef66f..c599112559e7 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -157,6 +157,10 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
 			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
 
+	if (data->status & DP_STATUS_HPD_STATE)
+		req.mode_data |= PMC_USB_DP_HPD_LVL <<
+				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
+
 	return pmc_usb_command(port, (void *)&req, sizeof(req));
 }
 
-- 
2.26.2.303.gf8c07b1a785-goog

