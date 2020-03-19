Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EDC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404EE20789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625128;
	bh=2Gkdd/83heQnFmGLEu+8gXq0kDGZx5JzMLIxTKv7kno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VrbrvyXj3ekZvXRg0wqgNcpVeHMHjONqZWn4QSFQL9W8g87PWwRwq9ivG3w10Bmme
	 OYocC9YBgCilOSErzCdRO+ViZcoP1ElDw2M8XE3vidyijVi1T9/sYUYI07lz4iT7Fy
	 7rNdKQpCk3oKXZMRtTmdBX4tfd/Ze1/nDQUaBveo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCSNF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbgCSNF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:05:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32ABA20732;
        Thu, 19 Mar 2020 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623125;
        bh=2Gkdd/83heQnFmGLEu+8gXq0kDGZx5JzMLIxTKv7kno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSP5oSTntzSPcNA6r5CJXpyaDlVU9UkAVPiRnItJVljkIeNp+zLOoLcbx5CutVJ4T
         9EcDK8nl+SUxrSGCU6lpPaCY9ykX+am7FivxyC7BOTytQjtKCs7zPBcP4iOPNVpcPT
         A9Waw7J7lgb2X6lMmdO6w9LcFvXe0YlNMDj4Cbs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/93] bnxt_en: reinitialize IRQs when MTU is modified
Date:   Thu, 19 Mar 2020 13:59:08 +0100
Message-Id: <20200319123926.260437977@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit a9b952d267e59a3b405e644930f46d252cea7122 ]

MTU changes may affect the number of IRQs so we must call
bnxt_close_nic()/bnxt_open_nic() with the irq_re_init parameter
set to true.  The reason is that a larger MTU may require
aggregation rings not needed with smaller MTU.  We may not be
able to allocate the required number of aggregation rings and
so we reduce the number of channels which will change the number
of IRQs.  Without this patch, it may crash eventually in
pci_disable_msix() when the IRQs are not properly unwound.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5310,13 +5310,13 @@ static int bnxt_change_mtu(struct net_de
 		return -EINVAL;
 
 	if (netif_running(dev))
-		bnxt_close_nic(bp, false, false);
+		bnxt_close_nic(bp, true, false);
 
 	dev->mtu = new_mtu;
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-		return bnxt_open_nic(bp, false, false);
+		return bnxt_open_nic(bp, true, false);
 
 	return 0;
 }


