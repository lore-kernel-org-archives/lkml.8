Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B08C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE39820720
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFvRYThJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgGNUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgGNUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so8048783pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLaqUlqIXEKDw6i85lizbwO407gGhXi2WgUCdFT1Ou4=;
        b=WFvRYThJYieMcZZcfrO7iKSQOtDiOIn11T8zg8cyTTY9mABDDOF4RU/XQKr+ZuWpRt
         pM1LeWbR6MW4SR16los784+NTr9yNy8eV+cE9JwNNpu7ZVPM0d8WFJBkDkGyUva2rLE6
         ELFE9UCIcL1bx5S0eqfJBslPX2Jeh4+U++df+fzjk/Axb/a5F3PxoCcrGva4F2RYfv+X
         CuQSCSs+DCJBaL5Y+ZTh/CJ05T4dX+hatiWX11kTEZ3u/c0maPXpd6OyC4KBNmLbS71G
         9fwODBOSaY4wl0fI6XmYygm+7rVsIgLaXsMxYbzn7w/O62WLhnJWZlI+w8AEJ2R2AODC
         iuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLaqUlqIXEKDw6i85lizbwO407gGhXi2WgUCdFT1Ou4=;
        b=rxxaKJwUcDrfeocXSaQYroKZIhoX4VPcRuoSC0eHpXN/ifEQwZuqGSIVxayaO7EA/n
         4RZ3C4TY+eTR3ksa8n65l7T2zHzstPjSWBYOpavDpP7eJZWoYqmwfdvRegwA6R4EfhMH
         6z2u30XTG8vS5/WDv65EJyCD2z9XVnYXMB6B+JA7lsuFZ2SdoHoRZJJJzYc9rwZ+h/I2
         V/oGCfMXILYU0gePyQoRQhGqBcgKANCLJRhmS+YvOrclNA4zsECArze7t3Q1xYd8c512
         Ex0Qpiq4POeHhjTrAIyJ0xh5IBKB3B+rZl+HwXPdNWhpyaf8GpsIPA2vsoSabnwyk3Ov
         Dgew==
X-Gm-Message-State: AOAM5336sXEhxYgtgk7oEm+I7dY6fvoVmap6Nw5w1ZOoXzug+LeyJLcZ
        fPjte3EEhHdzIfMcNta9iGTkGA==
X-Google-Smtp-Source: ABdhPJwNZcSXvJT1wtXgc68agE+YL1/Mrb+Az3kUVQCf8Y43dRW88sdoc4zonyyqrK61Li3XyFe5cQ==
X-Received: by 2002:a63:541e:: with SMTP id i30mr4735003pgb.47.1594757094489;
        Tue, 14 Jul 2020 13:04:54 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 05/11] remoteproc: stm32: Parse syscon that will manage M4 synchronisation
Date:   Tue, 14 Jul 2020 14:04:39 -0600
Message-Id: <20200714200445.1427257-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get from the DT the syncon to probe the state of the remote processor
and the location of the resource table.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 986f34a336a7..961a53f67ec5 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -71,6 +71,8 @@ struct stm32_rproc {
 	struct reset_control *rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
+	struct stm32_syscon m4_state;
+	struct stm32_syscon rsctbl;
 	int wdg_irq;
 	u32 nb_rmems;
 	struct stm32_rproc_mem *rmems;
@@ -607,6 +609,30 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 
 	*auto_boot = of_property_read_bool(np, "st,auto-boot");
 
+	/*
+	 * See if we can check the M4 status, i.e if it was started
+	 * from the boot loader or not.
+	 */
+	err = stm32_rproc_get_syscon(np, "st,syscfg-m4-state",
+				     &ddata->m4_state);
+	if (err) {
+		/* remember this */
+		ddata->m4_state.map = NULL;
+		/* no coprocessor state syscon (optional) */
+		dev_warn(dev, "m4 state not supported\n");
+
+		/* no need to go further */
+		return 0;
+	}
+
+	/* See if we can get the resource table */
+	err = stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl",
+				     &ddata->rsctbl);
+	if (err) {
+		/* no rsc table syscon (optional) */
+		dev_warn(dev, "rsc tbl syscon not supported\n");
+	}
+
 	return 0;
 }
 
-- 
2.25.1

