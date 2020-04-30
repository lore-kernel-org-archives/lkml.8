Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B67C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329EE2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8Hp6LU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgD3VfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgD3VfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:35:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B6C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f83so46630qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDbWKqllD32Zzrgur/5ifZ7Q6Ppu2GkH8sQaMON6aEA=;
        b=w8Hp6LU/YnMao27Myy/EieJ66WTJDSb2srpoFkwVQgk1zBbjc4sBbYcXQmdGxG8yV4
         4+QjcJO3M+SNfKmA4X7pjK1uLS+PoVpeG+OTFC6ffSASFPuKAUyFkatsZpwnfbY8eAUb
         njCJL50HuqRTm/46xi4L4sr4JFeAe5LAZSpEkgtb+E7GM7N6s3Rc9rsntbAHNbkxTWX1
         YR0whSuao/79fI8iCxtPcdzhlZhJehTV17LfEuFrRl+LzdRQ3OMEA1MEHprNOJovWaxg
         r4wHyQwQgjQ7eK7aF/8j4Rznag09rMfa2V1x1abhHDqQsLwL1lfXroV1duJcZnCSYM03
         rzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDbWKqllD32Zzrgur/5ifZ7Q6Ppu2GkH8sQaMON6aEA=;
        b=nkAVh99aXRCpKeO7wXr8OVeY9KDDc7o9OQ10CHoTtdJ3+/Dj6JIUeG8zLV8P6CysdU
         ntbdxxtCceRMuFv5KTOfEF68EE+3RltglMnNPubI/i6ch3w9PlsvwKNhrbi1ng6kvT/6
         +B8BH/E2qf0R9aKkNy7a4JWlnzORzeqVbxdWkpE+PVdUbovJSWa6gjZy7TPsxqfwfx0A
         AaPvzgEe3NY5Lrt8UPH6yiRaJWSENG+ZmFVP7WHFc8PgjohvDLU6rz0VunK3mlPPoRdl
         MsSmqBNUhU8Cuolw/LEImlcurawA6J5NHAA9kouTPI7kSEVuwxe92NouG2fg8sAOcScN
         csrA==
X-Gm-Message-State: AGi0PuZRTURz2Rn3UkSMomvGH/cPq1EJR4mA5IO5lCUdX2vX6ANXF2AF
        xtj7QtWyL8w4B9TfM7UK7TcJEg==
X-Google-Smtp-Source: APiQypLrSH7yaDRSRPpYaNxGoA74UjF04aY6CXlzqQMGPLp5Pw5yu1nJ6UVSjdnghjSA5D5aFznHvw==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr559577qke.175.1588282519043;
        Thu, 30 Apr 2020 14:35:19 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s190sm1112543qkh.23.2020.04.30.14.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:35:18 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: ipa: fix a bug in ipa_endpoint_stop()
Date:   Thu, 30 Apr 2020 16:35:10 -0500
Message-Id: <20200430213512.3434-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430213512.3434-1-elder@linaro.org>
References: <20200430213512.3434-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipa_endpoint_stop(), for TX endpoints we set the number of retries
to 0.  When we break out of the loop, retries being 0 means we return
EIO rather than the value of ret (which should be 0).

Fix this by using a non-zero retry count for both RX and TX
channels, and just break out of the loop after calling
gsi_channel_stop() for TX channels.  This way only RX channels
will retry, and the retry count will be non-zero at the end
for TX channels (so the proper value gets returned).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 6de03be28784..a21534f1462f 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1283,7 +1283,7 @@ static int ipa_endpoint_stop_rx_dma(struct ipa *ipa)
  */
 int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 {
-	u32 retries = endpoint->toward_ipa ? 0 : IPA_ENDPOINT_STOP_RX_RETRIES;
+	u32 retries = IPA_ENDPOINT_STOP_RX_RETRIES;
 	int ret;
 
 	do {
@@ -1291,12 +1291,9 @@ int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 		struct gsi *gsi = &ipa->gsi;
 
 		ret = gsi_channel_stop(gsi, endpoint->channel_id);
-		if (ret != -EAGAIN)
+		if (ret != -EAGAIN || endpoint->toward_ipa)
 			break;
 
-		if (endpoint->toward_ipa)
-			continue;
-
 		/* For IPA v3.5.1, send a DMA read task and check again */
 		if (ipa->version == IPA_VERSION_3_5_1) {
 			ret = ipa_endpoint_stop_rx_dma(ipa);
-- 
2.20.1

