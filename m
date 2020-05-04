Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B56C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3CB20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rq0x+5ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEDXxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgEDXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:53:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B7C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:53:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so165879qvz.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njpEHqJ2+bC0XHGj2Gh4SOikioCbruZmns91MTnO70c=;
        b=rq0x+5IDXCfi3TUfgjkNPS0lyyMoNJxroyBGpFEp0uuDKsjh73upRpIJXJU7d8CYIW
         PveqCmyT6Aap6tdsB8K1ja4FjM7MEMJgQ+M9vYhfyZ4z/1zI+7J6igQrSYRX8VKPQk1h
         iKw+gN9eTNy1EVI9MIOGvGxrVAzVGRg3tErAo7HtSG8qChG4GtTCyig9ijF9Q/3+8oxx
         vXazLQujHEpUk0aa4yA8PLoUu7t71ojy+eDCbycgOwHhYh5qjkpNxxGwxN1tSKqLG6fl
         dYQW3rQFQfRfPQzwgIQEkjeljCreNhlTkjI4Tw5dT1KdOcYFCCx5pxoxuPA2OqsyNKxA
         603A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njpEHqJ2+bC0XHGj2Gh4SOikioCbruZmns91MTnO70c=;
        b=FOJUNxhyNdxOFBW3n2SKCk0uQ9BfOz2uVq1w+hJjrjERGQ1IhLF9TCnmk62hn7o847
         tt0BYOA6uEBF7e4U308D9Y+ROPlQeJry9TCVM+qLgUk0yzP6mAcVtm8DaqRn6iU/+mhZ
         tEIDMeGVyBcnMWnsJyEwveHzg3R7oSdL9xEVpk8l4TSgfLdwp5xPjhT8mAjz1vcMwcew
         wkdukc3/QynAqB0QPIGuRbcgfa7v8xXrBxCypEpukaLEGaTz9UQ9t2bZ/lPK/TTTtEbP
         JTeoVii9kvxAxJ5UV0NLe2KsskPS0Ign5S8s1duGGx9HxpfWWiXMznbOUisFkrws25VZ
         ReEg==
X-Gm-Message-State: AGi0PuazCxfutBCGYek8roXR9yBVTqOmUfQaM6bYHwvqsG5IzNPyOtR0
        BfzmMbMbNenna3OMXh126y4srQ==
X-Google-Smtp-Source: APiQypISe7QYS+Aaf3aiaaXANNXXtH/Gfb6cUIcrkZtDtfUMEZY9NrVMMT6X1/JOJ02CaZBNGcfNlA==
X-Received: by 2002:a05:6214:7a7:: with SMTP id v7mr135118qvz.27.1588636432088;
        Mon, 04 May 2020 16:53:52 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm296004qti.47.2020.05.04.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:53:51 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: fix a bug in ipa_endpoint_stop()
Date:   Mon,  4 May 2020 18:53:41 -0500
Message-Id: <20200504235345.17118-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504235345.17118-1-elder@linaro.org>
References: <20200504235345.17118-1-elder@linaro.org>
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
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 713b6ebb4c376b3fb65fdceb3b59e401c93248f9)
---

NOTE:  DO NOT MERGE (this has already been committed.)

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

