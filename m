Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D07B20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFF7Iduq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGCVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgGCVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:23:40 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCFC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:23:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a6so11549056ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOZruoDFDXv5kLGp9J9FoBUytV2ZuP8UVxYNd0ERIPw=;
        b=SFF7IduqK8G6MhS5t5x3A4loCCSNpXlU/vcFEq44zuOhsuUIuL9X3xebW5rn37ffhK
         vReqYlp/FW149sVy2BhJUkAuTw9y1wGoVmsdpv/eqHR/iu7GmOr4D3gy8Y6TLmYi1K/T
         MuwR3Qtgm63pdp5TN2QJN5i7Z/4Cm+vq2+BPEW2UlO8xL5odTRCvfsjTtySnYh50RTwk
         1dCSOUA5jVUDHSNZrAxnspSMXOlUr1G+Qf7IKjPVrAa57hHGJ+I6qps+0H3OUWO68ZPY
         oNwr1AJLa58H609yScK+jSqGsRmWZbtjJFeipgUJExrrp+DIH+vUhVIGqSLPmvmH+dv0
         qnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOZruoDFDXv5kLGp9J9FoBUytV2ZuP8UVxYNd0ERIPw=;
        b=ZZkXR7ayatYxsDIS1zKM/XvEwScv9BDkWFHb6ps7NoChmJ0+jt6HdLDXnwHQt9zoZz
         aVjlwImNaoynhy93PD0lWtCZRrblgN4ubG5yXe8OjzvkfSJY4Td1dDJjtsX7T7MmuRlp
         3+S3ltBYaDmT9Osb2vef3fpR6XTK2zWIqKagr/kiMhMSjstpju8GsYIYs7ZreAc47Hq/
         K1qTLC1yrd7VWLJj6HMd1XILDMkS5Uq0mwQjhtU5t4kloOWuAve4dQCGtqkbnJ0fc+Xf
         IJQmhhk2lNbtaOTPceMEh9/tDXIm795XDR2M4Uqw83qI8znoO0fmWoFdse2KvMX+esmq
         VbdQ==
X-Gm-Message-State: AOAM5317ipuFcyNoAMBstiET0u0/FnILsemRTYfR3vSYSGJAydV3CWH0
        qnjqI6poxXYyeoBW2tihVhCXuA==
X-Google-Smtp-Source: ABdhPJzd2ewsFruwmxIfzsQDQR1WJ6igBFAXPgq3+XijH73+x/sX+9JIniWbRhBLw7MHTREUQRVdjg==
X-Received: by 2002:a92:c530:: with SMTP id m16mr20147548ili.300.1593811419265;
        Fri, 03 Jul 2020 14:23:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m6sm7485292ilb.39.2020.07.03.14.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 14:23:38 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ipa: introduce ipa_clock_rate()
Date:   Fri,  3 Jul 2020 16:23:34 -0500
Message-Id: <20200703212335.465355-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703212335.465355-1-elder@linaro.org>
References: <20200703212335.465355-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new function that returns the current rate of the IPA core
clock.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 6 ++++++
 drivers/net/ipa/ipa_clock.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index c5204fd58ac4..0fbc8b1bdf41 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -256,6 +256,12 @@ void ipa_clock_put(struct ipa *ipa)
 	mutex_unlock(&clock->mutex);
 }
 
+/* Return the current IPA core clock rate */
+u32 ipa_clock_rate(struct ipa *ipa)
+{
+	return ipa->clock ? (u32)clk_get_rate(ipa->clock->core) : 0;
+}
+
 /* Initialize IPA clocking */
 struct ipa_clock *ipa_clock_init(struct device *dev)
 {
diff --git a/drivers/net/ipa/ipa_clock.h b/drivers/net/ipa/ipa_clock.h
index bc52b35e6bb2..0f4e2877a6df 100644
--- a/drivers/net/ipa/ipa_clock.h
+++ b/drivers/net/ipa/ipa_clock.h
@@ -10,6 +10,14 @@ struct device;
 
 struct ipa;
 
+/**
+ * ipa_clock_rate() - Return the current IPA core clock rate
+ * @ipa:	IPA structure
+ *
+ * Return: The current clock rate (in Hz), or 0.
+ */
+u32 ipa_clock_rate(struct ipa *ipa);
+
 /**
  * ipa_clock_init() - Initialize IPA clocking
  * @dev:	IPA device
-- 
2.25.1

