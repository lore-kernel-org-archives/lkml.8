Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45361C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1702311C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsdDtrFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgHFQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgHFQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:32:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EDC02B8CA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:31:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so10295409wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=EsdDtrFjKUuP/BZmW1CY5RL5QUtFRm/t/YE3QvhQTdrk+YOX9tnzBC0latfyhTZ9qs
         8KVYxu0ZlruiLUWI7IrSEYLEbcvX+H/yQUkSk56XHjCmwPye4lptZc3A7zxEL3YVLafU
         OItNjT8dnLBMs0XhcMFYcZq0GiyQomjZYUiQo48M2GPS2efmgAiiNfAYw12pXJAJJ96X
         2tCA1N8q8YLHEMMZIlbGu516lKAlTucgsDZIpq8USikP4h2IQNYQSF7mBkp9UXgGBJbe
         6wIk2DN0bfrxIP8fSAAqEcW/aCl+LyJurk/yEfc9Mup+DUwPz5A9aJpNxU1+fE54GMHT
         T+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKzq9Wd5pDbV7/549EiQnkURmwLmMM//csWdIgiebW8=;
        b=LP6e2wiFrmjbsVDzh9KV6+jHfycrJX49r0vVdhLscjnfpEtTbyOCcbpZpRy6qC3Y4j
         R9D5Wary1VZpX2yHCTFE4431m50U3VD6TjGM3dqrNSxekiC13bkpTAMZ6kqUBgLK30ut
         CyAYw+HlsaxN2Mpd43DdY2tFPv1uxWMDF+YQVlfnXK7obhVZhpMLudiCFTP9aMWwmPqn
         iC3hgvz4VjA+lrXFJsHijMiUtVyaM0PTUIbfPRLbeUbSxDU7Y8gyUKLS+t3wdfZfKN/I
         ubcYBC2R8Okzg+vH+3WTyzQYbN3X9z07lQ20FJ2USXqGhgyGMwHqMj2V0yIcGqYwbedu
         nbkA==
X-Gm-Message-State: AOAM531GKAVR8lr8Lpb7BK1/txwVS1bV1xlVnhwkE5C6vovAriBRA/7L
        hritJrGEzBk/VZJeESRt3JNbexob4iA=
X-Google-Smtp-Source: ABdhPJxZbZm/odYmDQ8DR2AOCKo6562W7Nk3ONEMqBOj1UV79/ieFMlhXi0Nu7sq8tAmdAKGm7E9jg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr8721197wmb.178.1596731498457;
        Thu, 06 Aug 2020 09:31:38 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:37 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] interconnect: qcom: sc7180: Replace xlate with xlate_extended
Date:   Thu,  6 Aug 2020 19:31:25 +0300
Message-Id: <20200806163126.22667-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index dcf493d07928..a6f119f363b1 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -535,7 +535,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
