Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D08C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2A2207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZaXKB2Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgHUNpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgHUNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83AC06179E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so1903664wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=thgOsxp+Xq4BrFvbMKlBsMkOaotb5Mf5M65feuQsl1g=;
        b=ZaXKB2Ee5pnvOaTgPCoImaXNsyzLEyL/uH4YSjvQdVRqR/LP/b/8PbtH/p9K4OqW+a
         OEE2kcrRHdBjF+37oiKKK0M0nGhT9NQ03ouOKjEmoBcy2BZ9Ew211g4axDinefhqId/J
         74kVORgBW/bAFu0gdjWpR6VNhePUHT7tLankAGdLqExf70vJlInguFwq75pRtpxqdIul
         H+tZBFRiLeOGnt9L/bbXVRr158tG1vRJLH+/xoPUowCRg9DbNw5dh6d5d0yBROyGDxCl
         5P8FuRyMg8GQFxtZoKo6PYmlH/W/TXejuSQGtoGO31/XqksvAGm/CaBCyiKFMpamJI16
         L+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=thgOsxp+Xq4BrFvbMKlBsMkOaotb5Mf5M65feuQsl1g=;
        b=N48bLK9jrHT5bHJXx015Fx5biyG9swVecOM6zPp8fbcPg7IAhi+wer3Hw5Afor6hzD
         /XIyBxzHmxHVTQruo29vF83JweTmvKD9Q55lMQhSsy39v5NimdkFa1IQ0xG+u6C6it4Y
         +7fUBxsNO44Ub6TPwJuoZSSmg5/59UyWu/sgMXOJmDZxuYxudmB1WElXQDIwDNcte760
         pEsZHX5ddfJYYT9TIdM8Lrgkt2Yg+rNUCgmuAVhAkbp6f7Uj/QTSUzGb9dtqfePx4im0
         jwAY7L4I9KENUD4HMqZMvwi+dIzCHYGDfmBcVv2wOzIaxCuHhMFIvWYlR4M/13HFUukX
         k+5g==
X-Gm-Message-State: AOAM530GfMHp6KP+v6y8AXhcmrec0kAvT1+EeM2H7saQ5NSVoRPB/KYh
        /rIgixGCgRzA9/OFH2xjCRQPxw==
X-Google-Smtp-Source: ABdhPJy6RyED0f8sBL3O38VjQ0vstePlzROZmBceof4nYfVmuCSHrbvQw8vlHLwOfXjNDzBM8AKf/Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr3255089wmz.119.1598017430786;
        Fri, 21 Aug 2020 06:43:50 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:50 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 07/18] crypto: sun8i-ce: handle endianness of t_common_ctl
Date:   Fri, 21 Aug 2020 13:43:24 +0000
Message-Id: <1598017415-39059-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t_common_ctl is LE32 so we need to convert its value before using it.
This value is only used on H6 (ignored on other SoCs) and not handling
the endianness cause failure on xRNG/hashes operations on H6 when running BE.

Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 138759dc8190..08ed1ca12baf 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -120,7 +120,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 	/* Be sure all data is written before enabling the task */
 	wmb();
 
-	v = 1 | (ce->chanlist[flow].tl->t_common_ctl & 0x7F) << 8;
+	/* Only H6 needs to write a part of t_common_ctl along with "1", but since it is ignored
+	 * on older SoCs, we have no reason to complicate things.
+	 */
+	v = 1 | ((le32_to_cpu(ce->chanlist[flow].tl->t_common_ctl) & 0x7F) << 8);
 	writel(v, ce->base + CE_TLR);
 	mutex_unlock(&ce->mlock);
 
-- 
2.26.2

