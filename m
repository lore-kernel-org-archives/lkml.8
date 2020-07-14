Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7CE20674
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS6AcdqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGNV1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:27:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448FBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:27:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so7613780plk.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQGQidYI0HuOTJB5SyluznwAshWCGJHDKysMMkUDPn4=;
        b=ZS6AcdqKzLWc3bUzqs3TEDBMIlFYbIkPNHSbBeDM3U/3BJMaKti7q73i7A2usl3gqD
         x/3AhLYZGMSCE2xdZFhfopvEZGLkImAUfTAwlT70/mgJeW7FDYCjQZaaybi6poymMScf
         7DKMmtz1w29yQodxqGxZrD6NYXuSj4hBC7/Klw8numcOagIldTz7zvROVMGgUllyel47
         Tm/Pllyhw2K7y47phPHFf7QL2EIeS+o1+rE6IvgbaRCxotIY3HZjQdDwswWYEzISiAIQ
         Ti34Klj0UhRY3Hu+7O2y88OPqm1nRGurEJI7Qd+IWwLlEYnH9BLqEVPKPPpSgYBv2Ak4
         IDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQGQidYI0HuOTJB5SyluznwAshWCGJHDKysMMkUDPn4=;
        b=KxWIU8zX+cDFhHN+hm53uutAJT4P7gWsum1rhmunIlZufTZ+M7qqL64Tm8L7DYDPFe
         U0ZWPlDN9erGI3b1IBOEsn23IWdtQjqZ6T98HapnIMRmUON9GuSxjdsKRsZPRC0gaST6
         65QPMBuHdVfOxnGdClHiTOtbyna3hbbx80A7LoHDo+qYMUg+kgPNIk5YhHeQoqm9eUzN
         9PxtAB612faoronGKSILr0IRLXuF3pL/u6/knwTvDocf788ta0hfI5ijCs/ESCYU6E4N
         pW1a0Fz0oXFX1DsujZtrTJtMoQOy5KNGQbkt8UHgJ71qoFv0bq0xtXyeEMKrgJ90gkXg
         uFTw==
X-Gm-Message-State: AOAM533pPcDxeUEdR0OzM7SA6BnNIsPa5ktSgH2sqx9/oenlvZiOhExX
        WHDAyEBt0urfsxxV9+DhYlQ=
X-Google-Smtp-Source: ABdhPJwWT1SaRmSOH2iD3vjhVUNof8OdjC75JYNDBceQLWgdCplk5YYEca45LTvYmpfMdRwDlpiolw==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr6678167pjt.120.1594762024854;
        Tue, 14 Jul 2020 14:27:04 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.11.188])
        by smtp.gmail.com with ESMTPSA id np5sm31274pjb.43.2020.07.14.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:27:04 -0700 (PDT)
From:   Arpitha <98.arpi@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        puranjay12@gmail.com, yepeilin.cs@gmail.com
Cc:     Arpitha <98.arpi@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: core: fix coding style issues
Date:   Wed, 15 Jul 2020 02:55:59 +0530
Message-Id: <20200714212559.57584-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing WARNING: Prefer using '"%s...", __func__' to using 'function_name'
in a string in rtw_ioctl_set.c

Signed-off-by: Arpitha <98.arpi@gmail.com>
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

