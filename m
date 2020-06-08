Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D45D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662997;
	bh=khwqOgzIKy4HdyDJxlADdur1zwDQ2QxqGZxNDiHr2Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=shDmcUScCbpor1QYRJrDO+3kMbMjwpn51hi/AStkAGPAudMP2P5NR/IKdZUU9PP66
	 ioKYwZ/5M2lVnV6UOEjnega4mD6b2vEI9JUKGvK+f6jeXyASl40P3EZRQr+PAq5TA0
	 fZnOHPJUqm3q0mGZEHxvHX1RvudrcvRzVHU2qGy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgFHXOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgFHXLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402C72100A;
        Mon,  8 Jun 2020 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657897;
        bh=khwqOgzIKy4HdyDJxlADdur1zwDQ2QxqGZxNDiHr2Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZ7SEphqmAl7WwvXWSQVgN8OxL88Wm7Kutp7nfFP+ItfW4uZEtiQeYUcuUTc3U62h
         nXU2EUFsg71kgoKCbxpAyL2h/KXpyymvrX/I1Bl7Z+S2YquT3ihZ74V5o8kSH1ZVHF
         2mhfy61x7YgvcbVf6yTpXAfUvnBF/PPigqL16FRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 251/274] ice: fix potential double free in probe unrolling
Date:   Mon,  8 Jun 2020 19:05:44 -0400
Message-Id: <20200608230607.3361041-251-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit bc3a024101ca497bea4c69be4054c32a5c349f1d ]

If ice_init_interrupt_scheme fails, ice_probe will jump to clearing up
the interrupts. This can lead to some static analysis tools such as the
compiler sanitizers complaining about double free problems.

Since ice_init_interrupt_scheme already unrolls internally on failure,
there is no need to call ice_clear_interrupt_scheme when it fails. Add
a new unroll label and use that instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 545817dbff67..69e50331e08e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3298,7 +3298,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
 		err = -EIO;
-		goto err_init_interrupt_unroll;
+		goto err_init_vsi_unroll;
 	}
 
 	/* Driver is mostly up */
@@ -3387,6 +3387,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	ice_free_irq_msix_misc(pf);
 err_init_interrupt_unroll:
 	ice_clear_interrupt_scheme(pf);
+err_init_vsi_unroll:
 	devm_kfree(dev, pf->vsi);
 err_init_pf_unroll:
 	ice_deinit_pf(pf);
-- 
2.25.1

