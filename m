Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14632C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D651C21569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859034;
	bh=Bdr8LkOCOOwN/OjX7FmAJU2t/jbIWi4QoRtWhV4xW0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Po+qZffLFCLeNLvWkzpnr+IoLIXpT0Wms8vKvvbZl/cCDZqhP/i1NnKvaTmh3ty4z
	 b5nKEMHc0tKiJCLCZ7Y20jOYh7vJFxhcyLMBImxctxtn8ct0HtEMyb+r9wxF2Ucx9r
	 8SCT+H6XOqRYZjuykUU8mOnQ7dsnGjUjPQKGqQh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgAXJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733013AbgAXJnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:43:50 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E272721556;
        Fri, 24 Jan 2020 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859029;
        bh=Bdr8LkOCOOwN/OjX7FmAJU2t/jbIWi4QoRtWhV4xW0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+AAjhWpCAp3oQ7tqYhY+fLdIvoYn43fVfP0nglH/DfxIqZWwMTd49c65+9fgGmdo
         Y9CcLfz4uX2nzHXmEetdYZO9bnTHeoO5FWGBeacr3Dtgfftq6B/RVoqEhvfkLE3jZ0
         HgadmxrNsx7AOIZ9BieFiMCdTGJbMr4nYqu6AMDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/343] PCI: iproc: Remove PAXC slot check to allow VF support
Date:   Fri, 24 Jan 2020 10:27:10 +0100
Message-Id: <20200124092921.247494555@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>

[ Upstream commit 4da6b4480766e5bc9c4d7bc14bf1d0939a1a5fa7 ]

Fix previous incorrect logic that limits PAXC slot number to zero only.
In order for SRIOV/VF to work, we need to allow the slot number to be
greater than zero.

Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pcie-iproc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index c0ecc9f35667f..8f8dac0155d63 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -573,14 +573,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 			return (pcie->base + offset);
 	}
 
-	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
-	 */
-	if (pcie->ep_is_internal)
-		if (slot > 0)
-			return NULL;
-
 	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 }
 
-- 
2.20.1



