Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B34C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65D520728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEKoiDnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDYRxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726392AbgDYRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:53:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB0C09B052
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so6271022pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6BvBkudSN6hkasbyZGWSa3w45a+c98m9U+hOofx/k8=;
        b=NEKoiDnc0Wi50X0JTm+A+6re24GlOXXy5EwslehbGg0ESmM/naqdfJB/7zVnENvn69
         Z/cM5xkv/B7Fdrh+1Zx7IxuMskOWEsYDAjLG4TZUzDLEH6WR4WNKDjGutqvyCm0q4slz
         kmAsG9fOvfK1r8wsPo0HvsFFdIiB6lymJBFeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6BvBkudSN6hkasbyZGWSa3w45a+c98m9U+hOofx/k8=;
        b=paFolDrXVz5JUDgPGAeeCNcr0j2+ZndkrHVbZ6vg3GdUWjE0m/ZXzcF99iS1MiypfC
         j5fsPsh6MPrLTcIh+B/tOarssQQ+oOWeu+nBwdveJKDGl6rIAHzf4teMB/UCqcl9aJWT
         Jg6UUciCNUTFhiVXO8yRi53TbA3m5GWiaSlyz2DWnsJz9+ysQZS8zRBa/QNQl6TAI7zd
         Ga+egiTXumO9Pgk+ENyPqHq5pexJ1I+viMdvQs0Cv8rEaeXjRfb/P+03+Af2QeO+35Qn
         oX8gvwEHVUYQamyp5oEvog2n2cgEo10KwYvkm3ckGCncd1JDJH3QD/6U8/5AbbBZD20E
         1CsA==
X-Gm-Message-State: AGi0PubL4XGXX8O0kKQeDCcI3dQfX7SrlTmaqCMfnNt/oaguCHN1cpvf
        BGaRL4ZGN1yXXRTF+/zLa5Cp/w==
X-Google-Smtp-Source: APiQypJaAykefOasRlVrm2hc/uuRjttMHBxajhPlVnDwiTfDYgBwedKFua0ICaPmzcIH4jLmretzWA==
X-Received: by 2002:aa7:8a9a:: with SMTP id a26mr14699121pfc.77.1587837196403;
        Sat, 25 Apr 2020 10:53:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v127sm8342148pfv.77.2020.04.25.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 10:53:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/3] soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
Date:   Sat, 25 Apr 2020 10:53:11 -0700
Message-Id: <20200425175312.124892-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200425175312.124892-1-swboyd@chromium.org>
References: <20200425175312.124892-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl() returns a u32, and BITS_PER_LONG is different on 32-bit vs.
64-bit architectures. Let's loop over the possible bits set in that type
instead of looping over more bits than we ever may need to.

Cc: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 3f4951840365..28121a32a434 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -371,7 +371,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
 
-	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
+	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
 		if (!req) {
 			WARN_ON(1);
-- 
Sent by a computer, using git, on the internet

