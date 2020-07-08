Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2246EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED995206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594239684;
	bh=UeCNSUIXhUf07hExa3mxpd08ul/F7bP7XImjtU6s0mQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Gdpz9RtdSpgjLt4BI1jpwDrkZAF9SFqlnLm9DwgiQAUar6TqGu7Ck9RXYyvOIjetl
	 IRdEcoXUzLnGGS5rrMKJ9g9nu/zlYevFRya3DXgWJ0Vy8vPR75bDsFtUiw2r2VSfo/
	 p9+FZwjT3CwxISad/fSrdaJLJkC+uoA+qbLRRDXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGHUVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:21:22 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9AC206DF;
        Wed,  8 Jul 2020 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594239681;
        bh=UeCNSUIXhUf07hExa3mxpd08ul/F7bP7XImjtU6s0mQ=;
        h=Date:From:To:Cc:Subject:From;
        b=qpT21zjyUpZRBes6dwkVF7VRpNo7GVmRVSB6Z8LaZTi2JEQxIMzHw64KWRNqB7U7u
         ltBidmEtNbtwkVXLYf0V/xmUZ+JXRstbLw5hxbqCkpOSgjsqu9XrdlhlkZdCgps4Pu
         BGa5rraSVTfspfi+I7fjZMP4d9Tkx33lbeEij7ls=
Date:   Wed, 8 Jul 2020 15:26:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] Bluetooth: Use fallthrough pseudo-keyword
Message-ID: <20200708202650.GA3866@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/bluetooth/bcm203x.c     | 2 +-
 drivers/bluetooth/bluecard_cs.c | 2 --
 drivers/bluetooth/hci_ll.c      | 2 +-
 drivers/bluetooth/hci_qca.c     | 8 +-------
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 3b176257b993..e667933c3d70 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -106,7 +106,7 @@ static void bcm203x_complete(struct urb *urb)
 		}
 
 		data->state = BCM203X_LOAD_FIRMWARE;
-		/* fall through */
+		fallthrough;
 	case BCM203X_LOAD_FIRMWARE:
 		if (data->fw_sent == data->fw_size) {
 			usb_fill_int_urb(urb, udev, usb_rcvintpipe(udev, BCM203X_IN_EP),
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index cc6e56223656..36eabf61717f 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -295,7 +295,6 @@ static void bluecard_write_wakeup(struct bluecard_info *info)
 				baud_reg = REG_CONTROL_BAUD_RATE_115200;
 				break;
 			case PKT_BAUD_RATE_57600:
-				/* Fall through... */
 			default:
 				baud_reg = REG_CONTROL_BAUD_RATE_57600;
 				break;
@@ -585,7 +584,6 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_115200;
 		break;
 	case 57600:
-		/* Fall through... */
 	default:
 		cmd[4] = 0x03;
 		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_57600;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index d9a4c6c691e0..8bfe024d1fcd 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -219,7 +219,7 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
 		 * perfectly safe to always send one.
 		 */
 		BT_DBG("dual wake-up-indication");
-		/* fall through */
+		fallthrough;
 	case HCILL_ASLEEP:
 		/* acknowledge device wake up */
 		if (send_hcill_cmd(HCILL_WAKE_UP_ACK, hu) < 0) {
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 99d14c777105..7e395469ca4f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -472,8 +472,6 @@ static void hci_ibs_tx_idle_timeout(struct timer_list *t)
 
 	case HCI_IBS_TX_ASLEEP:
 	case HCI_IBS_TX_WAKING:
-		/* Fall through */
-
 	default:
 		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
 		break;
@@ -516,8 +514,6 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 
 	case HCI_IBS_TX_ASLEEP:
 	case HCI_IBS_TX_AWAKE:
-		/* Fall through */
-
 	default:
 		BT_ERR("Spurious timeout tx state %d", qca->tx_ibs_state);
 		break;
@@ -835,8 +831,6 @@ static void device_woke_up(struct hci_uart *hu)
 		break;
 
 	case HCI_IBS_TX_ASLEEP:
-		/* Fall through */
-
 	default:
 		BT_ERR("Received HCI_IBS_WAKE_ACK in tx state %d",
 		       qca->tx_ibs_state);
@@ -2072,7 +2066,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_WAKING:
 		del_timer(&qca->wake_retrans_timer);
-		/* Fall through */
+		fallthrough;
 	case HCI_IBS_TX_AWAKE:
 		del_timer(&qca->tx_idle_timer);
 
-- 
2.27.0

