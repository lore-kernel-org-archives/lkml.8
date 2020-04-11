Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D96C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C120787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoKzjQNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDKBes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:34:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37227 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKBer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:34:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id m16so1221772pls.4;
        Fri, 10 Apr 2020 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBHPPwCq78xfwPO4a6aoSvQF9RjVjmF6Ed9dcBshSdA=;
        b=IoKzjQNfjHm+WfS+8cWjjtPOszNAMydpftTTJ+WeqX/GK1TgHMC40CMLZRFHHW0vPO
         3zmK0cSW0lotU3q26Ng3vEL7FtGw0mIkieTR53J/iG8C1ge7CTUEpImvEGUaj0DKdT4l
         RxpXgd/aArieIQZ5BVJkhC4qoR3g1gVHc+nK3lRFeusXKgZc+BllrSiaC/T8KHLkrXta
         acfhBFUGJ0YJtABRz5qdobQyc3EiImZLdCkZigl9MZMrzp+Od1ebqLoXv4hJg5kSr2le
         aRWKfu0PmFxN56HV1reSabJopufIXhCcaj0tPZbku/qtrpT/AjHdcVJjhgQCuNSFetDY
         4F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBHPPwCq78xfwPO4a6aoSvQF9RjVjmF6Ed9dcBshSdA=;
        b=di3iUPyHh9zCOz0fNKd3ZIoa0bGSX3mOezhwnOOOew3oZEaoy9XHo5rDFrZ8EHp/c+
         o88fOIx87/mJHxBD58p7h11q0QB1qKHCdOWns6UKdcb/I53jQzgCYvWVASBTWzTtIw/1
         nm/015Ao5cJNtSzVKw7eCLq3+JuWnnrJ2wzYDiKF/EjWhDf8c/czk1UvzR2tLs3yu2Uj
         vCNeg6fDGXj6twvxvm+oqrLj9Zwu+Z0vvsm9s3oSlkzXTew0ZiK2JhqdkDIOiilVLivp
         AwLDsweywO9uP35dufqOk4zzoDWDqdnPm+VvPh1Ns707cZ2/MPC4uox7a4RQTVVkAHqb
         SIiA==
X-Gm-Message-State: AGi0Puah8wVjTC1eoZ1PoPuJPN9sgMo2GX/1kC7Ck1GnLmrt5fyhrvMu
        5DhlT1LWzUClehh7ES/4Jx0=
X-Google-Smtp-Source: APiQypI77CljKvDt7/vaFIH1lureibakn9/s2eRumy5dVl7uiVKkCEWQzDFrIpRJ2mkurlPQLEdqhA==
X-Received: by 2002:a17:90a:33c1:: with SMTP id n59mr8206521pjb.4.1586568887058;
        Fri, 10 Apr 2020 18:34:47 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mg20sm2808571pjb.12.2020.04.10.18.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:34:46 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH v3 1/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Sat, 11 Apr 2020 09:34:27 +0800
Message-Id: <20200411013427.152103-2-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200411013427.152103-1-sztsian@gmail.com>
References: <20200411013427.152103-1-sztsian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ziqian SUN (Zamir)" <sztsian@gmail.com>

Add new compatible device RTL8761B. RTL8761B is a USB Bluetooth device,
with support of BLE and BR/EDR. The USB info is

T:  Bus=03 Lev=04 Prnt=04 Port=00 Cnt=01 Dev#= 29 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=8771 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=XXXXXXXXXXXX
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
---

Changes since v2: Add USB info in commit message
Changes since v1: Add the firmware info

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

