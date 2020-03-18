Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC5DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100D2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="etWxABcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCRI1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:27:16 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36552 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCRI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:27:14 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so881520pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz7OMO0V/9gwDQsyrVVJj38Jk+MVAm8kgbfcul1v0lY=;
        b=etWxABcQQBRhpZIfQEpTNqzTqtzyDg8w+T9b824roKZQN/UqL6N/gCA17IOuTeE6J2
         qtmH6Zm7O7h3N9L9ZqZzSVwD+zpw1LHci1QRQAxiRzVjGlSvNKpu+ArsFW3O+KXblh04
         rzvvw4ca64rAPy7nBlQ0MOpURPhTaGar/uYS+DxoTtXyD/zDuEl3vEFkvVlHUE/UQ4/4
         W5jV64HSQ886VQJbZsd5GZ5mx2YI2P/4TjrGbK3fjBy5e4dchbOY3sVdKq1nITnzIRVP
         DPliOYOf1V6PfhUP2ujH86VpMOcoYwDJmXFfD8YYfzAVPEFYG6f5wAvMihIVTFR6cgM4
         YWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz7OMO0V/9gwDQsyrVVJj38Jk+MVAm8kgbfcul1v0lY=;
        b=d+ZA8NPKdumphVs7RBMn0XIHjlYDDnz59jMuigiPYm1Z3GHliDRNUm72v0R203+TSD
         g5n+7HNAtiBasFm3nO6irFLs8gJuYG97Ck6HCE4yeh1w1fX8mhLojGq5znCZTM227004
         lr3FPglvgEcLvt6g72vNUSE92NhgJZiKdYlOAfFZRvi/XWjQYvNTIU7aHu9L0h0rzI5X
         LbejDIX4mnit9tie5dAHEKwUnId1W4NO58oM3BiT1/1dyZUvoq+UnZYZeZzYPAyjeJgI
         ohND8MEL+MHfalmvJbMIR4bdFQ/mOQWTyMCv59yj33qlwAbupu1JyEVYVZTAd5Cq8tD/
         iW3w==
X-Gm-Message-State: ANhLgQ2aMzH5hKcy+PkVCR6ZxWLFPYZaYgK6RTTq4KRsRPXt9B0grOZ4
        lA17BiM5r8GWsTpvtNsGB2TZcQ==
X-Google-Smtp-Source: ADFU+vtln86LHcgYuQ6icKMWjY8Hj+LSNv+iEJI7dLh4orE2kJf17XDSIkHPUhy1QcKRtyCZcwwo1A==
X-Received: by 2002:a17:90a:26ed:: with SMTP id m100mr3494583pje.130.1584520031740;
        Wed, 18 Mar 2020 01:27:11 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id 18sm5492148pfj.140.2020.03.18.01.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:27:11 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH 1/2] rtl8xxxu: add enumeration for channel bandwidth
Date:   Wed, 18 Mar 2020 16:26:59 +0800
Message-Id: <20200318082700.71875-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200318082700.71875-1-chiu@endlessm.com>
References: <20200318082700.71875-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a data field in H2C and C2H commands which is used to
carry channel bandwidth information. Add enumeration to make it
more descriptive in code.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 6598c8d786ea..86d1d50511a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1133,6 +1133,15 @@ enum bt_mp_oper_opcode_8723b {
 	BT_MP_OP_ENABLE_CFO_TRACKING = 0x24,
 };
 
+enum rtl8xxxu_bw_mode {
+	RTL8XXXU_CHANNEL_WIDTH_20 = 0,
+	RTL8XXXU_CHANNEL_WIDTH_40 = 1,
+	RTL8XXXU_CHANNEL_WIDTH_80 = 2,
+	RTL8XXXU_CHANNEL_WIDTH_160 = 3,
+	RTL8XXXU_CHANNEL_WIDTH_80_80 = 4,
+	RTL8XXXU_CHANNEL_WIDTH_MAX = 5,
+};
+
 struct rtl8723bu_c2h {
 	u8 id;
 	u8 seq;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 54a1a4ea107b..511a3b4ed72a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4328,7 +4328,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 				    u32 ramask, u8 rateid, int sgi)
 {
 	struct h2c_cmd h2c;
-	u8 bw = 0;
+	u8 bw = RTL8XXXU_CHANNEL_WIDTH_20;
 
 	memset(&h2c, 0, sizeof(struct h2c_cmd));
 
-- 
2.20.1

