Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F8FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6639F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YG+qtu4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505417AbgDNUBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505369AbgDNUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:00:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0718C03C1A6;
        Tue, 14 Apr 2020 13:00:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so15693596wmf.5;
        Tue, 14 Apr 2020 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da7NFvYzDzumUirR7CSYfPXMxNhJVSYGrnWvejA0pP0=;
        b=YG+qtu4xnl/AbsvRm0ohemLRp2AW4jp55XsMOYdlmAQTLLOiq2okcy32Ix2mbUmI4V
         Cd2noAAYfWLR8jmkMjdkFCw/Ptc/ZDpNClLlPcnsMi4d2WbSZ9NMqEMx4/UZSW+zaE4A
         95uZEKSe3OTZwbZ7vCYAU+R5XWzm5RBsvk9nCEya16U7xLG16bYaX9usX6HH6mFFe9Ur
         vI6m+KSM9xq48zWa+mY1Rv52CgDdzLW/g67FnfPcxui8wdMDGMZosXpDqoQIEkZFrg8u
         T6dcfpoeXlCFrY6BCSvBY23UoVWRKVUR5pEe9k9QSvv4p7dfDFDm61nqmxjXe3jgGCLU
         cpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da7NFvYzDzumUirR7CSYfPXMxNhJVSYGrnWvejA0pP0=;
        b=VXs5jiLOHc5QyivPHfaN0Huk9R3Ppns+OMFgKykdHgOsCo+5CvGaDW66iamObCMC8e
         k6DMn/OptDTUUQLX3o1L5Br9hIZtLWsMkxyzDAJzGcvvbYh+LFkckZMoXBBjP0DkfFYw
         7nQqyQIGHgIppl4gAlaBRGLYgw5KcAKrun58YyE/6T0Y2CqrKocMEgywcB77Vk1u53h+
         H9JOW4ki+9xHUlLZWRR98S7Gc0ZcRt+A81U9tS2Ce2wJ6Ls6GZV0WAIYctg0fttaPCX8
         BuOk/sevOOjGPsDK8PBErCUVLReEPT8FPNEi1kJ0lsj6ucKsH82rwwzA1c37nk0pA7Jg
         4+eg==
X-Gm-Message-State: AGi0PuYhsnN4v44AMe+6qwmYvorBsGNidDB/4WeRP1TLILaUL9T3UoN7
        eX0FvqQwQT9xPbp8Urdvn8M=
X-Google-Smtp-Source: APiQypJBZbyV5J+rMhvq+Cc2aow4TKafhtniLnwvhkFqYb8Fbg15FSgd1n+x2Q4VYMNJYzOzhmEf5Q==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr1446383wmc.101.1586894428240;
        Tue, 14 Apr 2020 13:00:28 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b4sm15540253wrv.42.2020.04.14.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:00:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
Date:   Tue, 14 Apr 2020 22:00:14 +0200
Message-Id: <20200414200017.226136-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
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
output rate (compared to simply considering M, N and FRAC).

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
2.26.0

