Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A33C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BB220732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKx+JXyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIJHCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgIJG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:57:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2A6C061342
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so4611181wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFEv542Lhp8Q0f61EAB5CHsxrkFJGeJ0ctv6xlXdr9A=;
        b=PKx+JXyKX6oNJ99FSi8jIpQx1PBRxa50KrYhj3ZbAsKzw5r4J6yMp99KeO9WcPFB8c
         Ceceo6MnvArOwhTkJxPQXGShN/2HzVNXnJwyGmbROSYiv+l4qdxh92n/WtlKUSGL4PzO
         I4V7/mu+d/TlApnB0zv0n0RWo2Wf4r6mk3pEueiHLdFzA1m1LBd3gizya+K8Q7zFVx/b
         6EoLYVG3XkxF1RHCyOqAOMo3/V1yLm3UW3V4MNcJ/8RMC0wW5a1zinqsSE+SMjhTsZeJ
         oHUEBLEIe6t2SoaD466VF37n2SXfzhQS8z+1379EkeJp6Oe3m+DmSea4CteDsobRPWxB
         ZY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFEv542Lhp8Q0f61EAB5CHsxrkFJGeJ0ctv6xlXdr9A=;
        b=qalJwvx9i6nkCbT1PD9xaWT2nL9VUT5S8/n0rI0BewyIc6IqpzSQPxkR/INLYmREOR
         6lEJkcxOqZ592fyA2qIz3i3serW7hfPEYobvCXBqkeVcVjuyHjTuP51Z8an3NwW02F2U
         hD7jfzPl3kkgdLJFNt4TxLD3YCbHeFCfwoXhUvJY/ek1g9uS3JokiLgeiab9daypBuTP
         0llMabWXH0oip3sHBA/WUyIKvWupZfdS1x/Q2yxHhWvvue/FIB+lZHZG2FxnFOOeyQsd
         HDRhIbaTw4YP6RPtJ8pmh2CLrRrlEv/wbJpxt2o41C1DGy9HVAejfc5JwzNwpm4QkSQA
         Fxtg==
X-Gm-Message-State: AOAM531LVnqvhX60NDkE7bClIuGcHTR3owL70kgkE/ZEc/EyUvv5KCdy
        v8mTm4+2cpir9KkSkLv+BbTI13lg33XMCg==
X-Google-Smtp-Source: ABdhPJwglt/9uW5KPkunmXazmtb24J49GEPBxD3Bb9hG8tmIdx9pCeW1n4r7+1K7+lnSzxSbiVjn3g==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr6622241wmj.23.1599720908553;
        Wed, 09 Sep 2020 23:55:08 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 13/29] iwlwifi: mvm: tx: Demote misuse of kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:15 +0100
Message-Id: <20200910065431.657636-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1379: warning: Function parameter or member 'rate_n_flags' not described in 'iwl_mvm_hwrate_to_tx_status'
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1379: warning: Function parameter or member 'info' not described in 'iwl_mvm_hwrate_to_tx_status'
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1431: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_get_scd_ssn'

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
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2f6484e0d726c..82ebf264de397 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1371,7 +1371,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 	}
 }
 
-/**
+/*
  * translate ucode response to mac80211 tx status control values
  */
 static void iwl_mvm_hwrate_to_tx_status(u32 rate_n_flags,
@@ -1413,7 +1413,7 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
-/**
+/*
  * iwl_mvm_get_scd_ssn - returns the SSN of the SCD
  * @tx_resp: the Tx response from the fw (agg or non-agg)
  *
-- 
2.25.1

