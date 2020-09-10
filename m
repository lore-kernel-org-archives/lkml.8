Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88334C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D272078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSqRghSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIJHRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgIJG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF0C061389
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so4485505wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=watylvtavvjnlIiL88AKksk2UODGv6ozdE6QDJoiV0Y=;
        b=NSqRghSS5cx169+IIyEEIA1pUSywUIf49yMu9NjwR/xkjzO8d+5PfOmm/TYRQ/f1mB
         6haERzzrHCa7y3x7YGpFMKZxl18fS2UOM03jbFZpzIxhw5FccwGMDO5OePh43gsFdrB/
         +5aespm/3GiFg8l6B+zhD45sSafvLk2OGp0CJXT8oBww2J9WynDl3a2vwR+iVNQ/RdbZ
         /9QQbYRMc2jiSjkec3omZrbtZFJ62tfzvXKNtCU7vvZIOV+Tj3mdh3z0cUa9dmXXIWS9
         x2RrSWUpMB6gM7zUhAPhiu+5qja0KiPaNBvVhZsENyHzniZz03hBFq+ediLRAtlirXcG
         UQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=watylvtavvjnlIiL88AKksk2UODGv6ozdE6QDJoiV0Y=;
        b=I3bz7uEh5YCFpcMGfZQSHnHqJVQUHC3TS9s9Yit7553VzbtZOc8hNoz3pbsQblKExt
         W8GRJFhvs59T7kDS0n6RaLRZNBmLUe915FO1jirsVEVkTD/24Tg5rJ6QaSmVIDbid/uN
         7sj5VjYTmZgBwwyOrnibLyLZepXwkUGPtaXlJj4Wi9D+kWopzrPx0Avsaoz64GiJ+HB6
         FOA7YiZhL4QSHNAU+K/+URs6RzOA5G5oOcyszfB8VLILksjKXlC7F+f2j9Pn4J8TDeoX
         z4e/EmVVkWMNKX8xRQcaZoZBu47HZkqK9jy5pVasSULIHoosohS4Q7Rw1OPM8w6/8S7z
         u66g==
X-Gm-Message-State: AOAM530KE2ei184iYEMrmH9P/QR4bBArte9wWKR+xrFZ+SAUDlDrNY5L
        C7ELFvBU6fiZlC1bHQsnwC6A7Q==
X-Google-Smtp-Source: ABdhPJzWXsjc1qiY/ASKSBUySqorjX/uq7tPPkWgWr2DpV+zKNAZ9eOWEtsMDRTvwiFH7rKrsK7pIw==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr6750493wmb.94.1599720905943;
        Wed, 09 Sep 2020 23:55:05 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 11/29] iwlwifi: dvm: scan: Demote a few nonconformant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:13 +0100
Message-Id: <20200910065431.657636-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 of which do not attempt to document their parameters, 1 does a poor job.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:193: warning: Function parameter or member 'priv' not described in 'iwl_scan_cancel'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:205: warning: Function parameter or member 'priv' not described in 'iwl_scan_cancel_timeout'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'frame' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'ta' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'ies' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'ie_len' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'ssid' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'ssid_len' not described in 'iwl_fill_probe_req'
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c:570: warning: Function parameter or member 'left' not described in 'iwl_fill_probe_req'

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
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/scan.c b/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
index 1d8590046ff7d..832fcbb787e98 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/scan.c
@@ -186,7 +186,7 @@ static void iwl_do_scan_abort(struct iwl_priv *priv)
 		IWL_DEBUG_SCAN(priv, "Successfully send scan abort\n");
 }
 
-/**
+/*
  * iwl_scan_cancel - Cancel any currently executing HW scan
  */
 int iwl_scan_cancel(struct iwl_priv *priv)
@@ -196,10 +196,9 @@ int iwl_scan_cancel(struct iwl_priv *priv)
 	return 0;
 }
 
-/**
+/*
  * iwl_scan_cancel_timeout - Cancel any currently executing HW scan
  * @ms: amount of time to wait (in milliseconds) for scan to abort
- *
  */
 void iwl_scan_cancel_timeout(struct iwl_priv *priv, unsigned long ms)
 {
@@ -560,10 +559,9 @@ static int iwl_get_channels_for_scan(struct iwl_priv *priv,
 	return added;
 }
 
-/**
+/*
  * iwl_fill_probe_req - fill in all required fields and IE for probe request
  */
-
 static u16 iwl_fill_probe_req(struct ieee80211_mgmt *frame, const u8 *ta,
 			      const u8 *ies, int ie_len, const u8 *ssid,
 			      u8 ssid_len, int left)
-- 
2.25.1

