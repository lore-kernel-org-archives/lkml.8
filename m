Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E973C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CDE20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlMRUCt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHUHVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgHUHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58040C06136D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so825372wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsXVZlb3+RPh6wsFFLtZip9Xh8c8BRLlYFokPA0kQU8=;
        b=GlMRUCt0tk+ts8PiLe/psgZRUi46xqkZeg3YsyC3FR4geI5DPAC+Z3ksWqLHfcuETg
         C203xvi1zCzTgBG5JRdq5KLMOwrn4MwgT/luru6MwvDzIWOTv22d8NnO1kjCrbbLRxFL
         oHGGRX3igK0ZK5o8TFxdGMtir+lIaMP2c4dmh5PU5g4kURn1MyRx5wC274j8d37aLVFp
         yV8sAyeJec4NYastw6y5fzbnDfOYFbGJMxDnO8IYcqCOI/OX9IsAprz7+j8XQjWN2YGc
         LlB5fPm1IeR2+ywtO0dOrA2ndf9UiAsa8RZUc4Il6C1Ub3GtmSdchlzvWd7ujSR1U2nW
         gqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsXVZlb3+RPh6wsFFLtZip9Xh8c8BRLlYFokPA0kQU8=;
        b=SIxTwhU75yTSSq2mxw7pK0q2KFcOz6b6hwxXVA7CMsohfco9cyvxDGspNU9oL8JrPK
         ZvIwQPd3Dk6wKu+BIti3tZpZCZzscTinxqyLbReEnoKmhRI9VxacswGYhRZtC4pfeLnG
         sxln6io1bzVhRSKhhnlovrS3rAeIDAFlWTeUknmxGU52Mh8HFb9RgrjoHuD/CDZr/ya5
         pdS+aWG6Ne+KZ2iCola/D7XMUCP8URrYMGInOjiX0mJW8mICxGLaziqiCy28MaIh3g+z
         NgUg/5LqxqPs9PiP41501CBQwiDbfQd3a+YpLFLg2fS1TXPHBo3tlvdQ5VYfwkZP+4iP
         dczA==
X-Gm-Message-State: AOAM531Kvy0s/4opIM/5LNrXn9UBCnrz4+U5qAr8A9S3x6irGeUhz28o
        T158s1wnDQZeBlcJkYFMO5ENxw==
X-Google-Smtp-Source: ABdhPJzCwMbOmP03tTO4spaAbus4rZY09WFAG3Mma7D8oDWodk5Tt/MzWrKwrCrpe5EVtzJu3ncCyw==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr2359063wmb.67.1597994232048;
        Fri, 21 Aug 2020 00:17:12 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 19/32] wireless: intel: iwlwifi: dvm: devices: Fix function documentation formatting issues
Date:   Fri, 21 Aug 2020 08:16:31 +0100
Message-Id: <20200821071644.109970-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/devices.c:66: warning: Function parameter or member 'priv' not described in 'iwl_beacon_time_mask_low'
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c:66: warning: Function parameter or member 'tsf_bits' not described in 'iwl_beacon_time_mask_low'
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c:77: warning: Function parameter or member 'priv' not described in 'iwl_beacon_time_mask_high'
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c:77: warning: Function parameter or member 'tsf_bits' not described in 'iwl_beacon_time_mask_high'

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
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index d42bc46fe5662..c3e25885d1943 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -58,8 +58,8 @@ static void iwl1000_nic_config(struct iwl_priv *priv)
 
 /**
  * iwl_beacon_time_mask_low - mask of lower 32 bit of beacon time
- * @priv -- pointer to iwl_priv data structure
- * @tsf_bits -- number of bits need to shift for masking)
+ * @priv: pointer to iwl_priv data structure
+ * @tsf_bits: number of bits need to shift for masking)
  */
 static inline u32 iwl_beacon_time_mask_low(struct iwl_priv *priv,
 					   u16 tsf_bits)
@@ -69,8 +69,8 @@ static inline u32 iwl_beacon_time_mask_low(struct iwl_priv *priv,
 
 /**
  * iwl_beacon_time_mask_high - mask of higher 32 bit of beacon time
- * @priv -- pointer to iwl_priv data structure
- * @tsf_bits -- number of bits need to shift for masking)
+ * @priv: pointer to iwl_priv data structure
+ * @tsf_bits: number of bits need to shift for masking)
  */
 static inline u32 iwl_beacon_time_mask_high(struct iwl_priv *priv,
 					    u16 tsf_bits)
-- 
2.25.1

