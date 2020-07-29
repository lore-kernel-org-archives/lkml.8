Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438782074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596003995;
	bh=vkIUhrSXc9r1hVlkGgUCMHbIKL3mi0oUqbt+Vn4a3P0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rGTpsHJt9OA9PMrSg6P1USugBZeMaHyv/ei/IlyP3VBM//Nzk6sY+OxTixi7jlic/
	 oPP5ma4rIEHlEpuTbQbJMIqcu4jFRjkEKMnTlW8qsw/DuhS4la9xXzsIa3hpmAE137
	 OkfEBEH8HJie8B9kVgLc7qGAswx9FPXhb37Sz/kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgG2G0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2G0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:26:33 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3952065E;
        Wed, 29 Jul 2020 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596003993;
        bh=vkIUhrSXc9r1hVlkGgUCMHbIKL3mi0oUqbt+Vn4a3P0=;
        h=From:To:Cc:Subject:Date:From;
        b=l+l1H1rVblgSS73ZaAE2UC/kDo7iAjSnAOHiYXmMKW+eVDY1VDCG67tzGIS4d5baJ
         OyoT6f0IsxM5s6mGsFyWJ9gf8jHWtWBkmd4Oe3IorumVdfK+PHfuyCrsQeJH3IQi1e
         b/43PGTUoHrt24KHg8H5co4oMmRCcl7jlu4h5Rvs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] PCI: Fix kerneldoc of pci_vc_do_save_buffer()
Date:   Wed, 29 Jul 2020 08:26:20 +0200
Message-Id: <20200729062620.4168-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix subject
---
 drivers/pci/vc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5486f8768c86..5fc59ac31145 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -172,7 +172,6 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @save_state: buffer for save/restore
- * @name: for error message
  * @save: if provided a buffer, this indicates what to do with it
  *
  * Walking Virtual Channel config space to size, save, or restore it
-- 
2.17.1

