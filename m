Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1513C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EF320736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443422;
	bh=DXjRntfM0yrOlD0ZVfpicGkExS7X0UTEbsHxUNOlysU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RNbpgtFZxbzaWke4iZe2jYoqho/53tV17fZ4iYmi+hqx5YCSLiW2F7YJ1ushygSFm
	 Xps2ipjAYVcn7mfhICay4HUyomp9ewmvvyrGuWL3oTQz7Wdy0TteNMmU6md8bBaeVy
	 9SUzev9/1YKEUuuJIIzW7W0z35UQoSdjsRJ5wlQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgCQLKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgCQLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D4220658;
        Tue, 17 Mar 2020 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443417;
        bh=DXjRntfM0yrOlD0ZVfpicGkExS7X0UTEbsHxUNOlysU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoRm1QPWUxz04m0womfovrnkD+4ihnqYonXgAyZRiBkPU/TpSqVHarf7pQ5w4yFkS
         LUYB3Mb5XzMFAZ8nCt9cqSWUZsSvKr/a13K5mEzv18QNf+8y9NIfJG+A9fMnnofjCY
         9PKc4oQ1lACuMXLkt155l0VjDji0Ex22heRvGsUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Moulding <dmoulding@me.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 076/151] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
Date:   Tue, 17 Mar 2020 11:54:46 +0100
Message-Id: <20200317103331.884254585@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
@@ -308,7 +308,8 @@ iwl_parse_nvm_sections(struct iwl_mvm *m
 		}
 
 		/* PHY_SKU section is mandatory in B0 */
-		if (!mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
+		if (mvm->trans->cfg->nvm_type == IWL_NVM_EXT &&
+		    !mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
 			IWL_ERR(mvm,
 				"Can't parse phy_sku in B0, empty sections\n");
 			return NULL;


