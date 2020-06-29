Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B4B206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCB2v743"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbgF2Vzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391563AbgF2Vz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:55:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8C0C03E97B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c16so18848035ioi.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAS+84BNIbLsBoPOP/ylzzb5xE9wpBU8i+/yA5WKgjE=;
        b=vCB2v743azwgqIowwzMAL+FtFFnERCwnY4oOtaXtn/0AWpKfwQozXTOuvxZaeims5T
         /JHKXdvlkmZGH1iDgnbJm9z6+TlkiAxMvLhUj0n2qq2R2YHlvn7VZfK3CE338lUhQdJb
         +U6WfvRQVWHVXW3sbb0JehxokRLyoZX8cXiIwtVW5amZ8JI3fj1iilw5nyUjdUbA80XS
         YWqGo/VPcvYEHxQdPYI66tKrbGa/ly8JDC5QQX+ggIKv06FcEb53o6BHO17sulG7hDij
         irXBHpCpdjKMjNBMepk4tee6oDf7BGSLEaAUVbdZFvU5YsVyFw8Wz17YUhWI+g8E41sx
         2orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAS+84BNIbLsBoPOP/ylzzb5xE9wpBU8i+/yA5WKgjE=;
        b=r3r5eaJnV+E0oGKiUBqg2r073bxQvv/RDe+h+ezVCm3bF/aCmE7HBHYn3Z9muOivrT
         KbHBA1CS/ssWrWWYegdnICWtO3rCiQRWynyni9Y21VZb0w8gaaxKdDYQrjrW75ZAoDCW
         v94OlylG/t/ZW+hUUw50IkvS2AZgDDgU2t4SUeg4mFC16fdUQe+hnINF2kswdSIP5huk
         rQ2Fff9v9vD8pvonV3VUHu+JWRgu5GBYyFfQrL3XQAstVbWYDQlziOCYYCXg3qg0FcnY
         AmDOvgTz5XygSqFQ9LSlCYLvbcnJiPpFCo86n+3pgaSSC8vSr0f/IP85UsFS5DPbbzWZ
         3Vvw==
X-Gm-Message-State: AOAM531hYo4A2KmPBVpK/ovgSWECJkbqt3/pvCafoVCxCE2WmoivYxMA
        LAORdUwg62pyH1jHjqL6doQnyQ==
X-Google-Smtp-Source: ABdhPJxtc/vNa2b5B1A6esGMHU2utCpIh9sjRihbXsDi5a/z89JN0fabDW9BPEye3gCT3OA7bTk4QQ==
X-Received: by 2002:a02:5e88:: with SMTP id h130mr20329835jab.116.1593467727986;
        Mon, 29 Jun 2020 14:55:27 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a187sm543221iog.2.2020.06.29.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:55:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: ipa: reduce aggregation time limit
Date:   Mon, 29 Jun 2020 16:55:22 -0500
Message-Id: <20200629215523.1196263-3-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629215523.1196263-1-elder@linaro.org>
References: <20200629215523.1196263-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Halve the time limit used when aggregation is enabled on an RX
endpoint, to half a millisecond.

Use DIV_ROUND_CLOSEST() to compute the value that represents the
time period, to get better accuracy in the event the time limit is
not an even multiple of the granularity.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 9f50d0d11704..93449366d7d8 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -36,7 +36,7 @@
 #define IPA_ENDPOINT_QMAP_METADATA_MASK		0x000000ff /* host byte order */
 
 #define IPA_ENDPOINT_RESET_AGGR_RETRY_MAX	3
-#define IPA_AGGR_TIME_LIMIT_DEFAULT		1000	/* microseconds */
+#define IPA_AGGR_TIME_LIMIT_DEFAULT		500	/* microseconds */
 
 /** enum ipa_status_opcode - status element opcode hardware values */
 enum ipa_status_opcode {
@@ -583,9 +583,11 @@ static void ipa_endpoint_init_aggr(struct ipa_endpoint *endpoint)
 			val |= u32_encode_bits(IPA_GENERIC, AGGR_TYPE_FMASK);
 			val |= u32_encode_bits(aggr_size,
 					       AGGR_BYTE_LIMIT_FMASK);
+
 			limit = IPA_AGGR_TIME_LIMIT_DEFAULT;
-			val |= u32_encode_bits(limit / IPA_AGGR_GRANULARITY,
-					       AGGR_TIME_LIMIT_FMASK);
+			limit = DIV_ROUND_CLOSEST(limit, IPA_AGGR_GRANULARITY);
+			val |= u32_encode_bits(limit, AGGR_TIME_LIMIT_FMASK);
+
 			val |= u32_encode_bits(0, AGGR_PKT_LIMIT_FMASK);
 			if (endpoint->data->rx.aggr_close_eof)
 				val |= AGGR_SW_EOF_ACTIVE_FMASK;
-- 
2.25.1

