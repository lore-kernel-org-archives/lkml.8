Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6673220809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581625;
	bh=MjLl3ug6sbtCBvmLTLKqCIvNlrMQAeBsiE98mZv6j0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYgPCwuapEJNcGeRZ0ls8u4Dl4R/NWJoWGlgv/4C/CkJigxcX+zchLY1W9EgUKjpO
	 24N/i+o2dA4hmznRIXnofeZjH5VqBOa9o0VcI8yODCRXWGqvcR/xjfp4ShOdYn9VM/
	 ncY8cm1RGtdeNuqBR++R8Ja+KMOe/HT0eMQFA1Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbgFSP0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392316AbgFSPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA61218AC;
        Fri, 19 Jun 2020 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580223;
        bh=MjLl3ug6sbtCBvmLTLKqCIvNlrMQAeBsiE98mZv6j0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3Ul5h1OZUq5zjNzYrQrUCy7Snv+yUP+lv09fw5mGIVVQhwyLvZ399afpWC0+yrNP
         /6BxJ9u8euhXvxBbUEJTbosSBR94BgSM0TYXL30h6Mc8oFf8CzfVWBAKlsdfFqSuCB
         omfY5lqYNb6c1hm5+sJobAUmES17mdE38nb8Q1Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 168/376] iwlwifi: avoid debug max amsdu config overwriting itself
Date:   Fri, 19 Jun 2020 16:31:26 +0200
Message-Id: <20200619141718.275884757@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

[ Upstream commit a65a5824298b06049dbaceb8a9bd19709dc9507c ]

If we set amsdu_len one after another the second one overwrites
the orig_amsdu_len so allow only moving from debug to non debug state.

Also the TLC update check was wrong: it was checking that also the orig
is smaller then the new updated size, which is not the case in debug
amsdu mode.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: af2984e9e625 ("iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all TX packets")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20200424182644.e565446a4fce.I9729d8c520d8b8bb4de9a5cdc62e01eb85168aac@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 11 +++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c   | 15 ++++++++-------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 3beef8d077b8..8fae7e707374 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -481,6 +479,11 @@ static ssize_t iwl_dbgfs_amsdu_len_write(struct ieee80211_sta *sta,
 	if (kstrtou16(buf, 0, &amsdu_len))
 		return -EINVAL;
 
+	/* only change from debug set <-> debug unset */
+	if ((amsdu_len && mvmsta->orig_amsdu_len) ||
+	    (!!amsdu_len && mvmsta->orig_amsdu_len))
+		return -EBUSY;
+
 	if (amsdu_len) {
 		mvmsta->orig_amsdu_len = sta->max_amsdu_len;
 		sta->max_amsdu_len = amsdu_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 15d11fb72aca..6f4d241d47e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -369,14 +369,15 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
-		/*
-		 * In debug sta->max_amsdu_len < size
-		 * so also check with orig_amsdu_len which holds the original
-		 * data before debugfs changed the value
-		 */
-		if (WARN_ON(sta->max_amsdu_len < size &&
-			    mvmsta->orig_amsdu_len < size))
+		if (sta->max_amsdu_len < size) {
+			/*
+			 * In debug sta->max_amsdu_len < size
+			 * so also check with orig_amsdu_len which holds the
+			 * original data before debugfs changed the value
+			 */
+			WARN_ON(mvmsta->orig_amsdu_len < size);
 			goto out;
+		}
 
 		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
 		mvmsta->max_amsdu_len = size;
-- 
2.25.1



