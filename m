Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44792C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300D20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257627;
	bh=aYvB/CLqNzY0NxikruZq6X2FXZDOhA/dHZFO0339dAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e8SkouHFceBEgpRJtFK99UcBhI3gpI43ShI+zT8N1piHdauv1c4dAkSaDQhFDp0Kj
	 JNay8egGKw5hYyoGP2R78EPMwsIbQrbBKDy5tcTv2OOgouJGGKBxsJ2XNHf4NMO0Nj
	 sh5eJejYUvm/07pQSNJRLKGnbKXP52FCtKeCVNlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgCCRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgCCRrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:47:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACAE20870;
        Tue,  3 Mar 2020 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257622;
        bh=aYvB/CLqNzY0NxikruZq6X2FXZDOhA/dHZFO0339dAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUdk7AP/0SysO5OLXcGJzc4Hz75As0gHRZWkTS8HjVtzg/pvl0q+5/fpWDrWyh8Gk
         EGX918n4J23GV9RnyOU2Q0amih6zDmr/Vic2PCRcMMG17Wy08OiULaksGamc9YhYl6
         W7acaxSQ6Ds8B8Vfp32hlUyIi2LPlfrwSb95XTmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 065/176] ice: Dont allow same value for Rx tail to be written twice
Date:   Tue,  3 Mar 2020 18:42:09 +0100
Message-Id: <20200303174312.166742616@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



