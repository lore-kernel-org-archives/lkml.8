Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E86C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF3D24682
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409925;
	bh=eyQmVqZVHK7x4qjnteBvRUWKTk8fc86tqTK0aEqOcsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fqv6mb5vqNC2ogJAEdUP78zbtKcJeYTGpEDLJ47ZIaturgGrnG6xJa0qM1T7IOPzu
	 sq68VK5kQYem5ojR9OYwRt5iZLZBLXk3DamehcJacQ4sq41wnaxu1k7QMqkw7K5b1u
	 tOWxVU3lz+f4shxa6zLzLpmWwPAW5mVVLb7CkD1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgA3SpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbgA3SpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:45:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9702082E;
        Thu, 30 Jan 2020 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409920;
        bh=eyQmVqZVHK7x4qjnteBvRUWKTk8fc86tqTK0aEqOcsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxQd+0wfkKAHyKlkQr/vTGyUh/Dg8ARiwWBQIsgNOGfLSKKw8x9J4BnIRKxC3GOY+
         qVf0okFNzFpDzfQRoJMoXEejVANCPgZ9Gc9YCjTn0DoW+7S37pWrlJbAeuLIYlueQ0
         G2TM0xcJRJVrB90460tgk6pJJXa7woJbPicGwgx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 084/110] bus: ti-sysc: Use swsup quirks also for am335x musb
Date:   Thu, 30 Jan 2020 19:39:00 +0100
Message-Id: <20200130183624.081826624@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 1819ef2e2d12d5b1a6ee54ac1c2afe35cffc677c ]

Also on am335x we need the swsup quirks for musb.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 44d4f4864ac2a..0e5cfd752410d 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1265,6 +1265,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_MODULE_QUIRK_SGX),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
+	SYSC_QUIRK("usb_otg_hs", 0, 0, 0x10, -1, 0x4ea2080d, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xfffff0f0,
 		   SYSC_MODULE_QUIRK_WDT),
 	/* Watchdog on am3 and am4 */
-- 
2.20.1



