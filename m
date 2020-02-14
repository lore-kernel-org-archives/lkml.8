Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB19C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DE72468F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696630;
	bh=ZODufpkoPxhKGDUVFpS1KtfdoQy0axXfQ6zc5KDAAWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZQSxm5lXIKXadxP5PbHNXymsq5G0zVcbSa1uy1ZaU0tlb1c9VgiFF/RM7KFaSkMu
	 5piin6+c5AyA/6we1nFADDE96QYE9JTxz77sWUGt1d+ITXueZ2MDahR4VKDPMSTOoA
	 0EbX1AYq9jZCSaLMYgX/6DjHVJ4lfUAu7ycw2rzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbgBNQKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391374AbgBNQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C5124685;
        Fri, 14 Feb 2020 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696597;
        bh=ZODufpkoPxhKGDUVFpS1KtfdoQy0axXfQ6zc5KDAAWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1txZ7PlntZlQNl3ADMyNiu+MrAS8R0j4Wiu9fJkYp9rYjKAPXaTgbXm/HQEeXmBfh
         qUBDuFrL1rTp/K1hzjK34UeaF9AR6tNAWYrTYxLvNAw3pw+5TYHAPgMVti2eS+M0/7
         Uprv+uJFlEECX4Saku512Z4qA5/t2+arGwVxT1/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 383/459] powerpc/sriov: Remove VF eeh_dev state when disabling SR-IOV
Date:   Fri, 14 Feb 2020 11:00:33 -0500
Message-Id: <20200214160149.11681-383-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
index 9524009ca1ae4..d876eda926094 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -244,9 +244,22 @@ void remove_dev_pci_data(struct pci_dev *pdev)
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

