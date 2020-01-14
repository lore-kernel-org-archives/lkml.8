Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0BA24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVaDdHHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgANNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36653 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgANNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so12233529wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3X91y0YKtpUefKBm5V1gWMHQT+xVCGqO4GixzAymWQ=;
        b=SVaDdHHmNlwwRRAVfaT035wYU03VxGPN9Ht8Fv97RRkc7k3TWKgA0MsGC6PHFLUa9Q
         R9hIL8sjzGh1SIRcHqyKVBxkkGrZ8f6I8aiYWwyt6zxpEnlK8NCiu1kIiDhiQiyougQc
         i4dY6eRx8NGY3LH9k99/KHn7F8oG7dQsJ8Ut3CJGOb9hrOTf+7Fuo6UefWJPSkwribI2
         tNQuOgFRFuNVt8g8QBYdfqCz+qZpHwOtUp7vzJWL275o68ejAv0a9d8fXBcHzrE0h4Ds
         GFM6b5aHMnZOB78LJQdviwKqPiwZBJoiZ2x/9A/MIMsYKAfBbM7X4FwPYyQ/JTdo1STf
         sdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3X91y0YKtpUefKBm5V1gWMHQT+xVCGqO4GixzAymWQ=;
        b=sOQd29vct+3priVYxaetHbem0D0wcYG7UDJvT0Kt1iDnNva0Hmm4+IcH6upYDb304v
         yYSEOUFj5eT+efZ9Bs/OIkSj5gHomfRvah6z5UFGtd4q/nR3xQhN3TjRy+3AiZFIYMiB
         kng6cXcMur3I867pRGQxBEpzwT0maVCo2gdLY9AmxxKJlWRdYWcFOkeVS2rFI6km1HQv
         XPgMWmZFnlcX9SrtlTrVYY9GpIPeJgTTKTPR7vEiWigithnquyLB/SP1Nxhc6tnbqT7U
         tFexgLA9QrJFrfLk2y9eY4EFjs31yWOpablFU1Ph/kGwU4ZjL1yrBxqsaDHUFmN/kePm
         Jjcg==
X-Gm-Message-State: APjAAAWn41eaFDHh2FhUn2LFuk9M5phiQUMomlpE3FQVjvNjjgGHnVTH
        LkxfkodkzN5tlsVSydttePE=
X-Google-Smtp-Source: APXvYqx5a25T1uCgc/icHMS0apRgqIDzxT6d3HRuVADKN3fgIRpLjyzKHMlFZxYKAE6M/tm+lJvWsw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr25110475wrs.159.1579009506901;
        Tue, 14 Jan 2020 05:45:06 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id x10sm19361333wrp.58.2020.01.14.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:45:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8188eu: remove unnecessary parentheses in rtl8188e_dm.c
Date:   Tue, 14 Jan 2020 14:44:21 +0100
Message-Id: <20200114134422.13598-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114134422.13598-1-straube.linux@gmail.com>
References: <20200114134422.13598-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 36255199633a..5348db2725a1 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -36,7 +36,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = Adapter->HalData;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
-	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
 	/*  Init Value */
 	memset(dm_odm, 0, sizeof(*dm_odm));
@@ -71,7 +71,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct hal_data_8188e *hal_data = Adapter->HalData;
-	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	int i;
 
@@ -124,7 +124,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 void rtl8188e_InitHalDm(struct adapter *Adapter)
 {
 	struct dm_priv	*pdmpriv = &Adapter->HalData->dmpriv;
-	struct odm_dm_struct *dm_odm = &(Adapter->HalData->odmpriv);
+	struct odm_dm_struct *dm_odm = &Adapter->HalData->odmpriv;
 
 	dm_InitGPIOSetting(Adapter);
 	pdmpriv->DM_Type = DM_Type_ByDriver;
@@ -198,7 +198,7 @@ bool rtw_hal_antdiv_before_linked(struct adapter *Adapter)
 {
 	struct odm_dm_struct *dm_odm = &Adapter->HalData->odmpriv;
 	struct sw_ant_switch *dm_swat_tbl = &dm_odm->DM_SWAT_Table;
-	struct mlme_priv *pmlmepriv = &(Adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
 
 	/*  Condition that does not need to use antenna diversity. */
 	if (Adapter->HalData->AntDivCfg == 0)
-- 
2.24.1

