Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21256C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D918920738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBVItS+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHSHZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHSHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E9C06134B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r15so10540682wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zkp7Qawe8Rxm7rdSdovVzLB4vK2dfikmYIjnToE95fQ=;
        b=fBVItS+8uy4PAXVGRqKYqcnn9vyXIUkhYylVMPeahGvVrQto2p/kFHnE+EcYz8Ok5U
         0EptKYfI49bLYwsG662WDdFSVeqWNpy97/8Sny+D87UA+KwPnTCRIAR9EsOFKILlnA/Y
         7ocVDTmDlbuuCImjyvNzHsVM7FNVjvugAXJE6vv688eHXV4ASY4SPSbC1kbHPQHML8hG
         DjyK/P1ZEi3fDD30U2G8O46bBOX8i2yXFGoZGbibtjrZ4Ya+LMZTWP2HaiV70lEqTZM2
         mTuabOI+q0FndjZ/4xpKFuIGJro9fL46/+WJda9KOOHv6zRw5Uz6scFS2ha+5RE5euaS
         805g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zkp7Qawe8Rxm7rdSdovVzLB4vK2dfikmYIjnToE95fQ=;
        b=OcuBFAsImj9Cie+ivgMDp4uZRsHxJp64MVQIj+zqHzFXUDC5tmKKnhDS9kSkVpYRto
         k4+ZNECFVXAxOMyXoqeQcKo326ZpO2koWulvpD4mcS7rs8D7Q5W8Jex0nNvdHNEd50tA
         t1SDx/nZ8ulONmkbdtN2spAUS0+RSb+fmV+xluNA12/iwLyDHfYvFwbKHBq2O2zh2cCC
         SpPkfflb7+2bn6MGf+MO/zUlRbtTa+on088nqGZW2hu6NwPAWM2mY9R2NfAnqW6NLvNq
         U1njU6J2cHMehWAoZSLdu3x3nqebKhMHtDZdUkEZo0N1ns7bD2QY3G1L0IJuPbt/tb7y
         v1EA==
X-Gm-Message-State: AOAM532BRzInYu5sQAcPXUeu/JL3aOp6KPtPCDkLlcCq2cSH65qTMQZX
        5WX28mnKBDmwBGyuWPu+VgV3Ww==
X-Google-Smtp-Source: ABdhPJxSZ+TVjacVOaXJET7sX7pS2ZMFGfwgWGTctOu11RcWXc/86twvo3Hbv9eAa3q10tv3lzLa/Q==
X-Received: by 2002:adf:8445:: with SMTP id 63mr2657230wrf.375.1597821860190;
        Wed, 19 Aug 2020 00:24:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 12/28] wireless: intel: iwlwifi: dvm: lib: Demote non-compliant kernel-doc headers
Date:   Wed, 19 Aug 2020 08:23:46 +0100
Message-Id: <20200819072402.3085022-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither of these headers attempt to document any function parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:121: warning: Function parameter or member 'priv' not described in 'iwlagn_txfifo_flush'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:121: warning: Function parameter or member 'scd_q_msk' not described in 'iwlagn_txfifo_flush'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:779: warning: Function parameter or member 'priv' not described in 'iwlagn_set_rxon_chain'
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c:779: warning: Function parameter or member 'ctx' not described in 'iwlagn_set_rxon_chain'

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
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index eab94d2f46b1e..3b937a7dd4032 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -110,7 +110,7 @@ int iwlagn_manage_ibss_station(struct iwl_priv *priv,
 				  vif->bss_conf.bssid);
 }
 
-/**
+/*
  * iwlagn_txfifo_flush: send REPLY_TXFIFO_FLUSH command to uCode
  *
  * pre-requirements:
@@ -769,7 +769,7 @@ static u8 iwl_count_chain_bitmap(u32 chain_bitmap)
 	return res;
 }
 
-/**
+/*
  * iwlagn_set_rxon_chain - Set up Rx chain usage in "staging" RXON image
  *
  * Selects how many and which Rx receivers/antennas/chains to use.
-- 
2.25.1

