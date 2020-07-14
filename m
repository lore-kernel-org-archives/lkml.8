Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6ECC433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C692084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753530;
	bh=V6Pmu3m83SA+fn0VRBHhHKrR+JTh1Ner59R44FVUyEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VuULmJWpB0fNuikK40fN93qJ4OjCaRz+WZB90cYTxEYpMI5uz3bDaLQtgpEpwDF0T
	 9a+v/HoJgFhPUktz/t2mtHkl/Lj0fW5d5cKkQIUO/eZyIM6pKA1I4K6VNwfCoOdprU
	 dgT1vQUYbAMMGgJCscFTt3gECDsfP8/xwrI5+8Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgGNSyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbgGNSya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8C122BEB;
        Tue, 14 Jul 2020 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752869;
        bh=V6Pmu3m83SA+fn0VRBHhHKrR+JTh1Ner59R44FVUyEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdU7jIUJVFBQj1Nhdl2UVfgF0/7G57Xbptkhznoi2oYu8MZelNwvuol3CoposbZ4n
         dW+1ZnQG3NnvK63tsoc+TluueEEqCCxn4PNIuMY+ojzgF19RItr6UShfIz19ebw8Zn
         SR4HKsZRVdoNpyVXfSYasY+RMEULEvfhfHZp1u5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ciara Loftus <ciara.loftus@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 024/166] ice: protect ring accesses with WRITE_ONCE
Date:   Tue, 14 Jul 2020 20:43:09 +0200
Message-Id: <20200714184117.038430264@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ciara Loftus <ciara.loftus@intel.com>

[ Upstream commit b1d95cc2391ffac0c5b27256a4fb0d2cfb021a29 ]

The READ_ONCE macro is used when reading rings prior to accessing the
statistics pointer. The corresponding WRITE_ONCE usage when allocating and
freeing the rings to ensure protected access was not in place. Introduce
this.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2f256bf45efcf..6dd839b325259 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1063,7 +1063,7 @@ static void ice_vsi_clear_rings(struct ice_vsi *vsi)
 		for (i = 0; i < vsi->alloc_txq; i++) {
 			if (vsi->tx_rings[i]) {
 				kfree_rcu(vsi->tx_rings[i], rcu);
-				vsi->tx_rings[i] = NULL;
+				WRITE_ONCE(vsi->tx_rings[i], NULL);
 			}
 		}
 	}
@@ -1071,7 +1071,7 @@ static void ice_vsi_clear_rings(struct ice_vsi *vsi)
 		for (i = 0; i < vsi->alloc_rxq; i++) {
 			if (vsi->rx_rings[i]) {
 				kfree_rcu(vsi->rx_rings[i], rcu);
-				vsi->rx_rings[i] = NULL;
+				WRITE_ONCE(vsi->rx_rings[i], NULL);
 			}
 		}
 	}
@@ -1104,7 +1104,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->vsi = vsi;
 		ring->dev = dev;
 		ring->count = vsi->num_tx_desc;
-		vsi->tx_rings[i] = ring;
+		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
 	/* Allocate Rx rings */
@@ -1123,7 +1123,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->netdev = vsi->netdev;
 		ring->dev = dev;
 		ring->count = vsi->num_rx_desc;
-		vsi->rx_rings[i] = ring;
+		WRITE_ONCE(vsi->rx_rings[i], ring);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 69e50331e08e9..7fd2ec63f128e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1701,7 +1701,7 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
 		xdp_ring->netdev = NULL;
 		xdp_ring->dev = dev;
 		xdp_ring->count = vsi->num_tx_desc;
-		vsi->xdp_rings[i] = xdp_ring;
+		WRITE_ONCE(vsi->xdp_rings[i], xdp_ring);
 		if (ice_setup_tx_ring(xdp_ring))
 			goto free_xdp_rings;
 		ice_set_ring_xdp(xdp_ring);
-- 
2.25.1



