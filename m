Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F89C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DDB20720
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miob1jqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgGNUFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgGNUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A1CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so8091577pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOLpDhUaI5YvggRlgo01SV+Tf6RdV3ahOTchedkHuLg=;
        b=miob1jqq3uyJWDK9ehHABuSktDa5Dsm4+0451K6rGGo5B3KyWsNDs4e5X+wFRxTVeq
         To5GMy0VfU2mFj7H8BeWp2p1pHYsb6ZtVxpCTupv7HY0xRWCgnekld6iDJwip0yq5y1y
         aCStCoIiKicPpeHwSqWvOTKd1pQD1QTFRvZPlEMia/WO3oqWxceKUyWDrt2M4az+zwqm
         wd+cXATvk3FyONmAIFkJaAIN3/1PpvpUKbK3nMvbVeBmIBtfB0NNA9ZAZRrXYWn5n+I+
         fsGo79c6oOaV0L5pjzm0EIBAITNsPyFjht7r0mcoQCaDb+sUsEpSxWpghrI9gXmHW8U3
         jrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOLpDhUaI5YvggRlgo01SV+Tf6RdV3ahOTchedkHuLg=;
        b=XRtZHsDG+IG4pQ8zOBUVFikPLVvND1trO+BYNz+2D1uUtEDGZV9p79Knvu3fe2X+38
         Esspf75moF9AxEDPkmgQb1VjdS/UpvsG2zmlfFwx1YJ37QkkNQUTs7phDuvXMwfGdoq0
         HxIgKreqxXm6i4p+gXKLRr8vf47VxK4feJtEYJ0X57zlkxzumSeH7oLG+2oFD/laQL0p
         4tjvO0XnNkXAt0a+M3jGAIfO1EFlGhxZXvLqap1u05RDozSdG0P4Nebzx1628yvQu+D1
         KLX3NXheg5ExmVDsxa+5zkdNMHg6u4MHV3g7FYKrCZ1+QV5pwdBAgH1qzdy2uU1CyrRS
         lNpw==
X-Gm-Message-State: AOAM530FcPuCiytFhm+n96JntcxvdCCm6IHCmc/97RYNPBUJ3EJZ+dN4
        /8tc33cMekKOIBKOzH8x0gjnWg==
X-Google-Smtp-Source: ABdhPJz6mKLieZUUmXU9lcTrNEVXgWxB8eIfhND2OLgaJYj0xFmOUrJ3RIeo/P99+TTmJnFR5Te/IQ==
X-Received: by 2002:a63:d806:: with SMTP id b6mr4287879pgh.403.1594757090379;
        Tue, 14 Jul 2020 13:04:50 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 02/11] remoteproc: stm32: Request IRQ with platform device
Date:   Tue, 14 Jul 2020 14:04:36 -0600
Message-Id: <20200714200445.1427257-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request IRQ with platform device rather than remote proc in order to
call stm32_rproc_parse_dt() before rproc_alloc().  That way we can
know whether we need to synchronise with the MCU or not.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2973ba201c1d..c00f60d42ab6 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -262,7 +262,8 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
-	struct rproc *rproc = data;
+	struct platform_device *pdev = data;
+	struct rproc *rproc = platform_get_drvdata(pdev);
 
 	rproc_report_crash(rproc, RPROC_WATCHDOG);
 
@@ -554,7 +555,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	if (irq > 0) {
 		err = devm_request_irq(dev, irq, stm32_rproc_wdg, 0,
-				       dev_name(dev), rproc);
+				       dev_name(dev), pdev);
 		if (err) {
 			dev_err(dev, "failed to request wdg irq\n");
 			return err;
-- 
2.25.1

