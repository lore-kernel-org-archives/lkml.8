Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A1C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C30F20789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623504;
	bh=jetwA1u3uGfwY/G0enG3r4Nr4bil0aUXmabtHYmGvfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cMxzi6IJuM8VC+knn7Mpg+sDtCpL5tTzM0cV2ZATR/dAGG+lkair3/fj85fxij26K
	 y5ZptxP+NWHnQqtt5wy2RQNUiQ8yRd1q72ceGyxTyKttAgfT5KuBj8iHhwLjHsptV2
	 D8n12NkYWCKPOdo7CezTWaDiHn21NU55H7vzhkDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgCSNLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgCSNLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:11:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E92320722;
        Thu, 19 Mar 2020 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623497;
        bh=jetwA1u3uGfwY/G0enG3r4Nr4bil0aUXmabtHYmGvfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIq477Wp19hr/nVsyD/BO8QaERTkHGXrZQI4csBcDQvXIEgAqvRq1w6oH+sUfHbHT
         EH8uCmNjAdh19vehGx+L8Gp0kICBlAvT+OBEAvp+PKDY2btz4rdL5mnpZCBGfQRhCf
         eAcbxB/7xByyons1IsLpYXUjlsLgLNNdOqrx1htw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.9 47/90] iommu/vt-d: Fix the wrong printing in RHSA parsing
Date:   Thu, 19 Mar 2020 14:00:09 +0100
Message-Id: <20200319123943.075353407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

commit b0bb0c22c4db623f2e7b1a471596fbf1c22c6dc5 upstream.

When base address in RHSA structure doesn't match base address in
each DRHD structure, the base address in last DRHD is printed out.

This doesn't make sense when there are multiple DRHD units, fix it
by printing the buggy RHSA's base address.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Fixes: fd0c8894893cb ("intel-iommu: Set a more specific taint flag for invalid BIOS DMAR tables")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/dmar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -485,7 +485,7 @@ static int dmar_parse_one_rhsa(struct ac
 	pr_warn(FW_BUG
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		drhd->reg_base_addr,
+		rhsa->base_address,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));


