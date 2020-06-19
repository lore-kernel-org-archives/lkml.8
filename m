Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5272520809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582294;
	bh=fD1Mv3OSJzmSUoaS2M1EiI+nfFsRVHr4ttthDic856o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UaA3im8P77epBL4pvXuIeUR0WaBHT2TcmbNYrO1KUcZOtesmKnnWWKOuSPbnVVV9a
	 FtHs+EZwAH4rrBl7pC8uBv6mvJp082kC2qQFobrWFU+AHBgekdnNBofvBjTE3BYO5Q
	 8yyakmf+63LH7h2n3/oy3iF7/EhQcqstWkSHDIVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393050AbgFSP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404222AbgFSPTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:19:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3432158C;
        Fri, 19 Jun 2020 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579982;
        bh=fD1Mv3OSJzmSUoaS2M1EiI+nfFsRVHr4ttthDic856o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTdKGaqnJg8uVpBEieAYn7SEsI7KKXNpACVporeKaK0tznFl4+kW+cA2LEArdiMhe
         DQdvhLjqoGNHhJHTqAWZYLlXUQLt4s+XTOSaxjqGmtX7n9YDLDCWQxkqH6aaMHXiSo
         yI8NEfDSpj/wGZ8Ilo3jCIehvcUkihobhQR3mTWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 076/376] ice: fix PCI device serial number to be lowercase values
Date:   Fri, 19 Jun 2020 16:29:54 +0200
Message-Id: <20200619141713.952419806@linuxfoundation.org>
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



