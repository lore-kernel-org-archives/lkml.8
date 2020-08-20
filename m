Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38725C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1769F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917143;
	bh=T3vwGfkMUgsMdzkPpv+Mexi/XfKogYpoMKDy4MDYn7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IDrojk/00gRX2Fhvcw0ii4zj9Mzk4xd39AYV6XrtvftI5gu6JrIu4iKafLjLztxdC
	 sz7XpWQ5DYHhFdsD/8auqYmGVlPBqlGcg6I37jqbiFdLL2NPYPuKEPKOBLr9MGo0Bp
	 LJABEA8PHJEesiTvgEgCyhRrshndp/s0sk9e3dq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgHTJwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgHTJwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:52:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F072067C;
        Thu, 20 Aug 2020 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917125;
        bh=T3vwGfkMUgsMdzkPpv+Mexi/XfKogYpoMKDy4MDYn7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh4aG40029kQmI1OHr1s+oN0d2fz2Z+JXPq2BFtRJdvSeXQeAMVeMS8sv3A761e83
         Q643rgGHzINCAROBGoB1zqzZNlcQ9MTmDUYbWyohtHcIUyO9PEs7u2Lf8G+flSm/fP
         lxkFBdyunXg4yY/w6EMOu+wT+wuEKnIF5yWOyfIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 04/92] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
Date:   Thu, 20 Aug 2020 11:20:49 +0200
Message-Id: <20200820091537.719791072@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 45beb31d3afb651bb5c41897e46bd4fa9980c51c upstream.

We are seeing AMD Radeon Pro W5700 doesn't work when IOMMU is enabled:

  iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
  iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01c0]

The error also makes graphics driver fail to probe the device.

It appears to be the same issue as commit 5e89cd303e3a ("PCI: Mark AMD
Navi14 GPU rev 0xc5 ATS as broken") addresses, and indeed the same ATS
quirk can workaround the issue.

See-also: 5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208725
Link: https://lore.kernel.org/r/20200728104554.28927-1-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5068,7 +5068,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
  */
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	if (pdev->device == 0x7340 && pdev->revision != 0xc5)
+	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
+	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
 		return;
 
 	pci_info(pdev, "disabling ATS\n");
@@ -5079,6 +5080,8 @@ static void quirk_amd_harvest_no_ats(str
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+/* AMD Navi10 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */


