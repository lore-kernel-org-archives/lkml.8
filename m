Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8492C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F4020801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272323;
	bh=vwGKyhXHR/VC6+b9YGNFulZZs4DD0OXFatVpw++SAo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6GMIbuDt1m7cGo5UoU2B+lkKz0mKHPJmj4yYxA2O6f8WIUgjnVcj/vdmWT7nZ8iK
	 YdjZgjMsHTuX/qSejjJQMv2KlR72vh8NYrPFCZ6LX6vFRggn1fBYpxcxv/PNHPhxbP
	 fjs6jwa+f7HYthdr84TRaarkq9sHTjgdvUlhBTgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgBUIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731615AbgBUIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174FC222C4;
        Fri, 21 Feb 2020 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272317;
        bh=vwGKyhXHR/VC6+b9YGNFulZZs4DD0OXFatVpw++SAo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZNDAvL6o2LwDUZa4m/KELyP/RBi/DmKgfMlB8vwaTWoFBGJw81b3A3MaXziA8Zs+
         o6TBLOr4pH5P7I1kE3ea70bCbPdyWXIROLDWqNqo9qgG0ARebix2Q/xFyHizr536De
         gb3Lw1MzbbOd7z7EtExDy9hOrknZdCIBiy8rRHKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/344] ath10k: correct the tlv len of ath10k_wmi_tlv_op_gen_config_pno_start
Date:   Fri, 21 Feb 2020 08:38:15 +0100
Message-Id: <20200221072357.671708900@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <wgong@codeaurora.org>

[ Upstream commit e01cc82c4d1ec3bddcbb7cd991cf5dc0131ed9a1 ]

the tlv len is set to the total len of the wmi cmd, it will trigger
firmware crash, correct the tlv len.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1 and QCA6174
PCIE with firmware WLAN.RM.4.4.1-00110-QCARMSWPZ-1.

Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 4d5d10c010645..eb0c963d9fd51 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3650,6 +3650,7 @@ ath10k_wmi_tlv_op_gen_config_pno_start(struct ath10k *ar,
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
 	__le32 *channel_list;
+	u16 tlv_len;
 	size_t len;
 	void *ptr;
 	u32 i;
@@ -3707,10 +3708,12 @@ ath10k_wmi_tlv_op_gen_config_pno_start(struct ath10k *ar,
 	/* nlo_configured_parameters(nlo_list) */
 	cmd->no_of_ssids = __cpu_to_le32(min_t(u8, pno->uc_networks_count,
 					       WMI_NLO_MAX_SSIDS));
+	tlv_len = __le32_to_cpu(cmd->no_of_ssids) *
+		sizeof(struct nlo_configured_parameters);
 
 	tlv = ptr;
 	tlv->tag = __cpu_to_le16(WMI_TLV_TAG_ARRAY_STRUCT);
-	tlv->len = __cpu_to_le16(len);
+	tlv->len = __cpu_to_le16(tlv_len);
 
 	ptr += sizeof(*tlv);
 	nlo_list = ptr;
-- 
2.20.1



