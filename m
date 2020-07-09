Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4F8207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzrlJ6Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGIPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgGIPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:22:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D1C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:22:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so1168647pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMOOBkt6BiuVxgQAzukgH1LpqaS9kRk1p3gI+ObCk8A=;
        b=jzrlJ6Psxebm3YoLPTkaCJx36p17IwBdX/2XjTuRBRRB7pQyapYp/sG9EN0nHWGwNN
         vTpGQwaR5D/X4WAW9zWuimP4reSpSYzoU72J9th6SMGqr3DkvaI2YWujtefDul6v33Vn
         Dw5mzLDK4K2Y3STydiNqmQRAxhAmjM2rsISlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMOOBkt6BiuVxgQAzukgH1LpqaS9kRk1p3gI+ObCk8A=;
        b=azCvwmrDWTrtnH/7nXyipqwuahp6MJgfLbr/N1STtcB9q63gEFUmAaMJELCe2d16V9
         JewubHQ9kv8t8CwMz2gl4LfUBC6Uis/+nyIe8Scx/pAx1ywhEhkUfq1QI/9Mjt1LLWuW
         ZiQInMZhcFJzPFHpBBxvDE0sl8NHbTjXNuk4zXULtGansQb2W8cBkEOHYUEEcrYRwpL8
         GgNyf87tyDSN2pRG8I/lVxZqWcP4hNv7ihGMFxZGLG0zG9iXtuA11M/kjQ47NIPjzhkj
         LP1qfylLAf1MS4AV1bYRMk0+sufYMTZLXT7nML8nLxbz43Z+ahm27eIc/ss4YzYwztR+
         iXXA==
X-Gm-Message-State: AOAM5322VhXj/dzWsI8sde8FNjLc4hmGqcScOPb+ZqsnLNi5EPtZYR+U
        m+VXv4Fj0Jskq5ZGZ1CjtnPrPg==
X-Google-Smtp-Source: ABdhPJy/6mLFNsMrvrosVpNqu0HDjvO0HrWBNowFAIRcw5RHr2ZKshxCYnHJzeZ3fr3oioRfz/bZOw==
X-Received: by 2002:a62:ae0d:: with SMTP id q13mr50726036pff.89.1594308138738;
        Thu, 09 Jul 2020 08:22:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 137sm3116462pgg.72.2020.07.09.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 08:22:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Cc:     linux-arm-msm@vger.kernel.org, briannorris@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-wireless@vger.kernel.org,
        pillair@codeaurora.org, kuabhs@google.com,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 2/2] ath10k: Get rid of "per_ce_irq" hw param
Date:   Thu,  9 Jul 2020 08:21:05 -0700
Message-Id: <20200709082024.v2.2.I083faa4e62e69f863311c89ae5eb28ec5a229b70@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
References: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the patch ("ath10k: Keep track of which interrupts fired, don't
poll them") we now have no users of this hardware parameter.  Remove
it.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Patch ("ath10k: Get rid of "per_ce_irq" hw param") new for v2.

 drivers/net/wireless/ath/ath10k/core.c | 13 -------------
 drivers/net/wireless/ath/ath10k/hw.h   |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 22b6937ac225..9104496a5125 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -119,7 +119,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -155,7 +154,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -220,7 +218,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -255,7 +252,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -290,7 +286,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -328,7 +323,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -369,7 +363,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -417,7 +410,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -462,7 +454,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -497,7 +488,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -534,7 +524,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -603,7 +592,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.target_64bit = false,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL,
-		.per_ce_irq = false,
 		.shadow_reg_support = false,
 		.rri_on_ddr = false,
 		.hw_filter_reset_required = true,
@@ -631,7 +619,6 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = TARGET_HL_TLV_NUM_WDS_ENTRIES,
 		.target_64bit = true,
 		.rx_ring_fill_level = HTT_RX_RING_FILL_LEVEL_DUAL_MAC,
-		.per_ce_irq = true,
 		.shadow_reg_support = true,
 		.rri_on_ddr = true,
 		.hw_filter_reset_required = false,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index f16edcb9f326..c6ded21f5ed6 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -593,9 +593,6 @@ struct ath10k_hw_params {
 	/* Target rx ring fill level */
 	u32 rx_ring_fill_level;
 
-	/* target supporting per ce IRQ */
-	bool per_ce_irq;
-
 	/* target supporting shadow register for ce write */
 	bool shadow_reg_support;
 
-- 
2.27.0.383.g050319c2ae-goog

