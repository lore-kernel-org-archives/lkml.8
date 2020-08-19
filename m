Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBF6207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd8w5fY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHSH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHSHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E64C061346
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so1116262wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOjbJX83gJDY8f1/vIcwdpJ4Kow88m/y6XKP96xRsEA=;
        b=Sd8w5fY/YPVd1DFQ/uqbWtPwoLLwn1dYdDDX+iT0U6ENroYU/Zyf5KLdE6h1zDHyGx
         NkaqtyeOwci4grfqjJy1Cdo0GioYVQIDoqZIUkjEdGmWHUr5a1l03N2moGXVaD3TXLxh
         Su8+5wo/MFPFX2x4NdH3hPsXyy6p4jBKPR4YJ63U5bJbCwSGqrV2z18O52x8wnde4dD7
         Kz3L1bsKYeuGP4883KTZxMwiIr05VrFl6tiNj1/fZ6P6h3ojxTe8Wzaov+PZnfpxCmEI
         2Mo9JHbLonssqsCxB9fbMX9ZkFVrame84cD2oG+EjyxbWZAydCKGuN0B4y5QZ5mgrltA
         mvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOjbJX83gJDY8f1/vIcwdpJ4Kow88m/y6XKP96xRsEA=;
        b=IJQbahqlYw+J3wgChOGY8jeOdeEbd9mWF/RkPB+39lJ6pKf19YyHc/KCiJW/kMMkTA
         ikEvujrY/xm02YO0wPQmBiCl1gkpz9l1hCLGZssd43oR3vbhIDT9jRohFdWUCxeYWOtl
         JcVcmTCFEG2D21NneqaXvrFsMDwPL8bk96aaz84v4yhZWapDjc7wxKf5Il2I6GwZRGdG
         W8Xidn5sBNgPQQt8f/ddRABheZ1XODXOOcOzM5u4hx01R3+hghckFoY53GUNKptZD9h1
         3ptSesMdReKakzpcNT6Xqj9TX7/z3ptQjYCBAgjC6VNRdVGoBXGwalf4Pn4HDxfvjsQF
         gdDg==
X-Gm-Message-State: AOAM533N0XTdFf70nQvuQY6A36nBtx/EJS9i2S4JV96VqvxpGviq3+M9
        Oh7yfoQPOTdDKaPxjC/5Mi14FA==
X-Google-Smtp-Source: ABdhPJy0UFYNRBMrq6eI6vpVl0W7txr6OhB2et0zRKMpSV4SVc6y6PGjO2CMl8P+H5NxD1g3ELgsig==
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr3573600wmc.138.1597821854997;
        Wed, 19 Aug 2020 00:24:14 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 08/28] wireless: intel: iwlwifi: rs: Demote non-compliant kernel-doc headers
Date:   Wed, 19 Aug 2020 08:23:42 +0100
Message-Id: <20200819072402.3085022-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these headers attempt to document any function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:165: warning: cannot understand function prototype: 'const u16 expected_tpt_legacy[IWL_RATE_COUNT] = '
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:329: warning: Function parameter or member 'priv' not described in 'rs_program_fix_rate'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:329: warning: Function parameter or member 'lq_sta' not described in 'rs_program_fix_rate'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'tbl' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'scale_index' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'attempts' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:452: warning: Function parameter or member 'successes' not described in 'rs_collect_tx_data'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:681: warning: Function parameter or member 'sta' not described in 'rs_use_green'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'lq_sta' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'hdr' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:702: warning: Function parameter or member 'rate_type' not described in 'rs_get_supported_rates'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2628: warning: duplicate section name 'NOTE'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'priv' not described in 'rs_initialize_lq'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'sta' not described in 'rs_initialize_lq'
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:2632: warning: Function parameter or member 'lq_sta' not described in 'rs_initialize_lq'

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 4fa4eab2d7f38..548540dd0c0f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -151,7 +151,7 @@ static void rs_dbgfs_set_mcs(struct iwl_lq_sta *lq_sta,
 {}
 #endif
 
-/**
+/*
  * The following tables contain the expected throughput metrics for all rates
  *
  *	1, 2, 5.5, 11, 6, 9, 12, 18, 24, 36, 48, 54, 60 MBits
@@ -318,7 +318,7 @@ static u8 rs_tl_add_packet(struct iwl_lq_sta *lq_data,
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-/**
+/*
  * Program the device to use fixed rate for frame transmit
  * This is for debugging/testing only
  * once the device start use fixed rate, we need to reload the module
@@ -440,7 +440,7 @@ static s32 get_expected_tpt(struct iwl_scale_tbl_info *tbl, int rs_index)
 	return 0;
 }
 
-/**
+/*
  * rs_collect_tx_data - Update the success/failure sliding window
  *
  * We keep a sliding window of the last 62 packets transmitted
@@ -673,7 +673,7 @@ static int rs_toggle_antenna(u32 valid_ant, u32 *rate_n_flags,
 	return 1;
 }
 
-/**
+/*
  * Green-field mode is valid if the station supports it and
  * there are no non-GF stations present in the BSS.
  */
@@ -689,7 +689,7 @@ static bool rs_use_green(struct ieee80211_sta *sta)
 	return false;
 }
 
-/**
+/*
  * rs_get_supported_rates - get the available rates
  *
  * if management frame or broadcast frame only return
@@ -2612,7 +2612,7 @@ static void rs_rate_scale_perform(struct iwl_priv *priv,
 	lq_sta->last_txrate_idx = index;
 }
 
-/**
+/*
  * rs_initialize_lq - Initialize a station's hardware rate table
  *
  * The uCode's station table contains a table of fallback rates
-- 
2.25.1

