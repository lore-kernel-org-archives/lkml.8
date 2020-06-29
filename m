Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A8E206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGRgKAii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgF2VvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404373AbgF2VtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:49:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so18911189iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnwKMPzUR7vm+fNhfAe4BP95ZmBSiCousJyVZMr+eU4=;
        b=uGRgKAiimrgL2i7Xoqg6kmfwYFmRBO1K+Hf2WRe219l2vR8aW/OqlhuegRdkChRdnc
         rEWIRCb8GE4FvyD09etNE9iSoN66TFoedqfseGxy3t/ApZOdAWdhxQf6B8bBOQSOftS8
         2P+qW5At3Ax4AqjfZVFTIpQGDm2A5NvFvPIvJv0NNZx6/t/jqaxv0r/K/R2ZZgkG7DBb
         R8Rp46qzgzYKi2/RcXo92Efw+ZSAAMW9H0sm6Nanma6Vr90PCjA5lK5gj1G30t2HFupD
         GrRfqkvcrxE5h0e4j5J/9sgEEnH9T/9T1oEnU7jgIUS27wS1H8ThmX0gfIGXYHG6ER0w
         GGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnwKMPzUR7vm+fNhfAe4BP95ZmBSiCousJyVZMr+eU4=;
        b=jD+sfnL2hbi95Q3Os4rFvbdRm61MrWwvNlX/Q2e4/TI6A8hBzETMV7QFxpb1+QJU/P
         7CFSxz/7EmjZ+siAZxvhYIOIt9xaGz5y1kym1Ti13DyN1bkBKDKSVWfGSOU6djxnRTKx
         yCiZXKTr6j7Ewy3KhRzkOioQP3KEitf80hczqmjv2h8jeqVakGCaJULGIn9h8JV1io31
         nmncYLKT1exaKZOP6C7XIZzjWJ3anDmgsdKjPVBNn+qI5atbHDpmk6tZMczIfsT6+NkS
         AEEiPDUe6m8DASGqiAkB+GX26LZKCVJ9qDIzxOJ9H9McKXUiwYifAMr6TzwDmMmloQW+
         sHPQ==
X-Gm-Message-State: AOAM532ImgMkyWWtQa4/S5Zfc/5zoD6I9QuD2T/SiFtTgz2B+2FMRAQF
        iXz1EDy/UWkJrjHqKTAGK5wdPw==
X-Google-Smtp-Source: ABdhPJzQw2nxuO3eOLUdcXu6/d/nND+rrrENJbWNxkhhgZktkVnd+vMwypSgufU/1EQnjqLTnT2seA==
X-Received: by 2002:a05:6638:601:: with SMTP id g1mr20258787jar.137.1593467363991;
        Mon, 29 Jun 2020 14:49:23 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u10sm555500iow.38.2020.06.29.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:49:23 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: head-of-line block registers are RX only
Date:   Mon, 29 Jun 2020 16:49:15 -0500
Message-Id: <20200629214919.1196017-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629214919.1196017-1-elder@linaro.org>
References: <20200629214919.1196017-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_HOL_BLOCK_EN and INIT_HOL_BLOCK_TIMER endpoint registers
are only valid for RX endpoints.

Have ipa_endpoint_modem_hol_block_clear_all() skip writing these
registers for TX endpoints.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 9f50d0d11704..3f5a41fc1997 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -642,6 +642,8 @@ static int ipa_endpoint_init_hol_block_timer(struct ipa_endpoint *endpoint,
 	u32 offset;
 	u32 val;
 
+	/* assert(!endpoint->toward_ipa); */
+
 	/* XXX We'll fix this when the register definition is clear */
 	if (microseconds) {
 		struct device *dev = &ipa->pdev->dev;
@@ -671,6 +673,8 @@ ipa_endpoint_init_hol_block_enable(struct ipa_endpoint *endpoint, bool enable)
 	u32 offset;
 	u32 val;
 
+	/* assert(!endpoint->toward_ipa); */
+
 	val = u32_encode_bits(enable ? 1 : 0, HOL_BLOCK_EN_FMASK);
 	offset = IPA_REG_ENDP_INIT_HOL_BLOCK_EN_N_OFFSET(endpoint_id);
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
@@ -683,7 +687,7 @@ void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
 	for (i = 0; i < IPA_ENDPOINT_MAX; i++) {
 		struct ipa_endpoint *endpoint = &ipa->endpoint[i];
 
-		if (endpoint->ee_id != GSI_EE_MODEM)
+		if (endpoint->toward_ipa || endpoint->ee_id != GSI_EE_MODEM)
 			continue;
 
 		(void)ipa_endpoint_init_hol_block_timer(endpoint, 0);
-- 
2.25.1

