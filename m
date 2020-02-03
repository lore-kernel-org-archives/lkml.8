Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB4C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8B221741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747606;
	bh=jWRssr90GBfEJ4YHTI/skt6o02YDdSqapYNKQs8ZPNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0V0/TL/ZII3QrmNjfom7IkTriilS5z2P4Rh1hUWHT52DjfI04pX6s5teb4A1gt8X
	 gaoH+VKgfjIAnoGJ1SDvsRIuBRlChyxdskA/iUeLf9fhGGbat1V+2pB4f/EWzPVc7X
	 Lo3xllBdzKyEMiK6xkxIgv+EZoNTmSn6rG941bsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgBCQdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgBCQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:20 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3E621741;
        Mon,  3 Feb 2020 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747599;
        bh=jWRssr90GBfEJ4YHTI/skt6o02YDdSqapYNKQs8ZPNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8MHyI2UrNRQG9U/WIFaGmlVDMWfEN136UQ6wmh1B+qqBB/pS3Bzmgd9ApTMMWawZ
         GONN2+Iyed4Ecv+2gsX2IwhO2N69jn4mNdQ+u5yAj2Zw43C/FKG7fiKAUbJB0ZZF48
         aQSai8E5dm5IvHkMUIdsKoxrHxzv30ZsxndFReY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 62/70] r8152: get default setting of WOL before initializing
Date:   Mon,  3 Feb 2020 16:20:14 +0000
Message-Id: <20200203161921.126096722@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 9583a3638dc07cc1878f41265e85ed497f72efcb ]

Initailization would reset runtime suspend by tp->saved_wolopts, so
the tp->saved_wolopts should be set before initializing.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index db817d3c2bb8b..c5c188dc66268 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5259,6 +5259,11 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 	intf->needs_remote_wakeup = 1;
 
+	if (!rtl_can_wakeup(tp))
+		__rtl_set_wol(tp, 0);
+	else
+		tp->saved_wolopts = __rtl_get_wol(tp);
+
 	tp->rtl_ops.init(tp);
 	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp);
@@ -5272,10 +5277,6 @@ static int rtl8152_probe(struct usb_interface *intf,
 		goto out1;
 	}
 
-	if (!rtl_can_wakeup(tp))
-		__rtl_set_wol(tp, 0);
-
-	tp->saved_wolopts = __rtl_get_wol(tp);
 	if (tp->saved_wolopts)
 		device_set_wakeup_enable(&udev->dev, true);
 	else
-- 
2.20.1



