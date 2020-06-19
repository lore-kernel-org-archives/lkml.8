Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7430C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DF821531
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592589049;
	bh=T8vXW9nJdb52yqHR3CTrLd1h9Ib40yIUGO2opiHJepc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G5xxmEJut8Xd5ukvprNWWafXXObTKC1An9aoqnitAFYeoW0mzoJi/Q5B1ENctbqiI
	 3V4rp7ZYWSc4vBFiVAG4BigQnm3gLUkRUElX4f535HSryGyCGvOiehlPnBwOOSlh7z
	 KR5Nni7Dn2EY9m0OH9zgRJHfYAPGKDgcaZkdm0ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393053AbgFSRus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgFSRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:50:47 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B375208B8;
        Fri, 19 Jun 2020 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592589047;
        bh=T8vXW9nJdb52yqHR3CTrLd1h9Ib40yIUGO2opiHJepc=;
        h=Date:From:To:Cc:Subject:From;
        b=IJ2NfygmNwR1MttxZgaBImP9g4I2zBT2UyFQpUPw1VQl0M/2PTOimeOUz6G2YocgD
         +QDahI7Elxsqzr8N9uHVCNpHmRioXJbXKex63jOrm9aYmRYyxqhhMs5JFiAVr6ruVy
         kyJW4xoZxOWAhsIeYNZiwDxvucb0loaei1GHg/ZQ=
Date:   Fri, 19 Jun 2020 12:56:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ice: Use struct_size() helper
Message-ID: <20200619175611.GA27719@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 4420fc02f7e7..d92c4d70dbcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1121,8 +1121,7 @@ static enum ice_status ice_get_pkg_info(struct ice_hw *hw)
 	u16 size;
 	u32 i;
 
-	size = sizeof(*pkg_info) + (sizeof(pkg_info->pkg_info[0]) *
-				    (ICE_PKG_CNT - 1));
+	size = struct_size(pkg_info, pkg_info, ICE_PKG_CNT - 1);
 	pkg_info = kzalloc(size, GFP_KERNEL);
 	if (!pkg_info)
 		return ICE_ERR_NO_MEMORY;
-- 
2.27.0

