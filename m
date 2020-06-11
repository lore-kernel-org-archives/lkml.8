Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7BC20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFFmH6uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgFKTsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgFKTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:48:46 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E568C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:48:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w18so7732056iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3M1k+rxLR+PwfXAjQ6W5HE8fRS+A5J2ae6KqoLRPPl4=;
        b=OFFmH6uovBGuxKmPjvIBu6lk24X54eh9eewidpD3hl2KhGPmSHoaC5hvLL6A9hfqrc
         7tuRvN8j2JhiIQ0gOM8RX8sWw1Qf9lEHU4nlU6RYJ2yk7yioTe+8IFgIkc7t9nfIvU4o
         J/YODz60Tocv2Rsf9i4mb4jWi5QXNIDqVqzKnXGiq31ApX3E+oJPlnE/BmLcjJ6nY5YK
         vjqbhGFqaRlpKfAWJIcovky1zLI8UGTrHOktHYtGFbB0VV729btAFdqLXSo6er5f9g7u
         YnOVH21cpjTmE84Jmov6k5dVHdYjjUfyHg9FbLnw9S19t+OgpxNNR3W7n65DzIgdrJyk
         Hd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3M1k+rxLR+PwfXAjQ6W5HE8fRS+A5J2ae6KqoLRPPl4=;
        b=SAq62qPpgvJXjRXSjrXXU+OZO8/UxrmT8yiUs1ZeI57+FM7/KubMbe37DMLgrrZhhD
         EJ55l7B299LpijOr5GRk3BjmD4PDDaODPxEfmzrv/QjfecUbXhL89cFncj+i9CnYd4Ak
         72KYhn82Rr6CCdY05aydeubwwmEEH40aSeah+U1ny1VNqeUvHtilcGX9fMtrvTekKukI
         izqUuuQUuzkPiRPJA+7vsSSfcRcYcjUqYW+No+/77yJk+T0AHB3BmMVqa2q3QJPn2SrR
         izmqlh1R8u1Adsqm8RafKd79MbLpyBSeIXY1rRrpumrVwwYmden4LH8YSbVTNkAQad7b
         KP+A==
X-Gm-Message-State: AOAM530yGW1slpNzhgwPjib0tDvrdWeX50KJeb4ZV1IM588KsYTmtJfI
        JaSZvjVFAJ/TmpOjUxcldYDJOQ==
X-Google-Smtp-Source: ABdhPJxnNCcjbsMiIz1iPtN7j1K/HtNnK6YlowQ7G/DNOCuW4rKnhZhK82aWVgv4fYKqjWkCN7fV7Q==
X-Received: by 2002:a6b:b9d5:: with SMTP id j204mr10192360iof.38.1591904924876;
        Thu, 11 Jun 2020 12:48:44 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d13sm1981397ilo.40.2020.06.11.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:48:43 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/4] net: ipa: header pad field only valid for AP->modem endpoint
Date:   Thu, 11 Jun 2020 14:48:33 -0500
Message-Id: <20200611194833.2640177-5-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611194833.2640177-1-elder@linaro.org>
References: <20200611194833.2640177-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only QMAP endpoints should be configured to find a pad size field
within packet headers.  They are found in the first byte of the QMAP
header (and the hardware fills only the 6 bits in that byte that
constitute the pad_len field).

The RMNet driver assumes the pad_len field is valid for received
packets, so we want to ensure the pad_len field is filled in that
case.  That driver also assumes the length in the QMAP header
includes the pad bytes.

The RMNet driver does *not* pad the packets it sends, so the pad_len
field can be ignored.

Fix ipa_endpoint_init_hdr_ext() so it only marks the pad field
offset valid for QMAP RX endpoints, and in that case indicates
that the length field in the header includes the pad bytes.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index bf3e8ced3ee0..9f50d0d11704 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -467,7 +467,7 @@ static void ipa_endpoint_init_hdr(struct ipa_endpoint *endpoint)
 			header_size += sizeof(struct rmnet_map_ul_csum_header);
 		val |= u32_encode_bits(header_size, HDR_LEN_FMASK);
 
-		/* Define how to fill mux_id in a received QMAP header */
+		/* Define how to fill fields in a received QMAP header */
 		if (!endpoint->toward_ipa) {
 			u32 off;	/* Field offset within header */
 
@@ -499,10 +499,21 @@ static void ipa_endpoint_init_hdr_ext(struct ipa_endpoint *endpoint)
 	u32 val = 0;
 
 	val |= HDR_ENDIANNESS_FMASK;		/* big endian */
-	val |= HDR_TOTAL_LEN_OR_PAD_VALID_FMASK;
-	/* HDR_TOTAL_LEN_OR_PAD is 0 (pad, not total_len) */
+
+	/* A QMAP header contains a 6 bit pad field at offset 0.  The RMNet
+	 * driver assumes this field is meaningful in packets it receives,
+	 * and assumes the header's payload length includes that padding.
+	 * The RMNet driver does *not* pad packets it sends, however, so
+	 * the pad field (although 0) should be ignored.
+	 */
+	if (endpoint->data->qmap && !endpoint->toward_ipa) {
+		val |= HDR_TOTAL_LEN_OR_PAD_VALID_FMASK;
+		/* HDR_TOTAL_LEN_OR_PAD is 0 (pad, not total_len) */
+		val |= HDR_PAYLOAD_LEN_INC_PADDING_FMASK;
+		/* HDR_TOTAL_LEN_OR_PAD_OFFSET is 0 */
+	}
+
 	/* HDR_PAYLOAD_LEN_INC_PADDING is 0 */
-	/* HDR_TOTAL_LEN_OR_PAD_OFFSET is 0 */
 	if (!endpoint->toward_ipa)
 		val |= u32_encode_bits(pad_align, HDR_PAD_TO_ALIGNMENT_FMASK);
 
-- 
2.25.1

