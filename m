Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E526A21919
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578611;
	bh=Ktbx907Vc7Cf/keYgCLNc5qvxloSh/qfQ0N/wziWuKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwgqIXc2+wkbX9IB3dXI0mT/u8f+UweSVi8MpdbBboQJXVcPk7fZP18r9dgHE1s7l
	 Lo4W3+2M/BXXius3vCnLQSOFS7XIxyIBDfFWMivqTadw+/SwlOOT2XuuBRtGsk+Qh5
	 Aof3cNTwI0qaowBbcDFzvszXMz2f1yPehcVvBiDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390132AbgFSO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390079AbgFSO4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:56:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC97217D9;
        Fri, 19 Jun 2020 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578591;
        bh=Ktbx907Vc7Cf/keYgCLNc5qvxloSh/qfQ0N/wziWuKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJy2WGv0NP3eVQ3jpA34UHioM4O/Kpc2njspgDw0wNxm+LTp77vgjwtlW5wNsyI2n
         EjD5PGPzppBYe4bbHrwfeG+6PhW7NcXrhqOuRRHa1/T4NWSdbbFKdhvcDAEkprIj/t
         Y7a/t5d/T/yvkjiTEXe5D93CH88r1y0dJvV4PKN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com
Subject: [PATCH 4.19 080/267] ath9x: Fix stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
Date:   Fri, 19 Jun 2020 16:31:05 +0200
Message-Id: <20200619141652.738488503@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

commit 19d6c375d671ce9949a864fb9a03e19f5487b4d3 upstream.

Add barrier to accessing the stack array skb_pool.

The case reported by syzbot:
https://lore.kernel.org/linux-usb/0000000000003d7c1505a2168418@google.com
BUG: KASAN: stack-out-of-bounds in ath9k_hif_usb_rx_stream
drivers/net/wireless/ath/ath9k/hif_usb.c:626 [inline]
BUG: KASAN: stack-out-of-bounds in ath9k_hif_usb_rx_cb+0xdf6/0xf70
drivers/net/wireless/ath/ath9k/hif_usb.c:666
Write of size 8 at addr ffff8881db309a28 by task swapper/1/0

Call Trace:
ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:626
[inline]
ath9k_hif_usb_rx_cb+0xdf6/0xf70
drivers/net/wireless/ath/ath9k/hif_usb.c:666
__usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1648
usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1713
dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
expire_timers kernel/time/timer.c:1449 [inline]
__run_timers kernel/time/timer.c:1773 [inline]
__run_timers kernel/time/timer.c:1740 [inline]
run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786

Reported-and-tested-by: syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200404041838.10426-5-hqjagain@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/hif_usb.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -612,6 +612,11 @@ static void ath9k_hif_usb_rx_stream(stru
 			hif_dev->remain_skb = nskb;
 			spin_unlock(&hif_dev->rx_lock);
 		} else {
+			if (pool_index == MAX_PKT_NUM_IN_TRANSFER) {
+				dev_err(&hif_dev->udev->dev,
+					"ath9k_htc: over RX MAX_PKT_NUM\n");
+				goto err;
+			}
 			nskb = __dev_alloc_skb(pkt_len + 32, GFP_ATOMIC);
 			if (!nskb) {
 				dev_err(&hif_dev->udev->dev,


