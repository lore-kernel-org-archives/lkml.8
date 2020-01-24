Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86038208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864690;
	bh=vqlUTF29PNCkBlV6NrwNudwhu47jBkRrhaDjag+RlZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tTtZ8EicECbNFWHOrRGpSfTrRTJHsFMvPohkLY4UK4Y3skWaMNDRbx7a01FQAGdsu
	 E9mT3JpWtaZ+I4YOJHihN6T7nRP9eUEzrcqlEza+R4aQ9gqweXWquTsG/gc4KPd5iO
	 fdUMas17r7yee58/9jYT8panugwWzhixHPS3ONv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390602AbgAXLSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390588AbgAXLSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:18:03 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E38F20708;
        Fri, 24 Jan 2020 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864683;
        bh=vqlUTF29PNCkBlV6NrwNudwhu47jBkRrhaDjag+RlZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiZGylgmEGW5dHH/H8t1RBtJqlzTjR+8HfOYBeKvAKXG3u3EZAJL/J7lD03W9HA1k
         x21V6IpxQF9HKGiKvruCb1HEH/2U8MYh430tFnRbfzCsgx+HQvmd8VmtxBmdLHET52
         K+GJKF78UaOw8Z1gmcrXwLkdfDK31QgBZK/tEesY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <ray.jui@broadcom.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 336/639] PCI: iproc: Enable iProc config read for PAXBv2
Date:   Fri, 24 Jan 2020 10:28:26 +0100
Message-Id: <20200124093129.204094515@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

[ Upstream commit 8cff995405eb0b563e7a0d2c49838611ea3f2692 ]

iProc config read flag has to be enabled for PAXBv2 instead of PAXB.

Fixes: f78e60a29d4f ("PCI: iproc: Reject unconfigured physical functions from PAXC")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6bd68fd8..9d5cbc75d5ae0 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1347,7 +1347,6 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB:
 		regs = iproc_pcie_reg_paxb;
-		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_ob_map;
@@ -1356,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB_V2:
 		regs = iproc_pcie_reg_paxb_v2;
+		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_v2_ob_map;
-- 
2.20.1



