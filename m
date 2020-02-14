Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14CD206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699735;
	bh=LiJe7Oagm1mNMXF6zMLtUS9MDYRytae+4NbXXsV9DaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDv6+VjrmJo6eHL+MbV6ruwIjgd0jqIcgP0mvHMUtN980j1vRA1QZXa+izfx5Siu/
	 TNDhHybKEY9VHjBmfB8Y1GEPYKcjOUsFlM/uFPLPRzIiG5k6M2QFHiI7JEN/OO3CDD
	 oBWAU8wvqrD69MBCAbVtza9NrLB0pfrSgP2gEbV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394154AbgBNRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404249AbgBNQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C6324670;
        Fri, 14 Feb 2020 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696970;
        bh=LiJe7Oagm1mNMXF6zMLtUS9MDYRytae+4NbXXsV9DaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1d9DP8iSsOBOJRjYk989GwoSdNytMkpU0qNR7FfEnO0zEDu+lbulZKU8+yMkBEqb
         dciFLhNhJ/cblLYdKpfgwknaX0hXol/4ik2Nc6eTMCYpmhD3iuQWS4c66+pz2/1xke
         5Pbh3YJRi9CQWz98kkKIy/HzKICL3rRNLWwg6O7I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 209/252] powerpc/sriov: Remove VF eeh_dev state when disabling SR-IOV
Date:   Fri, 14 Feb 2020 11:11:04 -0500
Message-Id: <20200214161147.15842-209-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver O'Halloran <oohall@gmail.com>

[ Upstream commit 1fb4124ca9d456656a324f1ee29b7bf942f59ac8 ]

When disabling virtual functions on an SR-IOV adapter we currently do not
correctly remove the EEH state for the now-dead virtual functions. When
removing the pci_dn that was created for the VF when SR-IOV was enabled
we free the corresponding eeh_dev without removing it from the child device
list of the eeh_pe that contained it. This can result in crashes due to the
use-after-free.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>
Tested-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190821062655.19735-1-oohall@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/pci_dn.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index ab147a1909c8b..7cecc3bd953b7 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -257,9 +257,22 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 				continue;
 
 #ifdef CONFIG_EEH
-			/* Release EEH device for the VF */
+			/*
+			 * Release EEH state for this VF. The PCI core
+			 * has already torn down the pci_dev for this VF, but
+			 * we're responsible to removing the eeh_dev since it
+			 * has the same lifetime as the pci_dn that spawned it.
+			 */
 			edev = pdn_to_eeh_dev(pdn);
 			if (edev) {
+				/*
+				 * We allocate pci_dn's for the totalvfs count,
+				 * but only only the vfs that were activated
+				 * have a configured PE.
+				 */
+				if (edev->pe)
+					eeh_rmv_from_parent_pe(edev);
+
 				pdn->edev = NULL;
 				kfree(edev);
 			}
-- 
2.20.1

