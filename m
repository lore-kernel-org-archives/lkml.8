Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7480920722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQnfJJ9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgF3NdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbgF3NdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214CC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f6so5367751ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5aSRp59jKO5d55dBFG61qZSPf1iY4fVxx3iYfquSAE=;
        b=UQnfJJ9gy2RTNvVo3X6qL/EUr1IfMDFqaAo5/bpHG6K0FpVsMRaJjt1jpMfKvOjEBe
         Gz3kespK0A0O9wPjziN0o/9IelwlJYSBabSRt1ldI3BidnGo8/ZdCSj6JwxgW5fDjXJ3
         l7n/tDTcKXZt8+wKGW8yFoXyNIR2qdjJu2582Zi2ns9Ld1L9CIQ93ZZ+FGZOtvA1Jt9U
         yyVHilZ6aQMNtXLTcI2N0DKxemM8wjp40/QOc21194xQwQhxtoR2YduvUnnm4oTlEk7/
         qc/h9MMKNokPozIy38ZxduQXAc0QOJyztMgPMwSFlcQYu+PSTj56gXw7ahcPcaODn2ur
         /j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5aSRp59jKO5d55dBFG61qZSPf1iY4fVxx3iYfquSAE=;
        b=oUn/awcFeAfCQxr9JAW6zNjxaKpH1dxzq4GEfGP29qKD+A4Efay7VvL+1JEyad1hL0
         RrTuejARcRHWEK+AcP57ytbEiZrLY8HgmVltgPKN5SxHUOMRvCRL3mWH3Vie6408NyOM
         OLtGWVbOGI8OWcvFX9HWvuk/WUaGYRsYG/HQqFiBr4adff1JiE58mQjr5RyUnbMIoLdu
         5x3OmdhF6aP4y5OBYcIlV9EBLjtv1QWX9HFsp0idgmem8itWU8rcWStuEsnKoa9vRqmX
         BeqgMYSYsUTbehSQ8LZfuXLycnpY/KND7gh6wTlS+10kaq7zu0k01BkJ6Uz5m1e19Tqz
         xsuQ==
X-Gm-Message-State: AOAM531Olb/GTrcdScmivHQk0Y+469LMyRDQC/V5caUQFeb67BNP5XgU
        Oy17liIcXFlgWnZUx0OKtpSNDg==
X-Google-Smtp-Source: ABdhPJzxUL/OXKdQC0L4kfFUqJLX6w6ie9b1sYG3tSzEVuBI5e/8Zqs/9qFk1rNhFbJSmgjAea6XDg==
X-Received: by 2002:a6b:f40a:: with SMTP id i10mr21701041iog.155.1593523991143;
        Tue, 30 Jun 2020 06:33:11 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u15sm1538776iog.18.2020.06.30.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/5] net: ipa: mode register is TX only
Date:   Tue, 30 Jun 2020 08:33:02 -0500
Message-Id: <20200630133304.1331058-4-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133304.1331058-1-elder@linaro.org>
References: <20200630133304.1331058-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_MODE endpoint configuration register is only valid for TX
endpoints.  Rather than writing a zero to that register for RX
endpoints, avoid writing the register at all.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: The commented calls to assert() that were added are now gone.

 drivers/net/ipa/ipa_endpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 1babcfc79360..566ff6a09e65 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -541,7 +541,7 @@ static void ipa_endpoint_init_mode(struct ipa_endpoint *endpoint)
 	u32 offset = IPA_REG_ENDP_INIT_MODE_N_OFFSET(endpoint->endpoint_id);
 	u32 val;
 
-	if (endpoint->toward_ipa && endpoint->data->dma_mode) {
+	if (endpoint->data->dma_mode) {
 		enum ipa_endpoint_name name = endpoint->data->dma_endpoint;
 		u32 dma_endpoint_id;
 
@@ -552,7 +552,7 @@ static void ipa_endpoint_init_mode(struct ipa_endpoint *endpoint)
 	} else {
 		val = u32_encode_bits(IPA_BASIC, MODE_FMASK);
 	}
-	/* Other bitfields unspecified (and 0) */
+	/* All other bits unspecified (and 0) */
 
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
@@ -1297,6 +1297,7 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 		ipa_endpoint_init_aggr(endpoint);
 		ipa_endpoint_init_deaggr(endpoint);
 		ipa_endpoint_init_seq(endpoint);
+		ipa_endpoint_init_mode(endpoint);
 	} else {
 		if (endpoint->ipa->version == IPA_VERSION_3_5_1)
 			(void)ipa_endpoint_program_suspend(endpoint, false);
@@ -1306,7 +1307,6 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 	}
 	ipa_endpoint_init_cfg(endpoint);
 	ipa_endpoint_init_hdr(endpoint);
-	ipa_endpoint_init_mode(endpoint);
 	ipa_endpoint_status(endpoint);
 }
 
-- 
2.25.1

