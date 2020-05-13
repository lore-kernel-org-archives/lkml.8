Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EBC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C5120714
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iN7ylJiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEMCUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgEMCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:19:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:19:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so7080303pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y23e1WcGS/7zRXLgOmzbHP/L0sZSiIPexTD/XzyCks=;
        b=iN7ylJiSjv8PKHyMFgypEVb1YjwQJf4wJFiDlQmJ5ICYyYFJv+60LNuEIWETpl3Cf4
         SHLjln9qymrA0qTvUIjYOERc3AA3mBSynP4xEN/rfnrwa0ccI5rkkb2EUP9KRZ/sugPs
         /Vz7pMmyPVQwtwGTaI50MI1Xtcjpf3gTttGwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y23e1WcGS/7zRXLgOmzbHP/L0sZSiIPexTD/XzyCks=;
        b=PMwuJmHRQa3GZHClI+ogBAsMvYTJuHwJF/3l4ybZx7fjSeFJs2rIKA4pfqAIVKQipt
         G3pNePUZOA+PnAUfO+0pa2SvcRquE4Y6yfz66NHp1+CWVOTy+ZodNzcXykw6Nb/RbjRF
         /xg3w0tHptFifLhmE5i/71hdRyqghWHU+r0+Z2azXhDrhxBJ+n7SqS/qjHIGJ2ubacMU
         5ZoLqchZUqMx5pyTBVnyVnPF1++1PVRIXSzkeS/69DfP0mRpzcVQOLBwi+vnqOHFbVQV
         tPflMu+0b/hLk7ZnCFHEL+TRiAVAeIcHg+oH5R/666M/7TaifgKyWaJrcfPy0jx3Y+oB
         Tb5Q==
X-Gm-Message-State: AGi0PuZJPFtweajWQmdjHHN9ekIqi8mzeNhaGuMxuDm6jEFgf+ynDrNN
        ViJHl5rVoBj/h1TgsFPseil/y6TpFsY=
X-Google-Smtp-Source: APiQypIGZMF+bReUAlPyPZkyGkptCxIQx2Cnc6lQHTEj/Z5UeI4rP7JeXxIExcBcUOvRRF7LXyNaDw==
X-Received: by 2002:a63:d24a:: with SMTP id t10mr22052326pgi.326.1589336373592;
        Tue, 12 May 2020 19:19:33 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm14170600pja.53.2020.05.12.19.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:19:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/3] Bluetooth: Rename BT_SUSPEND_COMPLETE
Date:   Tue, 12 May 2020 19:19:25 -0700
Message-Id: <20200512191838.1.I14aad9cc7f34b095b49d17e8ff2688707d23ffae@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513021927.115700-1-abhishekpandit@chromium.org>
References: <20200513021927.115700-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed BT_SUSPEND_COMPLETE to BT_SUSPEND_CONFIGURE_WAKE since it sets
up the event filter and whitelist for wake-up.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 2 +-
 net/bluetooth/hci_request.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0c7f3ad766652..869ee2b30a4c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -110,7 +110,7 @@ enum suspend_tasks {
 enum suspended_state {
 	BT_RUNNING = 0,
 	BT_SUSPEND_DISCONNECT,
-	BT_SUSPEND_COMPLETE,
+	BT_SUSPEND_CONFIGURE_WAKE,
 };
 
 struct hci_conn_hash {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 51d3992732762..de1f4e72ec065 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3353,7 +3353,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		/* Only configure whitelist if disconnect succeeded */
 		if (!ret)
 			ret = hci_change_suspend_state(hdev,
-						       BT_SUSPEND_COMPLETE);
+						BT_SUSPEND_CONFIGURE_WAKE);
 	} else if (action == PM_POST_SUSPEND) {
 		ret = hci_change_suspend_state(hdev, BT_RUNNING);
 	}
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3f470f0e432c7..88941a2131c4d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1090,7 +1090,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 				   disconnect_counter);
 			set_bit(SUSPEND_DISCONNECTING, hdev->suspend_tasks);
 		}
-	} else if (next == BT_SUSPEND_COMPLETE) {
+	} else if (next == BT_SUSPEND_CONFIGURE_WAKE) {
 		/* Unpause to take care of updating scanning params */
 		hdev->scanning_paused = false;
 		/* Enable event filter for paired devices */
-- 
2.26.2.645.ge9eca65c58-goog

