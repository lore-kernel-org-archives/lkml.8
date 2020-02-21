Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B257C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2384F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274397;
	bh=FE0Z1BJ3NywBOscUKuwrnwjE3YVONSdmK2+ECjDwfX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUzTICzRs6ej9YRoT5nG8zyWFeJUa8HJ61nlzSX3RKk0P54s8VG9jRiZtLOKsebMs
	 +TkCJWR/MJHfLsZUt9znmlVJXTkWfq/w8iyyQ2Xrn4BBlD8x4baEADSsW8W8HTNldX
	 xcXC0OhB7B4T+dNnzE44ZrvdHxEOa3OLHT1PfCa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgBUIj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbgBUIAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:00:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589A42073A;
        Fri, 21 Feb 2020 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272007;
        bh=FE0Z1BJ3NywBOscUKuwrnwjE3YVONSdmK2+ECjDwfX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4KeaO3tYktjRh0yDbLywSyUbcFTR8N2podbZv9naSxtUcX5KJ3ZzYKt0GByY5WYE
         Mt37DGYzJaMsuBHSxTHHFxzhk0LnQS+q0u3Vc05LdMFyGqD/w3MGeLl72wBFGVH/h4
         aOINdQCiNUbZnk4ai11fMpletTfSWbkibMIEv+hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 381/399] iwlwifi: mvm: Check the sta is not NULL in iwl_mvm_cfg_he_sta()
Date:   Fri, 21 Feb 2020 08:41:46 +0100
Message-Id: <20200221072437.235810823@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit 12d47f0ea5e0aa63f19ba618da55a7c67850ca10 ]

Fix a kernel panic by checking that the sta is not NULL.
This could happen during a reconfig flow, as mac80211 moves the sta
between all the states without really checking if the previous state was
successfully set. So, if for some reason we failed to add back the
station, subsequent calls to sta_state() callback will be done when the
station is NULL. This would result in a following panic:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000040
IP: iwl_mvm_cfg_he_sta+0xfc/0x690 [iwlmvm]
[..]
Call Trace:
 iwl_mvm_mac_sta_state+0x629/0x6f0 [iwlmvm]
 drv_sta_state+0xf4/0x950 [mac80211]
 ieee80211_reconfig+0xa12/0x2180 [mac80211]
 ieee80211_restart_work+0xbb/0xe0 [mac80211]
 process_one_work+0x1e2/0x610
 worker_thread+0x4d/0x3e0
[..]

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index efdf15f57f163..02df603b64000 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
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
@@ -2037,7 +2035,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	rcu_read_lock();
 
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_ctxt_cmd.sta_id]);
-	if (IS_ERR(sta)) {
+	if (IS_ERR_OR_NULL(sta)) {
 		rcu_read_unlock();
 		WARN(1, "Can't find STA to configure HE\n");
 		return;
-- 
2.20.1



