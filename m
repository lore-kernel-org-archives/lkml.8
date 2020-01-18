Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE4C33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0034B246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Hnlsch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgARRe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:34:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35013 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgARRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:34:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so10696283wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I237oRzQZW6pSxKw4uz6Ghsrv3dWFefWLoL7gL1txsQ=;
        b=I0HnlschLb5ZG+4STXswQSIroh9sv+wLrWGhsHnCrAGXM1GOdxH18g+8yfwGo64bir
         F+eT01YcZ4qwQjoXAHcYgmloDO8ixl5vz9JqRUn15/g9Xy/OyclPuwLUN250ghmL8ssW
         a/MM7Lsn7pK8STcyBvqkY8CN4DFlLWsnuUHfp3+C6QhcPy07fpm4s+gzgl34lITD3U3G
         wPLTjDRfWzF8JUTX+/UrTvdqQ5bAvKXyNgnDESrIvp5z/7hcza8BOohV0plRQcwS8FKS
         EV+Xbf1E4shNlsbrZTZACEe95wtMovQIqEf3iuvkA+JXJcE656vVjIkBaYE4Pm0dWJ3V
         uWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I237oRzQZW6pSxKw4uz6Ghsrv3dWFefWLoL7gL1txsQ=;
        b=TIj74+GkZ4b0fLBMrc6K3Gm0/73eQs07Kv7CI9/9L1jk3VSZ0+PmqQFqjLyxz0CSND
         r6332nEBE72nWiy+S2L9brafEzE0BFY8Yu7BoFUftfZ0CGHNuVA5bY2MEy9QyP4wsogp
         zqh5iljd0v4PlW4OTRFNinoFpfo2gMutTMrjmJjK0XA7osJi3iNpMdsJ8qvTBvnxGTu9
         0e1DLvVcWl1GU+5OZMalJ28rmmHyrgImbkwOgHOF6RWHBnNTZeiVrwydsuynDl3lrd16
         NFSUYxQZDugZZbb71pwPwdqDkAA0usZGzCl333yUcDBRinHHr2tHe7Se58Jt8IhZ7dv4
         IaaQ==
X-Gm-Message-State: APjAAAXKKgqmvDPbf2N7T2NGIQKj+D0BMUPLM0UEmHUuNz8uAYbCnT4F
        qtMjjYbAtcQS01/ncc2Ayhg=
X-Google-Smtp-Source: APXvYqxr9wPzL93uiKfWaJTkPYys0Gazc9dYcJ6Zi5NDH6u0cFGamevl7idtd59ZjB24Xpik3fRT0g==
X-Received: by 2002:a05:600c:2c01:: with SMTP id q1mr10508095wmg.179.1579368866070;
        Sat, 18 Jan 2020 09:34:26 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-199.002.204.pools.vodafone-ip.de. [2.204.143.199])
        by smtp.gmail.com with ESMTPSA id q11sm39884347wrp.24.2020.01.18.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:34:25 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove unused enum and defines
Date:   Sat, 18 Jan 2020 18:33:43 +0100
Message-Id: <20200118173343.32405-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118173343.32405-1-straube.linux@gmail.com>
References: <20200118173343.32405-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IQK_BB_REG_NUM_MAX, RTL8711_RF_MAX_SENS, RTL8711_RF_DEF_SENS,
NUM_REGULATORYS and enum _RTL8712_RF_MIMO_CONFIG_ are not used
in the driver code, remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/odm.h    |  1 -
 drivers/staging/rtl8188eu/include/rtw_rf.h | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index 8245cea2feef..9d39fe13626a 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -239,7 +239,6 @@ struct odm_rate_adapt {
 
 #define IQK_MAC_REG_NUM		4
 #define IQK_ADDA_REG_NUM	16
-#define IQK_BB_REG_NUM_MAX	10
 #define IQK_BB_REG_NUM		9
 #define HP_THERMAL_NUM		8
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_rf.h b/drivers/staging/rtl8188eu/include/rtw_rf.h
index b5dfb226f32a..c3847cf16ec1 100644
--- a/drivers/staging/rtl8188eu/include/rtw_rf.h
+++ b/drivers/staging/rtl8188eu/include/rtw_rf.h
@@ -19,9 +19,6 @@
 #define SHORT_SLOT_TIME			9
 #define NON_SHORT_SLOT_TIME		20
 
-#define RTL8711_RF_MAX_SENS		6
-#define RTL8711_RF_DEF_SENS		4
-
 /*  We now define the following channels as the max channels in each
  * channel plan.
  */
@@ -30,8 +27,6 @@
 #define	MAX_CHANNEL_NUM_2G		14
 #define	MAX_CHANNEL_NUM			14	/* 2.4 GHz only */
 
-#define NUM_REGULATORYS	1
-
 /* Country codes */
 #define USA				0x555320
 #define EUROPE				0x1 /* temp, should be provided later */
@@ -74,17 +69,6 @@ enum	_REG_PREAMBLE_MODE {
 	PREAMBLE_SHORT	= 3,
 };
 
-enum _RTL8712_RF_MIMO_CONFIG_ {
-	RTL8712_RFCONFIG_1T = 0x10,
-	RTL8712_RFCONFIG_2T = 0x20,
-	RTL8712_RFCONFIG_1R = 0x01,
-	RTL8712_RFCONFIG_2R = 0x02,
-	RTL8712_RFCONFIG_1T1R = 0x11,
-	RTL8712_RFCONFIG_1T2R = 0x12,
-	RTL8712_RFCONFIG_TURBO = 0x92,
-	RTL8712_RFCONFIG_2T2R = 0x22
-};
-
 enum rf90_radio_path {
 	RF90_PATH_A = 0,		/* Radio Path A */
 	RF90_PATH_B = 1,		/* Radio Path B */
-- 
2.24.1

