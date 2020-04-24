Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3AC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55FB2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qn5e5cwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDXEy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXEyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:54:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA47AC09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:54:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so3482531pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgfluhA4o9GgClkBYCNW13vXSmjjsiy2AV2QktrmyMU=;
        b=Qn5e5cwaikIVGeMNavK2TKUVwo1B7GSRSSg9PjyR5r7ZDh6ETN9O2fpo7NDnLJpB16
         rOWcqxfVvmwTn04Ahy1q4fx6A5mudVuiLfXDQ4EMpNWDyc/UrQpaqh36SqJSPEbzBuvx
         dINlawAr2BIOGBdL6IHoXO19ofPaoSoo0gbRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgfluhA4o9GgClkBYCNW13vXSmjjsiy2AV2QktrmyMU=;
        b=TlAtgrvulXCVhnvC5VZxVIU+mqtHlYPhZfio4aMhWcWT0aiKN+sD68M05OpDUxjiz5
         j51aa40MRoLkYNUXQ8gbI5ewya5ASR6e2mjg59j18TfLJ24I0+NIX/5N21CZAT9+LANF
         3Zw7iwfSjwgJJF7e7tyo4VIueM3LLS89SPpVG8IPYJAlY+3pNIrPDj1cisLVg57pkUZp
         5Hg2/rFjm0WT84EGpJP//BjyYLMU6qnX4gemrJvPUgW/+QVZwuM1J30T8Uov1JjviCWS
         MFZbN+NxMOgU9f06yFSMiHWJ7SVoQcuzdT1+GIsIC2TvI0blau8ePlym8tE/qnA8j2Ub
         8B8A==
X-Gm-Message-State: AGi0Pubvg4cEQcfNM3Z6/XrvxRzpXGgkXBPXvQkKNWHDJ7E2Hj+bR8C+
        D/SKspdSGEl7duOApaC2Hjc9qnqKgm0=
X-Google-Smtp-Source: APiQypL1nl3kPHkvfAWu17BMV6TTkR+DpK5VuCgPjoEHDgHOfIy8cu8QESaFg4V7vDVkBKQZlk4ywg==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr4358869pjh.133.1587704057460;
        Thu, 23 Apr 2020 21:54:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 62sm4344680pfu.181.2020.04.23.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:54:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] soc: qcom: rpmh-rsc: Loop over less bits in irq handler
Date:   Thu, 23 Apr 2020 21:54:13 -0700
Message-Id: <20200424045414.133381-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424045414.133381-1-swboyd@chromium.org>
References: <20200424045414.133381-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl returns a u32, and BITS_PER_LONG is different on 32-bit vs. 64-bit
architectures. Let's make the type we stash the readl into a u32 and
then loop over the bits set in that type instead of potentially looping
over more bits than we will ever need to.

Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 76e0294a672c..462dd267afef 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -365,13 +365,13 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 {
 	struct rsc_drv *drv = p;
 	int i, j, err = 0;
-	unsigned long irq_status;
+	u32 irq_status;
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
 
 	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
 
-	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
+	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
 		if (!req) {
 			WARN_ON(1);
-- 
Sent by a computer, using git, on the internet

