Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41610C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E962146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWmdEhxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCKB0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:26:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:26:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id e16so578021qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP1h4LnU7XtbVr4y3Ipe7IVVDlnx9HE/9oHCfNpi+WM=;
        b=DWmdEhxbRi4c6Wg+y0GATJ62iaarJpImMb/f9vZSKIsSkrBGKKUSaWo1E/dEpqSr/K
         eVKPs/whf8Ze75a9+siOh36sJh2/cE3ZJu/u0VfyUP/ROogSYwfbm5K35GCnm+HYG14J
         6kCCGQfMt/EVaeMu9wBpnsZ1oPcTgUAmaui3r+qq8/YLsaTpHC0XkgLxzVGPaRoydonI
         62wywfcwFrdvhaf6z9Vo6wND3OmZVDITTcEsDRl0OgZBjnzb4dIgthnHwILPpa1GQkj+
         /Ghaeh+KWp5v+irIAlE2EMwtmNNXF2Io8iOHY57H0Fo2Dnocm+yrL0hv7JZjohGRkGJO
         HE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP1h4LnU7XtbVr4y3Ipe7IVVDlnx9HE/9oHCfNpi+WM=;
        b=iehEMHZt/oJKCT9gz1KZxq9liYHXGrNmLkbhOdHVqEOQFzu2ZqD9fFaTTxhDVEzk8T
         l2Dnm/1ir0jM5aFUqkwxljuMbXYVkgJGyxPK6U7H2t8DHjUZnW552itoIbQxfrJJ/L2C
         +IlDgxqwJcwBpKLPRjqwUZRzKkcWN2psI3/F3K4lUdxb3k9e25TsaqsNIimKW2Tc/5af
         cXpaTC4Qzv2M4VEAe1HZQ8mMsnPnqX7xbErDKnC0Ox6hsZ70/fFGTp5k1u4Vy8bUtDwR
         xTvtWLa6B6mSZKKpMm9XwWM9JebdDUzwbKp3jwRsa6WxPGnUq9Lyc/hBet4TnO7svGEV
         zxKw==
X-Gm-Message-State: ANhLgQ2XtOUHBydImvniyVLN73uH8IXGhxq2dQcnn+VNnYMTBBkgQLa6
        yXobJI4zY8eI6UsR4gbweZo+Ahre/ByoLg==
X-Google-Smtp-Source: ADFU+vvmeAaY55VzzyTgfMyK56hvzzpG+chCK2Qehp/bdiWtE7hHp88BWGBXhRLtPCdJTnqEdHMMbg==
X-Received: by 2002:a37:702:: with SMTP id 2mr626759qkh.134.1583889958494;
        Tue, 10 Mar 2020 18:25:58 -0700 (PDT)
Received: from 2158e4caaa32.ic.unicamp.br (wifi-177-220-84-104.wifi.ic.unicamp.br. [177.220.84.104])
        by smtp.gmail.com with ESMTPSA id i66sm4618730qkc.13.2020.03.10.18.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 18:25:57 -0700 (PDT)
From:   Thiago Souza Ferreira <thsouza2013@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8188eu: Fix block comments to use *
Date:   Wed, 11 Mar 2020 01:23:32 +0000
Message-Id: <20200311012332.27498-1-thsouza2013@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "Block comments use * on subsequent lines" warning of
rtw_mlme_ext.c, found by checkpatch.pl script

Signed-off-by: Thiago Souza Ferreira <thsouza2013@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 69 ++++++++++---------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 36841d20c..02b87a804 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -20,8 +20,8 @@
 static u8 null_addr[ETH_ALEN] = {};
 
 /**************************************************
-OUI definitions for the vendor specific IE
-***************************************************/
+ *OUI definitions for the vendor specific IE
+ ***************************************************/
 const u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 const u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
 static const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
@@ -33,16 +33,16 @@ const u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 const u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 
 /********************************************************
-MCS rate definitions
-*********************************************************/
+ *MCS rate definitions
+ *********************************************************/
 const u8 MCS_rate_1R[16] = {
 	0xff, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
 /********************************************************
-ChannelPlan definitions
-*********************************************************/
+ *ChannelPlan definitions
+ *********************************************************/
 static struct rt_channel_plan_2g RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x00, RT_CHANNEL_DOMAIN_2G_WORLD , Passive scan CH 12, 13 */
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13},		/*  0x01, RT_CHANNEL_DOMAIN_2G_ETSI1 */
@@ -173,10 +173,10 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 }
 
 /****************************************************************************
-
-Following are some TX functions for WiFi MLME
-
-*****************************************************************************/
+ *
+ * Following are some TX functions for WiFi MLME
+ *
+ *****************************************************************************/
 
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 {
@@ -1895,10 +1895,10 @@ unsigned int send_beacon(struct adapter *padapter)
 }
 
 /****************************************************************************
-
-Following are some utility functions for WiFi MLME
-
-*****************************************************************************/
+ *
+ *Following are some utility functions for WiFi MLME
+ *
+ *****************************************************************************/
 
 static void site_survey(struct adapter *padapter)
 {
@@ -2497,10 +2497,11 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 }
 
 /****************************************************************************
-
-Following are the callback functions for each subtype of the management frames
-
-*****************************************************************************/
+ *
+ * Following are the callback functions for each subtype of the management
+ * frames
+ *
+ *****************************************************************************/
 
 static unsigned int OnProbeReq(struct adapter *padapter,
 			       struct recv_frame *precv_frame)
@@ -3822,10 +3823,10 @@ static unsigned int OnAction(struct adapter *padapter,
 }
 
 /****************************************************************************
-
-Following are the initialization functions for WiFi MLME
-
-*****************************************************************************/
+ *
+ * Following are the initialization functions for WiFi MLME
+ *
+ *****************************************************************************/
 
 static struct mlme_handler mlme_sta_tbl[] = {
 	{WIFI_ASSOCREQ,	  "OnAssocReq",	  &OnAssocReq},
@@ -4151,10 +4152,10 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 }
 
 /****************************************************************************
-
-Following are the functions to report events
-
-*****************************************************************************/
+ *
+ * Following are the functions to report events
+ *
+ *****************************************************************************/
 
 void report_survey_event(struct adapter *padapter,
 			 struct recv_frame *precv_frame)
@@ -4405,10 +4406,10 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 }
 
 /****************************************************************************
-
-Following are the event callback functions
-
-*****************************************************************************/
+ *
+ * Following are the event callback functions
+ *
+ *****************************************************************************/
 
 /* for sta/adhoc mode */
 void update_sta_info(struct adapter *padapter, struct sta_info *psta)
@@ -4599,10 +4600,10 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 }
 
 /****************************************************************************
-
-Following are the functions for the timer handlers
-
-*****************************************************************************/
+ *
+ * Following are the functions for the timer handlers
+ *
+ *****************************************************************************/
 
 static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 {
-- 
2.20.1

