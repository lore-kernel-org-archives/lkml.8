Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7430A20732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/wDvUp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgIJG73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgIJG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:57:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F32C061346
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so4458687wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBwZYByjjh942d4ggJkaITmm4qS6KFDbT+209YIFm2k=;
        b=o/wDvUp3hJQejPqXu9BVpd4DAZVvxNEGCvwNBjgtKaCHOvkvK2PixeedyU+euKj3uM
         6RE7sSsFhFn7II5R/AT4j99dXRYjA64fISNqweLwk21m2ilur2CuKdp/ldA/0ExeQSGq
         diVFzJGZeH2I02ScPXSS9m+HBcHIDpVwWqSW1r9F9iwqMgVKVdY4b2m6LsXoe2I6Rhrd
         qtpxpuulD/8hye47v78oTqmg0QNkvrzcxD/6+noLrHjKzcw3SIkL670d75vQivrpQE5q
         T54i9iRRejeNy+G8gWYcBfd7RPfc2DxpwcbWyOpeX0qNDjoHkUvj6rD+YIlXhopr6css
         qhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBwZYByjjh942d4ggJkaITmm4qS6KFDbT+209YIFm2k=;
        b=owOFLcIqHP6eGQC6GndZls2ouP35S+GUFYQ/2MIY5qpHx/QE3A62PThVgHUTxzrf02
         H2OfrZCvw40mvNamKymIiVf3kLULCDvmlJpqIM9C4Qo0VXpK19zJQ9oVNfZp4tylUA8c
         w2Ycl6ABR1M/gVgiFljAZhUK2H19ilL8jZcp7/P0aBvLcVSmduo83oXA7mcNfLwPvV4Y
         VcSCWHrcEEEDWA01TPle1LoA/C7s4CuISGtQB+J0WzwNFxzP8lWVM3zZsB0HMSCAH+OD
         tvTvCGX18mDCxP9KEqJb7wQjLLy3gMWy1l4RXsXAbXzB7oxwTaVtMreAcIcBx4kQqVpB
         2NgQ==
X-Gm-Message-State: AOAM533c7+UUqx8gOOerf1irlLEtwaJ2Hl6DvONhKjRrw+6vhhhkzeuj
        k1XHcAIj4VR7CZ+Y8qR4abETPg==
X-Google-Smtp-Source: ABdhPJyzPwfgv9BHfQPFHkUwcAwFvGoFXu5+ZZChSk0rDJAdQiIj3E9ve0VgMnmySY7mUABMHevIVQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr6617171wmk.125.1599720910831;
        Wed, 09 Sep 2020 23:55:10 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 15/29] iwlwifi: iwl-drv: Provide descriptions debugfs dentries
Date:   Thu, 10 Sep 2020 07:54:17 +0100
Message-Id: <20200910065431.657636-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also demote a non-conforming kernel-doc function header.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/iwl-drv.c:124: warning: Function parameter or member 'dbgfs_drv' not described in 'iwl_drv'
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c:124: warning: Function parameter or member 'dbgfs_trans' not described in 'iwl_drv'
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c:124: warning: Function parameter or member 'dbgfs_op_mode' not described in 'iwl_drv'
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1329: warning: Function parameter or member 'ucode_raw' not described in 'iwl_req_fw_callback'
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1329: warning: Function parameter or member 'context' not described in 'iwl_req_fw_callback'

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
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 04f14bfdd0914..2a9075b1b3747 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -102,6 +102,9 @@ static struct dentry *iwl_dbgfs_root;
  * @fw_index: firmware revision to try loading
  * @firmware_name: composite filename of ucode file to load
  * @request_firmware_complete: the firmware has been obtained from user space
+ * @dbgfs_drv: debugfs root directory entry
+ * @dbgfs_trans: debugfs transport directory entry
+ * @dbgfs_op_mode: debugfs op_mode directory entry
  */
 struct iwl_drv {
 	struct list_head list;
@@ -1319,7 +1322,7 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
 	}
 }
 
-/**
+/*
  * iwl_req_fw_callback - callback when firmware was loaded
  *
  * If loaded successfully, copies the firmware into buffers
-- 
2.25.1

