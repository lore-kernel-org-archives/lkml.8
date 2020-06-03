Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C027F2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4AiOUmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFCJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgFCJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:25:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C9C05BD43;
        Wed,  3 Jun 2020 02:25:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so1249502pfb.0;
        Wed, 03 Jun 2020 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLLbgq9KPpYcFzAS1I9Vy/koOYddu4kXuTDFAnQZSMo=;
        b=n4AiOUmB/+uMUoafzHc2EbbNFCyvzygdqMXqUJFFs3l04JAuIMbMAfS3xW4pr/58Vt
         afNnEc1QKmcOl58Spd2fquRGZUGMtZZpsFm1bbEVMPO7kuXA+hmMqc8dhnIxtCr8vweo
         Q7tSy96uZ6+a70DEGxtSp9vQjnuHsopIS1yixJzZCZlsHUKZLmEvGi20W7V3Ppr7V/Rf
         J40NwQyWPe61nzBGJKvc7B70cCV75H/T7NZNprEB1/KgepuB71F8rR/VBszuP3wDN2nj
         QAGpqq8WjVovHLyY2t62GeJSM4NmcWrR3u4i/aVvFDhnw78GLvKTnAmEdKzcHZNlDxeB
         3NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLLbgq9KPpYcFzAS1I9Vy/koOYddu4kXuTDFAnQZSMo=;
        b=P+JiGfHdaD+Y6hHv/VPYyqxzZOSxdeN6KQV97SNLHS7GnMXXX8RsMI2g3Db+4TH9Th
         FAGSD0dzY2h8HO5e+vcPoap//xyyTkYf7OEboscUsS7vvRNspQeLdeG+BHIaU9ixnSWN
         X1JNJsropCciqvfNEr3ZwGnA+r817+uQWPaOhBg+QPoDiwj8Cg8pA/5mDmdUk7XRPFzk
         HEl2HZ9EQ+5zeLF138MtI694nw2p6M01hvg5fSpPmbWyuwOGiUNsiB9K0p77cJaeZQS1
         X/f+hUJ+zoqaFppGqfR8vCrXnoH7v36RhB8M0mEIM9Cn//YvTt8LnhbVBRAKlEbv7v0d
         McSg==
X-Gm-Message-State: AOAM532Mk5vbM5WW/MCmskWBePoQqg7dRXKOgCqGsf1TT85RTZhEItgG
        JUE+aoCSEST8BpQuUMCAh1A=
X-Google-Smtp-Source: ABdhPJy74JB6WhIFBFGNmB8HpyUpjOanK4Vf9Yb7WEHHg7l5dGGRhjOUx1JxZgMkVWKyOQc/hKgmKQ==
X-Received: by 2002:a65:4304:: with SMTP id j4mr27198788pgq.152.1591176337498;
        Wed, 03 Jun 2020 02:25:37 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id f29sm1248715pgf.63.2020.06.03.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:25:36 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] clk: clk-st: Add the missed checks in st_clk_probe()
Date:   Wed,  3 Jun 2020 17:25:28 +0800
Message-Id: <20200603092528.1424271-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_clk_probe() has not check for clk_hw_register_mux(), clk_hw_register_gate()
and devm_clk_hw_register_clkdev().
Add the missed checks and return devm_clk_hw_register_clkdev()'s return value
to check errors.

Fixes: 421bf6a1f061 ("clk: x86: Add ST oscout platform clock")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
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

