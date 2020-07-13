Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B777C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833DE20702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGMHYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:24:36 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:24:35 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id 2XQX230064C55Sk01XQXlM; Mon, 13 Jul 2020 09:24:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1juspD-0006Qe-3i; Mon, 13 Jul 2020 09:24:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1juspD-0001cY-1g; Mon, 13 Jul 2020 09:24:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Stefan Reinauer <stefan.k.reinauer@gmail.com>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] zorro: Fix address space collision message with RAM expansion boards
Date:   Mon, 13 Jul 2020 09:24:29 +0200
Message-Id: <20200713072429.6182-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting Linux on an Amiga with BigRAMPlus Zorro expansion board:

    zorro: Address space collision on device Zorro device 12128600 (Individual Computers) [??? 0x50000000-]

This happens because the address space occupied by the BigRAMPlus Zorro
device is already in use, as it is part of system RAM.  Hence the
message is harmless.

Zorro memory expansion boards have the ERTF_MEMLIST flag set, which
tells AmigaOS to link the board's RAM into the free memory list.  While
we could skip registering the board resource if this flag is set, that
may cause issues with Zorro II RAM excluded in a memfile.

Hence fix the issue by just ignoring the error if ERTF_MEMLIST is set.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/zorro.c b/drivers/zorro/zorro.c
index 47c733817903f303..1b9928648583193c 100644
--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -181,7 +181,7 @@ static int __init amiga_zorro_probe(struct platform_device *pdev)
 		z->resource.name = z->name;
 		r = zorro_find_parent_resource(pdev, z);
 		error = request_resource(r, &z->resource);
-		if (error)
+		if (error && !(z->rom.er_Type & ERTF_MEMLIST))
 			dev_err(&bus->dev,
 				"Address space collision on device %s %pR\n",
 				z->name, &z->resource);
-- 
2.17.1

