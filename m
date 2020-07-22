Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3180DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012E3208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595443998;
	bh=f8L1/mWk1WxKSeB8IoWJ9p9hZ6uj4JQNstTzmlRy1F4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vrdCC8KshavZf9KPZE+Df/qoeo+GxIQDmSJOTZBRpxDTe4FMhW/WTqxeFHAoKxOSw
	 A5wtsou5Ao0+mHWlDYTkRZhK+cOc2NDEISV0qNLKp2nl4lbT2YehR2EweFUUqMXhpC
	 aVz/nSAwdUeCJSf86xt8Gdkg54gT/9PEGR5sh1F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgGVSxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgGVSxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:53:15 -0400
Received: from embeddedor (unknown [200.39.29.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0018A207E8;
        Wed, 22 Jul 2020 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595443995;
        bh=f8L1/mWk1WxKSeB8IoWJ9p9hZ6uj4JQNstTzmlRy1F4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZMJLGObp80o7pPgKnfWFkKyW2KzENFNfm63e0wL9cCU+MqXE9pt1OlKZd4bRytXMo
         tWWNWe5I09MuQ1dOuk2JhzjFPfi9D06qKS9h6gHkIX8HBii2rva3Cedi5STQbaFl4V
         y2/uHqeOd3AYbq0eZu755l3gXsWf1S+INmZfbcHc=
Date:   Wed, 22 Jul 2020 13:58:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] net: qed_hsi.h: Avoid the use of one-element array
Message-ID: <20200722185852.GA16220@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type '__le32 reserved1'[2], once it seems
this is just a placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/qed_hsi-20200718.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index 1af3f65ab862..559df9f4d656 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -361,7 +361,7 @@ struct core_tx_update_ramrod_data {
 	u8 update_qm_pq_id_flg;
 	u8 reserved0;
 	__le16 qm_pq_id;
-	__le32 reserved1[1];
+	__le32 reserved1;
 };
 
 /* Enum flag for what type of dcb data to update */
-- 
2.27.0

