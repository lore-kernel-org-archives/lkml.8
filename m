Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B122BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBFF206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yODIs6sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDXh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEDXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:37:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211BC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:37:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so532974qts.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sp4luMaF6IKbI/3fhMGnaHSP2UluU8wsl5sO/u1BVg8=;
        b=yODIs6sx85nyS1LAB3htJ85KxKopBPuE4uu/Ga7AS7Zu7KTuBIXYqhwu+/wPz2gC82
         OIXJBsmQSRKc0G7LJCCCMKUqfQt3DZchu6NOJATTBVVOuDlWzdNsop76Pjqm6EHRm/uV
         MiUUEGlBieUZLJyBDh/gue+WiniyHgzx1i7RwChaw5UpgF6yewDFQ2rEJ3g/LgAGvf79
         xpYqB5pV8rfXhm5BhAunCeY3zqV/B0ZDfzJuSH1473v5XJpqCugbfkpXuzpDwRNR9whF
         DKudliVGpCJUy0ZxScYNcsBbF7+k1ltnLqNa/+tHvzG9muCXJbssf0m4nHNJGl7md10q
         IqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sp4luMaF6IKbI/3fhMGnaHSP2UluU8wsl5sO/u1BVg8=;
        b=ZB6gKiRyuI0DAA7Jio6GkdfQstvaTmhdGv6Myy519tRS8xHo5eWChCJBdX1oEB3F0W
         7HJ59Y5AIa8dyZwVfVwPBC+xmdlfUsTsdvoAhhKPnkyQF/l2lYdotmye/kgomeUaX8Bx
         LZGNirlc8yFPqevMIcuvt8ScdA8+n1fUC36dyeZl+4Y6GbsJH0MWzqRDps6RxC/tc2F8
         x4F/yzrUEImMfufb3HPxeShQC9qiuDDn6Z8t7ahZzkrhd22/+iDLQwPbBeuAauoXaphT
         b5+XctKCsd3dvRVQp42cp0LUMGAo/I7nECZ54RCVpy3fwHdHLA12HnObJi3m2Z5sF035
         co1Q==
X-Gm-Message-State: AGi0PubaQhfO+ta+Wc5UA952vvGTQs9RL2MbHBSRrpifOciMZzWKumQb
        7172xtrSCrBjbtKqnPKa2vY0Ag==
X-Google-Smtp-Source: APiQypK4Dfb2FAR2CSwLiWHXdfhVVee7mbYkoiVuuMUHAzuuzPxl4/tmD+Z8446kUGgatAEm6mHUlA==
X-Received: by 2002:aed:2591:: with SMTP id x17mr188790qtc.76.1588635442816;
        Mon, 04 May 2020 16:37:22 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x125sm494311qke.34.2020.05.04.16.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:37:21 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: ipa: remove endpoint delay mode feature
Date:   Mon,  4 May 2020 18:37:13 -0500
Message-Id: <20200504233713.16954-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504233713.16954-1-elder@linaro.org>
References: <20200504233713.16954-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "delay mode" feature was put in place to work around a problem
that was observed during development of the upstream IPA driver.  It
used TX endpoint "delay mode" in order to prevent transmitting
packets toward the modem before it was ready.

A race condition that would explain the problem has long since been
fixed, and we have concluded that the "delay mode" feature is no
longer required.  So get rid of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 1 -
 drivers/net/ipa/ipa_data.h        | 6 ------
 drivers/net/ipa/ipa_endpoint.c    | 4 +---
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index f7ba85717edf..52d4b84e0dac 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -74,7 +74,6 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 				.tx = {
 					.status_endpoint =
 						IPA_ENDPOINT_MODEM_AP_RX,
-					.delay	= true,
 				},
 			},
 		},
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 16dfd74717b1..7fc1058a5ca9 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -80,18 +80,12 @@ struct gsi_channel_data {
 /**
  * struct ipa_endpoint_tx_data - configuration data for TX endpoints
  * @status_endpoint:	endpoint to which status elements are sent
- * @delay:		whether endpoint starts in delay mode
- *
- * Delay mode prevents a TX endpoint from transmitting anything, even if
- * commands have been presented to the hardware.  Once the endpoint exits
- * delay mode, queued transfer commands are sent.
  *
  * The @status_endpoint is only valid if the endpoint's @status_enable
  * flag is set.
  */
 struct ipa_endpoint_tx_data {
 	enum ipa_endpoint_name status_endpoint;
-	bool delay;
 };
 
 /**
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index a830101b8edb..8dc12ec18fc7 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1341,10 +1341,8 @@ int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 {
 	if (endpoint->toward_ipa) {
-		bool delay_mode = endpoint->data->tx.delay;
-
 		if (endpoint->ipa->version != IPA_VERSION_4_2)
-			ipa_endpoint_program_delay(endpoint, delay_mode);
+			ipa_endpoint_program_delay(endpoint, false);
 		ipa_endpoint_init_hdr_ext(endpoint);
 		ipa_endpoint_init_aggr(endpoint);
 		ipa_endpoint_init_deaggr(endpoint);
-- 
2.20.1

