Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED44221556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581147;
	bh=ZOBjPwNTxWrUqyukv0mLvrQ62a6ylels/hEl/abfOe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CkGNJ3emTnEI/7/0AW/y3gFiIfDdkO3zfatXkrWBMoD8mG0T0Ce8F700gC1g6zbQc
	 IsUf91qiXuR3XUQ4fFZrbykmdXO5hIY5Fb/GcnYFLkIY5pHkBxJI2F1US7zkxaq5LR
	 5CKtURFQrqgv3DCY2ZWcHe1H1p3v7exmvti28tiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404616AbgFSP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404585AbgFSP2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:28:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BE521919;
        Fri, 19 Jun 2020 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580526;
        bh=ZOBjPwNTxWrUqyukv0mLvrQ62a6ylels/hEl/abfOe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhS7Ex0SRQKtgw97IzQ6Np/X6MVcnf/PQs2POz7MeV8lGz1u3KeNK8Tf+yDkZi2b3
         NBDMhQOmQ8Bh++IHPr8yiTRem7Z79CFLh666Xri1xBvXb59btsmcSiD09MrCAmTtjx
         wZJJ2XU7eUTwd669RzERbTsB8HcJFDn13LjWY3j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 243/376] ice: Fix inability to set channels when down
Date:   Fri, 19 Jun 2020 16:32:41 +0200
Message-Id: <20200619141721.832581252@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 765dd7a1827c687b782e6ab3dd6daf4d13a4780f ]

Currently the driver prevents a user from doing
modprobe ice
ethtool -L eth0 combined 5
ip link set eth0 up

The ethtool command fails, because the driver is checking to see if the
interface is down before allowing the get_channels to proceed (even for
a set_channels).

Remove this check and allow the user to configure the interface
before bringing it up, which is a much better usability case.

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 593fb37bd59e..153e3565e313 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3171,10 +3171,6 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 
-	/* check to see if VSI is active */
-	if (test_bit(__ICE_DOWN, vsi->state))
-		return;
-
 	/* report maximum channels */
 	ch->max_rx = ice_get_max_rxq(pf);
 	ch->max_tx = ice_get_max_txq(pf);
-- 
2.25.1



