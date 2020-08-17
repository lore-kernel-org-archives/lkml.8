Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F2C20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684606;
	bh=4l7MNG17BMIzhPTKb3rZXjSglBEavRFY51CPupNXRxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lHMohQJUFryvLagSSgcqSYBXcRbc/jZcBJvIVnjnE7dulvu2UubA9NBUoofGXcirn
	 pcLBhZwyyc0+gP7IH4wy/pqIiqFLTxvUjHGb1nZNpST2gHvpdyWoZygnFCGQGwVsCE
	 j782HB+p+AD4PismOAk8CTJg3dh7DOsdtNWgVEjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgHQRQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388774AbgHQQOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:14:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665D320772;
        Mon, 17 Aug 2020 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680840;
        bh=4l7MNG17BMIzhPTKb3rZXjSglBEavRFY51CPupNXRxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q10emzGFaiQzDVSZ3KuZLN2GsV0F/dbY7ACgFLRNEGuK9hq5GFfw8TwJeA0PLKchW
         9YZgjKqIyY8xmlizvOxCKnKNwkNlgOinAs+A4mdxq8z+7hhqk5jr+E/+GBfikHR6Qa
         gqueq+WrE4wpanOyKMPgVu5Ducu5PSz6tcRNKg+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/168] leds: core: Flush scheduled work for system suspend
Date:   Mon, 17 Aug 2020 17:16:50 +0200
Message-Id: <20200817143737.649338980@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 302a085c20194bfa7df52e0fe684ee0c41da02e6 ]

Sometimes LED won't be turned off by LED_CORE_SUSPENDRESUME flag upon
system suspend.

led_set_brightness_nopm() uses schedule_work() to set LED brightness.
However, there's no guarantee that the scheduled work gets executed
because no one flushes the work.

So flush the scheduled work to make sure LED gets turned off.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Fixes: 81fe8e5b73e3 ("leds: core: Add led_set_brightness_nosleep{nopm} functions")
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e3487b373b..4e63dd2bfcf87 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -173,6 +173,7 @@ void led_classdev_suspend(struct led_classdev *led_cdev)
 {
 	led_cdev->flags |= LED_SUSPENDED;
 	led_set_brightness_nopm(led_cdev, 0);
+	flush_work(&led_cdev->set_brightness_work);
 }
 EXPORT_SYMBOL_GPL(led_classdev_suspend);
 
-- 
2.25.1



