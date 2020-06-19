Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DA9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E7A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580472;
	bh=p8Gls/ngFCUygskBhXNN6w/ZchaZ+PQkKrIpXKkCKEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FYiyn2P2ensiHq6BQqcOuVPELJi3w0AI5NCU/L+gVImeoB4B27/EqalEm5J8BLun6
	 jR0DIN5rIb5gb92EolRsi3LoW3ew7c+oZyhQ3p7YQTzdX4av3jaJiqznjC2y5s/QUM
	 OgQPf/Csxl8uso4WsiiVRm/uz/Kpbjs1io9mHlmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404430AbgFSP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393501AbgFSP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6152921582;
        Fri, 19 Jun 2020 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580400;
        bh=p8Gls/ngFCUygskBhXNN6w/ZchaZ+PQkKrIpXKkCKEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEw/WpkMSSAH3iaR2VMItRG2kKV6SMi/78ktxbYfORs9OGPouDdZ7EkC58E/qph8B
         kCRiW3XuQtDNMa8ZUvb7fk3mc68noMIKjfCBriDGi0YF3J/aXUR9Q8yrW9jZtgjeHJ
         tH4rCB9X7tcBo9ZonUZMx8+fNd8D8e4MqPvfINu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 234/376] ice: fix potential double free in probe unrolling
Date:   Fri, 19 Jun 2020 16:32:32 +0200
Message-Id: <20200619141721.400066073@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -3387,6 +3387,7 @@ err_msix_misc_unroll:
 	ice_free_irq_msix_misc(pf);
 err_init_interrupt_unroll:
 	ice_clear_interrupt_scheme(pf);
+err_init_vsi_unroll:
 	devm_kfree(dev, pf->vsi);
 err_init_pf_unroll:
 	ice_deinit_pf(pf);
-- 
2.25.1



