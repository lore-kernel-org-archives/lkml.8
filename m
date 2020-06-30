Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E45206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uv2o6CXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgF3NdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732546AbgF3NdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E845C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so20925729iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDgFHsSUO1neDezcqrxbKw4M4Vw2z46/pelFQ4uN6Us=;
        b=Uv2o6CXgOdrdRE3wBPoMz4l/rv9cHmE7GOIu9KuRF3jvPrNrIGrq3ZyAtEs9sFPmRD
         nov4LVJHSax5nJSoLBvdW8tOPHnx2ycNPdBLnDMIC0Ovx/BWnncxdbXFwbQ7L0EfDI0Z
         JthTexCFC4V0SOCCebpo47934/c8iiYLcXrJ6+10TU0ezINJ8tS5VzgZm42C8N10nvfv
         xaKxv0NHS300FDcK7ESlR2dVaEPUElQJHJ4g/EqJ36Zq7tip4g2JfCZzZRqEbPQ6TrfE
         6B9L8NEV1pn9QPkDS2mGzPOJunMd08M+44ijUvXDmpp4EkGawSKbwhSK00LFvdW8Bsva
         x/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDgFHsSUO1neDezcqrxbKw4M4Vw2z46/pelFQ4uN6Us=;
        b=YlglmN2RINsCHLQ5ulEAeIkj0LIR8YoKx8K60c2ZQebjzSv4gJO3gLQyqJp6c2TfSc
         sEAl5GysbtHfVeOmE+udYnGnth42AuEA4H3UIV4E6sPW6VQIhg7bgkUYvZEdeMSMBe55
         WAu7sNG3z/PuMuvjg+FYjaNxr5JTSglPCipaqDrEjKFw1ZkyVJr4cY0MaD38L3QAQBKy
         yK9zj+IvLPQY2FA5M056oPfDce+/1iQJK0RHJ6P1KP/LOLt9fUfhadN5C2v6nc9uVTPw
         ARvx0mwcfPej7U0Vg605J5qw2mj/aVNewzPSTZb6Ft15Nm+LDLCx/bUYeODjpDs34ZQl
         +jQQ==
X-Gm-Message-State: AOAM5304CTm38H6VRH2NELvcBkF85YgmonGSqGKuuN30iCmvZefwI+tC
        i/04xz+j2ETdMA9yPvWj5uTtyA==
X-Google-Smtp-Source: ABdhPJzPIjbodBZZVbQt3ksOF6Eb4Cys04jmQn4GbX6gXxEzNM4nU8I8x87LLHl51/qU9UXjz/3TMw==
X-Received: by 2002:a05:6602:2dca:: with SMTP id l10mr21765627iow.163.1593523988825;
        Tue, 30 Jun 2020 06:33:08 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u15sm1538776iog.18.2020.06.30.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: ipa: head-of-line block registers are RX only
Date:   Tue, 30 Jun 2020 08:33:00 -0500
Message-Id: <20200630133304.1331058-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133304.1331058-1-elder@linaro.org>
References: <20200630133304.1331058-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_HOL_BLOCK_EN and INIT_HOL_BLOCK_TIMER endpoint registers
are only valid for RX endpoints.

Have ipa_endpoint_modem_hol_block_clear_all() skip writing these
registers for TX endpoints.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: The commented calls to assert() that were added are now gone.

 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 9f50d0d11704..31afe282f347 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -683,7 +683,7 @@ void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
 	for (i = 0; i < IPA_ENDPOINT_MAX; i++) {
 		struct ipa_endpoint *endpoint = &ipa->endpoint[i];
 
-		if (endpoint->ee_id != GSI_EE_MODEM)
+		if (endpoint->toward_ipa || endpoint->ee_id != GSI_EE_MODEM)
 			continue;
 
 		(void)ipa_endpoint_init_hol_block_timer(endpoint, 0);
-- 
2.25.1

