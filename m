Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77508C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DAE206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgC0Fi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:38:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47679 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgC0Fi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:38:58 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jHhhk-00085G-Qu; Fri, 27 Mar 2020 06:38:52 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jHhhj-0001QA-LF; Fri, 27 Mar 2020 06:38:51 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Bin Liu <b-liu@ti.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, russell@personaltelco.net,
        fercerpav@gmail.com
Subject: [PATCH v1] usb: musb: dsps: set MUSB_DA8XX quirk for AM335x
Date:   Fri, 27 Mar 2020 06:38:49 +0100
Message-Id: <20200327053849.5348-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beagle Bone Black has different memory corruptions if kernel is
configured with USB_TI_CPPI41_DMA=y. This issue is reproducible with
ath9k-htc driver (ar9271 based wifi usb controller):

root@AccessBox:~ iw dev wlan0 set monitor  fcsfail otherbss
root@AccessBox:~ ip l s dev wlan0 up
kmemleak: Cannot insert 0xda577e40 into the object search tree (overlaps existing)
CPU: 0 PID: 176 Comm: ip Not tainted 5.5.0 #7
Hardware name: Generic AM33XX (Flattened Device Tree)
[<c0112c14>] (unwind_backtrace) from [<c010dc98>] (show_stack+0x18/0x1c)
[<c010dc98>] (show_stack) from [<c08c7c2c>] (dump_stack+0x84/0x98)
[<c08c7c2c>] (dump_stack) from [<c02c75a8>] (create_object+0x2f8/0x324)
[<c02c75a8>] (create_object) from [<c02b8928>] (kmem_cache_alloc+0x1a8/0x39c)
[<c02b8928>] (kmem_cache_alloc) from [<c072fb68>] (__alloc_skb+0x60/0x174)
[<c072fb68>] (__alloc_skb) from [<bf0c5c58>] (ath9k_wmi_cmd+0x50/0x184 [ath9k_htc])
[<bf0c5c58>] (ath9k_wmi_cmd [ath9k_htc]) from [<bf0cb410>] (ath9k_regwrite_multi+0x54/0x84 [ath9k_htc])
[<bf0cb410>] (ath9k_regwrite_multi [ath9k_htc]) from [<bf0cb7fc>] (ath9k_regwrite+0xf0/0xfc [ath9k_htc])
[<bf0cb7fc>] (ath9k_regwrite [ath9k_htc]) from [<bf1aca78>] (ar5008_hw_process_ini+0x280/0x6c0 [ath9k_hw])
[<bf1aca78>] (ar5008_hw_process_ini [ath9k_hw]) from [<bf1a66ac>] (ath9k_hw_reset+0x270/0x1458 [ath9k_hw])
[<bf1a66ac>] (ath9k_hw_reset [ath9k_hw]) from [<bf0c9588>] (ath9k_htc_start+0xb0/0x22c [ath9k_htc])
[<bf0c9588>] (ath9k_htc_start [ath9k_htc]) from [<bf0eb3c0>] (drv_start+0x4c/0x1e8 [mac80211])
[<bf0eb3c0>] (drv_start [mac80211]) from [<bf104a84>] (ieee80211_do_open+0x480/0x954 [mac80211])
[<bf104a84>] (ieee80211_do_open [mac80211]) from [<c075127c>] (__dev_open+0xdc/0x160)
[<c075127c>] (__dev_open) from [<c07516a8>] (__dev_change_flags+0x1a4/0x204)
[<c07516a8>] (__dev_change_flags) from [<c0751728>] (dev_change_flags+0x20/0x50)
[<c0751728>] (dev_change_flags) from [<c076971c>] (do_setlink+0x2ac/0x978)

After applying this patch, the system is running in monitor mode without
noticeable issues.

Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 88923175f71e..c01f9e9e69f5 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -690,7 +690,7 @@ static void dsps_dma_controller_resume(struct dsps_glue *glue) {}
 #endif /* CONFIG_USB_TI_CPPI41_DMA */
 
 static struct musb_platform_ops dsps_ops = {
-	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP | MUSB_DA8XX,
 	.init		= dsps_musb_init,
 	.exit		= dsps_musb_exit,
 
-- 
2.26.0.rc2

