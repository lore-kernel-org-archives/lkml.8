Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85053C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9B120760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664567;
	bh=fD1Mv3OSJzmSUoaS2M1EiI+nfFsRVHr4ttthDic856o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcygALO2iZE+WHeQgIjFHUj+1lb5kYxPUa3TEZgy7q0adTEYUJDojl25g7an2m9sN
	 rP2me+C/P0YgW08GtxElNJaz7U66CpUDsXXt5+nGLZpiPDFOsQD93LEWLKO7O/aiXq
	 MJ4wNAWGNO5DOu1f2BoNrN/+L08PPQvl2TgWkA3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgFIBCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgFHXHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B40D2089D;
        Mon,  8 Jun 2020 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657672;
        bh=fD1Mv3OSJzmSUoaS2M1EiI+nfFsRVHr4ttthDic856o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLcLmBS7FoL2qRPOE2hgzCre7I7T+KsLeat8v5PtKod9Z/buhtfotseDmmm/c30F0
         YPtCBtvbLqFp/65XL8JfJyOPMmxCHkcjvaw8l7F/KFScY958AvQ1229gYgSodMtj6d
         iYFBEGykAfkAXyC/6NwBJ+XWIf9eb8g24a+KmYrs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 081/274] ice: fix PCI device serial number to be lowercase values
Date:   Mon,  8 Jun 2020 19:02:54 -0400
Message-Id: <20200608230607.3361041-81-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

[ Upstream commit 1a9c561aa35534a03c0aa51c7fb1485731202a7c ]

Commit ceb2f00707f9 ("ice: Use pci_get_dsn()") changed the code to
use a new function to get the Device Serial Number. It also changed
the case of the filename for loading a package on a specific NIC
from lowercase to uppercase. Change the filename back to
lowercase since that is what we specified.

Fixes: ceb2f00707f9 ("ice: Use pci_get_dsn()")
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 599dab844034..545817dbff67 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3126,7 +3126,7 @@ static char *ice_get_opt_fw_name(struct ice_pf *pf)
 	if (!opt_fw_filename)
 		return NULL;
 
-	snprintf(opt_fw_filename, NAME_MAX, "%sice-%016llX.pkg",
+	snprintf(opt_fw_filename, NAME_MAX, "%sice-%016llx.pkg",
 		 ICE_DDP_PKG_PATH, dsn);
 
 	return opt_fw_filename;
-- 
2.25.1

