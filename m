Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE00C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890C42086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9txNfqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgBCSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:32:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38195 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgBCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so126821pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irG/49dMakkcizB1EhGzZ0q46vUWgKgRR/O4DfgliP8=;
        b=W9txNfqrmlT1zTNYlOzadp2h717ImERtWGxmlFhMJyy3Cvbt2EkrZ7QHEEhZee/tLI
         2o/QteXLaDQfJilOZk+arBl7J9b7EQoAS10PsXrfshojgUPCSr+RcIGpnlZBwJ3PUZKV
         2BNRVlJ75sGaGV17qYBHR6p2AFT6V0ye1npes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irG/49dMakkcizB1EhGzZ0q46vUWgKgRR/O4DfgliP8=;
        b=r5RfZvGvyv/rWAVHSV4DJoXjfjIDycCFTAvsfNOv9N5CbnoNoKxVEvqgaaXdQEOR7C
         duS/XGlsr0ijpzlUMquZfociVdKA8hu9M9MDAOJNaUWWRmimChKd6HEIw2SOMPmtw6xv
         KZMpB2C/CpFg21Q8K6Onv8tZakGDYBkoj38nG4DNOoUn8ip5slWt6w9HFE1fB2rLKwBa
         iwUuzeyiFFcDyBY3/USPW9z/megTuDdahZl7NUzOZr0+ZY7wf/2tUvlMrSv2Y88r9rXu
         QZayfytIkNu1DcwHipaWrBJv/FeyERJ0qpi8ceBWp6glqwYMzc8VcFmgFNn79uNAVnDO
         CJhg==
X-Gm-Message-State: APjAAAW9qp4DVa0QuD5q+hQdLwO0MMPGSBpVwY8fWsEHDmg761tQ28d2
        KeveS2SAoaEIk5DpDnHB2r++7Q==
X-Google-Smtp-Source: APXvYqxDEEAhxY5Kou6RFexCZKMGdzs5fWxkyE49qHB7K7s9tyuDQgE8RSJu/rWIOyK6jKu9VzYE2w==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr25103802plo.260.1580754745151;
        Mon, 03 Feb 2020 10:32:25 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:24 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/15] clk: qcom: Use ARRAY_SIZE in gpucc-sc7180 for parent clocks
Date:   Mon,  3 Feb 2020 10:31:43 -0800
Message-Id: <20200203103049.v4.10.I3bf44e33f4dc7ecca10a50dbccb7dc082894fa59@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nicer to use ARRAY_SIZE instead of hardcoding.  Had we always
been doing this it would have prevented a previous bug.  See commit
74c31ff9c84a ("clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Patch ("clk: qcom: Use ARRAY_SIZE in gpucc-sc7180...") split out for v3.

Changes in v2: None

 drivers/clk/qcom/gpucc-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index c88f00125775..a96c0b945de2 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -84,7 +84,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_data = gpu_cc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_shared_ops,
 	},
-- 
2.25.0.341.g760bfbb309-goog

