Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED1C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C35E24953
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254868;
	bh=Nh7gMGFbFDqRDU6KRwGLRELYcn+AP104P30Mc9SedG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pRJohwXj+eDL7+nLwBM6JsbufEg+B8nafdZxSsB80e90O0DJ5NZKr1bGVumwexOVd
	 0qqJA8T+FaAKf1kWgWG1Wlu9NCQz4zScu0jx2OtwRayjCxvzXQ+f5bNCSvzq21cb0S
	 AwHh3x2zoI+Zk6fktODOwL3Si3Ti93J10DNTBDIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgD3Ny1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbgD3Nxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE1420774;
        Thu, 30 Apr 2020 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254823;
        bh=Nh7gMGFbFDqRDU6KRwGLRELYcn+AP104P30Mc9SedG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w76iYVkAKxFLIUDezM7jNfL42z0HSHUrkik2nyPrSNGSujSJb4P3m2cNw20TmfMgZ
         dqiMDwfr1K2FIlKqD+PwNdnP86PFZgw6XVoxn55gj+tG/sZv4QHfMtt1hEZoXYczeL
         nIT6bC1jL1sgDt1bSYF5PbwTMI51Vz5YMaYthd0Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/30] wimax/i2400m: Fix potential urb refcnt leak
Date:   Thu, 30 Apr 2020 09:53:10 -0400
Message-Id: <20200430135325.20762-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 7717cbec172c3554d470023b4020d5781961187e ]

i2400mu_bus_bm_wait_for_ack() invokes usb_get_urb(), which increases the
refcount of the "notif_urb".

When i2400mu_bus_bm_wait_for_ack() returns, local variable "notif_urb"
becomes invalid, so the refcount should be decreased to keep refcount
balanced.

The issue happens in all paths of i2400mu_bus_bm_wait_for_ack(), which
forget to decrease the refcnt increased by usb_get_urb(), causing a
refcnt leak.

Fix this issue by calling usb_put_urb() before the
i2400mu_bus_bm_wait_for_ack() returns.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wimax/i2400m/usb-fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wimax/i2400m/usb-fw.c b/drivers/net/wimax/i2400m/usb-fw.c
index 529ebca1e9e13..1f7709d24f352 100644
--- a/drivers/net/wimax/i2400m/usb-fw.c
+++ b/drivers/net/wimax/i2400m/usb-fw.c
@@ -354,6 +354,7 @@ out:
 		usb_autopm_put_interface(i2400mu->usb_iface);
 	d_fnend(8, dev, "(i2400m %p ack %p size %zu) = %ld\n",
 		i2400m, ack, ack_size, (long) result);
+	usb_put_urb(&notif_urb);
 	return result;
 
 error_exceeded:
-- 
2.20.1

