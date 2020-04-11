Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5616AC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D7420CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646765;
	bh=TDMmE3HA7P262dLCJay7eV/fPrKmEXSAMyUMQ6LXYKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjj78gfZhoFDZF8kcLFY/kTy0xOTmYcE5xOpwyfWwRJ1Tl5puLRuiEnShicJJ8Ytw
	 tL3RkNfj/YHgBVhE9ICU1Z7d/7oZ0p7tOcuWDGP+ZiI6XXrtFwZWmoT9ZPRHWBs5A6
	 H9DiuQhHXH9g0nMTMRE17DLxTZhfDSZgMKrINcEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgDKXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgDKXMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:12:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B979920787;
        Sat, 11 Apr 2020 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646745;
        bh=TDMmE3HA7P262dLCJay7eV/fPrKmEXSAMyUMQ6LXYKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcXaqYBolIdhjh64rhcgRGL8yzq12KutWgM6N85k6I8RcUMhYizYlYssUprzd1+U+
         EmvzZ8N38F07sVTXTAlaR/4UPw2YQYtEU23oQdNmDRiD4Phr+tvpsYwUwZhghuAvGY
         Vmtl5Z26uaLEmu0CkqO7mqlpTqAxw1w9KrtsdJAU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/66] Bluetooth: Fix calculation of SCO handle for packet processing
Date:   Sat, 11 Apr 2020 19:11:15 -0400
Message-Id: <20200411231203.25933-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit debdedf2eb5a2d9777cabff40900772be13cd9f9 ]

When processing SCO packets, the handle is wrongly assumed as 16-bit
value. The actual size is 12-bits and the other 4-bits are used for
packet flags.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e03faca84919e..99c2685b6c89d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4190,13 +4190,16 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr = (void *) skb->data;
 	struct hci_conn *conn;
-	__u16 handle;
+	__u16 handle, flags;
 
 	skb_pull(skb, HCI_SCO_HDR_SIZE);
 
 	handle = __le16_to_cpu(hdr->handle);
+	flags  = hci_flags(handle);
+	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x", hdev->name, skb->len, handle);
+	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
+	       handle, flags);
 
 	hdev->stat.sco_rx++;
 
-- 
2.20.1

