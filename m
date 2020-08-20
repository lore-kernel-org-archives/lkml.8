Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52636C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDC320724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916155;
	bh=61l/JMXtp6cMAV+NVOTPh+tXEErxNGyAOehCesszQOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=psXSvZBbf4PYxtvtozSK25kWqflBVEKlKtxhTg+sXIN6ucuI/+H9zzoIWFL4Xkodq
	 8Pw4KZQJq1xH7eL1Q03Qo3LDeotrJWl5UMc+ie0WnjJNHEaHXrvf4ec8szuUawB5yu
	 QGFIocMPf5JrNpEW6+tTKz1+yx56REKvWYOVHJl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHTJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgHTJft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:35:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444322173E;
        Thu, 20 Aug 2020 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916148;
        bh=61l/JMXtp6cMAV+NVOTPh+tXEErxNGyAOehCesszQOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0F7mZAkIPtywnT1b5PhXm2r8J2NFHGu+pFFKpGVlubJ+XUVqAz3nYTFxdaZJSZdiJ
         gTM/xGzziK8ZswcgUBE5GnNRRQLkl2HB3cxXOnYxteTPXjn6OsRbuEJhtUJQtVx3X4
         k/cgKEzAYkPn1ToMA4Qb3D2HMxcXjzs8b7XKATeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.7 005/204] PCI/ATS: Add pci_pri_supported() to check device or associated PF
Date:   Thu, 20 Aug 2020 11:18:22 +0200
Message-Id: <20200820091606.469344265@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

commit 3f9a7a13fe4cb6e119e4e4745fbf975d30bfac9b upstream.

For SR-IOV, the PF PRI is shared between the PF and any associated VFs, and
the PRI Capability is allowed for PFs but not for VFs.  Searching for the
PRI Capability on a VF always fails, even if its associated PF supports
PRI.

Add pci_pri_supported() to check whether device or its associated PF
supports PRI.

[bhelgaas: commit log, avoid "!!"]
Fixes: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS")
Link: https://lore.kernel.org/r/1595543849-19692-1-git-send-email-ashok.raj@intel.com
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Cc: stable@vger.kernel.org	# v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    2 +-
 drivers/pci/ats.c           |   15 +++++++++++++++
 include/linux/pci-ats.h     |    4 ++++
 3 files changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2645,7 +2645,7 @@ static struct dmar_domain *dmar_insert_o
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
+			    pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -309,6 +309,21 @@ int pci_prg_resp_pasid_required(struct p
 
 	return pdev->pasid_required;
 }
+
+/**
+ * pci_pri_supported - Check if PRI is supported.
+ * @pdev: PCI device structure
+ *
+ * Returns true if PRI capability is present, false otherwise.
+ */
+bool pci_pri_supported(struct pci_dev *pdev)
+{
+	/* VFs share the PF PRI */
+	if (pci_physfn(pdev)->pri_cap)
+		return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_pri_supported);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -25,6 +25,10 @@ int pci_enable_pri(struct pci_dev *pdev,
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+bool pci_pri_supported(struct pci_dev *pdev);
+#else
+static inline bool pci_pri_supported(struct pci_dev *pdev)
+{ return false; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID


