Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63472C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E03E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339540;
	bh=/J699oMm2O3gF9D+bDAXECvT1yvmuNGteL2a5lfpte4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJ4/O5GnkIIBbjLV1kSefqs0gpTm33wT7B8O2pQbBSRaz2ZcO+G1KgQGK7mZNK0PM
	 8K44HFa4vSiOIe4FTrinxNSirbhS5TjMiGQdAqua2h6EkKZ7KDlFS/ZDmb3jylVNUO
	 SlJcxKRzz83ste6KSHzDsupKZl/Or9S30zOCqtMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgBJM67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbgBJMlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:15 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6762051A;
        Mon, 10 Feb 2020 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338474;
        bh=/J699oMm2O3gF9D+bDAXECvT1yvmuNGteL2a5lfpte4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGgxqJeLyhqA5rCnI1OK9aImNhpFv68iY7tH4r+JkhvPYGwDcBfZ/9wCyCkedKW30
         +K4uYWxgm4i79stJce4YFeJKtOkHklVfOnUigUE4ayHNcrCZcYJUxxmn2f0fltQqw3
         MOTNfZIChDZYsENRX9Cc+j5LY1pjApzCz1K/Pix0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 206/367] iwlwifi: dont throw error when trying to remove IGTK
Date:   Mon, 10 Feb 2020 04:31:59 -0800
Message-Id: <20200210122443.458465140@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

commit 197288d5ba8a5289f22d3aeb4fca3824bfd9b4af upstream.

The IGTK keys are only removed by mac80211 after it has already
removed the AP station.  This causes the driver to throw an error
because mac80211 is trying to remove the IGTK when the station doesn't
exist anymore.

The firmware is aware that the station has been removed and can deal
with it the next time we try to add an IGTK for a station, so we
shouldn't try to remove the key if the station ID is
IWL_MVM_INVALID_STA.  Do this by removing the check for mvm_sta before
calling iwl_mvm_send_sta_igtk() and check return from that function
gracefully if the station ID is invalid.

Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3320,6 +3320,10 @@ static int iwl_mvm_send_sta_igtk(struct
 	igtk_cmd.sta_id = cpu_to_le32(sta_id);
 
 	if (remove_key) {
+		/* This is a valid situation for IGTK */
+		if (sta_id == IWL_MVM_INVALID_STA)
+			return 0;
+
 		igtk_cmd.ctrl_flags |= cpu_to_le32(STA_KEY_NOT_VALID);
 	} else {
 		struct ieee80211_key_seq seq;
@@ -3574,9 +3578,9 @@ int iwl_mvm_remove_sta_key(struct iwl_mv
 	IWL_DEBUG_WEP(mvm, "mvm remove dynamic key: idx=%d sta=%d\n",
 		      keyconf->keyidx, sta_id);
 
-	if (mvm_sta && (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-			keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-			keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256))
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)
 		return iwl_mvm_send_sta_igtk(mvm, keyconf, sta_id, true);
 
 	if (!__test_and_clear_bit(keyconf->hw_key_idx, mvm->fw_key_table)) {


