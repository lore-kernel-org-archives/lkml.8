Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB70C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CBC206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGDezAuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgFATBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgFAR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2BC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z64so3837068pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5BZPTZAmXxklJpoMRb5vD0GYMFXpjrq4/dihvCieGA=;
        b=oGDezAuwIcD3h/JVFiFkScpwzDR7DBlQ3K82qjR89+nwgkSaq0E5YppwnXKytVSlas
         dl/hRrPjMDN0njFWBVSKAVG8aR6rmRXgaxqwVvmhmdk2DKf6XYFQIaf9Eavl3reRURgG
         4VEQIvfKLORMIIs35V5Mm8PL7qzFCVvr+tQ1uxZG6vBedJTKCkDSH6rRJC6hMMaRqZEO
         Y1YAuNKI1gQ3YObz3ty3IXa5OyI1bnIprq3f84lh9LlQnL03m3dce8SwO14bW/NuHYM3
         5FXETrADg+UOjJ5EoctZZ4Ix7VbLhchbCdEu3YuYtK8CejO9iOCwSu3PY5LVK5LaBEhj
         yPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5BZPTZAmXxklJpoMRb5vD0GYMFXpjrq4/dihvCieGA=;
        b=Co570YDfv6Y2XUYTRIbQ6oNOJLdYr7ahcgnblgTpMco+Wk3k4N1vavvwMYWN9zaYFE
         ksonNqlJoZUh9WTS80zbvPVuKUnMEWZUzwvaMZpdn8P4rPggAzZ39i5SxD/5Hz5T7Ttn
         hhF3//Li7MnKZw1+dhdt+cZVCEWS++UQ84HkuGmN2kWw2WL1snrnenfTh3DmmrrKgaCk
         KedH2gXEdwCdJWTStWeWYxnTxxQrs2jSWkQokByTfNqMgPjA94DwAauAOOm3xBq0/Rgn
         Lmo8u/eZS5LkC+Nqw5YZOyMidOlU4whRJ9CTF23jG8Rke6UTQTa4aloMV1K1WbEaI1Vx
         e7Xg==
X-Gm-Message-State: AOAM531sR17UlIdjWVyS+WgODK9UKejY1y9Ns0vjB5m7Nb+8iTTjeixD
        wb1Uyw1MkXscArooA7B90JFQUA==
X-Google-Smtp-Source: ABdhPJxrhPzy4O3NyPsLmeg5/fP9w0+e83//FkVHlGYJSYKm29+DOBd/ogwZCnOjBob1eTm4pfRdqw==
X-Received: by 2002:a63:3c11:: with SMTP id j17mr20781628pga.70.1591034160056;
        Mon, 01 Jun 2020 10:56:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:55:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/11] remoteproc: stm32: Remove memory translation from DT parsing
Date:   Mon,  1 Jun 2020 11:55:45 -0600
Message-Id: <20200601175552.22286-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than one has to be done after the other, there is no correlation
between memory translation and DT parsing.  As such move function
stm32_rproc_of_memory_translations() to stm32_rproc_probe() so that
stm32_rproc_parse_dt() can be extended to look for attach bindings
in a clean way.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 1e512ddf2591..3e3b199a02c1 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 
 	*auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(pdev, ddata);
+	return 0;
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
@@ -633,6 +633,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = stm32_rproc_of_memory_translations(pdev, ddata);
+	if (ret)
+		goto free_rproc;
+
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
-- 
2.20.1

