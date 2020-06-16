Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E067C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5119C208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322710;
	bh=HpNJ3q8VhMPUwZr5wg2XHd0tXHo7Vqwt6uIEiQ4MXjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeKqxxhy9Ljo2dWRmRUXcajrmOxR/AqnQfE8+ayds1Xwl7mvJ1XRMqPULMcoCUpPf
	 IluNZOROI7AGzjitRa3oUGGkVkbEHAYSeAJPs+yrs8dtMlJrZfdzwNuPyK7yw/BgAN
	 TK7wZLoLz5IMLugbcc3cSETzpJT/e8CFBnjzRbpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgFPPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732490AbgFPPve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:51:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C970E214DB;
        Tue, 16 Jun 2020 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322694;
        bh=HpNJ3q8VhMPUwZr5wg2XHd0tXHo7Vqwt6uIEiQ4MXjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHfPruonOE3vI+OYSM1uXaAjrXiT4KOlOQlElVcPvjWm0LwD7f5Wcpjdq3uHuFSar
         pW9vj28AiT11HzGTRuvnzU7hG2fAP/QQnVCL9Rf9ir45XGdlSLFFQaqTva/WMgkEY6
         HYWiJnYAb0Df3rvO2cS7DHUHkHVgjrKb52Gg54wM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 037/161] s390/pci: Log new handle in clp_disable_fh()
Date:   Tue, 16 Jun 2020 17:33:47 +0200
Message-Id: <20200616153108.149665067@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <ptesarik@suse.com>

[ Upstream commit e1750a3d9abbea2ece29cac8dc5a6f5bc19c1492 ]

After disabling a function, the original handle is logged instead of
the disabled handle.

Link: https://lkml.kernel.org/r/20200522183922.5253-1-ptesarik@suse.com
Fixes: 17cdec960cf7 ("s390/pci: Recover handle in clp_set_pci_fn()")
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_clp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 0d3d8f170ea4..25208fa95426 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
 
 int clp_disable_fh(struct zpci_dev *zdev)
 {
-	u32 fh = zdev->fh;
 	int rc;
 
 	if (!zdev_enabled(zdev))
 		return 0;
 
 	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
-	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
+	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
 	return rc;
 }
 
-- 
2.25.1



