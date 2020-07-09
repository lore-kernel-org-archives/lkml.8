Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A67620708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="sKPUbOT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGINya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgGINy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:54:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC157C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:54:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so1803143qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKjRYvSAJqWIMQCbW26UX9pAyMFbyr2ycBY9k4qgOjc=;
        b=sKPUbOT061HaLNgBIumsPHsOK03hjWr6gSfhBbbJIeqofNaLJMF6hJJPVq6gWB68k8
         +N5vga7ve7KsepdWPXXwI7/msoWMuVcM5DIPP87zi7RvFmXN5eVXiUcySkyIScWtFSSA
         Rz59jLwn6xy5XUILCjiD5exA+cfLpsvChDy5W2qTLh6VUnlLid+5RFC7kMbkdt9NsM9a
         nEJ45Nfuq+MPjT4fUDBTv63HyYV1NuoiFvp4mVjxF4m87NDUyorjoLGsIFB2JkYYGqtl
         9VIfwPyKzwQ0P3nHMFkOlKO3eclHTQeXxKQkABUlVx93YLDGrT86hWzOVYDvqgPHW7G7
         NbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKjRYvSAJqWIMQCbW26UX9pAyMFbyr2ycBY9k4qgOjc=;
        b=UT+0/WgQZizj/YQ+k5OUdxIqCDiknCFZLu1do7fbfp3gfUnTbX2knztsFVYLmBfJUi
         AS/cK/UNnPKCrkAQUXL7D7ms/p+hBYgeXs378S5qlo0A8oyjQZTrm2O4EsQpDRuql+ht
         Qyecc+rMW7ChSfrf9tJJiKz/eUcxyu+AxyAP6oY/VlVHd4x8lLTVs+07FuU7sdfnWYA/
         lcU8lwzntW12y8P9F2/PlquH2oCJmyJ0wC9ps5xLS0QMDYX+aHegYo+RPUnKCCK2zRKe
         xEE0ssKnHD4T/oiCLz+suZh6m+F/OL9AIaOStW8wBkPW5k8vh+x7KpX60MLEFI8SQrGt
         UYmw==
X-Gm-Message-State: AOAM532BnP4zX2oSNZ8D0XXgWfz9xL11hZ1KyJV7dW9sPt+jDMJwo01G
        kTrbPcIpMyKABOVVgw6wALdfKQ==
X-Google-Smtp-Source: ABdhPJykbhcSTJYSBURH9qEKA/wXv6pa+RNLNZhYj/LlUDEnh7EAzM2s0RwztMWwHWmmJX4oWLZOEw==
X-Received: by 2002:a37:5bc3:: with SMTP id p186mr63724878qkb.401.1594302866953;
        Thu, 09 Jul 2020 06:54:26 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 130sm3632735qkn.82.2020.07.09.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:54:26 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/14] clk: qcom: gcc: fix sm8150 GPU and NPU clocks
Date:   Thu,  9 Jul 2020 09:52:32 -0400
Message-Id: <20200709135251.643-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200709135251.643-1-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the parents and set BRANCH_HALT_SKIP. From the downstream driver it
should be a 500us delay and not skip, however this matches what was done
for other clocks that had 500us delay in downstream.

Fixes: f73a4230d5bb ("clk: qcom: gcc: Add GPU and NPU clocks for SM8150")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/gcc-sm8150.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 72524cf11048..55e9d6d75a0c 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -1617,6 +1617,7 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 };
 
 static struct clk_branch gcc_gpu_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(15),
@@ -1632,13 +1633,14 @@ static struct clk_branch gcc_gpu_gpll0_clk_src = {
 };
 
 static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(16),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gpu_gpll0_div_clk_src",
 			.parent_hws = (const struct clk_hw *[]){
-				&gcc_gpu_gpll0_clk_src.clkr.hw },
+				&gpll0_out_even.clkr.hw },
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
@@ -1729,6 +1731,7 @@ static struct clk_branch gcc_npu_cfg_ahb_clk = {
 };
 
 static struct clk_branch gcc_npu_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(18),
@@ -1744,13 +1747,14 @@ static struct clk_branch gcc_npu_gpll0_clk_src = {
 };
 
 static struct clk_branch gcc_npu_gpll0_div_clk_src = {
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x52004,
 		.enable_mask = BIT(19),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_npu_gpll0_div_clk_src",
 			.parent_hws = (const struct clk_hw *[]){
-				&gcc_npu_gpll0_clk_src.clkr.hw },
+				&gpll0_out_even.clkr.hw },
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
-- 
2.26.1

