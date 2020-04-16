Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39088C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076842223E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043922;
	bh=8g4rtJKK7f7hAR4yH8/t0x0WZTPgRBWJXq9lOexgqK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lurdZb4T2hz3gUfisu11Tvv7gvkUhl1H6YJUL1xCNWM1S8agKGNxSbehdIS0evUwR
	 6s7/5oPOXuRcqWhVSgXeCOf28Jlc3qaA/2PjaP14vd1azRFr+8XIjEG2MiyrMOUG9K
	 g9NNFHOEd6DLOyITs3XuS9159+btUUIm0FppbQXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896500AbgDPNb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895759AbgDPN21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:28:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D0021D82;
        Thu, 16 Apr 2020 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043705;
        bh=8g4rtJKK7f7hAR4yH8/t0x0WZTPgRBWJXq9lOexgqK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6fNHGj3tKnKdZWYdG0ypjoilqkysCBi6i3oyDKDk/A/rOm09HLjQpFFlhf1qu5BU
         r/P4aiKLefKEk6uHbW7ejNDzch8q8JTuqR+z82YleqqnVG8JunQkkqd5PFNd/jI160
         3sS/BdSGi30DCMTKkszfcAQ+vxnzJ9/fjzFMBncA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 065/146] PCI/ASPM: Clear the correct bits when enabling L1 substates
Date:   Thu, 16 Apr 2020 15:23:26 +0200
Message-Id: <20200416131251.804144228@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

commit 58a3862a10a317a81097ab0c78aecebabb1704f5 upstream.

In pcie_config_aspm_l1ss(), we cleared the wrong bits when enabling ASPM L1
Substates.  Instead of the L1.x enable bits (PCI_L1SS_CTL1_L1SS_MASK, 0xf), we
cleared the Link Activation Interrupt Enable bit (PCI_L1SS_CAP_L1_PM_SS,
0x10).

Clear the L1.x enable bits before writing the new L1.x configuration.

[bhelgaas: changelog]
Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
Link: https://lore.kernel.org/r/1584093227-1292-1-git-send-email-yangyicong@hisilicon.com
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.11+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -747,9 +747,9 @@ static void pcie_config_aspm_l1ss(struct
 
 	/* Enable what we need to enable */
 	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)


