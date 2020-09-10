Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65402078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYJqd1E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIJHSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbgIJG4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F9C0617BB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so4627594wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkJnqXxLKchHWxEQRJwgWXXCncTXSd4DzK09wyk1JRk=;
        b=DYJqd1E6K+y9QXkHGAIL5L1tXb7g2KMB7ljmLob/AWKP/B3CE0VlYJ+ZmLnA1JsU+W
         XzeKdAFsy3l664YPEVaTMsQyAxViTd7y/szoEgOR3KBWpL4pzwKQAlvQV69no2+57iAO
         sBvvSBR2DbNxQ6bNR8Lzl1VEXxN5F6qC0fQHRQ5TFDTnBG5oX1mfdBa2iCtghm17AxG2
         1V8A2AfOYwH8cVYYPvNFSVtl154KCArcSZDn+zizPSCxWsvuJh+9xjvKibqeFwq8iOur
         LZ6006V9Brdrycp32HJO4D2kbIXGA4X8S9D03PGja1KroF6T4l90Ual4A97wbQRlGduW
         3ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkJnqXxLKchHWxEQRJwgWXXCncTXSd4DzK09wyk1JRk=;
        b=KdbNCitUd1VL3iNYIInzgHDC8ztyHxlUSM67gafSsZ8htO1CGm7T/VKm2k63XsdSp8
         aQXcJuf9f2HJWV48cKI25B5mKSaau3SLpcR5B5st/1AZa3y0NtOpABw7kS8UD2z00obN
         5nwWuq4Z1hpjW+las6Ul2pWuon5tdcZEOGv3DgaFQmWP3xE6a4TDSdJGrcZU7pv+puDg
         +6s2ZHix7aEo5YGKXMfQTT1jsCKty20TuInIMJ4MFpuSRJ3fjMXIlmcyCYa2qJdUxEhv
         v2+U0cAxdk079StLw+/PbTghtaqQ1EG7FtBkstkZKKQUEOf6Uwl7+I5C69FXDrtJhb40
         qz3w==
X-Gm-Message-State: AOAM533hDfcLjOfuXLN78TpejRG+syBpk5cNgvLLnjfB2GtqG+Nw5fpm
        zOMmAnoZRi2UKRf8NzXnaZlvZw==
X-Google-Smtp-Source: ABdhPJyWZsjYvdkZU9EYL+wKFtSQo4POMqm+cW+4REdrJdO0d6J7tVdZDQUtki7PleCf2FTISfGwYQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr7063757wmb.25.1599720902615;
        Wed, 09 Sep 2020 23:55:02 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 08/29] iwlwifi: mvm: ops: Remove unused static struct 'iwl_mvm_debug_names'
Date:   Thu, 10 Sep 2020 07:54:10 +0100
Message-Id: <20200910065431.657636-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as if it's never been used.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/mvm/ops.c:466:36: warning: ‘iwl_mvm_debug_names’ defined but not used [-Wunused-const-variable=]

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
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d095ff847be92..8e1e9ffbbf59a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -460,15 +460,6 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
 };
 
-/* Please keep this array *SORTED* by hex value.
- * Access is done through binary search
- */
-static const struct iwl_hcmd_names iwl_mvm_debug_names[] = {
-	HCMD_NAME(DBGC_SUSPEND_RESUME),
-	HCMD_NAME(BUFFER_ALLOCATION),
-	HCMD_NAME(MFU_ASSERT_DUMP_NTF),
-};
-
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
-- 
2.25.1

