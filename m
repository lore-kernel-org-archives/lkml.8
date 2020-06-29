Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20364C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4E5206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGp01w2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404175AbgF2Vzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391560AbgF2Vz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:55:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB733C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so18861093iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQuQWfZzfj1SDZzBIXoKjjE4U7nBLLgIi6SIHAdQ+GA=;
        b=nGp01w2niKYCt4PaDR03fsVvxKd2eC+s3Q3ZlNqyypP7ldsPagswtGN9KUM4XpbMIS
         Aa9+EGXM/XCYpLzhGgRDKGbNqzrCnxV387ZzSl/TfHcNQM0o3SykBipxtAeYnbQJbo1z
         h/C+KpByaLay7PG11dGkPSCVyYbYjkGT1aGqC84lQ90RyZg1H/i8zJd4M8ZfZh64WFbQ
         B7L//WshF43JDl7GAWd1uVvioE2U6lJSsSNNpRIHQ9dJMwXqBVDGEB5Nhbjsz44aJ4ly
         Odk/LQmZSPI3hCI8zXjT9mK+fzzOArU9EY9PiorANBPUC4Bjq5gnpn4UcexJh7T7mGOR
         1Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQuQWfZzfj1SDZzBIXoKjjE4U7nBLLgIi6SIHAdQ+GA=;
        b=Fc6CkxrJy3NHSC8FgXEOT9f3a2FtARvOTzOZIsWAyQ2jRzd9CJMXY7wLLLa3WQBBvL
         4DDn5fNepql3M4heYfd1epJEW9vFzi0nxXmbS9eh1A300dUODfJy9PUro4U0AB/UWHd0
         rHXUZf+fT32FeIbi/iujGusgnFi+X/sVK1kMQaxL08nOv0UNMUW79bn3IPuf2MCZXsNy
         5t5H/MBP08IXEc9Xq21ABSZbx1o6/KiuYD/T2p/iLBNByeIFbrywGQsO9qwfiI8s1y+U
         dX2fCqGaX2l+c+3zY5HrbCyitfOmv0CRg1kyvcDukWuoTojXDTNxJx7dlmFmNeuk1Cdo
         MNFA==
X-Gm-Message-State: AOAM533SAp9EdoE8kzvodZh0K0Z1T6kjNH767f+fLIBXfozafBe3ipFo
        1mGon+sRJdVtcBPNWakd5T9ZSA==
X-Google-Smtp-Source: ABdhPJxGwvvKmc1/Mw85Jidwdd9tp3bG583KjI33LYk6uebsjpDlj/Bf8q7fbeentimbgNbROGtx3Q==
X-Received: by 2002:a05:6602:491:: with SMTP id y17mr18551373iov.72.1593467727042;
        Mon, 29 Jun 2020 14:55:27 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a187sm543221iog.2.2020.06.29.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:55:26 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: ipa: rework ipa_aggr_granularity_val()
Date:   Mon, 29 Jun 2020 16:55:21 -0500
Message-Id: <20200629215523.1196263-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629215523.1196263-1-elder@linaro.org>
References: <20200629215523.1196263-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer used for aggregation makes use of an internal 32 KHz clock.
The granularity of the timer is programmed by a field whose value is
computed by ipa_aggr_granularity_val().  Redefine the way that value
is computed by using a new TIMER_FREQUENCY constant representing the
underlying clock frequency.

Add two BUILD_BUG_ON() calls to ensure the value used is valid.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c |  5 +++++
 drivers/net/ipa/ipa_reg.h  | 17 ++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 76d5108b8403..27a869df3a4b 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -674,6 +674,11 @@ static void ipa_validate_build(void)
 
 	/* This is used as a divisor */
 	BUILD_BUG_ON(!IPA_AGGR_GRANULARITY);
+
+	/* Aggregation granularity value can't be 0, and must fit */
+	BUILD_BUG_ON(!ipa_aggr_granularity_val(IPA_AGGR_GRANULARITY));
+	BUILD_BUG_ON(ipa_aggr_granularity_val(IPA_AGGR_GRANULARITY) >
+			field_max(AGGR_GRANULARITY));
 #endif /* IPA_VALIDATE */
 }
 
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 0a688d8c1d7c..7ae8015798ae 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -190,24 +190,23 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
 	return 0x00000000;
 }
 
-
 #define IPA_REG_LOCAL_PKT_PROC_CNTXT_BASE_OFFSET	0x000001e8
 
 #define IPA_REG_AGGR_FORCE_CLOSE_OFFSET			0x000001ec
 /* ipa->available defines the valid bits in the AGGR_FORCE_CLOSE register */
 
+/* The internal inactivity timer clock is used for the aggregation timer */
+#define TIMER_FREQUENCY	32000	/* 32 KHz inactivity timer clock */
+
 #define IPA_REG_COUNTER_CFG_OFFSET			0x000001f0
 #define AGGR_GRANULARITY			GENMASK(8, 4)
-/* Compute the value to use in the AGGR_GRANULARITY field representing
- * the given number of microseconds (up to 1 millisecond).
- *	x = (32 * usec) / 1000 - 1
+/* Compute the value to use in the AGGR_GRANULARITY field representing the
+ * given number of microseconds.  The value is one less than the number of
+ * timer ticks in the requested period.  Zero not a valid granularity value.
  */
-static inline u32 ipa_aggr_granularity_val(u32 microseconds)
+static inline u32 ipa_aggr_granularity_val(u32 usec)
 {
-	/* assert(microseconds >= 16); (?) */
-	/* assert(microseconds <= 1015); */
-
-	return DIV_ROUND_CLOSEST(32 * microseconds, 1000) - 1;
+	return DIV_ROUND_CLOSEST(usec * TIMER_FREQUENCY, USEC_PER_SEC) - 1;
 }
 
 #define IPA_REG_TX_CFG_OFFSET				0x000001fc
-- 
2.25.1

