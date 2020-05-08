Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5E9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0D824953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942277;
	bh=POwLX1SmMFcQfjvzYyCJqlQaSBoWeieD5GSTE2vxqa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=neYss1SWVgO3rOv+5mpD2ifxiZbfjTLJ89JQ9IIuCT2lcNiFxTbW+hTQUtDOF2m/j
	 eXx6mKIT94TiNgMDsapcXsYmSXlzCt6ZWd9xEDojYaB3y4LvObeA3/aaTgu6Ygt8dj
	 GiUN2NH8lGCDuNOg5re/46pshoecdW/W/No/4MzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgEHMvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgEHMvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:51:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7774D24954;
        Fri,  8 May 2020 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942269;
        bh=POwLX1SmMFcQfjvzYyCJqlQaSBoWeieD5GSTE2vxqa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLnYKjzJqFwRqQj1A8HxVnH8cqozV2Ts7DrhDvaTZ4ZWAWVasanYraDKEDSNRnetL
         bGgNa/M6nnLUh1x1JbJ383DSCfKyWN2n8gLpycn4f8yYKEDwSQZEN5eUar/KQA16nZ
         T6hA0fR2+kvg25eItCIOjIf5lQ7OuO6BUYriz6RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/32] wimax/i2400m: Fix potential urb refcnt leak
Date:   Fri,  8 May 2020 14:35:24 +0200
Message-Id: <20200508123036.302330740@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -354,6 +354,7 @@ ssize_t i2400mu_bus_bm_wait_for_ack(struct i2400m *i2400m,
 		usb_autopm_put_interface(i2400mu->usb_iface);
 	d_fnend(8, dev, "(i2400m %p ack %p size %zu) = %ld\n",
 		i2400m, ack, ack_size, (long) result);
+	usb_put_urb(&notif_urb);
 	return result;
 
 error_exceeded:
-- 
2.20.1



