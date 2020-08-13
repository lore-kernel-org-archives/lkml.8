Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C1FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F64720771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGTZCgTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:54:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:54:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so4232899wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KD/rbm7MY6kHb9nm3mJZXOBpnLCJZBDrUMTQS2ogXNo=;
        b=HGTZCgTnh/Xm79AQsi1grOBtUXPhiTGZ5UBuBe/Cr01repvPDz3V5I7evnyPrWH4k+
         4VP2upEEDoQeglntdtBDAOWuU//18as8TfAoXG7upQ9booY5Kdbin2KOdoEBBKHlrgWh
         aoz93cilaXlzMOWezyA+ugdJzCpNEeNmfhGirYOPIfkDWM61nAlPwODPv+SjXSv4g8xb
         43wQKV8NICSKH1tbr2ZnyCNhGSgFr3GpDaFzVNKEOYcBY2KtY2buEs7l/t7AkJ62BQbG
         42U0VZOXCnjjJPyu8sDtptNcNQjVxgoPjEEvQWirI3fUcMYM1Iiwtb938n2TerwTUiT7
         v97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KD/rbm7MY6kHb9nm3mJZXOBpnLCJZBDrUMTQS2ogXNo=;
        b=rbiYR39Vog/dJdFBInvVS/oIvjJV3+T+wRUCFG7YDP0tfxwqPGpE32oHgM0stpZzIU
         JoRb9XCN7LbZkfrqEbIyZGUvXGekzc76T9gy2peFtNhcEFNftJIuAyFc+YLu6Z+AoA2o
         nqIZGJ9RTB9R2t1+qUURt1tbegLVwOrLDKmzyBEKSgV1mjiHORzg/wqXUWX0PXIHGRWq
         UMdf/8Chtmxl5Rmm+ebj/I43JJYFM8naDjSyCya5EGwVma0M2Z0njTLsPul0c4sh1Cv0
         YrlIcn+0Gu4w2KVNzRxUlK2FEXZOnZymwcF8HoXjgtvJN7mA6J4xQxj6NGzYpfqGES6V
         ayJA==
X-Gm-Message-State: AOAM533T+3aO42FAkah9Lc6VoN/MVG6+LlObfOp8e73AtFleFrTY9KhM
        R04jYZ9xevgbBlnIoSxlGIs=
X-Google-Smtp-Source: ABdhPJwoKnFqQ8fy0U4Xkg9vWZT6x1KbB6FO+761njEBiFucLEpvGnW4oiq83wPuPf6qVFQRs+jWGQ==
X-Received: by 2002:a5d:6541:: with SMTP id z1mr2414825wrv.320.1597301651052;
        Wed, 12 Aug 2020 23:54:11 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-140-180.002.204.pools.vodafone-ip.de. [2.204.140.180])
        by smtp.gmail.com with ESMTPSA id b123sm8080511wme.20.2020.08.12.23.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:54:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove 5 GHz code
Date:   Thu, 13 Aug 2020 08:50:53 +0200
Message-Id: <20200813065053.13883-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the TODO 5 GHz code should be removed.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Remove code for channels > 14 from rtw_get_center_ch().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a3ea7ce3e12e..a5790a648a5b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -374,20 +374,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset)
 	u8 center_ch = channel;
 
 	if (chnl_bw == CHANNEL_WIDTH_80) {
-		if ((channel == 36) || (channel == 40) || (channel == 44) || (channel == 48))
-			center_ch = 42;
-		if ((channel == 52) || (channel == 56) || (channel == 60) || (channel == 64))
-			center_ch = 58;
-		if ((channel == 100) || (channel == 104) || (channel == 108) || (channel == 112))
-			center_ch = 106;
-		if ((channel == 116) || (channel == 120) || (channel == 124) || (channel == 128))
-			center_ch = 122;
-		if ((channel == 132) || (channel == 136) || (channel == 140) || (channel == 144))
-			center_ch = 138;
-		if ((channel == 149) || (channel == 153) || (channel == 157) || (channel == 161))
-			center_ch = 155;
-		else if (channel <= 14)
-			center_ch = 7;
+		center_ch = 7;
 	} else if (chnl_bw == CHANNEL_WIDTH_40) {
 		if (chnl_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			center_ch = channel + 2;
-- 
2.28.0

