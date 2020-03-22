Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B74C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2BA20722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0H7tsH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCVUWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:22:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45675 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:22:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9so4951271pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s5N8HPshUSv1/rbRJhRfTwnB6R7SlJsQhsweyy2/B3o=;
        b=l0H7tsH/Vn+KiDgJxXaPPCb/uVoShPRec3BWMEDB1rDNTTCwFZKaCS+OTHgC2DN6PJ
         ExRL03gZITpol+BiIYVLcUcRngJxX2ovHYVvW3fhvA5Tcr8O6ALLXuQyHQUlpiidgNoP
         jmWCsUwWkAvDNM/znLFtofWZvT8DWtjvhueZJ6n33r3BuqYNGx6hx+r/mMqUOhbNOtD7
         uXevKM003q0/I65/0UEIRixtwBjfRwZ7k/rt15Dnv/eOxF7b4/MsEb0lRAUBS1vOxk3U
         HAgDnRSizkNXgS5T82IubjMhkijLq7NqTwJmE1lpo73Brt8kb88cWUjSmjvPu6NUfTku
         Z1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s5N8HPshUSv1/rbRJhRfTwnB6R7SlJsQhsweyy2/B3o=;
        b=URYGAZBw1nuPanJ0cVFPW9rrCDzkl0QVJ9GAnj+Nbd2h3KnTKaZCdXrxu7L7LPQm74
         gHB6flPvDj0ECRIUdT8/Y2fJO1QZiEfDqZBxE+S5e0L/KYNYQ8eNTkGN77Vd9FeXVz/h
         RbYMNh4ewDk4G5fZw1Zpu626voTfZNb95cPArbZUxKhhu2xs7BsC7aDXHkNpY0716f5V
         VCRXb6OF8+7KFBEKOZWmSRiBQP8OefNqmE0m2rGIykzitq3N2F1/tz4KdbjuqeD6UVDr
         KDIRVnrjCdhAQrh6KpGd3wxoB9XzH0NZlshwtP/iSjpfJAvhTtEu9uViCNnsKzXB9WFb
         K8Qg==
X-Gm-Message-State: ANhLgQ2L1vu/F522nAY4ABGqDVWCLiAtbiNnabQUhi09V2bhTIfvyCKn
        PnZPYOX66uQkVRdOY2u2Lp4=
X-Google-Smtp-Source: ADFU+vv2ElqoY0EZxQIvQPOUzpRz1vZd9Pj6WUsg4hB51DO5nYlMaaBIfrawtwA///bT60ef+O/udg==
X-Received: by 2002:a17:90a:9310:: with SMTP id p16mr20966563pjo.24.1584908539286;
        Sun, 22 Mar 2020 13:22:19 -0700 (PDT)
Received: from simran-Inspiron-5558 ([14.139.82.6])
        by smtp.gmail.com with ESMTPSA id z63sm11246027pfb.20.2020.03.22.13.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 13:22:18 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:52:14 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: Remove comparisons to NULL in
 conditionals
Message-ID: <20200322202214.GA9750@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparisons to NULL in conditionals in
drivers/staging/rtl8723bs/core/rtw_ap.c
Issues reported by checkpatch.pl as:
CHECK: Comparison to NULL could be written

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a76e81330756..82b977c07205 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -79,7 +79,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			&tim_ielen,
 			pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
 		);
-		if (p != NULL && tim_ielen > 0) {
+		if (p && tim_ielen > 0) {
 			tim_ielen += 2;
 
 			premainder_ie = p + tim_ielen;
@@ -103,7 +103,7 @@ static void update_BCNTIM(struct adapter *padapter)
 				&tmp_len,
 				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
 			);
-			if (p != NULL)
+			if (p)
 				offset += tmp_len + 2;
 
 			/*  get supported rates len */
@@ -112,7 +112,7 @@ static void update_BCNTIM(struct adapter *padapter)
 				_SUPPORTEDRATES_IE_, &tmp_len,
 				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
 			);
-			if (p !=  NULL)
+			if (p)
 				offset += tmp_len + 2;
 
 			/* DS Parameter Set IE, len =3 */
@@ -1036,7 +1036,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 	}
@@ -1048,7 +1048,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		pbss_network->IELength - _BEACON_IE_OFFSET_
 	);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
 		supportRateNum += ie_len;
 	}
@@ -1136,8 +1136,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			break;
 		}
 
-		if ((p == NULL) || (ie_len == 0))
-				break;
+		if (!p || ie_len == 0)
+			break;
 	}
 
 	/* wmm */
@@ -1165,7 +1165,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				break;
 			}
 
-			if ((p == NULL) || (ie_len == 0))
+			if (!p || ie_len == 0)
 				break;
 		}
 	}
@@ -1296,7 +1296,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
 	if (!psta) {
 		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
-		if (psta == NULL)
+		if (!psta)
 			return _FAIL;
 	}
 
@@ -1453,7 +1453,7 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	}
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1491,12 +1491,12 @@ static int rtw_ap_set_key(
 	/* DBG_871X("%s\n", __func__); */
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -1668,11 +1668,11 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 		&wps_ielen
 	);
 
-	if (pwps_ie == NULL || wps_ielen == 0)
+	if (!pwps_ie || wps_ielen == 0)
 		return;
 
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
-	if (pwps_ie_src == NULL)
+	if (!pwps_ie_src)
 		return;
 
 	wps_offset = (uint)(pwps_ie - ie);
@@ -2322,7 +2322,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	for (i = 0; i < chk_alive_num; i++) {
 		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
 
-		if (psta == NULL) {
+		if (!psta) {
 			DBG_871X(FUNC_ADPT_FMT" sta_info is null\n", FUNC_ADPT_ARG(padapter));
 		} else if (psta->state & _FW_LINKED) {
 			rtw_sta_media_status_rpt(padapter, psta, 1);
-- 
2.17.1

