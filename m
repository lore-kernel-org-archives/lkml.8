Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A5A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="TFteUP+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbgF2Vmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgF2Shy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691ACC03141C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c139so15928712qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKjRYvSAJqWIMQCbW26UX9pAyMFbyr2ycBY9k4qgOjc=;
        b=TFteUP+PzrABsrT7Iqmoia3CSf9TxnsyR7tM4s01yJ9Y0F72qWSUFcstAAR2MiIg3V
         cGfBV4wBCvubSaPwKtkOTkxZOarQFXy2Mt/t4AvMMXqPg6u1Woiy0pXijB7gF3CyawL7
         YUkGv4xdYXQYTXCnwKCP0B4dnsz12vt1fawA6iX+v/OLstJhQcpqELJkg6+u7O4go3FO
         gd8u821HbYFQsjDUBQt2D0VYoL+e8okCAxc6WCxiaNjLlyoDEqL+04clH04PCTMJQp23
         45wTUGNsd0nuXP/ZOaM/QKRFQHQRRXpBAkTzY9N6uG1f1980TMKOcRUc4saNxGrtK/LD
         d7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKjRYvSAJqWIMQCbW26UX9pAyMFbyr2ycBY9k4qgOjc=;
        b=O9unKgDfftAS3W7w17uJJOsgTpbFrrZ/q2PtgJCUtqN/RVA+PfO70DZy7Y9O41/yeP
         D0aM53wqE0HSmM0YNlzwJ6GR4sqi//n/3z1y2LXU4Y15+NDOsrtNyfpxlPBmqFJNg/EM
         gSpPSnhBTeJU3YA250ZrZ5s6R76YmDmqgtNqUsJsVqpV4+PCtx6xZ79GddtL8JpsJbXY
         zS+o64YSAQbDZQaxOoAkOx9EkcprNsaQaKdE6PI75mRsaPdPv/8VzCE8Wlyik48HtXgi
         hCsE+vCSunKgMVudMp7+DERRf+WZsBjAkq9WsK+BEZk9RWAHLc3Njrp8YxdC1ST9a34D
         solw==
X-Gm-Message-State: AOAM5316XqAYHKTQw/sn/UJB/9igvubWQLPO7/1mJDOiNVm9iLJ4NTZU
        wyAgVZco+Gx+0p+RZ0aWsk4qpA==
X-Google-Smtp-Source: ABdhPJyGf8Cj/3C59Fd+/iwH3VAZ/Okqfp0p6Q7w43DVzio9qxfdfPPMKZGAwA7optdr6wEe7s2fDw==
X-Received: by 2002:a05:620a:1275:: with SMTP id b21mr15667265qkl.4.1593451260707;
        Mon, 29 Jun 2020 10:21:00 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q5sm408363qtf.12.2020.06.29.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:21:00 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/13] clk: qcom: gcc: fix sm8150 GPU and NPU clocks
Date:   Mon, 29 Jun 2020 13:20:31 -0400
Message-Id: <20200629172049.30452-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629172049.30452-1-jonathan@marek.ca>
References: <20200629172049.30452-1-jonathan@marek.ca>
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

