Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFCC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09FB20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747856;
	bh=Lcno1KbzFHCzHqKn9HtlxRgI1lCVBZUjrWPcoksga+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYz0US7/PYSTrSW7uodd4V9Hsn/LcmcdqnGxJTMp3YEEQD9CD9XwOoFmcaJrZ8agU
	 iXbqPBJa2Fe9HL3d63fPdMN3Zkp4T1Q3ZMPcVqivG0rI0r8cF25dAkOnSEBy6LG8Za
	 cpLzVdjl7H+R2MJoeoO7MTL+Z9OZaAofkTAXDlo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgBCQhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbgBCQhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:20 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448A62087E;
        Mon,  3 Feb 2020 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747839;
        bh=Lcno1KbzFHCzHqKn9HtlxRgI1lCVBZUjrWPcoksga+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui3L4Xog87WyjIneM0bHb4z6BPWG3dc2yC/9sr2TjIAJDNMFWP/kUTs4YqzuPeViN
         pA2tOoXpLbU/wgPqkFVXSmMvKgQxTgiNNjzr51UBXpuAIt24dpIXBOs7xCA+IZn7hv
         lwWsTPdJK5ZA7IkAE8SOqmMIgy2T9YmczBmTJmRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Sperling <stsp@stsp.name>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 61/90] iwlwifi: mvm: fix NVM check for 3168 devices
Date:   Mon,  3 Feb 2020 16:20:04 +0000
Message-Id: <20200203161925.037188062@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit b3f20e098293892388d6a0491d6bbb2efb46fbff ]

We had a check on !NVM_EXT and then a check for NVM_SDP in the else
block of this if.  The else block, obviously, could only be reached if
using NVM_EXT, so it would never be NVM_SDP.

Fix that by checking whether the nvm_type is IWL_NVM instead of
checking for !IWL_NVM_EXT to solve this issue.

Reported-by: Stefan Sperling <stsp@stsp.name>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 945c1ea5cda86..493bcc54a8485 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -281,7 +281,7 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 	int regulatory_type;
 
 	/* Checking for required sections */
-	if (mvm->trans->cfg->nvm_type != IWL_NVM_EXT) {
+	if (mvm->trans->cfg->nvm_type == IWL_NVM) {
 		if (!mvm->nvm_sections[NVM_SECTION_TYPE_SW].data ||
 		    !mvm->nvm_sections[mvm->cfg->nvm_hw_section_num].data) {
 			IWL_ERR(mvm, "Can't parse empty OTP/NVM sections\n");
-- 
2.20.1



