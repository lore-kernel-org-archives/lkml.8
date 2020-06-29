Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECEC2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4LfHzCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbgF2Vzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391567AbgF2Vz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:55:29 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so18861189iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhXLf8hCPPQ+UdSoyfLtjbvzDTqGh8KFNg/omzR+iuI=;
        b=H4LfHzCS2CW6/4yLINtVbSs0mFoQdgIJuZTVKx5VSUNSNAbwhnNbykExgW8yKLSesi
         //uiaPsrXlk8+bzgLVF8FN+ZfPNN/VB1YhCnM4POfqeCZXivOdIDYPMh4SP1InXwhiF9
         SQ1XEx+PqUQhgF+iV/bQY8u7dqPusIEFtWdwCQN+ZuC2vpx2A0zAI37e4717c7XMNG1q
         P3zHdt7M6ErNQbZp+lQQUaW3PbVDZAnkoHCzpPioEQluORd0wvwfr9uePxO3cvDRiDGP
         Spv/Zd6ck01HJmBj+IE1+sG8l+dnsJI9SLZytSCzfMZrtRbMk5ygBuMVlX5IgfarHbFd
         fTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhXLf8hCPPQ+UdSoyfLtjbvzDTqGh8KFNg/omzR+iuI=;
        b=A1XwQ6Ryxzkk+hopx5YwWzgCxcYjLKHNvY1OFAaGiQ0fuuONoNmK1KYCEXGPpp8VgB
         Cr5TkDDPR4OQ0jZwC1SwSvf2Wg6lrttmrEW4N4fnQDo6suIz2lPMEU76CVxTSqW3iJJc
         Ee3FYxJfjz2T/cPggayp+7Oij8ahifHwMdW9ptSwipKpq+jmT7DWihi0NI7R113gzU39
         467bz3z96ErRg/kzJtgy6cnyZBtzZ370YQGyp8SgFR4e1YFSlCPIsUXBi1mT9NoBhqyj
         G7UCDnEXamIsuDgr35cdUEtLv3BFj8CG+KUvEyk4I6lED2cOXNnIPMoP+a+G3A11ZqIf
         uUVw==
X-Gm-Message-State: AOAM5310/XzsMwJlUKUsRqPHoNQiAi4zBFrt1ctYBKNJHJ2OWBrq9TpW
        HAY/ug7DQcovyX6p+QMXifqTOA==
X-Google-Smtp-Source: ABdhPJx6KlUdC5r9U+5mwhAkNaapkCRSHSlif49582mtDylGlUP9dQWnsK/O41bK58apqRBnAh4pWw==
X-Received: by 2002:a02:3f1f:: with SMTP id d31mr19739447jaa.76.1593467729091;
        Mon, 29 Jun 2020 14:55:29 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a187sm543221iog.2.2020.06.29.14.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:55:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: ipa: reuse a local variable in ipa_endpoint_init_aggr()
Date:   Mon, 29 Jun 2020 16:55:23 -0500
Message-Id: <20200629215523.1196263-4-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629215523.1196263-1-elder@linaro.org>
References: <20200629215523.1196263-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the "limit" local variable in ipa_endpoint_init_aggr() when
setting the aggregation size limit.  Simple cleanup.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 93449366d7d8..2f56981b051e 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -576,19 +576,20 @@ static void ipa_endpoint_init_aggr(struct ipa_endpoint *endpoint)
 
 	if (endpoint->data->aggregation) {
 		if (!endpoint->toward_ipa) {
-			u32 aggr_size = ipa_aggr_size_kb(IPA_RX_BUFFER_SIZE);
 			u32 limit;
 
 			val |= u32_encode_bits(IPA_ENABLE_AGGR, AGGR_EN_FMASK);
 			val |= u32_encode_bits(IPA_GENERIC, AGGR_TYPE_FMASK);
-			val |= u32_encode_bits(aggr_size,
-					       AGGR_BYTE_LIMIT_FMASK);
+
+			limit = ipa_aggr_size_kb(IPA_RX_BUFFER_SIZE);
+			val |= u32_encode_bits(limit, AGGR_BYTE_LIMIT_FMASK);
 
 			limit = IPA_AGGR_TIME_LIMIT_DEFAULT;
 			limit = DIV_ROUND_CLOSEST(limit, IPA_AGGR_GRANULARITY);
 			val |= u32_encode_bits(limit, AGGR_TIME_LIMIT_FMASK);
 
-			val |= u32_encode_bits(0, AGGR_PKT_LIMIT_FMASK);
+			/* AGGR_PKT_LIMIT is 0 (unlimited) */
+
 			if (endpoint->data->rx.aggr_close_eof)
 				val |= AGGR_SW_EOF_ACTIVE_FMASK;
 			/* AGGR_HARD_BYTE_LIMIT_ENABLE is 0 */
-- 
2.25.1

