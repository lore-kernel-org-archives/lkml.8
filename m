Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3132078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922022;
	bh=JCjjjWbCYvT0bGRkX2Iilrpaa0f75hvq0QdyHN79ywc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cJnvO0NecXqsMRYEnh+I/px6VbFVGEBV3fo1wmzqwrtzObtpDVxu3BrkrX6G7VOwU
	 0Yy7GwNiqw2264M+m5F+9MrcxQtV/4K9UGFO9ilOAJ9jGMfCBqUZCFFnBNdECqGGuC
	 g2eZ5gWqbyBiLwcyFg3+6maWdeijyrisUchuPqcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgHTLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgHTKJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:09:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F9620724;
        Thu, 20 Aug 2020 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918156;
        bh=JCjjjWbCYvT0bGRkX2Iilrpaa0f75hvq0QdyHN79ywc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQlLbiKc88k098lUpm/wLb9SyLHTGgKWf4Fpg9ZqvcMG287Dsd4wHbb92K69I890z
         JfjDgHWnHSlDPKfSyyjZCLyiZDj6foztvEKyPfDZ1nHP6HIgr+82Z2eStW7pnBYcSy
         na5MOQAX1vtpeTdEu/6iHDJg0BlOJVR8y8y6uNM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 072/228] brcmfmac: set state of hanger slot to FREE when flushing PSQ
Date:   Thu, 20 Aug 2020 11:20:47 +0200
Message-Id: <20200820091611.202545237@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

[ Upstream commit fcdd7a875def793c38d7369633af3eba6c7cf089 ]

When USB or SDIO device got abnormal bus disconnection, host driver
tried to clean up the skbs in PSQ and TXQ (The skb's pointer in hanger
slot linked to PSQ and TSQ), so we should set the state of skb hanger slot
to BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb.
In brcmf_fws_bus_txq_cleanup it already sets
BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb, therefore we add the
same thing in brcmf_fws_psq_flush to avoid following warning message.

   [ 1580.012880] ------------   [ cut here ]------------
   [ 1580.017550] WARNING: CPU: 3 PID: 3065 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c:49
brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
   [ 1580.184017] Call Trace:
   [ 1580.186514]  brcmf_fws_cleanup+0x14e/0x190 [brcmfmac]
   [ 1580.191594]  brcmf_fws_del_interface+0x70/0x90 [brcmfmac]
   [ 1580.197029]  brcmf_proto_bcdc_del_if+0xe/0x10 [brcmfmac]
   [ 1580.202418]  brcmf_remove_interface+0x69/0x190 [brcmfmac]
   [ 1580.207888]  brcmf_detach+0x90/0xe0 [brcmfmac]
   [ 1580.212385]  brcmf_usb_disconnect+0x76/0xb0 [brcmfmac]
   [ 1580.217557]  usb_unbind_interface+0x72/0x260
   [ 1580.221857]  device_release_driver_internal+0x141/0x200
   [ 1580.227152]  device_release_driver+0x12/0x20
   [ 1580.231460]  bus_remove_device+0xfd/0x170
   [ 1580.235504]  device_del+0x1d9/0x300
   [ 1580.239041]  usb_disable_device+0x9e/0x270
   [ 1580.243160]  usb_disconnect+0x94/0x270
   [ 1580.246980]  hub_event+0x76d/0x13b0
   [ 1580.250499]  process_one_work+0x144/0x360
   [ 1580.254564]  worker_thread+0x4d/0x3c0
   [ 1580.258247]  kthread+0x109/0x140
   [ 1580.261515]  ? rescuer_thread+0x340/0x340
   [ 1580.265543]  ? kthread_park+0x60/0x60
   [ 1580.269237]  ? SyS_exit_group+0x14/0x20
   [ 1580.273118]  ret_from_fork+0x25/0x30
   [ 1580.300446] ------------   [ cut here ]------------

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200624091608.25154-2-wright.feng@cypress.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 2370060ef980a..0807331284895 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -653,6 +653,7 @@ static inline int brcmf_fws_hanger_poppkt(struct brcmf_fws_hanger *h,
 static void brcmf_fws_psq_flush(struct brcmf_fws_info *fws, struct pktq *q,
 				int ifidx)
 {
+	struct brcmf_fws_hanger_item *hi;
 	bool (*matchfn)(struct sk_buff *, void *) = NULL;
 	struct sk_buff *skb;
 	int prec;
@@ -664,6 +665,9 @@ static void brcmf_fws_psq_flush(struct brcmf_fws_info *fws, struct pktq *q,
 		skb = brcmu_pktq_pdeq_match(q, prec, matchfn, &ifidx);
 		while (skb) {
 			hslot = brcmf_skb_htod_tag_get_field(skb, HSLOT);
+			hi = &fws->hanger.items[hslot];
+			WARN_ON(skb != hi->pkt);
+			hi->state = BRCMF_FWS_HANGER_ITEM_STATE_FREE;
 			brcmf_fws_hanger_poppkt(&fws->hanger, hslot, &skb,
 						true);
 			brcmu_pkt_buf_free_skb(skb);
-- 
2.25.1



