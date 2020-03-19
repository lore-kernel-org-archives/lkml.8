Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16EEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB62072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="EAH0hp/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCSGnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:43:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52615 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:43:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so590603pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+ce41gqzm22CFinhLSiCMx2DKeV8K25scp1EFRhKKw=;
        b=EAH0hp/YzZ0Vx4g3oknSGTUeMwX95d+ZF2zis5RDrJWofKUdR7jCmr9F3UI41cFa8y
         hc1EYB0izrbe8GkM+C2rYNh5gTUutq8UUfe4ZukDPfKRBCKchRvx7wbcjJL3RfDYx1t9
         +ChaHcSXgT0Ndz7bEhiR6HYOe/ZHxNi/MT/uJKdO3FETYnijJArGITiW+ncDlo5TsRoo
         Iwl7nUxxKl89ONoO+Mj/N74P/pZiRlTusFfWkXgurYTasrNhRBvVZUtlJULO55e6pWAc
         X6SFTRFqON2doCR5bBwtb4M+Q1xkGJXnq/JL/yQXBdTn2P9Oz5/IU1EfsvCGsm2tTVmS
         XeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+ce41gqzm22CFinhLSiCMx2DKeV8K25scp1EFRhKKw=;
        b=l4rJui3weR1sOk5S1BKYHgnkzDQd2mM9o0D5OYvSQ2VKidxVARSyOBGVgbJj5SKZu+
         /9IN9ketmsO6pn1XvTkqsnrttDkjydaTf0lEzjuhu+gE+H84vklAuovr2p4GR8Qu/H0o
         yy6r2JCuA2oO8+IrH4WKig0d5mkBqcs2wijhc4IG5E8qydscwPs1/qCjV+3snMP4wAY/
         ZaNHfUABr3W3HnFwDsk8F8t36PFXfqUnOJZ7GaH/zQ9+6wdqqxGU/GA9f4dSdTKhMv7Q
         ilnWZc7arP0/Hm3NwP/ISaCeMueg7jBRHT5a/sYHW7oCCR+ulCAKDWnZyjswDtlFabcg
         ZVZw==
X-Gm-Message-State: ANhLgQ3uoLKYgQ8io0uy45ZjPAZYQdwZpLjatvX0lLbBXBUwl8GpqNBr
        +MJBJOeN4koRsTKwzpfL833P5Q==
X-Google-Smtp-Source: ADFU+vvMiNTNJKvodZ7OC0QL8loodVxCZgzt0kLxePaXUFH5k5QafWPyqtXsLXgxDGFI7lDonBoHEw==
X-Received: by 2002:a17:90a:bc01:: with SMTP id w1mr2182430pjr.154.1584600230434;
        Wed, 18 Mar 2020 23:43:50 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-130.HINET-IP.hinet.net. [59.127.47.130])
        by smtp.gmail.com with ESMTPSA id x8sm1098973pfp.135.2020.03.18.23.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 23:43:49 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] rtl8xxxu: Fix sparse warning: cast from restricted __le16
Date:   Thu, 19 Mar 2020 14:43:41 +0800
Message-Id: <20200319064341.49500-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning reported by sparse as:
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:4819:17: sparse: sparse: cast from restricted __le16
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:4892:17: sparse: sparse: cast from restricted __le16

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 54a1a4ea107b..daa6ce14c68b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4816,8 +4816,8 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		rate = tx_rate->hw_value;
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
-		dev_info(dev, "%s: TX rate: %d, pkt size %d\n",
-			 __func__, rate, cpu_to_le16(tx_desc->pkt_size));
+		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
+			 __func__, rate, le16_to_cpu(tx_desc->pkt_size));
 
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
@@ -4889,8 +4889,8 @@ rtl8xxxu_fill_txdesc_v2(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		rate = tx_rate->hw_value;
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_TX)
-		dev_info(dev, "%s: TX rate: %d, pkt size %d\n",
-			 __func__, rate, cpu_to_le16(tx_desc40->pkt_size));
+		dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
+			 __func__, rate, le16_to_cpu(tx_desc40->pkt_size));
 
 	seq_number = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
 
-- 
2.20.1

