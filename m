Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FBC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F2215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iN9Rmvvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgDXUZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgDXUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880CC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so2949323pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exYZpvChsSlo7lAJbJWuh/pu5cSD6aiCv7Lp3iIYni8=;
        b=iN9Rmvvnqh92eC4TVhJvXp9LrfV9PydbkGYoRVJklbytnIqLGmkGSkG1lI2zxCRgRF
         5M53EDEEzllMIdgoLfs1/dVl8b3pTJfORPir4EQsdGV5FGTSVHYNP6wQ3KcdmPUgPpDH
         YJvNHFBk/YBKfcyFuLNIun9KsZvifIbnoX14xisIiPXfuVfLDlPu6+PjVy9eWJ0Pun4A
         1SmSDGzlNT2UlssN6jOGylFsnYwa8kVifpktDTIW+H/dVnq36Vp+0AuTokOk9ojoWvGi
         cLVSm+hhmnpYe3VgiFbrN7OgP+GhT8Vp3GSAE0Q0lX+SM/8VROPHvcG/UzE1Le1Sr0m6
         TPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exYZpvChsSlo7lAJbJWuh/pu5cSD6aiCv7Lp3iIYni8=;
        b=DwbYdacXn3ADKMWMaz76V4Qc6U3NjwbrkQKY2szGqeYYDFXYzdFLoFFo3Q7U7oIXve
         fBURAAgZJvkH7DoUEC+P1Sl3wo7pwbj8nBRtWKkercAWQ4IJKbnURqhizdNGqIGdZ6yG
         WDF9Jv7iLYwLANdfjME1CHH2t3JX4LRMN4yqS37bzLFjixNtn28o95vK+poiLPJjbfvn
         lgotgtnfoTtHFmVv/4w/OOT4qEM5vMlh6cSHRQ9pZBqSLCwrIlnyxDnKdm5xki39k477
         Fz2lhSCDrYrw0m2uhRYpUMi4kbCM/Za6pL8s5iq3yhQRgRqEnA3+a8rSBY0Au2+dMy/u
         7SaQ==
X-Gm-Message-State: AGi0PuZPkkbbQSOXDeJrNG+NxUhDvadB6SBAlssKGlfJ4Po8w+HOuoAO
        JOl3/WfOXFX1HTDrAhi8CrYbvg==
X-Google-Smtp-Source: APiQypL5AzMQXq3gOoXlH0PVqgL7PRKhGgSOEjwcpARkI3Rx98coNs2TcHAu6I+2Ek+Xn1y8hG4T1g==
X-Received: by 2002:a17:90a:1743:: with SMTP id 3mr8488308pjm.106.1587759918032;
        Fri, 24 Apr 2020 13:25:18 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] remoteproc: stm32: Update M4 state in stm32_rproc_stop()
Date:   Fri, 24 Apr 2020 14:25:02 -0600
Message-Id: <20200424202505.29562-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the M4 co-processor state in function stm32_rproc_stop() so
that it can be used in synchronisation scenarios.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 404f17a97095..86d23c35d805 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -493,6 +493,18 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		}
 	}
 
+	/* update coprocessor state to OFF if available */
+	if (ddata->m4_state.map) {
+		err = regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
@@ -531,6 +543,7 @@ static struct rproc_ops st_rproc_ops = {
 
 static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
 	.start		= stm32_rproc_sync_start,
+	.stop		= stm32_rproc_stop,
 };
 
 static const struct of_device_id stm32_rproc_match[] = {
-- 
2.20.1

