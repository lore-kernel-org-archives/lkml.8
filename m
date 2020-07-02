Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38687C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DDD208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpOKoGgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGBLZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgGBLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:25:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC3C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:25:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r12so16650559ilh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp2cMksA2bKPwFtLgY/MdRQdPPtTBA5vqesfT2+0hjc=;
        b=ZpOKoGgZlAuRQs5w7DsHYa62CW16hmQWM1HcZzK51k7rMZJhv1MF74+eKeB3DU2pg1
         NI63CGILl/2WsASLDtzkHVaA8SZTgeodbnefw5lVLFDFXAgqNbEgoo80GPd4m+e3isKS
         /jxYBRTrYTVzHBkm+nNNQy0nymA69OgsbmEfoGuN6KhUp/at28+S+Idug6ETvajRv1JI
         227hCdaggbcuw5getFtTppHvKwaiVfji5Vjm3218MNLEaat/ArxfEgZTWcjgsIEutyhQ
         MsuH6ki5461HFzUqhcTYzDZ0T4gDlF+Bqxfa6F48UMJVynAO0RLa0v67UJwWL9D5iVDa
         tj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp2cMksA2bKPwFtLgY/MdRQdPPtTBA5vqesfT2+0hjc=;
        b=sW3ctsEYZkKcmeFidcUq4N0DRay48c88xll5omz6GakEis4CcljfrEmnPvGJCw8T7M
         KNz2Q2SKE0aAq6Ru52IQ1LLFD85sjIeROiVwCQQmgMCChqlaJxGWobQ/UDXi/TtpfrhA
         F3GC20IMtGw5Z9ZVTCbGJQsPMDaSNBxPnFaIpSh4bgjIJp80vb99WX/SVavL7bxObRvi
         TZeA+QJeW6OPzIpgvpHctb4RmqcHAGrbE7n1oUc1o8IeT3CPzODsFi6NLAZJG6LC75f0
         qAIb+xtpS67GFcdLpO8DHEk0d2qRQtmaHdVHrgF48rnOEfvtgdvbt0kIZnL2nq+uJjYx
         HjMg==
X-Gm-Message-State: AOAM530zg9eNb13SFzAX9pBnWNWtX0o/BulQBcfpN67SpJ14a1/FbDwW
        UlOqdpHG8HrUY7K8X9QWQ39viQ==
X-Google-Smtp-Source: ABdhPJwEv0HnyP43dQAbI1RSDGyNlCw4/LxYtvhyIKCZJLEssNc1xhU9uEsBvjwtkgqrnjdbjWfRfA==
X-Received: by 2002:a92:c087:: with SMTP id h7mr11803456ile.279.1593689142638;
        Thu, 02 Jul 2020 04:25:42 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c3sm4692842ilj.31.2020.07.02.04.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:25:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] net: ipa: move version test inside ipa_endpoint_program_delay()
Date:   Thu,  2 Jul 2020 06:25:34 -0500
Message-Id: <20200702112537.347994-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702112537.347994-1-elder@linaro.org>
References: <20200702112537.347994-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPA version 4.2 has a hardware quirk that affects endpoint delay
mode, so it isn't used there.  Isolate the test that avoids using
delay mode for that version inside ipa_endpoint_program_delay(),
rather than making that check in the caller.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index a7b5a6407e8f..7f4bea18bd02 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -318,7 +318,9 @@ ipa_endpoint_program_delay(struct ipa_endpoint *endpoint, bool enable)
 {
 	/* assert(endpoint->toward_ipa); */
 
-	(void)ipa_endpoint_init_ctrl(endpoint, enable);
+	/* Delay mode doesn't work properly for IPA v4.2 */
+	if (endpoint->ipa->version != IPA_VERSION_4_2)
+		(void)ipa_endpoint_init_ctrl(endpoint, enable);
 }
 
 /* Returns previous suspend state (true means it was enabled) */
@@ -1294,8 +1296,7 @@ static void ipa_endpoint_reset(struct ipa_endpoint *endpoint)
 static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 {
 	if (endpoint->toward_ipa) {
-		if (endpoint->ipa->version != IPA_VERSION_4_2)
-			ipa_endpoint_program_delay(endpoint, false);
+		ipa_endpoint_program_delay(endpoint, false);
 		ipa_endpoint_init_hdr_ext(endpoint);
 		ipa_endpoint_init_aggr(endpoint);
 		ipa_endpoint_init_deaggr(endpoint);
-- 
2.25.1

