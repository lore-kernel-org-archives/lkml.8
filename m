Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A85207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6TrpqGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBRLFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:05:20 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:35708 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:05:20 -0500
Received: by mail-pg1-f202.google.com with SMTP id j29so13735184pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CAoGK0unI+k/xLNKWQdh/lAz4VEEtKso1RLerS+jz98=;
        b=o6TrpqGwRyQGGsIaFlxwYKueoWgUAF4oLyN9Z3JTTL7WDa7Y45dVKy3jvooyfmhZal
         c88Ik7pzARj6rngW3H4f35VaNEbgNOHMBModA1la5bjN7qgpfUN4aYp/5fiY++J8uTX5
         7NzMK7/5IFSWXrCT2gUamB6pnGF0OVVh997QnEhkaXjCL7th7EHVPp2mhIVZg8rvBFIp
         cmm8ei+0ULdDQRGUrxXgd158260yWzyXBxa1HHyYWWYh+WOCMsiBseJkaF5qDjVEKTCj
         7kNb8u00EIQTLAMtbIBMnhnzVvuZ3hT13+X2WYS+FUTAWhj/moREt93bkbfABL/TVgl2
         XpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CAoGK0unI+k/xLNKWQdh/lAz4VEEtKso1RLerS+jz98=;
        b=MbjIqpUnO4x5AnRtSJp9fQ3LFu+ybGs3myPtbZ8S1fpSSDefCv5eL+oamBIuI33/Cx
         7uB73H2yoT5XxKtW2/ohU5TiTbdwWgxDAfD2JdLGLqsy6baDcEbFVmwFme/5mRHc6e1F
         rY0SQZFjwxNYDr1k1lQOFLqQ1Q9KDMHJ+1z/ZjJr552kfGgVzb3tdiswlw+F/1hCPcZx
         zeA0M+UyWigRnDqqVuY22ekrMpQmmqeFj24iHWyQppWR9va6NFZug7Fyx90DH/f7uj3O
         SjkhONZkcLITCfsyaHHVrf2iFzyiSpA3Ze2cly7McCN1RYaF5bAXruEheTs1QKCzcW4v
         GlOA==
X-Gm-Message-State: APjAAAUhEfnyuWcPI38kUl5HhiVy8UiHMa5OW2Sk078Fc4tSee62LPrm
        L6No1Z2ShY0G6xQkNwK3ZeEvP9zsoMHefYlNrQ==
X-Google-Smtp-Source: APXvYqy8QXu88UfVxv1mCeKTOtVGqBAda09uLXAcnx1IfRX/aGLHvD+3P7BIZvf5E9bFI9KyVQXAtyUv9pxhStFRHg==
X-Received: by 2002:a63:6383:: with SMTP id x125mr19783198pgb.409.1582023919543;
 Tue, 18 Feb 2020 03:05:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:05:13 +0800
Message-Id: <20200218190509.Bluez.v1.1.I04681c6e295c27088c0b4ed7bb9b187d1bb4ed19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v1] bluetooth: fix passkey uninitialized when used
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "howardchung@google.com" <howardchung@google.com>,
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

From: "howardchung@google.com" <howardchung@google.com>

This issue cause a warning here
https://groups.google.com/forum/#!topic/clang-built-linux/kyRKCjRsGoU

Signed-off-by: Howard Chung <howardchung@google.com>
---

 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 50e0ac692ec4..fa40de69e487 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2179,10 +2179,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		 */
 		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 				 hcon->role)) {
+			/* Set passkey to 0. The value can be any number since
+			 * it'll be ignored anyway.
+			 */
 			err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 							hcon->type,
-							hcon->dst_type,
-							passkey, 1);
+							hcon->dst_type, 0, 1);
 			if (err)
 				return SMP_UNSPECIFIED;
 			set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
-- 
2.25.0.265.gbab2e86ba0-goog

