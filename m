Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF1620760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoX9fUZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGCRFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGCRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3502C061794;
        Fri,  3 Jul 2020 10:05:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so21720375edz.12;
        Fri, 03 Jul 2020 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQghqn+BdVK6MdFw7UQ7WWQRVvFzcu0qCSzHvd/dFL0=;
        b=PoX9fUZYqBUFRRo3oVlwWTIQBHuDwzJ58TTGr5FrOn0RfhECKCyKfSu7FLqah+7NtT
         KHbx557OXvJseGo83RIAsnaqUur9TljJKs0hWFQ7heth9HQ8gZ1LXAJhL+VQzU2rV9Wl
         vI0v0ofCoTJfjNnHqbx7t91BNFLKZw2N4+JToAjRRlwXycCchISYVYKRmodRtMFSPS++
         J46kGBGPljqPLUgM0CZI9bCAeoC23INdZY7WUUIoAcQQVb3RqDZ35Xn7SJXCOpVnXy4c
         k2z8HpP6Ay25SP9SsPz4WZrwOh4XdTFIDxcKU6MXCCncHerYJuXnIxtlWC6cl10b/n7t
         hFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQghqn+BdVK6MdFw7UQ7WWQRVvFzcu0qCSzHvd/dFL0=;
        b=KJ3Rp90TdCtyG88MEhQwxIsgoU+MlLx0vtopqQ6sWqLoUpSOdNZbpii8GeZ60XNPwE
         95Q1eeJi7oQUyHusanLh6dhT7cTOU+KpWCYzoylsfYM2Q4qQ1clfQb5XqlL0sLdCHnwT
         XsHssTOwlRXD1QDCTem0OCakSm4N9Hfuv6h09ydaoYuqZwdRcuOIHssBk/KKhLljhlao
         uvmkASmEyY+1bLvH+fDcQ0Wvo6EH/GU9eQ2JaieSUD6dr4RUV6Q0614s0PHd5JuriF+3
         fIWgoC80ueSrqg4JFeAUxfYuVLHiFiUvRBRb+EqYRikfC+1M/TeRdv6LjI0nGsZfRc0n
         t1gA==
X-Gm-Message-State: AOAM5334dxL8T2GZyNf8PaTwuaF0FCCiMBHGBHX1k0seXqjHC8ImJl0X
        d9nlRL9yW70/FTbuUkM4OHU=
X-Google-Smtp-Source: ABdhPJytqKyGUgJ4iBt8m1t8/05Pp2xV4Xybk3nl/H3dB7jxgSgYlRX1u+kF5XrULpT3wyxAwx/Jig==
X-Received: by 2002:a50:d8c2:: with SMTP id y2mr33760647edj.114.1593795916584;
        Fri, 03 Jul 2020 10:05:16 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:16 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 1/6] clk: actions: Fix h_clk for Actions S500 SoC
Date:   Fri,  3 Jul 2020 20:05:07 +0300
Message-Id: <c57e7ebabfa970014f073b92fe95b47d3e5a70b1.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The h_clk clock in the Actions Semi S500 SoC clock driver has an
invalid parent. Replace with the correct one.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Fixes tag
 - Added Mani's Reviewed-by tag

Changes in v2:
 - None

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

