Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13C42075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nR9FBxJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgDXOCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDXOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:02:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A97C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so10838318wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K3HkFGZRBx+SfRUwC9FdXoQJ5KxG+Q8nwo7U5Wcmh7A=;
        b=nR9FBxJU4AwfNu8Nost8ZNfD+ic5azwVFtO78kpgQG4qV8/QSIWqK/iMKdeFfZAmWz
         92BNqidWJ0z4iJlL+cG05E/rWRn2xYAra5Y5BUL+LYzaCniPF1tBZzZLsoiSsev6X60n
         EhJVKr+rAaz3pNAhsV07RHeJ1HI/SwnTRVge3LaQLnX+rq6uZ+AlyNVWPSAyBUfI0bmP
         Y2M+1MaH8pe170Oj+PxGNl0hPY93pW4xpFfVBREK2OZO6uG/q1eb9v6FGulN8W4m/AFY
         9U48/3hyzWf/fIKmE2IyGwG9HET0LCmF8R/Qpge1B7CkwrYHLx7csQqPu4E7hzHlwKFH
         raAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K3HkFGZRBx+SfRUwC9FdXoQJ5KxG+Q8nwo7U5Wcmh7A=;
        b=pRNpDeHP0A0Wz6NLYopXSOgExfAdHWvo9ehUWE99bSUeOgmhNmrO1mZwyf+TsAl+VB
         1ti+O27qDjpRudhpvDc/kduLTxq+Xlv66eIhowPZtzJyJMThiPpdnbmSnvOjC91hFW7Z
         M2wNBmmVGR6V3AeS4QHArpXt02Uwmsug5tQi+CvyJpoGQ9NVQ6HgOM6W/D29uJvd32NT
         W5k+eqAkYcbw3DAT9bqOF6MBHm5SV8s+iGzyxDsB1DL54iSeV6vLYkG8pT0FWLgFIiVf
         h5LA6VB6XLx1CE4pmwjT0tMuJX/FBNjd3cQgTd+jwtcT8Q3Ep/FX7WLbM/F97IfquWCP
         pQTw==
X-Gm-Message-State: AGi0PubfQJwugBx45brkhoDdpWLUVzskHUganoBE0FXbe3KvjP+D6OFB
        jSWv3Mu/kHRWyarCHXxCMxBeEo1vatI=
X-Google-Smtp-Source: APiQypKaSsCpg9CaGME9ZcSz+7wbng/kuKXyOnfancyO7n+TDWY04ElvRmOuXXa1lh04NBb+FTJwBQ==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr10901009wmf.175.1587736964147;
        Fri, 24 Apr 2020 07:02:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v131sm3061051wmb.19.2020.04.24.07.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:02:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 09/14] crypto: sun8i-ce: handle different error registers
Date:   Fri, 24 Apr 2020 14:02:09 +0000
Message-Id: <1587736934-22801-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
References: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error registers are different across SoCs.
This patch handle those difference.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 58 ++++++++++++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 +++
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index b957061424a1..80f7918fbea8 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -40,7 +40,8 @@ static const struct ce_variant ce_h3_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 50000000, 0 },
-		}
+		},
+	.esr = ESR_H3,
 };
 
 static const struct ce_variant ce_h5_variant = {
@@ -51,7 +52,8 @@ static const struct ce_variant ce_h5_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_H5,
 };
 
 static const struct ce_variant ce_h6_variant = {
@@ -64,7 +66,8 @@ static const struct ce_variant ce_h6_variant = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
 		{ "ram", 0, 400000000 },
-		}
+		},
+	.esr = ESR_H6,
 };
 
 static const struct ce_variant ce_a64_variant = {
@@ -75,7 +78,8 @@ static const struct ce_variant ce_a64_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_A64,
 };
 
 static const struct ce_variant ce_r40_variant = {
@@ -86,7 +90,8 @@ static const struct ce_variant ce_r40_variant = {
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
-		}
+		},
+	.esr = ESR_R40,
 };
 
 /*
@@ -102,6 +107,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 {
 	u32 v;
 	int err = 0;
+	struct ce_task *cet = ce->chanlist[flow].tl;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	ce->chanlist[flow].stat_req++;
@@ -128,19 +134,52 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			msecs_to_jiffies(ce->chanlist[flow].timeout));
 
 	if (ce->chanlist[flow].status == 0) {
-		dev_err(ce->dev, "DMA timeout for %s\n", name);
+		dev_err(ce->dev, "DMA timeout for %s (tm=%d) on flow %d\n", name, ce->chanlist[flow].timeout, flow);
 		err = -EFAULT;
 	}
 	/* No need to lock for this read, the channel is locked so
 	 * nothing could modify the error value for this channel
 	 */
 	v = readl(ce->base + CE_ESR);
-	if (v) {
+	switch (ce->variant->esr) {
+	case ESR_H3:
+		/* Sadly, the error bit is not per flow */
+		if (v) {
+			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
+			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4, cet, sizeof(struct ce_task), false);
+		}
+		if (v & CE_ERR_ALGO_NOTSUP)
+			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
+		if (v & CE_ERR_DATALEN)
+			dev_err(ce->dev, "CE ERROR: data length error\n");
+		if (v & CE_ERR_KEYSRAM)
+			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
+		break;
+	case ESR_A64:
+	case ESR_H5:
+	case ESR_R40:
 		v >>= (flow * 4);
+		v &= 0xF;
+		if (v) {
+			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
+			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4, cet, sizeof(struct ce_task), false);
+		}
+		if (v & CE_ERR_ALGO_NOTSUP)
+			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
+		if (v & CE_ERR_DATALEN)
+			dev_err(ce->dev, "CE ERROR: data length error\n");
+		if (v & CE_ERR_KEYSRAM)
+			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
+		break;
+	case ESR_H6:
+		v >>= (flow * 8);
 		v &= 0xFF;
 		if (v) {
 			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
 			err = -EFAULT;
+			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4, cet, sizeof(struct ce_task), false);
 		}
 		if (v & CE_ERR_ALGO_NOTSUP)
 			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
@@ -150,7 +189,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			dev_err(ce->dev, "CE ERROR: keysram access error for AES\n");
 		if (v & CE_ERR_ADDR_INVALID)
 			dev_err(ce->dev, "CE ERROR: address invalid\n");
-		}
+		if (v & CE_ERR_KEYLADDER)
+			dev_err(ce->dev, "CE ERROR: key ladder configuration error\n");
+		break;
+	}
 
 	return err;
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index fe97fee74e47..ed1a91da967b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -65,6 +65,12 @@
 #define CE_ERR_ADDR_INVALID	BIT(5)
 #define CE_ERR_KEYLADDER	BIT(6)
 
+#define ESR_H3	0
+#define ESR_A64	1
+#define ESR_R40	2
+#define ESR_H5	3
+#define ESR_H6	4
+
 #define CE_DIE_ID_SHIFT	16
 #define CE_DIE_ID_MASK	0x07
 
@@ -94,12 +100,14 @@ struct ce_clock {
  * @has_t_dlen_in_bytes:	Does the request size for cipher is in
  *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
+ * @esr:	The type of error register
  */
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
 	u32 op_mode[CE_ID_OP_MAX];
 	bool has_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
+	int esr;
 };
 
 struct sginfo {
-- 
2.26.2

