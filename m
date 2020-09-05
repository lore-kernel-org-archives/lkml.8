Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A316C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69112073B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWYdNE+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgIEL5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIEL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 07:57:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1ECC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 04:57:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so9168037wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4aoGFxNszSIUAcbHGuDlBMtXkOLa4x8B3iFVhhfOO8=;
        b=PWYdNE+NkrEnk5G1ea8IxtZb2eUKVlxu/lz5HtaK6VGQ7XedtklWR1ea0nIVkQIaPM
         4nRCXWrLS3/WiTXWVTSaT8RSJ5Y8iGZBJ3/MMAEWWiYBPaD1xzUTVJLCH/DAOklkWInV
         Qi/4qUzTUGaf3qV2Hmgg1ITFXec5HtwSQZ8kMw8gG01Qu37MTCmVmpaDEcj3YEi7k/F7
         pBMCj7iMRWIM499k83tzUx25OCJeItKjcqMop8Ti3l0VcqNlDLa3uoJFjAwIEEIe5SeU
         FzvU+7RclG0DUCKU/o5jzl9lnEcaYFj5LywYo7zRq+oAmmxkBfd5QMxnQPaBZ+JVMUAO
         5HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4aoGFxNszSIUAcbHGuDlBMtXkOLa4x8B3iFVhhfOO8=;
        b=EBesO0w8HHoE76Kb8lCqFBvWBRInqYWfNALkFrXn7VJIju0hREU9myoXb+W5AelRgK
         yBwDffOAvUTD6N3ijiNeAYs0o7TESOAdu2ZePEWkkkXBDyt2ggW71hYfEc8FfGB9PQFc
         /ENkSu5FAmeBaJCQAAwn2BydiR2N4z1hm/D216VKXTE4XaMOiUXf3k5wpNK8IkNI+xP5
         JrCg9FZ68YNn8mJFo/fHFIMsj0AeqCQy4dtPBnBbCDzAAMf0qV16B0ljR2DH6ROywF4A
         aCUUJ2uRLZS4Diu0IA/Xm7ypesiM+yg/geZHba2h0XdqPaC2wkGHXNyovcw0mr8O2aJr
         uz3g==
X-Gm-Message-State: AOAM530DCsOgr8id9Kf5xY0votQcD/zu9Fse1QvyT1wlNv4zNu0SwP+t
        xw/k4ny+tfOJslSAGSAQQtg=
X-Google-Smtp-Source: ABdhPJwsEVFfVGJILIA8cv1wnvjyfLmYey8Y0tyNh5XX02jhX04pVWvRybUxGEDN8UiM6HgvS7hiCQ==
X-Received: by 2002:a7b:c44b:: with SMTP id l11mr11789966wmi.52.1599307052463;
        Sat, 05 Sep 2020 04:57:32 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-123.092.219.pools.vodafone-ip.de. [92.219.207.123])
        by smtp.gmail.com with ESMTPSA id 124sm17517159wmd.31.2020.09.05.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:57:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: clean up whitespace in wpa_set_encryption()
Date:   Sat,  5 Sep 2020 13:53:58 +0200
Message-Id: <20200905115358.10278-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unnecessary whitespace in wpa_set_encryption() by removing
extra spaces and replacing tabs with spaces. Clears a checkpatch error.

ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index dbcfdd7cae32..77ecf4fe8382 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -343,9 +343,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 {
 	int ret = 0;
 	u32 wep_key_idx, wep_key_len, wep_total_len;
-	struct ndis_802_11_wep	 *pwep = NULL;
+	struct ndis_802_11_wep *pwep = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
 	param->u.crypt.err = 0;
@@ -437,11 +437,11 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					psta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled))
+				    (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption3Enabled))
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 
 				if (param->u.crypt.set_tx == 1) { /* pairwise key */
-					memcpy(psta->dot118021x_UncstKey.skey,  param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
+					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
 						memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
@@ -453,7 +453,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 					rtw_setstakey_cmd(padapter, (unsigned char *)psta, true);
 				} else { /* group key */
-					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey,  param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16 ));
+					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
 					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 					padapter->securitypriv.binstallGrpkey = true;
@@ -473,7 +473,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					pbcmc_sta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled))
+				    (padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption3Enabled))
 					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 			}
 		}
-- 
2.28.0

