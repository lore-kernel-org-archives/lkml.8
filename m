Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8733CC3F34A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5737A24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811902;
	bh=jU20o2m4/MwMjTdHW/S1FdBDfn3HPFyKqG/AycpqT0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ADkuy53qj8105il7lWAdRGAhU1hZ+Iu5ty4likyvePcg1mtBLc5wKrkkOuOJn8QAL
	 09MUgXIIFwC8m4BFKzjMjww/qdmyu4/HmVbX8bgCaQPxnb7ZNJCNzyGrJwCPuKrkqX
	 2qLPV/3ydUVx9+sIn1G4hFjU7dbqJ1+/rx9LJlyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgB0N6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732433AbgB0N6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:58:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006D82073D;
        Thu, 27 Feb 2020 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811896;
        bh=jU20o2m4/MwMjTdHW/S1FdBDfn3HPFyKqG/AycpqT0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkhWjZavuBUVCd/l5PYHYuJ0slln6LqtKNDmTQUi9rj3jD1Sua8uoMWnDHrjzXSUO
         8gETURxecLiMQtiu1DABpytCMDmMwzWTqp9/b9vJzV1EWHcFnxNLmbgkJF7QtXVe4U
         64h0UCWrW9AJXe8Ees0A5HtEhhM4OyHTiEfp4x8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 142/237] powerpc/sriov: Remove VF eeh_dev state when disabling SR-IOV
Date:   Thu, 27 Feb 2020 14:35:56 +0100
Message-Id: <20200227132307.099078303@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0e395afbf0f49..0e45a446a8c78 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -261,9 +261,22 @@ void remove_dev_pci_data(struct pci_dev *pdev)
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



