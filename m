Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8718320780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afhODrly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbgF3Moy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbgF3Mou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:44:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE68C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:50 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so20810273ion.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fzm9ivbOZhTMkiMv3HS0noPXFaLM5j356lho+0tq40=;
        b=afhODrlyuRuSgJChUpQG2XY3nveWqjldkpWmGxxjIP0xJfH/0BJkI+Jh3eGsxnB+OR
         zutMm5QTTporiO9wAqYMbWs0bD5SB4tuBfpn+yDG2UL3a5LtawbTw0TZkt9J9ZmJO5BL
         t5Xbl1+kb72T6t5ovYqhZ1/H528+/djnLm+JWr/D6/Jl4ryQ8ekHTVssYXrVdlFovycI
         0iZiQc4jS222M1OpzWLp30LY5Sf4SdC7YMxra1Fak0RGs/fDOSrceJDBRvCHBFvpxlZV
         vY6xDrgDR45SvZ0N9UgWqZsriKpkx/UnmA23ktp2IYVlQ8l208uKpl8JVE8KhVV5U6Hm
         TGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fzm9ivbOZhTMkiMv3HS0noPXFaLM5j356lho+0tq40=;
        b=HlofVwy//BLPpkqzVQXpIqumHcpAdWXG2Ov93Ss7HxbIIaA4podUlwuCimgJRAI1ez
         z3UpPY+2bmTI9LCEx7HZjOVymYoKI8gehQ31YYpCX0sL+oelJO+HJyaapzwCqo8bk/4n
         xFkdT64O90jH5z+MwRZ+3gTIuKoRnAPQSr+jvNXTizuA4sqsbwuUoz+mE0nRsUXubdF6
         lrNYJsjb8is4xU8wU72PYnF/0WsSuY9WkfBwiMn9uyeFxqRPIm+IIC+EgVlhqCPZGSB3
         0ORQvsn+Z4JLPEJ4jIrHtmW6WzTkcnQ++ze7awYCGdCoYzRL8mv7laVAaZeACfsN2M71
         ZJWw==
X-Gm-Message-State: AOAM532Y4Y/dye3PgQtEbvOJABYzgJHRaGMJ7B7RtzJzU6clHlid4UcD
        n1ZR1yCljd/gqELs6nh9rZMv0g==
X-Google-Smtp-Source: ABdhPJxwuCQKXzJ4+E1VHwYwm85X9sscQdUMNA9Fsw/KOgUIafz6HoyQtbTCkf1qhN6Kf9Gouy1ydA==
X-Received: by 2002:a02:694c:: with SMTP id e73mr23210222jac.17.1593521090058;
        Tue, 30 Jun 2020 05:44:50 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t83sm1697536ilb.47.2020.06.30.05.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:44:49 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] net: ipa: no checksum offload for SDM845 LAN RX
Date:   Tue, 30 Jun 2020 07:44:43 -0500
Message-Id: <20200630124444.1240107-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630124444.1240107-1-elder@linaro.org>
References: <20200630124444.1240107-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AP LAN RX endpoint should not have download checksum offload
enabled.

The receive handler does properly accommodate the trailer that's
added by the hardware, but we ignore it.

Fixes: 1ed7d0c0fdba ("soc: qcom: ipa: configuration data")
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Fixed typo in description, and added "Fixes" tag.

 drivers/net/ipa/ipa_data-sdm845.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index 52d4b84e0dac..de2768d71ab5 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -44,7 +44,6 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
-				.checksum	= true,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
-- 
2.25.1

