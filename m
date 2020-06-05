Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869EA206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/GhGmZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFEQOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFEQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:14:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA165C08C5C2;
        Fri,  5 Jun 2020 09:14:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so5096993pfg.8;
        Fri, 05 Jun 2020 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOl8Flzh5QfUAmLnA9UWhjEFQAgb6tPF02nTEzrngmE=;
        b=o/GhGmZWIxJqhVDJKsQKGbPLqyjuawNYlFwCMSB1dmIOnfTQOWz+gyD8F4W9+foEip
         sGduLULJG3sp/+AjRqE7W7sqIbpzF2ncOlDLUlwBVeO7u63L6GeeAJoLYaYkLFetqG3E
         cz1WbWSYBHkNRKVGkVnDkY4ZkLUKwviwZlOaDS2pzxWLrpS/5HQ7hthbe7Su8fHi+iim
         I2io55Tb7ZkkiWMfLsORboU0m+a4utgq3W2V8f7U83kFohzNiF3NHOyEZy+TTW4bxcht
         O7tpsqxzHlkh8w48zv4OFSjGN8q5TA5nkf3R5zWuI5LGR/xmCGyGJRCgk4jIUrsDggjR
         wqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOl8Flzh5QfUAmLnA9UWhjEFQAgb6tPF02nTEzrngmE=;
        b=e7Dp2bKlOXURHR5+3S6wEVQffRDJYxhLdaDHtKDy1nf1g3nDAb1MaykksqInqz4VfY
         yrS05sgRe8gcRNmXJ/Q7K3Rl3d0wMcKC1CgUg0K089T2OSSIZNx+E0RfZ+gj1nNTQj9K
         ctmSuQDRwVSM+5Ys0eDLCobck3VtSKI7eWQs2xobXrHVn00JA+nJQ0pDkGw3ezbSQJk9
         wIPH6Y6CR6XItCi/6L+O+Y7PoxVjBD1P7uReGDmtYnZ2uP2LEOD5Klhb554MQcwbhruC
         ihXDPSZ1QH0XegZVJ2nsWzmyqpmqdYmSonvuhvoFZ74rlCJc2oJ2Qx7bAl63oRb4Y3wT
         C0vQ==
X-Gm-Message-State: AOAM531og9G4j88KoKNAgs7HlyiLC20ONFm7o/ZjhQbOIffLzu69+X9C
        tfYuLHkIQMrrFru4Bu6qo2M=
X-Google-Smtp-Source: ABdhPJx+oYs7CN1MRuADp7QymAO8VtA4DAeydYgA4KPRUXclZZTlBFTS70qpwF1A3FJ1zbMweHcCNQ==
X-Received: by 2002:a63:6447:: with SMTP id y68mr9800595pgb.395.1591373681240;
        Fri, 05 Jun 2020 09:14:41 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id g19sm63576pfo.209.2020.06.05.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:14:40 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] clk: clk-st: Add missed return value checks in st_clk_probe()
Date:   Sat,  6 Jun 2020 00:14:30 +0800
Message-Id: <20200605161430.2513121-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return values were not checked after calls of the following functions.
  - clk_hw_register_mux
  - clk_hw_register_gate
  - devm_clk_hw_register_clkdev

Thus add error detection and the corresponding exception handling.

Return the value from the function call "devm_clk_hw_register_clkdev"
at the end of this function implementation.

Fixes: 421bf6a1f061 ("clk: x86: Add ST oscout platform clock")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify description.

 drivers/clk/x86/clk-st.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index 25d4b97aff9b..e6ee6ea2568b 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -46,16 +46,20 @@ static int st_clk_probe(struct platform_device *pdev)
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
 		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
 
+	if (IS_ERR(hws[ST_CLK_MUX]))
+		return PTR_ERR(hws[ST_CLK_MUX]);
+
 	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
 	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
-	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
-				    NULL);
+	if (IS_ERR(hws[ST_CLK_GATE]))
+		return PTR_ERR(hws[ST_CLK_GATE]);
 
-	return 0;
+	return devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
+					   "oscout1", NULL);
 }
 
 static int st_clk_remove(struct platform_device *pdev)
-- 
2.26.2

