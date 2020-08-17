Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFCF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692077;
	bh=Npu3UeR3EM6VyxZdke2f0joPg//KAUdcSv7WEvWzGj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f4+hZyRfdDuC0ai0tkYxZkEIfciCKKbtTe60y5QgDKFxzZC6MNZLV+E/26ICaJIH9
	 KzkzqtMA2Tkw9NfvveJzhD6ngJAphCct4x06hRi4iFejx87rfJumaq2+Q+wa8dW3gT
	 cuI3HjMQjRCAzNYIKaC+mG6bHl6BuHtpa4AyBpxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbgHQTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbgHQPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:36:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC39208E4;
        Mon, 17 Aug 2020 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678592;
        bh=Npu3UeR3EM6VyxZdke2f0joPg//KAUdcSv7WEvWzGj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIR698ie1DTDjrCidA9YcpzFs/OmuvZJi4l8sQIAsUCAkkkYQmwUyTH96OPe3GiuQ
         tXdsgz3VXVdWhCsqESN1fhJqNsmWkZFxVPiU78bhcvhYvDmZqkq8wqdBmOnTVJ/qPf
         fRy5gSnQmTnh7k3p/AkfDAJxaKrz+rG88joYc2Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rick Farrington <ricardo.farrington@cavium.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 357/464] liquidio: Fix wrong return value in cn23xx_get_pf_num()
Date:   Mon, 17 Aug 2020 17:15:10 +0200
Message-Id: <20200817143850.865635363@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

[ Upstream commit aa027850a292ea65524b8fab83eb91a124ad362c ]

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: 0c45d7fe12c7e ("liquidio: fix use of pf in pass-through mode in a virtual machine")
Cc: Rick Farrington <ricardo.farrington@cavium.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 43d11c38b38a9..4cddd628d41b2 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1167,7 +1167,7 @@ static int cn23xx_get_pf_num(struct octeon_device *oct)
 		oct->pf_num = ((fdl_bit >> CN23XX_PCIE_SRIOV_FDL_BIT_POS) &
 			       CN23XX_PCIE_SRIOV_FDL_MASK);
 	} else {
-		ret = EINVAL;
+		ret = -EINVAL;
 
 		/* Under some virtual environments, extended PCI regs are
 		 * inaccessible, in which case the above read will have failed.
-- 
2.25.1



