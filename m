Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49477C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE94206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXA0dnkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGJVrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:47:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0BC08C5DC;
        Fri, 10 Jul 2020 14:47:25 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a14so3294100qvq.6;
        Fri, 10 Jul 2020 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4BIXM/X/4TDwBaDfHH2qeLVBAs7PCGQrZDucm3WMQA=;
        b=lXA0dnkhWEzo+ZcE67jH+G1OgotEBlFxSKDTrTSdVqYCG25rP2YQDQjX8ZX2ow1Q1/
         XlzIEgUG9K6iyMLvNZFTuxDS7VSBtmGBdcVsjPM+2I8UX3K5VAsatr9rnxB9FfBvjsJq
         hABIVqaZYYjcKtikl3YtQSstw1Iv512kGKS/L21/Yro9jRmyD8t/OtRiByiwvlFiixgz
         9C1CnWBNmZQfAm3+g2JVCaxPmzfqZIPr2DvRSCA3EonhzUW4Z3W1oS46s/06jAky2TW1
         IH0hvL3WhTD98VFnr3vKykPgI2eZVcLjZz8PgsVx1H7itedHXLhQm2hRbCUkxOqFFFll
         6KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4BIXM/X/4TDwBaDfHH2qeLVBAs7PCGQrZDucm3WMQA=;
        b=UyFu8h6Y7gp8UktsR9xP2HnmBHHEITCOT5ivZ1aFfuvLQg/bQmpDf4KQCisW8kM+KN
         UGrbh42GqOjXrvE0TYku82v9qB/vhTLN8vq7q3RxUYTlBLYEFaNuxQfe5OeXlrVaNDH4
         3izTCPBbYPz38aXUABKBfz4Qyy5KPjU/iWM810WRt8JsRwrYxEJmKglYGGvBbnuDeoK8
         kn6gW1jSQYyDpvL6avbD+8ofxdp3ibj1i7PPi0AqPgFyAvIPCBA9ozIveZeBYoT3bQoC
         clYR5d0hgN/aKGSNiiRPbTTX1ptnkN6oh0CDd0ruV6LW1Gq9flIN+rCg4wP0hEdV4A4w
         n6xg==
X-Gm-Message-State: AOAM532170PK2l+vuyoXpM1AilKWqKowti22fmSXjB1dhOTNYPw9343Q
        1ES3DSVmIg6PQ5eDBcjHKw==
X-Google-Smtp-Source: ABdhPJy+8ouNnOFsAjWlZGUPZPhMenwY4SizL6H6mf4dXiIltgFw3gi7pzw+NnH3gWcRNGhFtiNNMA==
X-Received: by 2002:a0c:f109:: with SMTP id i9mr66510402qvl.154.1594417644040;
        Fri, 10 Jul 2020 14:47:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id p66sm8930426qkf.58.2020.07.10.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 14:47:23 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH 2/2] net/bluetooth: Prevent out-of-bounds read in hci_inquiry_result_with_rssi_evt()
Date:   Fri, 10 Jul 2020 17:45:26 -0400
Message-Id: <82c4e719b7615f5333444bdc2b5cc243a693eeb1.1594414498.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
References: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check `num_rsp` before using it as for-loop counter. Add `unlock` label.

Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b3736c83b8e..f9f4262414b3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4159,6 +4159,9 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
 		info = (void *) (skb->data + 1);
 
+		if (skb->len < num_rsp * sizeof(*info) + 1)
+			goto unlock;
+
 		for (; num_rsp; num_rsp--, info++) {
 			u32 flags;
 
@@ -4180,6 +4183,9 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
 
+		if (skb->len < num_rsp * sizeof(*info) + 1)
+			goto unlock;
+
 		for (; num_rsp; num_rsp--, info++) {
 			u32 flags;
 
@@ -4200,6 +4206,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 		}
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.25.1

