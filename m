Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498AC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D13520575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099192;
	bh=jTkbz6y8N+xHaIkPwxT3Swbov8LWwYRkjGnhFasGZuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z85McRVQpRTwXRKTXc7RJ/IXYI0+ij8fXokd/PV3kzTbG2f7ii2NvuR7tSfrshMRp
	 1EthQPUt8rZ0WIx3yMB0Z/buhLOkHi1naHQ/xaSoXq8cfXryulk+m85aaBKzkjnqwL
	 kvtImx+XcmVSUvyqCRZmfU7yjfgy02fGj8lISGzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgD1Sju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgD1Sjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:39:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D903620730;
        Tue, 28 Apr 2020 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099185;
        bh=jTkbz6y8N+xHaIkPwxT3Swbov8LWwYRkjGnhFasGZuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGRwaFgchut9kj4Lz80PVo6Fl6q6nEEegUxKQlVkKa9Gshl9u/Ulz3FVBZzEztXxi
         D17G8xpBAZhafdxf4tzAzwlr99DZuxhr6GagpYR2LegsSoTBufu90W9mRGB8+aReq9
         ELM0XdGVlivnBOTLVUA+5LgXdenHzxa+wpgsOA7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 110/131] iwlwifi: mvm: beacon statistics shouldnt go backwards
Date:   Tue, 28 Apr 2020 20:25:22 +0200
Message-Id: <20200428182239.053291784@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

commit 290d5e4951832e39d10f4184610dbf09038f8483 upstream.

We reset statistics also in case that we didn't reassoc so in
this cases keep last beacon counter.

Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/iwlwifi.20200417100405.1f9142751fbc.Ifbfd0f928a0a761110b8f4f2ca5483a61fb21131@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -587,6 +587,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *
 
 struct iwl_mvm_stat_data {
 	struct iwl_mvm *mvm;
+	__le32 flags;
 	__le32 mac_id;
 	u8 beacon_filter_average_energy;
 	void *general;
@@ -630,6 +631,13 @@ static void iwl_mvm_stat_iterator(void *
 		}
 	}
 
+	/* make sure that beacon statistics don't go backwards with TCM
+	 * request to clear statistics
+	 */
+	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		mvmvif->beacon_stats.accu_num_beacons +=
+			mvmvif->beacon_stats.num_beacons;
+
 	if (mvmvif->id != id)
 		return;
 
@@ -790,6 +798,7 @@ void iwl_mvm_handle_rx_statistics(struct
 
 		flags = stats->flag;
 	}
+	data.flags = flags;
 
 	iwl_mvm_rx_stats_check_trigger(mvm, pkt);
 


