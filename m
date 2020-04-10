Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6231C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0502078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW+hm8We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:54:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42469 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgDJOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:54:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id g6so1064437pgs.9;
        Fri, 10 Apr 2020 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6ZrCM4Eyl/wAuS/c58gA5rdORjIAL/RvTPnppGuooA=;
        b=YW+hm8Web9fU7eJsBS+w+/ybDb5tx/EL4mLHxLLIcBf0k6Lrn7/si1GjBga3u1K4T9
         EMAHCpsL4SYvW3Icur0lkRaLxOFqYL64qfoaIzSD++OG2ZFDCQadys3FaUmLT+meTv9t
         TuYbn3LxlOk76vnpPmYAOXtrX0jiW8jkhw4oRZFxi/raFn0vh4u8wBngG5lMVI1dOzpi
         CF7gyH9UvLDg6p8g3GFtKSQJzDUvKX0CukCVv+ppEOhk29D0/4iyO8eYB52sKoCQfFqD
         1pG2Ruy/+UXQHL8hExfDNTfqO9AQKTXRHoulrpr2LPEocmjIeJYGqBgR8BDgtUPAKq9S
         cJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6ZrCM4Eyl/wAuS/c58gA5rdORjIAL/RvTPnppGuooA=;
        b=V2p6EEZpxvmNRaJL2OCCV6p6EGN+vqB/ZiO05LtPP3C34Rc1048WgFfnWuUFQZ2FzZ
         gz67KtzVCTH2yGAQBE/i4SJL/dQ1qdBZne8LW3z4Y22RFyDe6L4RZrWo8VRraK5Yprwb
         ktrbEdCu3cBwZkp4Byo+tpxLb28l9SwGHyVfzCJtLZqtRdtYuScAE4HbrajW3frusy8U
         h/vyy1CINuDRKuYuGtWChWQwo42mtoKsDo3NTUtkiR86Ryr3TJ5QiQ+Sg8ahKfuifzae
         3jtxFFl2nfMGepBFzA2RPVu/aDCzDr+MXNYGaqMNGfobwqgyXd8zZxQt7y35zmDqKtil
         EU8g==
X-Gm-Message-State: AGi0PubZ9jD9KQoh2t91yBayJ2E1K/nLuVc0r2hqEazjKN5tBkxIO/JR
        s1JJWgA9irGK0mggRM3NmAQ=
X-Google-Smtp-Source: APiQypJRXHuMJl6YsUkur4BKjdxQu5xsfYbiMsOCBQuktQQypEkn8B02tAI0CFc4DybaRxy2olUN0A==
X-Received: by 2002:aa7:9150:: with SMTP id 16mr5587175pfi.209.1586530480369;
        Fri, 10 Apr 2020 07:54:40 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v5sm1951230pfn.105.2020.04.10.07.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:54:39 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH v2 1/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Fri, 10 Apr 2020 22:54:20 +0800
Message-Id: <20200410145420.108868-2-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200410145420.108868-1-sztsian@gmail.com>
References: <20200410145420.108868-1-sztsian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ziqian SUN (Zamir)" <sztsian@gmail.com>

Add new compatible device RTL8761B.

Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
---
 drivers/bluetooth/btrtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 67f4bc21e7c5..3a9afc905f24 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -130,12 +130,19 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
 	/* 8761A */
-	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8761A, 0x0,
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
+	/* 8761B */
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8761b_config" },
+
 	/* 8822C with UART interface */
 	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
 			 IC_MATCH_FL_HCIBUS,
@@ -267,6 +274,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8723B, 9 },	/* 8723D */
 		{ RTL_ROM_LMP_8821A, 10 },	/* 8821C */
 		{ RTL_ROM_LMP_8822B, 13 },	/* 8822C */
+		{ RTL_ROM_LMP_8761A, 14 },	/* 8761B */
 	};
 
 	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
-- 
2.25.2

