Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A81AC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D833F205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ+tC554"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgGOO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgGOO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:28:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:28:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so3146863pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBeNhu4r9ct33AD8nCJXuATCP+neQ9VRMXlPD66LODI=;
        b=bJ+tC554X0Z6XqwKuLjItvQCNuXil4sEPt5/kcK+5lquxGsA5DfrMx926ECsIDfxoe
         2fg8PqXxt9DdZ/rhAsVjkO6be9/BOqmLIITSoueABAs8Yd1VFtFV12kaezh/4oQXQzSI
         zsZEEip04dcCec0GwMCWnXXCvju1HDFr3GPnwKKa2P3Wo0LPitr5hEHkJhlqyoac9w4u
         ncKmJbGO/6EjmhaDgGtR7r2dNdVwgYw3qIB4sz4usgkeo9dJO6lrPRPiFKxcTusgDDbq
         TreOYCTOgHker/rRu+jzmdz7kehDXAZgMx3Gjm3JzS7f8ZAZ8BaW8wxk0I8RIYQw0F+I
         zbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBeNhu4r9ct33AD8nCJXuATCP+neQ9VRMXlPD66LODI=;
        b=UBPrO0kQcAx/zgqN/+kNrJgxbWrrIbaMb6gsRu2u7B2qolmcdf2qfIzrXAYMuFos8V
         CEO1ig5fZJmMgboTh9JovPTTQRFvXpeXMxU+2BeehZZI7IE/U3lF2tG/m0fqmZbAuV4/
         MCpN4aQHMnOT1mh9PU1SD3tTuURBHacA3SRf9LDZQ1D+jm6zByN4R4JTKxsZ2B2irUZ4
         Rmn3FX73KRp3wGBScZ6SmXJ9xJOR3DaX9uRfIG5nDy4KunQdHRXffA/WKTQcqg4x1F+O
         +5VrL/vPW17AcC42yem5DIuX+2IADM7SdqT+v/L7ep12VRZPVo4sebsMywVAS9PoYCry
         txlA==
X-Gm-Message-State: AOAM533/RsRuopKHOGeCAdVrOWFafaxjY6ePU4w99VcRM52DfEQiioYn
        QqpbD4zLW+ylWu6SJGJDwRQ=
X-Google-Smtp-Source: ABdhPJx/jqAj8OJkuIeTpRWjFpTG7mKBnmmil4xsrr7Uid+wQiSPt/pDI30z7NJCu4rLwQ8BpHppxg==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr10302117pjb.186.1594823288335;
        Wed, 15 Jul 2020 07:28:08 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.11.188])
        by smtp.gmail.com with ESMTPSA id ji2sm2335989pjb.1.2020.07.15.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:28:07 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        puranjay12@gmail.com, yepeilin.cs@gmail.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: core: fix coding style issues
Date:   Wed, 15 Jul 2020 19:57:10 +0530
Message-Id: <20200715142710.76205-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing WARNING: Prefer using '"%s...", __func__' to using 'function_name'
in a string in rtw_ioctl_set.c

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 9cc77ab4fd6b..fa88e8b2852d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -44,12 +44,12 @@ u8 rtw_do_join(struct adapter *padapter)
 
 		if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 		    pmlmepriv->to_roaming > 0) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("%s: site survey if scanned_queue is empty\n.", __func__));
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
 			if (ret != _SUCCESS) {
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
+				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s: site survey return error\n.", __func__));
 			}
 		} else {
 			pmlmepriv->to_join = false;
@@ -313,7 +313,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
+		 ("+%s: old =%d new =%d fw_state = 0x%08x\n", __func__,
 		  *pold_state, networktype, get_fwstate(pmlmepriv)));
 
 	if (*pold_state != networktype) {
@@ -496,7 +496,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		break;
 	}
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
+		 ("%s:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n", __func__,
 		 wep->KeyLength, wep->KeyIndex, keyid));
 
 	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0],
@@ -507,7 +507,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
+		 ("%s:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n", __func__,
 		 psecuritypriv->dot11DefKey[keyid].skey[0],
 		 psecuritypriv->dot11DefKey[keyid].skey[1],
 		 psecuritypriv->dot11DefKey[keyid].skey[2],
-- 
2.25.1

