Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8079020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577411;
	bh=StM8Mz4zDrwZucJ3FbQLllhtm41L09CDt96wvqoY6KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dO1oyYTUeJkvzqBMq7rK1j+CAW2zSxwj9WaW3GQ5DpsK0PsFkxwAcSeS1n5IEd5Pp
	 SBuDdNQmLrKQlwSpZ4LfcbgR0NDHOkaTRoN/NDG5BjfCZ5BRV1+2xKKZK+ZOOM6Rhh
	 lQ/0Lz3CcMwZNsK1AtVfoEpJqR9U/VA3Mh+eQ5Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbgFSOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgFSOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3209F2158C;
        Fri, 19 Jun 2020 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577397;
        bh=StM8Mz4zDrwZucJ3FbQLllhtm41L09CDt96wvqoY6KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zF9CftVlLVOdafO3/It4tqYoSRhAjaN/nX/F3T8Kd/s85chn72JiPL6fliIxjXFnr
         rywyECMdovSGcJJ7pS4V3P/4+R2kONW5tP9uZFKkDmXfPhsR+uwhJRg43XpSZgND1y
         Uv0GLq9YXD3Q601ZqQ+xJLzJK0Yb6KxOpUxMHup8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Alexander Duyck <aduyck@mirantis.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jeff Chase <jnchase@google.com>
Subject: [PATCH 4.4 006/101] igb: improve handling of disconnected adapters
Date:   Fri, 19 Jun 2020 16:31:55 +0200
Message-Id: <20200619141614.342127109@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>

commit 7b06a6909555ffb0140733cc4420222604140b27 upstream.

Clean up array_rd32 so that it uses igb_rd32 the same as rd32, per the
suggestion of Alexander Duyck, and use io_addr in more places, so that
we don't have the need to call E1000_REMOVED (which simply looks for a
null hw_addr) nearly as much.

Signed-off-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Alexander Duyck <aduyck@mirantis.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Jeff Chase <jnchase@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/igb/e1000_regs.h |    3 +--
 drivers/net/ethernet/intel/igb/igb_main.c   |    5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/intel/igb/e1000_regs.h
+++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
@@ -386,8 +386,7 @@ do { \
 #define array_wr32(reg, offset, value) \
 	wr32((reg) + ((offset) << 2), (value))
 
-#define array_rd32(reg, offset) \
-	(readl(hw->hw_addr + reg + ((offset) << 2)))
+#define array_rd32(reg, offset) (igb_rd32(hw, reg + ((offset) << 2)))
 
 /* DMA Coalescing registers */
 #define E1000_PCIEMISC	0x05BB8 /* PCIE misc config register */
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -946,7 +946,6 @@ static void igb_configure_msix(struct ig
 static int igb_request_msix(struct igb_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct e1000_hw *hw = &adapter->hw;
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,
@@ -959,7 +958,7 @@ static int igb_request_msix(struct igb_a
 
 		vector++;
 
-		q_vector->itr_register = hw->hw_addr + E1000_EITR(vector);
+		q_vector->itr_register = adapter->io_addr + E1000_EITR(vector);
 
 		if (q_vector->rx.ring && q_vector->tx.ring)
 			sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
@@ -1230,7 +1229,7 @@ static int igb_alloc_q_vector(struct igb
 	q_vector->tx.work_limit = adapter->tx_work_limit;
 
 	/* initialize ITR configuration */
-	q_vector->itr_register = adapter->hw.hw_addr + E1000_EITR(0);
+	q_vector->itr_register = adapter->io_addr + E1000_EITR(0);
 	q_vector->itr_val = IGB_START_ITR;
 
 	/* initialize pointer to rings */


