Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F892075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fY4oVKEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgEUBV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgEUBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:21:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDCC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so2476632pfy.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrczHrPxmDimhB0/0NhkdkJAAqMI1FXR2cfHE8LPPuw=;
        b=fY4oVKEYigIgJbK5QhuEyLd8h7DXZOm903dplBUrm1W9BNFia4NyZ/trpNvPcuDS8y
         F9Z9dECpyL2syQ4GNkBgc0n3MB/+H5L/cQ/LhzSwilLxrIbZfG27fd8qVN1yDalnlNOS
         QWLMG4JBz26Jb6L0ajjFHTgGi3S5Divls5GSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrczHrPxmDimhB0/0NhkdkJAAqMI1FXR2cfHE8LPPuw=;
        b=Qw5hBXvR4G89rUL70XMmPVYrvbyXSOLLihe5ID2A1BxENHUkShSO45tmViUVWvQO3R
         TL+JzaXydOjv5/P/N3tv7wAhn6fhn8BzuX/hwDvdTuSTltMHXZNJ4+LTE36MqhHly+UK
         X12cuYEROo2i9IaQuGKwtkNovggckaBR4+vvuc/Pd6i00K6QiHrbQ2OTXfCbhW/20nml
         SNG+GsNacsD0bwfH7bPXJzLbp3Cm2/7yL2hko6AjGh/PUfQrw7wSfp3FHDliwAygUUUo
         y9qsj1J1zhrup1S5u7fbhKFNCm5yWEO4A/CPtiwZpIhK6AFPJyElVVlOcnMjZCWO9IpW
         uxeA==
X-Gm-Message-State: AOAM533IZhPY6WYn3V5AT9yQFwTuyJR3QWP5ZJgFnKYnqb+x2dKwZxUk
        nZmcwLIITk7WmJrFXekr6NrIiN+PRFU=
X-Google-Smtp-Source: ABdhPJyC2aXpth0JL0PPxOCTcL8YxZ8CIfVZzeCBJDozDwlTldiKu9T91PGvQI9ZmJzYkJ1360k4aA==
X-Received: by 2002:aa7:9e90:: with SMTP id p16mr6935503pfq.38.1590024083536;
        Wed, 20 May 2020 18:21:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm3081020pfa.111.2020.05.20.18.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 18:21:22 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 2/3] soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
Date:   Wed, 20 May 2020 18:21:18 -0700
Message-Id: <20200521012119.238270-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521012119.238270-1-swboyd@chromium.org>
References: <20200521012119.238270-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
index 60fc56987659..ce725d4ff097 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -383,7 +383,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
 
-	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
+	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
 		if (!req) {
 			WARN_ON(1);
-- 
Sent by a computer, using git, on the internet

