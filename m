Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA53C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD52073B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvBLdksW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgEXRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:41:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81990C061A0E;
        Sun, 24 May 2020 10:41:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so16229431ljn.2;
        Sun, 24 May 2020 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DJnVhkC0smUm5PBOJDcd8TAmlHR8nF02N00TJklYYQ=;
        b=IvBLdksWxW/9lWBFTdOtkxBKw0ZNRyZcRM5cSzd/Qfzo3v/KNB3EBAVpDzlRIpuSHH
         ejgjQKeWwBm4DXQMwURZFcb/f5wPmXyHOlPv2N/lgcxVx4wm5MDeil6YbyLoq35oPsdL
         DIqhR0vAPFM0NxGWIi6ypdqJ5lky1jIxUzBTYRReYLSI1ET6tnJ99rH3MeaPsgWaPVBg
         +C3MVhgUdCpqbC2TwkY3tC/VXvJzjhYu6KL8hbrBjOhwYeXmPMnXiYXPwYqzfRq9izYi
         p2ZNCeJPdtvo5DJXYE2Jenbc9/VpAeeqc50K3LI9ES4mAlVw1gpT3C7G+KDWovzm/N63
         NDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4DJnVhkC0smUm5PBOJDcd8TAmlHR8nF02N00TJklYYQ=;
        b=BHNeFmU3qcAwjn+I4Rx7hNrzHtrOl0hL3anmx8Nh6kXaJVp+yCB8TrsccZzSOond8p
         H8SCUIDS9XCjTVdsg42UPVGisWwaP73TorItAyQIDIj3VYwCvX790MP5Sr7kMbQtUKZc
         H12BotD0Xtccg64ICAXeG2TBjxnomWQxOYpcilN+mDSdNZDRwFxnYO9PimNtub/2CYTR
         BZ8pCUXhov34NT11kgAECQZXZhOYJ7UDjkm2qipeQ9jeztpSXnwj/RQj46QVYCwgO+JB
         frXQMbJWmbC4DGwsTygnEywyeZksQ8aklvx5kUjLC25sAwwKtGRyBmpk8HikoCb5zzKF
         GyeQ==
X-Gm-Message-State: AOAM5311Elp6N7febNsy24fBMRYtVPbb+JcQqIAJ5XqAg6nDeeYvxVdD
        VZSj86dmTLMimDGiWdP+DHY=
X-Google-Smtp-Source: ABdhPJzZk+yfj1Ja13ec/de2TyVXKMy4/esJqt6+09zYGUJ3TAy8+GjWdPQ8wcmrRk5EmADWUdtzKg==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr10626462ljj.426.1590342086046;
        Sun, 24 May 2020 10:41:26 -0700 (PDT)
Received: from icewind.winter.local ([93.185.31.54])
        by smtp.gmail.com with ESMTPSA id x3sm2957430lji.110.2020.05.24.10.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 10:41:25 -0700 (PDT)
From:   "Azamat H. Hackimov" <azamat.hackimov@gmail.com>
Cc:     azamat.hackimov@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: btbcm: Added 003.006.007, changed 001.003.015
Date:   Sun, 24 May 2020 20:41:29 +0300
Message-Id: <20200524174129.29372-1-azamat.hackimov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new Broadcom device BCM4350C5, changed BCM4354A2 to BCM4356A2.

Based on Broadcom Windows drivers 001.003.015 should be BCM4356A2. I
have user report that firmware name is misplaced
(https://github.com/winterheart/broadcom-bt-firmware/issues/3).

Signed-off-by: Azamat H. Hackimov <azamat.hackimov@gmail.com>
---
 drivers/bluetooth/btbcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index df7a8a22e..1b9743b7f 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -414,11 +414,12 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
 	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
 	{ 0x2126, "BCM4335A0"	},	/* 001.001.038 */
 	{ 0x220e, "BCM20702A1"	},	/* 001.002.014 */
-	{ 0x230f, "BCM4354A2"	},	/* 001.003.015 */
+	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x4106, "BCM4335B0"	},	/* 002.001.006 */
 	{ 0x410e, "BCM20702B0"	},	/* 002.001.014 */
 	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
+	{ 0x6607, "BCM4350C5"	},	/* 003.006.007 */
 	{ }
 };
 
-- 
2.26.2

