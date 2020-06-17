Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B29C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1052089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYQVXWaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgFQQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgFQQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64885C061755;
        Wed, 17 Jun 2020 09:48:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so3115888ejc.8;
        Wed, 17 Jun 2020 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZZKUF07v/nlA1jyQTW7KSPjbPs9IKRSHg41mjIxwpk=;
        b=sYQVXWaLgIeNiJ4w4XegGp1tVc+4eLMLhF+EeJsFwFeVs67vr90CoL+lnfw4FlgpHW
         SpwY76GMZg6CvROrI2tEX45wgJoVzpHpG7gkBAMFtM/Swba7fYRXK4Zk3TKKGxRkhJo6
         Ns0P2N02EpwsLIvzj+0SZr3gYVOSimhtb9/XNbRd6dAzBeLgIOYrhiuua1j3yIFHM4xK
         kY99RKkidFqZv5TEp0vxHqYPtVFNFnq9Qlt02JuIYJAN/TwmfAzqw7k1YN+NS6c3LNn6
         qEl9gLRkp7iVWdd+hWxQDEx7buzLAnf4PRcGhXPSMnrs6UGj6WnlCmEqAqpsR8jmtQrH
         sQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZZKUF07v/nlA1jyQTW7KSPjbPs9IKRSHg41mjIxwpk=;
        b=hhAkK6yq+ENOqhhDxf01125o42SOkDqlvTq9CYbYqRoAaNIYH7/X1gP7fcy0h/4MrU
         mUHcjFuD5jFWH6wHJXsxIhefYzFFnybwLEehp5dRRy6wImE0pAJX94szUVDZZH2KYL2T
         q8S6hmdjE2vVFsvBEMevnJyCmcLwVdHHL/F7mO+G0uJVnuiV8X1J3uo/Kw/Rpj4SAWTo
         WXIHMrM9dk1Spiv89fF5Jf3CWzRzwg6qWHRjppoP/oFpthiszoBXe3BmJxvMCXkpKyfq
         ddu0beUgfMr0dR1c2OLPcKdiFMYOmV4wrFci5J1Dx/Rcuc+zlpnL64blrfoDIZiUyztu
         nVcQ==
X-Gm-Message-State: AOAM5323bwIiIm/HnNnu7HyWJ5CZ2Qa7TRt5ycuXXvJbwslniqB1arej
        zDjje1Ip0VqRj2bhwuJ29iPpxGabw3k=
X-Google-Smtp-Source: ABdhPJzkQ4XoHE0hXyWg9y7w5h3GyxnfvBxCnp283I3LuBNWtWnXUf8nbKu2nCHtLm2+3r0DEwd3xQ==
X-Received: by 2002:a17:906:1116:: with SMTP id h22mr69349eja.350.1592412496144;
        Wed, 17 Jun 2020 09:48:16 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:15 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] clk: actions: Fix h_clk for Actions S500 SoC
Date:   Wed, 17 Jun 2020 19:48:01 +0300
Message-Id: <7b50d637e7c69e8c91e16354ca1ee0e91e516f3b.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The h_clk clock in the Actions Semi S500 SoC clock driver has an
invalid parent. Replace with the correct one.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index e2007ac4d235..0eb83a0b70bc 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -183,7 +183,7 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
 static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
-static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
-- 
2.27.0

