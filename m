Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6380020BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974013;
	bh=HJ/vuluO3Ej1jFBZvEEcc3VyOV2Ph3E3UJEfwVh6Z80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pjW3D+BVSfeD0y0Ues+vArg07pHZ+QoZf8V52hn5Z0CvHPnbc8FWJ7ZhGZVroFsRT
	 o6dRb8ncVnAbcJCglINzSoqdRbHdc/iuylwII6vuHBXfQ+O4CteEEuQABPUQZ2WwtL
	 SxjMWZd2IMgGQ8tTr0F3J0izX9tRDlG21KxBkSRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgIAP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgIAPXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AE2206FA;
        Tue,  1 Sep 2020 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973802;
        bh=HJ/vuluO3Ej1jFBZvEEcc3VyOV2Ph3E3UJEfwVh6Z80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqlebqpBXQ8InraHBBUImJMejs1phoHkzBgbeqXU8j6fQUP7mTFhAFDdDfgvLfEry
         nuABjp18L5wCFdWmd0zCIUK9dEQibMVseo45xex0LQOa4ez3y/X9HppjKgvTKm4h3V
         YrhLeWgbzlKmLzfSS9zAKauFurEx4D5F7Ojf0Bb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/125] Revert "ath10k: fix DMA related firmware crashes on multiple devices"
Date:   Tue,  1 Sep 2020 17:10:07 +0200
Message-Id: <20200901150937.100789081@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhi Chen <zhichen@codeaurora.org>

[ Upstream commit a1769bb68a850508a492e3674ab1e5e479b11254 ]

This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
PCIe hung issue was observed on multiple platforms. The issue was reproduced
when DUT was configured as AP and associated with 50+ STAs.

For QCA9984/QCA9888, the DMA_BURST_SIZE register controls the AXI burst size
of the RD/WR access to the HOST MEM.
0 - No split , RAW read/write transfer size from MAC is put out on bus
    as burst length
1 - Split at 256 byte boundary
2,3 - Reserved

With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
issue happened. It broke PCIe spec and caused PCIe stuck. So revert
the default value from 0 to 1.

Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
         QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
         Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index fac58c3c576a2..3ff65a0a834a2 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -753,7 +753,7 @@ ath10k_rx_desc_get_l3_pad_bytes(struct ath10k_hw_params *hw,
 
 #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
 #define TARGET_10_4_NUM_WDS_ENTRIES		32
-#define TARGET_10_4_DMA_BURST_SIZE		0
+#define TARGET_10_4_DMA_BURST_SIZE		1
 #define TARGET_10_4_MAC_AGGR_DELIM		0
 #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
 #define TARGET_10_4_VOW_CONFIG			0
-- 
2.25.1



