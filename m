Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D391C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465682072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217187;
	bh=B7EWYdzw+f0RsTvHeXczbavP40vVNGvfLWkYXmipdd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFWIRGuB6pBoFUmnk9kqG1Aim2ZvJvlnduv4QiYImW3YB14dwf3Z+FeRv4ToMAsS+
	 LZV/NgyDDkY+Krg6HEmyRwWbihCeJMtAnmKEnJf8RfDeMaKWvioGDOD7CplavI9hrU
	 8RNVksUfsskQ6I8bdKM7NtUUQOOYARBiHaY+D908=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgAPX00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732438AbgAPX0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:26:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE5A20684;
        Thu, 16 Jan 2020 23:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217163;
        bh=B7EWYdzw+f0RsTvHeXczbavP40vVNGvfLWkYXmipdd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sjp8yqRGtM3lcfmcFD2zrMkUd9vB6DcwgumPpaznNOMee5Uc1CqJzPbVb37bHIMuR
         pfLlV2RXwb+JZCmdpYn3+NHsKxwWvYjn2YvHEZ3nCCtIBX8S6mZTaPJgLiL9Eh6FDl
         7fvdCFLgbmz9WY6I79ssnOQzSPerfXqnVNyzqkmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 174/203] iwlwifi: mvm: fix support for single antenna diversity
Date:   Fri, 17 Jan 2020 00:18:11 +0100
Message-Id: <20200116231759.707341460@linuxfoundation.org>
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

From: Luca Coelho <luciano.coelho@intel.com>

commit bb99ff9baa02beb9216c86678999342197c849cc upstream.

When the single antenna diversity support was sent upstream, only some
definitions were sent, due to a bad revert.

Fix this by adding the actual code.

Fixes: 5952e0ec3f05 ("iwlwifi: mvm: add support for single antenna diversity")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -514,6 +514,18 @@ static int iwl_send_phy_cfg_cmd(struct i
 	struct iwl_phy_cfg_cmd phy_cfg_cmd;
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
 
+	if (iwl_mvm_has_unified_ucode(mvm) &&
+	    !mvm->trans->cfg->tx_with_siso_diversity) {
+		return 0;
+	} else if (mvm->trans->cfg->tx_with_siso_diversity) {
+		/*
+		 * TODO: currently we don't set the antenna but letting the NIC
+		 * to decide which antenna to use. This should come from BIOS.
+		 */
+		phy_cfg_cmd.phy_cfg =
+			cpu_to_le32(FW_PHY_CFG_CHAIN_SAD_ENABLED);
+	}
+
 	/* Set parameters */
 	phy_cfg_cmd.phy_cfg = cpu_to_le32(iwl_mvm_get_phy_config(mvm));
 
@@ -1344,12 +1356,12 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		ret = iwl_send_phy_db_data(mvm->phy_db);
 		if (ret)
 			goto error;
-
-		ret = iwl_send_phy_cfg_cmd(mvm);
-		if (ret)
-			goto error;
 	}
 
+	ret = iwl_send_phy_cfg_cmd(mvm);
+	if (ret)
+		goto error;
+
 	ret = iwl_mvm_send_bt_init_conf(mvm);
 	if (ret)
 		goto error;


