Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E59C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87190205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409688;
	bh=7jlyodMR1hMib1vLo8tBYpdkJz1ljJqLkFdpx1YkWZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGWHbs3FL38iFoiZB40nQw775pFmXeAjvatTACJaW3e5KYF2dcs52Fd0TZU0HxCww
	 Y/5aOIi2QCVUdkpbooau/24GEC9eliByS2q8AMIRjdhbipa8hRs17pWoFj8gZVXyfi
	 q/erwHxoXc0LyZj7kyv1NlkMigISn9rpvmpShtvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgA3Sl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgA3SlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:41:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C182082E;
        Thu, 30 Jan 2020 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409683;
        bh=7jlyodMR1hMib1vLo8tBYpdkJz1ljJqLkFdpx1YkWZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DstCog62vcLfkeVuKwafd+qjwdcvySiauIBmDWIez6ssJ89vQHeDRLh1PpiYS450f
         689xlbjPw0i8e3stguR4jKRnN9EHwhqbf93uGAn5vRdN4ICB3nOQCOppQDle0IApga
         IhtxVGS62zO4ycRR8emlrG8+lq95UxDlit7HbfA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 49/56] rsi: fix non-atomic allocation in completion handler
Date:   Thu, 30 Jan 2020 19:39:06 +0100
Message-Id: <20200130183617.803270823@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit b9b9f9fea21830f85cf0148cd8dce001ae55ead1 upstream.

USB completion handlers are called in atomic context and must
specifically not allocate memory using GFP_KERNEL.

Fixes: a1854fae1414 ("rsi: improve RX packet handling in USB interface")
Cc: stable <stable@vger.kernel.org> # 4.17
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/types.h>
 #include <net/rsi_91x.h>
 #include "rsi_usb.h"
 #include "rsi_hal.h"
@@ -29,7 +30,7 @@ MODULE_PARM_DESC(dev_oper_mode,
 		 "9[Wi-Fi STA + BT LE], 13[Wi-Fi STA + BT classic + BT LE]\n"
 		 "6[AP + BT classic], 14[AP + BT classic + BT LE]");
 
-static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num);
+static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num, gfp_t flags);
 
 /**
  * rsi_usb_card_write() - This function writes to the USB Card.
@@ -285,7 +286,7 @@ static void rsi_rx_done_handler(struct u
 	status = 0;
 
 out:
-	if (rsi_rx_urb_submit(dev->priv, rx_cb->ep_num))
+	if (rsi_rx_urb_submit(dev->priv, rx_cb->ep_num, GFP_ATOMIC))
 		rsi_dbg(ERR_ZONE, "%s: Failed in urb submission", __func__);
 
 	if (status)
@@ -307,7 +308,7 @@ static void rsi_rx_urb_kill(struct rsi_h
  *
  * Return: 0 on success, a negative error code on failure.
  */
-static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num)
+static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num, gfp_t mem_flags)
 {
 	struct rsi_91x_usbdev *dev = (struct rsi_91x_usbdev *)adapter->rsi_dev;
 	struct rx_usb_ctrl_block *rx_cb = &dev->rx_cb[ep_num - 1];
@@ -337,7 +338,7 @@ static int rsi_rx_urb_submit(struct rsi_
 			  rsi_rx_done_handler,
 			  rx_cb);
 
-	status = usb_submit_urb(urb, GFP_KERNEL);
+	status = usb_submit_urb(urb, mem_flags);
 	if (status) {
 		rsi_dbg(ERR_ZONE, "%s: Failed in urb submission\n", __func__);
 		dev_kfree_skb(skb);
@@ -827,12 +828,12 @@ static int rsi_probe(struct usb_interfac
 		rsi_dbg(INIT_ZONE, "%s: Device Init Done\n", __func__);
 	}
 
-	status = rsi_rx_urb_submit(adapter, WLAN_EP);
+	status = rsi_rx_urb_submit(adapter, WLAN_EP, GFP_KERNEL);
 	if (status)
 		goto err1;
 
 	if (adapter->priv->coex_mode > 1) {
-		status = rsi_rx_urb_submit(adapter, BT_EP);
+		status = rsi_rx_urb_submit(adapter, BT_EP, GFP_KERNEL);
 		if (status)
 			goto err_kill_wlan_urb;
 	}


