Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61ECC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2E1207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNwHAFYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJHQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgIJG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:56:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F14C06138B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so4611135wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORROKc4zS4isv+NiIKK9DX3bTWpPv9GkX3d9qrOHUaI=;
        b=XNwHAFYLI6xhX2vkpi2xe5/VpsSZo+TVtfRCP25YQcCAiV4/6dYbkr3YB6pJ0alyxm
         bnE2P+slAwR0e/GQAVby3W+CrGYMXZyBdibRXjTM2e1C1r+xtJFknw9hUhi/bNzYbT0z
         vRnUELULOJ3/LcFTZYfe9/rPL8/6trg4pweA0SAP3V/9rTbxw3sdrQSFoCb8dhHq11DX
         gTQsbzahldCf4Y+6HXQjIdUoP15WKlhXuCozKezhOx32CeR5ALXBdetvAsL51Hy/gGax
         hjMuJdvDrLvlSQnkw6piihjPw+cq7FETIrPBvVJaoYHD1I7KepJslP3kZ2qrHS6JPbNa
         hp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORROKc4zS4isv+NiIKK9DX3bTWpPv9GkX3d9qrOHUaI=;
        b=dQfDzsP7Td5qMgemQrpIOA2yy6onD6wDzhtxszAkgWOQLQZ9XpKngiAbe4ySOhlFqd
         4p8fsW/6KEckQq4cFt0rXIkA0RPdqqdnfL66m0Zssaw+BpSxSexVKwp1LBVbUhx8wcqn
         Lg5pmrJS0zysN82nPpzln4VuC0gNF2oLoeyqOTjvFM01qHbM1SaUfK2Ubz4TSGGbzWCP
         +u0A92G5ZzYsJpf5yhOAE7NF3qjMrrjb/rPzWQz34rp2UcEepVDYR95iEmMvDns7wIa3
         9brYVVd4ZgdlCSGnF1i8s74gpoplZiPV4k5iliEt5NLC9Xz2jzNrvXa6oEOxQCHoIOoA
         cmzg==
X-Gm-Message-State: AOAM531sMVDhwappJorrLSil6NLd1ry7gPqF/CvQUBeYyNgaK2uv7RyP
        vE4wo96VuBex+pOZT8Q//wel+A==
X-Google-Smtp-Source: ABdhPJySiRPvcSS8cpL9kt4JKM6/jZo5Fv2pqIoqM5g4KGu2xB54ejlLh0R8gdhFDjlTVqLNJL8yug==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr7191248wmb.77.1599720907356;
        Wed, 09 Sep 2020 23:55:07 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH 12/29] iwlwifi: dvm: rxon: Demote non-conformant kernel-doc headers
Date:   Thu, 10 Sep 2020 07:54:14 +0100
Message-Id: <20200910065431.657636-13-lee.jones@linaro.org>
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

 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:695: warning: bad line:
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:701: warning: Function parameter or member 'priv' not described in 'iwl_set_rxon_channel'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:701: warning: Function parameter or member 'ctx' not described in 'iwl_set_rxon_channel'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:839: warning: Function parameter or member 'ctx' not described in 'iwl_full_rxon_required'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:1029: warning: Function parameter or member 'priv' not described in 'iwlagn_commit_rxon'
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c:1029: warning: Function parameter or member 'ctx' not described in 'iwlagn_commit_rxon'

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
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 6f37c9fac31d9..12a3d464ae640 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -689,7 +689,7 @@ void iwl_set_rxon_ht(struct iwl_priv *priv, struct iwl_ht_config *ht_conf)
 		_iwl_set_rxon_ht(priv, ht_conf, ctx);
 }
 
-/**
+/*
  * iwl_set_rxon_channel - Set the band and channel values in staging RXON
  * @ch: requested channel as a pointer to struct ieee80211_channel
 
@@ -826,7 +826,7 @@ static int iwl_check_rxon_cmd(struct iwl_priv *priv,
 	return errors ? -EINVAL : 0;
 }
 
-/**
+/*
  * iwl_full_rxon_required - check if full RXON (vs RXON_ASSOC) cmd is needed
  * @priv: staging_rxon is compared to active_rxon
  *
@@ -1007,7 +1007,7 @@ static void iwl_calc_basic_rates(struct iwl_priv *priv,
 	ctx->staging.ofdm_basic_rates = ofdm;
 }
 
-/**
+/*
  * iwlagn_commit_rxon - commit staging_rxon to hardware
  *
  * The RXON command in staging_rxon is committed to the hardware and
-- 
2.25.1

