Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A0C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B120726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYYROw/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:04:09 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55310 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:04:09 -0500
Received: by mail-qt1-f201.google.com with SMTP id c8so1293591qte.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PqRD4UbVhW58Tl+hqtfrY0XqJZDl4mnYLCjvYwU+muU=;
        b=bYYROw/t06LnGxEegtu8dkHpt81thJWvDlz7xRDTZzCCyEeE3CgC9SuCbdhERyO4oK
         IThTTjOGvDpcz38PmYV0zYNBPj2pmIId1tBts/UkRWRT8Muhaarwj0W981o2Y4M5rJwQ
         Ha9jDbvEgn23OumhugnI7NhO2HAdlQ9wrIyGM7zhbcI7r2i2BnA5SX+GhSWK3n1SMc25
         rjMAL2oBVJ6mL9bAAWxNgfApo2JyLCK6xc/FGvVORwZE/OLYXfm2Qspp9UlKjfV6NYkI
         3tUWp37az9OuHSu1j0tigFSjpOth/ukXPbmepEYqzHL8f3t+B4vy4Rat0fJNGc1A8Eit
         spKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PqRD4UbVhW58Tl+hqtfrY0XqJZDl4mnYLCjvYwU+muU=;
        b=a05GNgt6eFXGzkXjS8yYozqtU7Aq/uWs5OLZetwm9Hs1xhmWWaAlpRB1nbGCA8g5pO
         izCL5FU4jnVo/joTgIPB934/AqHWfh/Db4k+sfxQwOs8xKbDYhmfgMvlreJVhs69yw3U
         qWwTws+0A5cgb30a64myRHrZoAJQ51pHqyxjUCErwWXK02nRP0MzOFuKRuveSHns2eoR
         ikX8cZ6hJx53p856fUIQmckgLqkmI1Qu0Jw9ZVxpdDDgkhm4XScTDcgNzChzuLnt7ZVy
         psaUeN6JbhmQHQ7sE/hAoQgTtXSCfW4OFul59B52zuLotjvWiXfSJPoemIVu10OxjEDi
         ZXaA==
X-Gm-Message-State: APjAAAWqIPOzOFNWygjKrNVk3ltKsotSxejH78ce1Qe3TSlIv6FMgS8U
        g+WqI2JpA2UAmMq2UuN18DrTfi/8GoC3kveDbg==
X-Google-Smtp-Source: APXvYqxva0U+pcomyB9XOXpYzjCscHp4hFCu8arNfQ68abfmMw/1M/sfncNdROqlFpFyn+h8UlFkdilLHV/6peFwew==
X-Received: by 2002:a05:6214:17cd:: with SMTP id cu13mr5858602qvb.192.1581069847854;
 Fri, 07 Feb 2020 02:04:07 -0800 (PST)
Date:   Fri,  7 Feb 2020 18:04:00 +0800
Message-Id: <20200207180348.Bluez.v2.1.Ia71869d2f3e19a76a6a352c61088a085a1d41ba6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [Bluez PATCH v2] bluetooth: secure bluetooth stack from bluedump attack
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attack scenario:
1. A Chromebook (let's call this device A) is paired to a legitimate
   Bluetooth classic device (e.g. a speaker) (let's call this device
   B).
2. A malicious device (let's call this device C) pretends to be the
   Bluetooth speaker by using the same BT address.
3. If device A is not currently connected to device B, device A will
   be ready to accept connection from device B in the background
   (technically, doing Page Scan).
4. Therefore, device C can initiate connection to device A
   (because device A is doing Page Scan) and device A will accept the
   connection because device A trusts device C's address which is the
   same as device B's address.
5. Device C won't be able to communicate at any high level Bluetooth
   profile with device A because device A enforces that device C is
   encrypted with their common Link Key, which device C doesn't have.
   But device C can initiate pairing with device A with just-works
   model without requiring user interaction (there is only pairing
   notification). After pairing, device A now trusts device C with a
   new different link key, common between device A and C.
6. From now on, device A trusts device C, so device C can at anytime
   connect to device A to do any kind of high-level hijacking, e.g.
   speaker hijack or mouse/keyboard hijack.

Since we don't know whether the repairing is legitimate or not,
leave the decision to user space if all the conditions below are met.
- the pairing is initialized by peer
- the authorization method is just-work
- host already had the link key to the peer

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2:
- Remove the HCI_PERMIT_JUST_WORK_REPAIR debugfs option
- Fix the added code in classic
- Add a similar fix for LE

 net/bluetooth/hci_event.c | 10 ++++++++++
 net/bluetooth/smp.c       | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6ddc4a74a5e4..334d7ccd8d6e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4557,6 +4557,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 			goto confirm;
 		}
 
+		/* If there already exists link key in local host, leave the
+		 * decision to user space since the remote device could be
+		 * legitimate or malicious.
+		 */
+		if (hci_find_link_key(hdev, &ev->bdaddr)) {
+			bt_dev_warn(hdev, "Local host already has link key");
+			confirm_hint = 2;
+			goto confirm;
+		}
+
 		BT_DBG("Auto-accept of user confirmation with %ums delay",
 		       hdev->auto_accept_delay);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 83449a88a182..f58426dea4de 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2118,6 +2118,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 *pkax, *pkbx, *na, *nb;
 	u32 passkey;
 	int err;
+	struct smp_ltk *key;
 
 	BT_DBG("conn %p", conn);
 
@@ -2168,6 +2169,23 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+
+		key = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+				   hcon->role);
+
+		/* If there already exists link key in local host, leave the
+		 * decision to user space since the remote device could be
+		 * legitimate or malicious.
+		 */
+		if (smp->method == JUST_WORKS && key) {
+			err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+							hcon->type,
+							hcon->dst_type, passkey,
+							2);
+			if (err)
+				return SMP_UNSPECIFIED;
+			set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+		}
 	}
 
 mackey_and_ltk:
-- 
2.25.0.341.g760bfbb309-goog

