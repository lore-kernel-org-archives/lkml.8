Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D195C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770C32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnuQ7Svk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSGp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:45:26 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39387 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:45:26 -0500
Received: by mail-pf1-f202.google.com with SMTP id o1so14890425pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 22:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JFI3+kM1LWruGVLKeVPFO/XZwyOSYT/vDPiEnVdBj2U=;
        b=PnuQ7SvkJrwFsCkOr3rvHKfrDrwUoHQwrQQitEv/ezWelIifCVoD7E3e/i+/2TbM+X
         IwDtLxTnUEfVdwcl86OnwvXOLU70wOEw5HjL0v/xxm5717Pb45kjxTcUhUMbrmdsyP+C
         SBKE6mym4PF3P72mIY7hikh8i3a0aESWh+EGXRwooJhSJ8OYdGDoz+hXpRSaw0axM8Ex
         lC+0iV0uJuKu1tSimojwsqaUaYK/Ci5C2h9tZDxNlL3m1P3aB2xekQ91IYnZXgMP5WR2
         +0hlJJr0F5xYVtjxQjNN5VJvD2bkr1IH8Z41iOCRcsbF8sY6i5hUm+rC3ZHfqAgUC51h
         Ua+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JFI3+kM1LWruGVLKeVPFO/XZwyOSYT/vDPiEnVdBj2U=;
        b=uTqxPRx3BO+XhdyeEe6mF0Vc6b3r5Re3zmlwr+8drSwJqA7y1EQ3FlLeQupZ6pGj0V
         mcGyK2yficf5RtoZAAStOX2h0E0uO83mPVYTNU1XklGx+5vI3z0ijiD94zD+0zn1EOTf
         sIcOqiPtrJvcUMc6hiT2geV/RxPdkdxu/faHetlulBNwBGL1qCtg9CZfF/XR3A5GwEa7
         jAjQsOdJgCiDuYzDl139nVmpeeVHZngPBJeDJQG8NlCeXxoJPEMfkmMjxdFB0ULX+jKn
         VLxduNQTnhr6x2tEpq1Xxv7EALe51xHK6zJDCl77okO7eIHFkvepEYCqGlSFtKjZh9xc
         uZvg==
X-Gm-Message-State: APjAAAVIAvyWxygHz4zQRMAyremfDqhFNzjKD7VNP2IsLF0+9LRPUdLd
        ZpUmqzaw2uHv/cWoV5e39LZz4MCLIybNnJ271Q==
X-Google-Smtp-Source: APXvYqz+J/xwCfFRMD1shS+tndghawrwzI7Yd0VrboY//9yoBvjkbC42tNq4IbmZInjyjU6RkwV+tCIPByJGmiAtag==
X-Received: by 2002:a63:5443:: with SMTP id e3mr20602878pgm.245.1582094725566;
 Tue, 18 Feb 2020 22:45:25 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:45:19 +0800
Message-Id: <20200219144442.Bluez.v2.1.I145f6c5bbf2437a6f6afc28d3db2b876c034c2d8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v2] bluetooth: fix passkey uninitialized when used
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue cause a warning here
https://groups.google.com/forum/#!topic/clang-built-linux/kyRKCjRsGoU

Signed-off-by: Howard Chung <howardchung@google.com>

---

Changes in v2:
- refactor code

 net/bluetooth/smp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 50e0ac692ec4..929e0bebaf80 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2115,7 +2115,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
-	u8 *pkax, *pkbx, *na, *nb;
+	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
 	u32 passkey;
 	int err;
 
@@ -2179,13 +2179,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		 */
 		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 				 hcon->role)) {
-			err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
-							hcon->type,
-							hcon->dst_type,
-							passkey, 1);
-			if (err)
-				return SMP_UNSPECIFIED;
-			set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+			/* Set passkey to 0. The value can be any number since
+			 * it'll be ignored anyway.
+			 */
+			passkey = 0;
+			confirm_hint = 1;
+			goto confirm;
 		}
 	}
 
@@ -2206,9 +2205,11 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
 	if (err)
 		return SMP_UNSPECIFIED;
+	confirm_hint = 0;
 
+confirm:
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
-					hcon->dst_type, passkey, 0);
+					hcon->dst_type, passkey, confirm_hint);
 	if (err)
 		return SMP_UNSPECIFIED;
 
-- 
2.25.0.265.gbab2e86ba0-goog

