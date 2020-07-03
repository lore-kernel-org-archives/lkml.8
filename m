Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9042C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5C620885
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3+4z0zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGCVXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:23:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5AC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:23:40 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k23so33610023iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1fvvSd4Jv5N25/XSLdxX+JF3MOyj15/ornprnLeFOY=;
        b=v3+4z0zZjv/Bxxn6QyPOtGVRYSermsfOiK3NcNSIscR3kAUv4NnU1HJZp/RXdYftKK
         hIRZ9O1MOYL3/W+7b7sPiSOe8nKifmsN3DZEs+BX98lSx72o8FVG6lGQWTVfw/dAN5VW
         Zhu/q+/jEjwYRSx8YSY8S4DVEEJzfChFKxRRqKXtBEwMCmhyLUYJa/5kxb+FkBT4oroJ
         ggMDjzynPDUcNmCocI3MUJnB95CZRWIAwIathOEboPVaAIU7jPgISB4aNNFB1Znc5XzH
         HCmTESRu3C/il4GdqAgzydL+tZygL+LrklydqGNHCwKwK/EMjh+GvvTCNbnXjOm4J3qx
         iH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1fvvSd4Jv5N25/XSLdxX+JF3MOyj15/ornprnLeFOY=;
        b=ckGI8p+q69m/yjEYJrgYuF97lEDtFpGeISQrrc8ShxL3vBievV3VXKrRjUeJAYnDHQ
         krYNDcHfj0f5Xh3Eh9ks7xpInlctxwXsjRV2QkqqsC0kvdRIxJGJGapRWYP0zbg/dp4d
         6vZXDHGdQ17COF9wfDKAR9l68Na8I80zr+EEB+gxWQ1GDaum2qyNBRpq5CNfV31m3imO
         pxTLZLK9vkykwE4vik/oYNSVUCkoSzz6jvc2CQaTiv4ktCi9BzTUNHjfTNsuFZv0yka2
         X97XEVrZVNXN1ogYyYfsgfzFG37Pir4jLj1Kg39hya0O6R+ZmW7ddJHtUcfrelm6zlxp
         gvvA==
X-Gm-Message-State: AOAM532S/xR9lU3OVrZyfAmUc3xWnxHcPeoDgXNTwAik9bmkSLKF1/ID
        LmlNus23H0tEp3PnpiEjKq4acA==
X-Google-Smtp-Source: ABdhPJzTNgGdpMMHiWeIE4BEuDI17/AWYfbYhZTTh1Wd5AjrGeQkUPoxuOrQOZea7HuSdq3xo6c9qg==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr41444432jap.122.1593811420291;
        Fri, 03 Jul 2020 14:23:40 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m6sm7485292ilb.39.2020.07.03.14.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 14:23:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ipa: fix HOLB timer calculation
Date:   Fri,  3 Jul 2020 16:23:35 -0500
Message-Id: <20200703212335.465355-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703212335.465355-1-elder@linaro.org>
References: <20200703212335.465355-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPA v4.2, the exact interpretation of the register that defines
the timeout for avoiding head-of-line blocking was a little unclear.
We're only assigning a 0 timeout to it right now, so that wasn't
very important.  But now that I know how it's supposed to work, I'm
fixing it.

The register represents a tick counter, where each tick is equal to
128 IPA core clock cycles.  For IPA v3.5.1, the register contains
a simple counter value.  But for IPA v4.2, the register contains two
fields, base and scale, which approximate the tick counter as:
    ticks = base << scale
The base and scale values to use for a given tick count are computed
using clever bit operations, and measures are taken to make the
resulting time period as close as possible to that requested.

There's no need for ipa_endpoint_init_hol_block_timer() to return
an error, so change its return type to void.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 78 +++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 99115a2a29ae..d4be12385bcc 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -21,6 +21,7 @@
 #include "ipa_modem.h"
 #include "ipa_table.h"
 #include "ipa_gsi.h"
+#include "ipa_clock.h"
 
 #define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
 
@@ -675,63 +676,70 @@ static void ipa_endpoint_init_aggr(struct ipa_endpoint *endpoint)
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
 
-/* A return value of 0 indicates an error */
+/* The head-of-line blocking timer is defined as a tick count, where each
+ * tick represents 128 cycles of the IPA core clock.  Return the value
+ * that should be written to that register that represents the timeout
+ * period provided.
+ */
 static u32 ipa_reg_init_hol_block_timer_val(struct ipa *ipa, u32 microseconds)
 {
+	u32 width;
 	u32 scale;
-	u32 base;
+	u64 ticks;
+	u64 rate;
+	u32 high;
 	u32 val;
 
 	if (!microseconds)
-		return 0;	/* invalid delay */
+		return 0;	/* Nothing to compute if timer period is 0 */
 
-	/* Timer is represented in units of clock ticks. */
-	if (ipa->version < IPA_VERSION_4_2)
-		return microseconds;	/* XXX Needs to be computed */
+	/* Use 64 bit arithmetic to avoid overflow... */
+	rate = ipa_clock_rate(ipa);
+	ticks = DIV_ROUND_CLOSEST(microseconds * rate, 128 * USEC_PER_SEC);
+	/* ...but we still need to fit into a 32-bit register */
+	WARN_ON(ticks > U32_MAX);
 
-	/* IPA v4.2 represents the tick count as base * scale */
-	scale = 1;			/* XXX Needs to be computed */
-	if (scale > field_max(SCALE_FMASK))
-		return 0;		/* scale too big */
+	/* IPA v3.5.1 just records the tick count */
+	if (ipa->version == IPA_VERSION_3_5_1)
+		return (u32)ticks;
 
-	base = DIV_ROUND_CLOSEST(microseconds, scale);
-	if (base > field_max(BASE_VALUE_FMASK))
-		return 0;		/* microseconds too big */
+	/* For IPA v4.2, the tick count is represented by base and
+	 * scale fields within the 32-bit timer register, where:
+	 *     ticks = base << scale;
+	 * The best precision is achieved when the base value is as
+	 * large as possible.  Find the highest set bit in the tick
+	 * count, and extract the number of bits in the base field
+	 * such that that high bit is included.
+	 */
+	high = fls(ticks);		/* 1..32 */
+	width = HWEIGHT32(BASE_VALUE_FMASK);
+	scale = high > width ? high - width : 0;
+	if (scale) {
+		/* If we're scaling, round up to get a closer result */
+		ticks += 1 << (scale - 1);
+		/* High bit was set, so rounding might have affected it */
+		if (fls(ticks) != high)
+			scale++;
+	}
 
 	val = u32_encode_bits(scale, SCALE_FMASK);
-	val |= u32_encode_bits(base, BASE_VALUE_FMASK);
+	val |= u32_encode_bits(ticks >> scale, BASE_VALUE_FMASK);
 
 	return val;
 }
 
-static int ipa_endpoint_init_hol_block_timer(struct ipa_endpoint *endpoint,
-					     u32 microseconds)
+/* If microseconds is 0, timeout is immediate */
+static void ipa_endpoint_init_hol_block_timer(struct ipa_endpoint *endpoint,
+					      u32 microseconds)
 {
 	u32 endpoint_id = endpoint->endpoint_id;
 	struct ipa *ipa = endpoint->ipa;
 	u32 offset;
 	u32 val;
 
-	/* XXX We'll fix this when the register definition is clear */
-	if (microseconds) {
-		struct device *dev = &ipa->pdev->dev;
-
-		dev_err(dev, "endpoint %u non-zero HOLB period (ignoring)\n",
-			endpoint_id);
-		microseconds = 0;
-	}
-
-	if (microseconds) {
-		val = ipa_reg_init_hol_block_timer_val(ipa, microseconds);
-		if (!val)
-			return -EINVAL;
-	} else {
-		val = 0;	/* timeout is immediate */
-	}
 	offset = IPA_REG_ENDP_INIT_HOL_BLOCK_TIMER_N_OFFSET(endpoint_id);
+	val = ipa_reg_init_hol_block_timer_val(ipa, microseconds);
 	iowrite32(val, ipa->reg_virt + offset);
-
-	return 0;
 }
 
 static void
@@ -756,7 +764,7 @@ void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
 		if (endpoint->toward_ipa || endpoint->ee_id != GSI_EE_MODEM)
 			continue;
 
-		(void)ipa_endpoint_init_hol_block_timer(endpoint, 0);
+		ipa_endpoint_init_hol_block_timer(endpoint, 0);
 		ipa_endpoint_init_hol_block_enable(endpoint, true);
 	}
 }
-- 
2.25.1

