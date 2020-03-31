Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8647C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645968;
	bh=Mj3QYaMdquQMTJeE6GXk4ab+R6R5s1og9D1PWZ/TTQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+NZZQa48usU2/dfxF4Tl20m1f6LeRBPT8vKoW9P3KdTeyTThVLh+B2VGg/9iTI47
	 XxB0137DM2UPgqkVIN310FDGU6ihokUR4fsFcCY8o6GD3mIrbyGtO36cB/l4Ns9NAM
	 HBAbmdAC2UGO/fQrpC1xQcTECHTDmMIEpNG2Fhc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgCaJMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbgCaJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8573C20675;
        Tue, 31 Mar 2020 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645963;
        bh=Mj3QYaMdquQMTJeE6GXk4ab+R6R5s1og9D1PWZ/TTQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFMAS3T+A/ckbeXL2pM2WWk8YaSAgZnfsgOFZX+L2VsDV7+FzI/C82LhVdKCuTTsJ
         OmCL6mVAkoNNQRXZrBxKpq0L2LN5jPrqV4/8QNjBPUXEXg7ILnuZIqAB+Kz/erp3B0
         I28zQG0KaPwYzS6W1E0nNhSakgnIn4plIKmHBOj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 043/155] bnxt_en: Reset rings if ring reservation fails during open()
Date:   Tue, 31 Mar 2020 10:58:03 +0200
Message-Id: <20200331085423.254926165@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 5d765a5e4bd7c368e564e11402bba74cf7f03ac1 ]

If ring counts are not reset when ring reservation fails,
bnxt_init_dflt_ring_mode() will not be called again to reinitialise
IRQs when open() is called and results in system crash as napi will
also be not initialised. This patch fixes it by resetting the ring
counts.

Fixes: 47558acd56a7 ("bnxt_en: Reserve rings at driver open if none was reserved at probe time.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11603,6 +11603,10 @@ static int bnxt_set_dflt_rings(struct bn
 		bp->rx_nr_rings++;
 		bp->cp_nr_rings++;
 	}
+	if (rc) {
+		bp->tx_nr_rings = 0;
+		bp->rx_nr_rings = 0;
+	}
 	return rc;
 }
 


