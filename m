Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC518206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWeAl/Q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgF3DPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgF3DPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:15:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D92C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 20:15:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so7908859ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 20:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnvoY3haB0lkXFUtpPBEotF++tFsvMyqqAyM4Qg1MaQ=;
        b=XWeAl/Q1DUptQJdejIDggTu9F0H4AtRUlR9s9MxsEwBtXR7JAE3kLeX11fTCj/Dycr
         hNBqrh5b7MRiUYB5pQgEbL71EsKqbhYN8g63BKt1LHdu4lI8vK0prJ1YAISUG7K2RqVS
         hcvNXEbx1VMxIGtqRnzQ+tKyAcStwdn8W3PgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnvoY3haB0lkXFUtpPBEotF++tFsvMyqqAyM4Qg1MaQ=;
        b=NYv9s+Ld2BtB09hR4mO9qr1HZHOM5s2E7NzyexV0/6+Kk58DSsS35qFP8RaSkdXHRE
         jj2NvwJBfiUkK3FbCUD6xQxLol2QziYwO5qeCR79tJwsTTw3MvE2++7CmOgN7myv+0NR
         PI84oy+i/1x7V9oSAaRC6dSwaY2jHKZNIGEknrGMZTYgyDAoq4YFDjC9tRJvT1ohvliD
         Tv9zxMktgTu4sF4lFzzjkq+MPeQKl+rH6KpXPLQItTy5vysyES+N5pEOOgZSj6EIT3oL
         Z2OKOXjId9j9RbjkYfEl+ZZ8+2KP96JJ1jMXKc+A9g882QejkTH9ujZkAd9D1g22cjOa
         7r7g==
X-Gm-Message-State: AOAM532wecyQ23mTwmj+URlPE9WSIif+0fbmCGN2ha9Tfn6RB/F4rlei
        uFkubtaD27G8MJ8aQAhy91EFc95qgsw=
X-Google-Smtp-Source: ABdhPJyCaY4RyJ36oOm/AkJtdEmCYXpSXmi7dv53zIUgI3DXuKN9uF2aD+jKbihSx6VE2FF7bgv16w==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr15417102plq.140.1593486905209;
        Mon, 29 Jun 2020 20:15:05 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id x66sm54166pgb.12.2020.06.29.20.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 20:15:04 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>, pavel@ucw.cz,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
Date:   Mon, 29 Jun 2020 20:15:00 -0700
Message-Id: <20200629201441.v1.1.I162e3c6c4f4d963250c37733c3428329110c5989@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the kernel oops by removing unnecessary background scan
update from hci_adv_monitors_clear() which shouldn't invoke any work
queue.

The following test was performed.
- Run "rmmod btusb" and verify that no kernel oops is triggered.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5577cf9e2c7cd..77615161c7d72 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3005,8 +3005,6 @@ void hci_adv_monitors_clear(struct hci_dev *hdev)
 		hci_free_adv_monitor(monitor);
 
 	idr_destroy(&hdev->adv_monitors_idr);
-
-	hci_update_background_scan(hdev);
 }
 
 void hci_free_adv_monitor(struct adv_monitor *monitor)
-- 
2.26.2

