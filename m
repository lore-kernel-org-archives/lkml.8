Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972F6222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875763;
	bh=WYGlAtvcJ/zNOfMgmNDpYqZxUajZ9NfxlUM6gXF4sE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MEj4XJGl3eL0+gpQAA7CWnFv24m5snaexNrGER9SZAldLxZfL+54T1Ka/bdh7pwkO
	 3GUbPAUcnlraiLZhCWIuxAP/qjSRc0NCMikAE+0JJCtfBtjqGPzbYQWiBEgb3qsOmD
	 f/cyDDnfDfCR4mRNtFp4nijMn8txvcVpyrzaOlKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405475AbgAXOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392384AbgAXOW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:22:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BFA2467B;
        Fri, 24 Jan 2020 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875749;
        bh=WYGlAtvcJ/zNOfMgmNDpYqZxUajZ9NfxlUM6gXF4sE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6eCKr4vXFJiiFkQullnVIwfuP0tzNIydPubrNRgm7qiH+rdcOD16+qASELmv+pB5
         NR4gcQnfTokDuNV7Le6TFcbdL2+UAeWOI4n+xFRjxL0mT7xkJURCg25KD5BQPyfSsW
         St6/UIFG2FOQpfpUFASfuNoryFxjA9kprmTaID8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, hayeswang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 6/9] r8152: add missing endpoint sanity check
Date:   Fri, 24 Jan 2020 09:22:18 -0500
Message-Id: <20200124142221.31201-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142221.31201-1-sashal@kernel.org>
References: <20200124142221.31201-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 86f3f4cd53707ceeec079b83205c8d3c756eca93 ]

Add missing endpoint sanity check to probe in order to prevent a
NULL-pointer dereference (or slab out-of-bounds access) when retrieving
the interrupt-endpoint bInterval on ndo_open() in case a device lacks
the expected endpoints.

Fixes: 40a82917b1d3 ("net/usb/r8152: enable interrupt transfer")
Cc: hayeswang <hayeswang@realtek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 10dd307593e89..db8b489b0513c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4243,6 +4243,9 @@ static int rtl8152_probe(struct usb_interface *intf,
 		return -ENODEV;
 	}
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 3)
+		return -ENODEV;
+
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {
-- 
2.20.1

