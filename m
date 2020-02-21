Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2468C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84F320801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271471;
	bh=DiMCdG6riLHSRN4nxkcS6mNDd2S8rOcMOtsYxDu6lYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrhXPslwwCxZq1lcmTP5CJrKSuhQLtoLejBKckbqCU3Cw7n5Yn++fM07j3LKpL88j
	 uaEt1Sw0XZCZ1XKV1jcCk5VBMpz9J2PJfKFcnqrUr1r0o7zAHhkZz5IaMeGcqdRJFA
	 FED/Zwit/ArjczcTtNnq4JHaHOxbZasWOKA3ReeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgBUHvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgBUHvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF3F20801;
        Fri, 21 Feb 2020 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271467;
        bh=DiMCdG6riLHSRN4nxkcS6mNDd2S8rOcMOtsYxDu6lYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLvnBQKBZE7sd9dl64FZt2m6uvf2mmNeglNAeFJJ1PXVAXIoBgotgyc/7ZouLLp/J
         4EUWhwMDX9I42nJXq+/dLfj74aEHRMTG2NdWdzULmrFoGsY0HXKWDkGs7Wsn51/SaI
         ntZV0S7dVlKrcEl/PVHN2Y8RAtYxK9NgZtJ9JW3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5.5 177/399] PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()
Date:   Fri, 21 Feb 2020 08:38:22 +0100
Message-Id: <20200221072419.893783395@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@google.com>

[ Upstream commit bb950bca5d522119f8b9ce3f6cbac4841c6d6517 ]

Commit d355bb209783 ("PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()")
unexported a bunch of symbols from the PCI core since the only external
users were non-modular IOMMU drivers. Although most of those symbols
can remain private for now, 'pci_{enable,disable_ats()' is required for
the ARM SMMUv3 driver to build as a module, otherwise we get a build
failure as follows:

  | ERROR: "pci_enable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
  | ERROR: "pci_disable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!

Re-export these two functions so that the ARM SMMUv3 driver can be build
as a module.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
[will: rewrote commit message]
Signed-off-by: Will Deacon <will@kernel.org>
Tested-by: John Garry <john.garry@huawei.com> # smmu v3
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/ats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b6f064c885c37..3ef0bb281e7cc 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -69,6 +69,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	dev->ats_enabled = 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_ats);
 
 /**
  * pci_disable_ats - disable the ATS capability
@@ -87,6 +88,7 @@ void pci_disable_ats(struct pci_dev *dev)
 
 	dev->ats_enabled = 0;
 }
+EXPORT_SYMBOL_GPL(pci_disable_ats);
 
 void pci_restore_ats_state(struct pci_dev *dev)
 {
-- 
2.20.1



