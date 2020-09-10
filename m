Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B40C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6395620732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7I7/sOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIJG6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgIJG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D3C061386
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so4475452wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=f7I7/sOE5MX2MwYG0P7i9T0mXlgEc/Xg/VnzodtaTudMO88woJ1hS+eKDB7SiFV+vH
         TJKdZ0nKQdU1VSMvuH4XRX5knInP266MCc9oE6QVW9gxLQVPipXHQIH0bSkFz3Tu4rWX
         aoSPEOSa5W5RxBACYetaAr29wn4cv2jy3eFHeaqqx6nGqHAmvtW8UUn841lHiqv7Mfjq
         vpfncZHtm/KM57VHcU5w1jnbMhIBCKRNh0i8yG5XorXF5b3mUpoz1TpN09FostJpBILe
         cABq3qJleabsAl1uYBqTq58PkKy5sb6NOfqbfWjbrZf3FUmqGyCb9Q5uJzq1s1gqj1pI
         mr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ089mc+jG2SVa5Dv6nfNI2A1vqsj2U3E/4seGpFeQ0=;
        b=ASCfhtFh1lE+z68QIHLn98485Sx8wcaUONLBGC9AUtAsjQfFt+Bama08S4hHELMUlU
         LaobOBtVcK4nEPZUK1n9y3iD2SMviWT5qJQggtCE3kwyoKt4+8nvg+ZFNctxITAcPfTK
         XzUzVtEae8bVn0mrP726b9unFoq4pmkZLItTihTXRZQsH+8hnhh+muwJvU+7d6lykKZF
         IJ8r2Wx9+wo91qhf+QNYaknZ9WDOZDHWPrH17ObfWUrpm/n0Ann3rZfhVty0G01hU11n
         Ypnxvri135W1hLgL3MKoP8kBZSI99Wi7Mc0apndmQBeKQwtDerUwlN8fQt+7JZpnUTrl
         jL/A==
X-Gm-Message-State: AOAM5336xWMxldBu0URRjb0OFritLluwhKSj+6Nm6GM+Vc7vrh9NrThO
        yqiA2k0dOyCuffSBKQtc1mj5YQ==
X-Google-Smtp-Source: ABdhPJx8tJ70LHF6HpOyRTSAL+A8LVJtbLNEjzH/eMpBtN3oalvlMo2E8ReiliY1BaBveE11V2DF9Q==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr7270091wmm.38.1599720904847;
        Wed, 09 Sep 2020 23:55:04 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 10/29] iwlwifi: mvm: utils: Fix some doc-rot
Date:   Thu, 10 Sep 2020 07:54:12 +0100
Message-Id: <20200910065431.657636-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misnamed, and missing descriptions likely due to doc-rot.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Function parameter or member 'lq' not described in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:669: warning: Excess function parameter 'sync' description in 'iwl_mvm_send_lq_cmd'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'mvm' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'vif' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Function parameter or member 'smps_request' not described in 'iwl_mvm_update_smps'
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c:695: warning: Excess function parameter 'smps_requests' description in 'iwl_mvm_update_smps'

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
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index be57b83918506..71eda04946023 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -658,7 +658,8 @@ int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
 
 /**
  * iwl_mvm_send_lq_cmd() - Send link quality command
- * @sync: This command can be sent synchronously.
+ * @mvm: Driver data.
+ * @lq: Link quality command to send.
  *
  * The link quality command is sent as the last step of station creation.
  * This is the special case in which init is set and we call a callback in
@@ -683,8 +684,10 @@ int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq)
 
 /**
  * iwl_mvm_update_smps - Get a request to change the SMPS mode
+ * @mvm: Driver data.
+ * @vif: Pointer to the ieee80211_vif structure
  * @req_type: The part of the driver who call for a change.
- * @smps_requests: The request to change the SMPS mode.
+ * @smps_request: The request to change the SMPS mode.
  *
  * Get a requst to change the SMPS mode,
  * and change it according to all other requests in the driver.
-- 
2.25.1

