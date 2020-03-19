Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC2C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03E9206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623848;
	bh=+d8ajJzWO100hATUUE+6j7BLWE9UwVheTuluFvGV3IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2sARiBdPrYNGNEQbKhmArSO8c+hMuoagBpEF+r4/2Pg5/gbx/s6WbaZsAF0HnVSD
	 PEgGkZIiV1n8yij2Sxa2mWkYmx99MNCsyVPbgyKkE/fRJMpkBJuOSKR0zaA+TuqE1P
	 ZqKzs3Wmtkb73lrOv7ev+cOxo8llMwA5ivnU3p9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgCSNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbgCSNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:17:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DDDB21775;
        Thu, 19 Mar 2020 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623838;
        bh=+d8ajJzWO100hATUUE+6j7BLWE9UwVheTuluFvGV3IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ/4QnebPSIxX53wNWnAybJUwiC897iCRWc+rWQiA5ytcDfNnHkD0k5cG5lokqP4o
         BZos7ivQGWyRnNc0J6uQp/zeX02Wh063VuVPFJ6KIRA0k62F4zKzWzlnow+a2FrvUJ
         OVg54x4TcFBqj7AARfLIOb+/sfaz+Txnusi0WYDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Moulding <dmoulding@me.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 39/99] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
Date:   Thu, 19 Mar 2020 14:03:17 +0100
Message-Id: <20200319123953.604920974@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Moulding <dmoulding@me.com>

commit a9149d243f259ad8f02b1e23dfe8ba06128f15e1 upstream.

The logic for checking required NVM sections was recently fixed in
commit b3f20e098293 ("iwlwifi: mvm: fix NVM check for 3168
devices"). However, with that fixed the else is now taken for 3168
devices and within the else clause there is a mandatory check for the
PHY_SKU section. This causes the parsing to fail for 3168 devices.

The PHY_SKU section is really only mandatory for the IWL_NVM_EXT
layout (the phy_sku parameter of iwl_parse_nvm_data is only used when
the NVM type is IWL_NVM_EXT). So this changes the PHY_SKU section
check so that it's only mandatory for IWL_NVM_EXT.

Fixes: b3f20e098293 ("iwlwifi: mvm: fix NVM check for 3168 devices")
Signed-off-by: Dan Moulding <dmoulding@me.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -326,7 +326,8 @@ iwl_parse_nvm_sections(struct iwl_mvm *m
 		}
 
 		/* PHY_SKU section is mandatory in B0 */
-		if (!mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
+		if (mvm->trans->cfg->nvm_type == IWL_NVM_EXT &&
+		    !mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
 			IWL_ERR(mvm,
 				"Can't parse phy_sku in B0, empty sections\n");
 			return NULL;


