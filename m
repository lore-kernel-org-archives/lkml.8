Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE9C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447CB20829
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCGB1hi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGRP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGRP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:58:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B1C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:58:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so6722277plt.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1UWpjWdsLNWPlgbdy02tqmEYswuYmQoob6quBB6g04=;
        b=QCGB1hi0YESLSG6rF2XZhgypBDF9IneUM2cGfrQpqcYDNVV9K7SLbWVfXxBg4IRgbW
         ym/Gfby5QUlRO53MnGwyyoqNzGv9jTXHFbFs8f9eiOf3glPygV4Ut9BOyY/0H6cJbQFM
         nlUgd7cvNOFJKpBNP60HyUfRjdv8nQ4YEButGXbsfylTmkLCK+OWMtpvW4Y75Ze1NuSn
         pHk09lKOQsO6FG1JZmJvaAULb46heVk/Kw5HkpChtgG/9ZrogvrBiRt3de+K+OMxQSC3
         /tNnA91swimrnOVKZ1cIXqpiyCkvZv4MJ+fGHPs0JY3oKw7W34sifBakFMTfMi5+e8aF
         SQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1UWpjWdsLNWPlgbdy02tqmEYswuYmQoob6quBB6g04=;
        b=rRTS1eEMHxXFFALb1tDP0WuInl++V+GKeSfD8dhMkoOKmZRDCZMm3G37EE63z8HuTm
         mofiyUqNdiyh6i33hGtIcHD5FMHjNrOW2/hn2NtFKL7UUY6HNspZgvOrMChctSWIpFtD
         SrPN+spvmsG1nYNmEc0La2usKJsk+NWlT32c1cGYlGETOBx3NvkYpBg81dO8GBTA1tnu
         akMMAoT2lLdkfTcvUa3ELuZc/JayXpA83gGqTygMAC8dZR7TbZc9g6RgY5ksFxUdfcg1
         Bhz1IM8HK0AJoDytQX1ICZ7B3Tofq3mDOfD5Y2QoazbCkn1Q7WZLYBvU5dotPGqldIU3
         1r9Q==
X-Gm-Message-State: AOAM532JB0s6R2CawjI1gUXXwO/akp11UnXFVzAxmm2SmeG9lWJteqb2
        KmChSIPDNAtYdsqHKuHgd08=
X-Google-Smtp-Source: ABdhPJwJ0PpQSHUZCXAZkdM2zvR/fLQPIt5NF9WZAzK5BadG8Usgow1YkN8XSCicaj4xZU6M/X811Q==
X-Received: by 2002:a17:90a:1f06:: with SMTP id u6mr15009934pja.33.1595087933448;
        Sat, 18 Jul 2020 08:58:53 -0700 (PDT)
Received: from thinkpad.teksavvy.com ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id bx18sm5837889pjb.49.2020.07.18.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 08:58:52 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Subject: [PATCH] staging: wlan-ng: properly check endpoint types
Date:   Sat, 18 Jul 2020 08:58:36 -0700
Message-Id: <20200718155836.86384-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As syzkaller detected, wlan-ng driver submits bulk urb without checking
that the endpoint type is actually bulk, add usb_urb_ep_type_check()

Reported-and-tested-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index fa1bf8b069fd..7cde60ea68a2 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -339,6 +339,12 @@ static int submit_rx_urb(struct hfa384x *hw, gfp_t memflags)
 
 	hw->rx_urb_skb = skb;
 
+	result = usb_urb_ep_type_check(&hw->rx_urb);
+	if (result) {
+	       netdev_warn(hw->wlandev->netdev, "invalid rx endpoint");
+	       goto cleanup;
+	}
+
 	result = -ENOLINK;
 	if (!hw->wlandev->hwremoved &&
 	    !test_bit(WORK_RX_HALT, &hw->usb_flags)) {
@@ -354,6 +360,7 @@ static int submit_rx_urb(struct hfa384x *hw, gfp_t memflags)
 		}
 	}
 
+cleanup:
 	/* Don't leak memory if anything should go wrong */
 	if (result != 0) {
 		dev_kfree_skb(skb);
@@ -388,6 +395,12 @@ static int submit_tx_urb(struct hfa384x *hw, struct urb *tx_urb, gfp_t memflags)
 	struct net_device *netdev = hw->wlandev->netdev;
 	int result;
 
+	result = usb_urb_ep_type_check(&hw->tx_urb);
+	if (result) {
+	       netdev_warn(hw->wlandev->netdev, "invalid tx endpoint");
+	       goto done;
+	}
+
 	result = -ENOLINK;
 	if (netif_running(netdev)) {
 		if (!hw->wlandev->hwremoved &&
@@ -407,6 +420,7 @@ static int submit_tx_urb(struct hfa384x *hw, struct urb *tx_urb, gfp_t memflags)
 		}
 	}
 
+done:
 	return result;
 }
 
-- 
2.27.0

