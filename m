Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EDC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43F920780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tR8/oPjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgDQSlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgDQSll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF0C061A0C;
        Fri, 17 Apr 2020 11:41:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so3929856wmc.0;
        Fri, 17 Apr 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pDfj/QraDSKRnuL+EP//h6wcVnH2S8rr57iQRcR8OO4=;
        b=tR8/oPjB9/ARC6Hww1D9hRyK/54LWHuBJ+pEdpKCepWwuReRyO2Nuab4w0rvaaHqK4
         u8layFvzbJh1hpiDg2tCv5gBb6ylIeBOmfJM5ixjUs+Jro8434qaruah3qBH8byFQcva
         Z8U2c/Fx3YrJu7x5fA58+yphQvt4/frOW6854zyDxZvbSvcu0aqEFeoUQMTTvSJT3jOm
         l+zq2hQBC94+pkeNQrCTKmRE4lPv1e3iTsWVlXmy4FwnDdPY65zHBIEQt12kJRRiCN7F
         0JAW3rLLWtskqYGDRpKtnZdseu5z5rLUSFUXpmvaxYbIc/w1yLBPrFcWTbeDsTCRw30i
         Ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDfj/QraDSKRnuL+EP//h6wcVnH2S8rr57iQRcR8OO4=;
        b=IRG3HpUHp4weXP2o9E64B6Im45yCx0JKRA2a5PHLjaq+3m547IkcxbvFPQ/mhFF1iz
         jUHFwjxmvL7qjnhfKw97+WRBv2FNcxgzQYW4ftbvWpBjqf8f2yRsr12KeVdKrUs1a5Hg
         g+zDIdjf0T4H6MQnvpkAJYL1ulzY70ArpRTUBX/IboTe3ktSgj56fGYNtaKVMtf2C9fV
         Mjm9dlEaCFSKNkZ8CsSXaArZxhqihT/TzpssaguMMuiUK+rKDbldnggQ5oXytkK+D1GS
         E9GupujN8AbeDxd6/szmQBev6+8P1UwwYZzUU0hK9+/J17w5MJoprgivnXesDCoJwSLo
         0BVQ==
X-Gm-Message-State: AGi0Puax3WTAwyiBXjmOd4JrthyMSURQ3nRYjJd/bcKHunSOytI0u5kl
        ilF07qi2pRY870NI7PVCYr4=
X-Google-Smtp-Source: APiQypK5zOAKZQ5Jv4qR6V0MqyvU1fbrwrOUGQZj8hr390Y8FhwQ0Ia7fSUa6KYL6mXnV95wrrnNkQ==
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr4506759wmi.2.1587148900114;
        Fri, 17 Apr 2020 11:41:40 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c17sm33237391wrp.28.2020.04.17.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
Date:   Fri, 17 Apr 2020 20:41:24 +0200
Message-Id: <20200417184127.1319871-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
References: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hdmi_pll_lvds_out as parent of the vid_pll_in_sel clock. It's not
easy to see that the vendor kernel does the same, but it actually does.
meson_clk_pll_ops in mainline still cannot fully recalculate all rates
from the HDMI PLL registers because some register bits (at the time of
writing it's unknown which bits are used for this) double the HDMI PLL
output rate (compared to simply considering M, N and FRAC) for some (but
not all) PLL settings.

Update the vid_pll_in_sel parent so our clock calculation works for
simple clock settings like the CVBS output (where no rate doubling is
going on). The PLL ops need to be fixed later on for more complex clock
settings (all HDMI rates).

Fixes: 6cb57c678bb70 ("clk: meson: meson8b: add the read-only video clock trees")
Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 7c55c695cbae..90d284ffc780 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1077,7 +1077,7 @@ static struct clk_regmap meson8b_vid_pll_in_sel = {
 		 * Meson8m2: vid2_pll
 		 */
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_hdmi_pll_dco.hw
+			&meson8b_hdmi_pll_lvds_out.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
-- 
2.26.1

