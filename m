Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45C2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220831;
	bh=ptTW+YYETIRDhpHCqs0Mh+HK/LL5TuQ7hkeqD5ieABk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5Kq6PaRMXwqeOp9UiRZHQxugnemD5dFuKO0bpgiSbgaa4Rns0/j+V+7jljxrVeKB
	 nEjX2CIsaisivlU5o30eKuWpRQkBzUEYyDqe/S8QRCx+N90lWO3cM0JMOFGFgTzchz
	 Y2T9MxGChtNADfiMv2g+xGRNVxhIjUadCR4pLv/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgA1ONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgA1ONl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:13:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2BA2468A;
        Tue, 28 Jan 2020 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220820;
        bh=ptTW+YYETIRDhpHCqs0Mh+HK/LL5TuQ7hkeqD5ieABk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhJYkkp/1dcwPAaPXfcCS0En8oRLR90woJM1+IVnUNyXikrASoL9gkPKTTQPTIjHH
         Fr3d3PVyVkXTLh4NGVMvoFGee/zCcZdqzyrEQvNB0YmfuoajnQGxYcKSsnp1tndCtO
         hwil5zs2Kp5E6cDbTTC7MwxCRZKtKJkpkUcXRjEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 161/183] firestream: fix memory leaks
Date:   Tue, 28 Jan 2020 15:06:20 +0100
Message-Id: <20200128135845.785116443@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit fa865ba183d61c1ec8cbcab8573159c3b72b89a4 ]

In fs_open(), 'vcc' is allocated through kmalloc() and assigned to
'atm_vcc->dev_data.' In the following execution, if an error occurs, e.g.,
there is no more free channel, an error code EBUSY or ENOMEM will be
returned. However, 'vcc' is not deallocated, leading to memory leaks. Note
that, in normal cases where fs_open() returns 0, 'vcc' will be deallocated
in fs_close(). But, if fs_open() fails, there is no guarantee that
fs_close() will be invoked.

To fix this issue, deallocate 'vcc' before the error code is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/atm/firestream.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -923,6 +923,7 @@ static int fs_open(struct atm_vcc *atm_v
 			}
 			if (!to) {
 				printk ("No more free channels for FS50..\n");
+				kfree(vcc);
 				return -EBUSY;
 			}
 			vcc->channo = dev->channo;
@@ -933,6 +934,7 @@ static int fs_open(struct atm_vcc *atm_v
 			if (((DO_DIRECTION(rxtp) && dev->atm_vccs[vcc->channo])) ||
 			    ( DO_DIRECTION(txtp) && test_bit (vcc->channo, dev->tx_inuse))) {
 				printk ("Channel is in use for FS155.\n");
+				kfree(vcc);
 				return -EBUSY;
 			}
 		}
@@ -946,6 +948,7 @@ static int fs_open(struct atm_vcc *atm_v
 			    tc, sizeof (struct fs_transmit_config));
 		if (!tc) {
 			fs_dprintk (FS_DEBUG_OPEN, "fs: can't alloc transmit_config.\n");
+			kfree(vcc);
 			return -ENOMEM;
 		}
 


