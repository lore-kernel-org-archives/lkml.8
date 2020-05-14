Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8723020722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itfwljKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgENUkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbgENUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:40:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30620C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:40:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so1899723pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orFzK+6AOl9Sz0N2w3p5SSg3SPmMkMh0jb6dZXjNAFs=;
        b=itfwljKE6dCaMRKBfaZdVJiDDpQn+H0q3OXHX0xEW0fAzV9TtKcwxa9k1icTMbgtZ0
         A9k5X9GRE6zHz1wJCAzI89aHn7KR/PTPtPxV3J2e+VHBcFhOErNlUKDVywPVq20aPhZ2
         vhFniAOOlpLdUP11cqpognmTQA0TE5CHef7034Z14rpHGwtzLEvhED6S46TaQoG9wPTJ
         Q36C/kBerR+9jXx0XTSbivpZx1ADQI3vOxWoQ2hrggQ6AjtserhKuzhX23jLf6qOg0T4
         CUfXaDJXbTG6wfe38nGgPUIikJDfRuFMczF4O+C0ftU03AgK+/ME+/xArEdUgQa8CuZz
         SsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orFzK+6AOl9Sz0N2w3p5SSg3SPmMkMh0jb6dZXjNAFs=;
        b=fkLDYflYEHHFMZaafeuqVZf7iOu8O+K9cdOpwWX+riTmQ6Q9fmc6wlXtClCAj3Gba8
         gTab0BrdKG4ivnpykjjlMr3DpuZfarvHG5bCeh1vXWWCBLTOZNNOYv+Ep2A1T5qXExgz
         DIn7eo8EPwSFoEdiLWh3Xc38HCgrUg50NOWg2i3dq4yDi4ybQ23VARIrsIy67mjSjXSe
         vTkT+fJQKtw2zQpHg5/NRozZ7phrV+1JmjxJpcauDBR7BxlwH+iPpDJyoIZAvu7DlfeV
         UmfikfsJRLP04ufmrsHgYp6AbNL58ZxmGhVm6L8ml/hLqfPe/6jBmPjWEX+4l8c3J7oy
         N5Cw==
X-Gm-Message-State: AOAM531LwSfrOOxUZxrCZSnWj/qvaHVAWe/OBgYdeoJLr1j5i8ETiPey
        NckRYnb64cGJdf3sTpb7lc7TMQ==
X-Google-Smtp-Source: ABdhPJwmToiAUSfM51heHoivdVVzk95N7v0Ac6EJD2j0gDVBAEZT/9rq66kWhN1DDxZLb2zR4zRESA==
X-Received: by 2002:a65:5186:: with SMTP id h6mr5926004pgq.453.1589488824707;
        Thu, 14 May 2020 13:40:24 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d124sm76062pfa.98.2020.05.14.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:40:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] rpmsg: core: Add wildcard match for name service
Date:   Thu, 14 May 2020 14:40:21 -0600
Message-Id: <20200514204022.24233-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204022.24233-1-mathieu.poirier@linaro.org>
References: <20200514204022.24233-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the capability to supplement the base definition published
by an rpmsg_driver with a postfix description so that it is possible
for several entity to use the same service.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a6361cad608b..5e01e8dede6b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
 static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
 				  const struct rpmsg_device_id *id)
 {
-	return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
+	size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
+
+	/*
+	 * Allow for wildcard matches.  For example if rpmsg_driver::id_table
+	 * is:
+	 *
+	 * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
+	 *      { .name = "rpmsg-client-sample" },
+	 *      { },
+	 * }
+	 *
+	 * Then it is possible to support "rpmsg-client-sample*", i.e:
+	 *	rpmsg-client-sample
+	 *	rpmsg-client-sample_instance0
+	 *	rpmsg-client-sample_instance1
+	 *	...
+	 *	rpmsg-client-sample_instanceX
+	 */
+	return strncmp(id->name, rpdev->id.name, len) == 0;
 }
 
 /* match rpmsg channel and rpmsg driver */
-- 
2.20.1

