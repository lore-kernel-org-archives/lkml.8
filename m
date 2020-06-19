Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F2021556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578297;
	bh=8yoXurofjINO9e19tCh1Lw0j0UROoW+aYWBwamOttjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=soetbBpg7lupLr40oorsKDpxtM5aYDEdLZykAqR+H1uKSlY0x0vAOWO1knUvVOvWo
	 Q0PDy+uKdnTe/j/Kfh1LedY/j4dqhflQ9F5337gaqmKnted0pyni95NrH8L1DAj+Hl
	 8JMGvH6iTpPUPXg/5eJW/J8MpRLObvbBPv+Nl2Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbgFSOve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389402AbgFSOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:51:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8BD21852;
        Fri, 19 Jun 2020 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578277;
        bh=8yoXurofjINO9e19tCh1Lw0j0UROoW+aYWBwamOttjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Gdi4sw/qvEckvhyC3vxDr9OSQFCFRB6A2vmiae0JLTynjPLAjrnjKBjt2xNHGCaz
         Zqw77kJB3PjfUsoKoJomuHE1vD4ZCDW10H6TzyCNeVIefZdW2Csuy/nObxw+QGSoGb
         zE5wM/Z6R2o/v22M1BsfNlrWsEGkCk3N/vZBredg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 151/190] PCI: Add ACS quirk for iProc PAXB
Date:   Fri, 19 Jun 2020 16:33:16 +0200
Message-Id: <20200619141641.275161672@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Ratna <abhinav.ratna@broadcom.com>

[ Upstream commit 46b2c32df7a462d0e64b68c513e5c4c1b2a399a7 ]

iProc PAXB Root Ports don't advertise an ACS capability, but they do not
allow peer-to-peer transactions between Root Ports.  Add an ACS quirk so
each Root Port can be in a separate IOMMU group.

[bhelgaas: commit log, comment, use common implementation style]
Link: https://lore.kernel.org/r/1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com
Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1bc7d4bcfea4..f6e88d5b1c4f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4515,6 +4515,19 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	return acs_flags ? 0 : 1;
 }
 
+static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * iProc PAXB Root Ports don't advertise an ACS capability, but
+	 * they do not allow peer-to-peer transactions between Root Ports.
+	 * Allow each Root Port to be in a separate IOMMU group by masking
+	 * SV/RR/CR/UF bits.
+	 */
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+
+	return acs_flags ? 0 : 1;
+}
+
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
@@ -4597,6 +4610,7 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 	/* APM X-Gene */
 	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	{ 0 }
 };
 
-- 
2.25.1



