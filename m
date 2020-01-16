Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4F42064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218164;
	bh=RPnjgwJitvJ9WTJhiXRj+CfScZfy+WqaNZeXHqvhueI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKDooZfG1YBMyME5EaQTsVNZdutyvigWum3OmPza1YHYYRkS79iW6xxWQciOTZ8Er
	 ylo4Dgg2GKZFPKEeF7pks4MvolFMIFS3z1cj3QunrdiocX222FWPIvH2NzJ+esFztG
	 m84PmXT5d6S6k9QVI4m6tlVAH3oHAYsa8RJzBkcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbgAPX0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbgAPXZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:25:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3152075B;
        Thu, 16 Jan 2020 23:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217158;
        bh=RPnjgwJitvJ9WTJhiXRj+CfScZfy+WqaNZeXHqvhueI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLRUTzX1+2xgdgmuBxhoaKoGplXW6wzklXu6l1PKnTxf8wLHRonFq33Nhq4o9cq90
         azhkuTZ3PLDuIz6bHkZ+uC8N058FpoopdBo/jgLpgAAKZsICFTnjJkqU1wap73tdxS
         za9al0sCzZFXqgoHAXoKfKdFFS6h9erGG8p8dymA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 5.4 172/203] iwlwifi: mvm: consider ieee80211 station max amsdu value
Date:   Fri, 17 Jan 2020 00:18:09 +0100
Message-Id: <20200116231759.571800150@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

commit ee4cce9b9d6421d037ffc002536b918fd7f4aff3 upstream.

debugfs amsdu_len sets only the max_amsdu_len for ieee80211 station
so take it into consideration while getting max amsdu

Fixes: af2984e9e625 ("iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all TX packets")
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c |    8 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    |    7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -350,7 +350,13 @@ void iwl_mvm_tlc_update_notif(struct iwl
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
-		if (WARN_ON(sta->max_amsdu_len < size))
+		/*
+		 * In debug sta->max_amsdu_len < size
+		 * so also check with orig_amsdu_len which holds the original
+		 * data before debugfs changed the value
+		 */
+		if (WARN_ON(sta->max_amsdu_len < size &&
+			    mvmsta->orig_amsdu_len < size))
 			goto out;
 
 		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -935,7 +935,12 @@ static int iwl_mvm_tx_tso(struct iwl_mvm
 	    !(mvmsta->amsdu_enabled & BIT(tid)))
 		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
-	max_amsdu_len = iwl_mvm_max_amsdu_size(mvm, sta, tid);
+	/*
+	 * Take the min of ieee80211 station and mvm station
+	 */
+	max_amsdu_len =
+		min_t(unsigned int, sta->max_amsdu_len,
+		      iwl_mvm_max_amsdu_size(mvm, sta, tid));
 
 	/*
 	 * Limit A-MSDU in A-MPDU to 4095 bytes when VHT is not


