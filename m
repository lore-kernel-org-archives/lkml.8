Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EAC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FE520CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8ohPrA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMVaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:30:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33293 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:30:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so805717wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x5+ov4CaVNZaEBNcRsthINHg4Fcgw3j3by4jIhHXUPE=;
        b=T8ohPrA3ZboIa5u4Nl/BlJpMST1God0vPv3q/UzL9Y6wKj/33IyZPOop9L0A0oDIvb
         IzdK0SJGCm8NU5qxlmNTN3JK1Y0Q92UYM7Aqh54HLZYXSU/d4/rFyNhlMinaMBwYHjrt
         EUq/nukFxoCV6lMuwC9GU6ByCLvtdAuxeEVItUEkn9+4HUH98qvZrboQtgDVZX263Wiw
         HJhiWcqTJHSuG7luBi8FJjUeQPTEKqrpFVsJj0/UL0GcfDq//FVwm8A3PZIZ80+kc1kL
         0IZOEDYLrhmWH0phkfDyJ+vyuAzJ09JC3trT1CCg0iCaFhbahmFKNZ8bH+F5HjBGYTmp
         j+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x5+ov4CaVNZaEBNcRsthINHg4Fcgw3j3by4jIhHXUPE=;
        b=DfXQNqOm0vvcdU1D8ApLeREdBBf0bvHIv1SzpbKZfp2yJsNhDTS704WaAgrhW+7/D5
         K1KpPJETokhq86zudbH8UrPpF23a+g/eL8mE51snYLPG3687MMbD0dzdaCWA8lbCOFWA
         hs+HZNB8xddgDMeZRNc8v5wbbxozpDm2TVOxe/x+7zva/dlDN6x0Q/QTUhddbeMcZvRN
         VRXnYbik1Gq+GCklxpCw7ckoT4/eohmzGNclXb2Vg9E+kC7lBgqzQUJh2fZqJx4myT75
         HNRu5EdVkGwSK4FSz71fqMNTPkJoemEftaxsemRF5qGHUcUQ7RAZZyyJ5iT/yxx/FsnC
         5VZg==
X-Gm-Message-State: APjAAAUim7RFuPV+hQyFOGw7maNaPlp+ielagTXpzCp1UYvjQxBHVUBq
        vfHLShcpje05xJ/lcaqYak4=
X-Google-Smtp-Source: APXvYqzysidmxeF3t6al9a/pvcMTwMeqSyDBI10V1/2DEDyws6CBSFoyFe9KpxqsxxlKDAO68qvIpw==
X-Received: by 2002:a1c:6485:: with SMTP id y127mr23185458wmb.11.1578951008958;
        Mon, 13 Jan 2020 13:30:08 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id z187sm16403823wme.16.2020.01.13.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:30:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused parameters from rtw_check_network_type
Date:   Mon, 13 Jan 2020 22:29:39 +0100
Message-Id: <20200113212939.9738-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameters 'ratelen' and 'channel' of function rtw_check_network_type are
unused, remove them. Reduces object file size by 62 bytes.

  text    data     bss     dec     hex filename
398525   12896    4688  416109   6596d drivers/staging/rtl8188eu/r8188eu.o
398463   12896    4688  416047   6592f drivers/staging/rtl8188eu/r8188eu.o

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c        | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/rtl8188eu/include/ieee80211.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 88e42cc1d837..93283c7deec4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -429,7 +429,7 @@ static void update_bmc_sta(struct adapter *padapter)
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
-		network_type = rtw_check_network_type((u8 *)&pcur_network->SupportedRates, supportRateNum, 1);
+		network_type = rtw_check_network_type((u8 *)&pcur_network->SupportedRates);
 
 		memcpy(psta->bssrateset, &pcur_network->SupportedRates, supportRateNum);
 		psta->bssratelen = supportRateNum;
@@ -802,7 +802,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		supportRateNum += ie_len;
 	}
 
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
+	network_type = rtw_check_network_type(supportRate);
 
 	rtw_set_supported_rate(pbss_network->SupportedRates, network_type);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index cc1b5438c04c..1344d369e05d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -98,7 +98,7 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 	return true;
 }
 
-int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
+int rtw_check_network_type(unsigned char *rate)
 {
 	/*  could be pure B, pure G, or B/G */
 	if (rtw_is_cckratesonly_included(rate))
diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index d569fe5ed8e6..75f0ebe0faf5 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -765,7 +765,7 @@ bool rtw_is_cckrates_included(u8 *rate);
 
 bool rtw_is_cckratesonly_included(u8 *rate);
 
-int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
+int rtw_check_network_type(unsigned char *rate);
 
 void rtw_get_bcn_info(struct wlan_network *pnetwork);
 
-- 
2.24.1

