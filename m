Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BF622B49
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917928;
	bh=nomXhcYIp8cGk9ExnDbF/NwHaf8ImgxM9gUxQ+TVNfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GdgtjhqRbkWaEZWcQGmFDJyRYGJahlwor2zr0okLWsGKTOV6B6pJ1kRFEVJlhAaiL
	 gpBEevjU4brUFxHDb92np9B7SJEH0V3rwkMB8XwixWGzun0Cd/e8mbkEhLcVk/n0Iq
	 VbebLPIfH6LNfZcKW7MrGBGeHxFGPYykDLhvFPWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgHTKFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbgHTKBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2872822B40;
        Thu, 20 Aug 2020 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917696;
        bh=nomXhcYIp8cGk9ExnDbF/NwHaf8ImgxM9gUxQ+TVNfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08Eov4rGhGH0BTvqmm5oMMM2A/Kex+u8iPGiRSPiEku83iQFkzwTegkjXZbaRzd0W
         YGmmkW6i5OHBND29zIpOS0EYqr7TjIPfcoR3FcWG99lGDw+zhfn1ZttQJWBPas3Jgv
         nt0nUK1hBZ3BcFpJ6D+kd2xhqa7eYM8i9l0ycvbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 124/212] leds: core: Flush scheduled work for system suspend
Date:   Thu, 20 Aug 2020 11:21:37 +0200
Message-Id: <20200820091608.611404453@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index aa84e5b375931..7d3f23bad88dd 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -110,6 +110,7 @@ void led_classdev_suspend(struct led_classdev *led_cdev)
 {
 	led_cdev->flags |= LED_SUSPENDED;
 	led_set_brightness_nopm(led_cdev, 0);
+	flush_work(&led_cdev->set_brightness_work);
 }
 EXPORT_SYMBOL_GPL(led_classdev_suspend);
 
-- 
2.25.1



