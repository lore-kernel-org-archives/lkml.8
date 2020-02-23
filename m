Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA6BC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DF206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425324;
	bh=aYvB/CLqNzY0NxikruZq6X2FXZDOhA/dHZFO0339dAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d25lvPba73O4bWR4OEw7gRusTZ+fCc3CrsUfDx2D+cUxvTUH521FR1ugI42nQ64/3
	 Pw5gBF4ul482SAVra0TSBI7kbvD+h4CPeaPgCsiyMLgNV1HyVelV88sBK8qkUC5RIv
	 zk6AQxZR5VCdqFUQbjl4fQhV2+Pbfw2hJ4yRrRx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBWCfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgBWCWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:22:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B404A227BF;
        Sun, 23 Feb 2020 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424531;
        bh=aYvB/CLqNzY0NxikruZq6X2FXZDOhA/dHZFO0339dAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3jZp0krimDbF/pG7CR0W5fDvPIjl6r2v2nILqkdFneioYE2XFhm3tvIyHD7nnWSk
         p6m92+S/qiotzHaNvMyh0EyseWVpenZBjjncrqBYJHb+nZuEuzU/WHOKW2jhhU2v90
         vB+eKvdvdl3HrL8vQEuCs+Oq0Uy0XTSoAewS9Dy0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brett Creeley <brett.creeley@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 43/58] ice: Don't allow same value for Rx tail to be written twice
Date:   Sat, 22 Feb 2020 21:21:04 -0500
Message-Id: <20200223022119.707-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit 168983a8e19b89efd175661e53faa6246be363a0 ]

Currently we compare the value we are about to write to the Rx tail
register with the previous value of next_to_use. The problem with this
is we only write tail on 8 descriptor boundaries, but next_to_use is
updated whenever we clean Rx descriptors. Fix this by comparing the
value we are about to write to tail with the previously written tail
value. This will prevent duplicate Rx tail bumps.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 35bbc4ff603cd..6da048a6ca7c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -10,7 +10,7 @@
  */
 void ice_release_rx_desc(struct ice_ring *rx_ring, u32 val)
 {
-	u16 prev_ntu = rx_ring->next_to_use;
+	u16 prev_ntu = rx_ring->next_to_use & ~0x7;
 
 	rx_ring->next_to_use = val;
 
-- 
2.20.1

