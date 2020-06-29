Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C950D2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqVFoan+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbgF2Vt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404376AbgF2VtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:49:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966CC08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e64so13914761iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Il6tZPozA+81DRifdvTR8dOWxcR0CVn20QskeLQXSZw=;
        b=lqVFoan+9JSGnYlS5t8a7bwkLr0z10ICIXqMz1hxYO2oexKA364ZUNfCWNwL08JpmV
         /+lTaRryvPqLqMDfxaUqYfWDiWmkBmfw0qumv6sX9x0klUHBMOWHwQEfPE0DrOzkOdkb
         7wixiAuLQCtC/YN23hPtrj4jLV5oAsLVbPBXJ8TBA8EV9hHV91KOPCr5cw0/45VidQES
         4qdyKi2LtpZIUPhVU3tfScB08DgQkCQWt9MiY2NZBC3QSvT02SLVg0K9QsaR/BKImE6l
         SQBJIAvz/PD665euNXFPJlogsqAJ7Rj57mGmlamjHDL7pyuN6NT+2Pxl7fUBlRPom8JU
         6K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Il6tZPozA+81DRifdvTR8dOWxcR0CVn20QskeLQXSZw=;
        b=Ski2SvWg1sJzChNd3jNTQ7njPMAI/iZtvfYjndPvP7m/W18DBJf7r99Wp3HSrZ1R4S
         t0IDSLmwCbrybaniAfgISaHgeZ+0hPeBhrf7i+BTYCIqpbLwpxOLJ2Vrx5rhS2TtlD9p
         iRnti6P57QJcpFQ54XdCzskY2X0OITiI2EgSmZhD8IdDNJxXiMg/IEXznB0Q97jJ1HZ/
         hIf3bYTg0NQZc6kdSxeTff4yTDQzul8N5IAOFCXp02EEmdYgXEHQ15K2eyWbnijBfYH8
         uwyaX+k+ia3rkVxlzjgA+WqND8JB3mjuSUiHjohJPnKtCpa8arKQpndfAV7ZpMEMdvvO
         RxQQ==
X-Gm-Message-State: AOAM531aTuTVpRO8WQILiPYITfEgDlx4ihGPh3uzvs1B9pzbULVvDLGf
        2a7GARJfl4Yl5oT4UxdrUNWGaQ==
X-Google-Smtp-Source: ABdhPJzrssCIiELFHZzXgJZAcnCKtob6IAke/+TnnTYjfE0zxV6PrMK6Y8E2HFZxkcLHSpX52PPrzQ==
X-Received: by 2002:a02:10c1:: with SMTP id 184mr19313863jay.135.1593467365137;
        Mon, 29 Jun 2020 14:49:25 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u10sm555500iow.38.2020.06.29.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:49:24 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: metadata_mask register is RX only
Date:   Mon, 29 Jun 2020 16:49:16 -0500
Message-Id: <20200629214919.1196017-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629214919.1196017-1-elder@linaro.org>
References: <20200629214919.1196017-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_HDR_METADATA_MASK endpoint configuration register is only
valid for RX endpoints.  Rather than writing a zero to that register
for TX endpoints, avoid writing the register at all.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 3f5a41fc1997..0c2bec166066 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -527,10 +527,12 @@ static void ipa_endpoint_init_hdr_metadata_mask(struct ipa_endpoint *endpoint)
 	u32 val = 0;
 	u32 offset;
 
+	/* assert(!endpoint->toward_ipa); */
+
 	offset = IPA_REG_ENDP_INIT_HDR_METADATA_MASK_N_OFFSET(endpoint_id);
 
 	/* Note that HDR_ENDIANNESS indicates big endian header fields */
-	if (!endpoint->toward_ipa && endpoint->data->qmap)
+	if (endpoint->data->qmap)
 		val = cpu_to_be32(IPA_ENDPOINT_QMAP_METADATA_MASK);
 
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
@@ -1306,10 +1308,10 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 			(void)ipa_endpoint_program_suspend(endpoint, false);
 		ipa_endpoint_init_hdr_ext(endpoint);
 		ipa_endpoint_init_aggr(endpoint);
+		ipa_endpoint_init_hdr_metadata_mask(endpoint);
 	}
 	ipa_endpoint_init_cfg(endpoint);
 	ipa_endpoint_init_hdr(endpoint);
-	ipa_endpoint_init_hdr_metadata_mask(endpoint);
 	ipa_endpoint_init_mode(endpoint);
 	ipa_endpoint_status(endpoint);
 }
-- 
2.25.1

