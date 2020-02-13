Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FFC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94B217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607904;
	bh=qalAB5bKEGVK827bqT35jJirfnT6wm6bOd0KLJ3sqa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dw57GyPfSDpEfyGDdS3dekoXZikErwBW97BTsTJ6rjVTEcqRXx16zhUJVec7igedz
	 xKvdcLqHVTaU0i8ZQWz3ABWBZCCEi2G9UYAfRv7p0Sgsr4tdt02D3sG14P1//xVZOX
	 qiItkTwFzzdf/Xl3mZ/SjXZ/UTxF4J2iDk6/e9SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgBMPbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgBMP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:03 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C749F206DB;
        Thu, 13 Feb 2020 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607682;
        bh=qalAB5bKEGVK827bqT35jJirfnT6wm6bOd0KLJ3sqa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yC3KPv7mK7YRLq+rZn++f6aVivYYO1j3GpIWY1r68PxEs5k7Ej3+pBP6WyNVoWOMZ
         Q6Lbs8H/1emNpnPo7wiHCl7HIUiXerUs2UNeCGtd860c+NQKJn//mycU1qS7ne6D/C
         ajnva7UwXUWevdiVX3N6HqLveVhiT1zs1aS0iHLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 006/120] RDMA/i40iw: fix a potential NULL pointer dereference
Date:   Thu, 13 Feb 2020 07:20:02 -0800
Message-Id: <20200213151903.615842568@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 04db1580b5e48a79e24aa51ecae0cd4b2296ec23 upstream.

A NULL pointer can be returned by in_dev_get(). Thus add a corresponding
check so that a NULL pointer dereference will be avoided at this place.

Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
Link: https://lore.kernel.org/r/1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/i40iw/i40iw_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1225,6 +1225,8 @@ static void i40iw_add_ipv4_addr(struct i
 			const struct in_ifaddr *ifa;
 
 			idev = in_dev_get(dev);
+			if (!idev)
+				continue;
 			in_dev_for_each_ifa_rtnl(ifa, idev) {
 				i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_CM,
 					    "IP=%pI4, vlan_id=%d, MAC=%pM\n", &ifa->ifa_address,


