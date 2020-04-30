Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53AC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD03920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254965;
	bh=UZzWHQH2Ye08RTrRi7qlN1lnduAxTuqxC+B9xQqkuV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ygb/rxjM2LAG37YE4T6Q4fu6DeNX+HZajy7dA11+320PkQHsfXB+bBuLOtzSYM1Rw
	 A0ptXo366qKfzyZlSr5z4P8oMgEG2J5N7nQ7Q1y6drz007vl+jf8an7CiAXDsOJy9j
	 X2u51A/0mpOJwJRB5hae4OPwPrU8EyD4KLgY3sEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgD3NzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgD3NyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:54:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8BD2072A;
        Thu, 30 Apr 2020 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254855;
        bh=UZzWHQH2Ye08RTrRi7qlN1lnduAxTuqxC+B9xQqkuV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZ7+80/OyL6xHc7F2xqRXDaDgCkWl6IU5unvSQBlMhU2EdqpmOPlLDbjOQSieOSwv
         BVgCyDPH4s1Wh5TWOlFEC5Bv7hxAcPsy3HbSFDtKzZCOp1qK40pxB4us8vXuRuhlqo
         qQq8KuJwcvgmlu0YslzpMKl/lfsggrplWRa8pMj0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/27] wimax/i2400m: Fix potential urb refcnt leak
Date:   Thu, 30 Apr 2020 09:53:46 -0400
Message-Id: <20200430135402.20994-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135402.20994-1-sashal@kernel.org>
References: <20200430135402.20994-1-sashal@kernel.org>
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
index 502c346aa790b..7d396c81ec3eb 100644
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

