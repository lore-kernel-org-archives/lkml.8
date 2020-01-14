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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C681C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8EB2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISQZSrrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgANNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51790 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgANNpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so13825500wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpKakralIPyvjPHv3rr4wf+iVlH8zSAYqzWrW+Kshes=;
        b=ISQZSrrGkbWtthPuq5EXri0f1KOLLV/BeWZpoy/BykwWcpzPK56O3gTLPt/x3kdZLs
         Wbmm6XzK67LpCPohaORl38IxsJJJ/nPb+qUNbjqVy31UAD1gB1/l5boCQZZJByZJNNPn
         S9XpbLsJvhyYGxD9vyQnp9lob0oc7fOq12dgTgde0h13a1E64MZHNvb/bad/9wHLMcAY
         WcQuG0KMjvXAslqWKEz2qXoLYl5XNukti3RZ1Qn/yjRNfWd02TkwOX/bxopNyqLynUGO
         CFQ1NqNhVAhxPVI0kdx40nBxrUfMD2me1T4+AuqUxKpVvdwljdqqkIzNSC8d/Pi/DZvY
         bEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PpKakralIPyvjPHv3rr4wf+iVlH8zSAYqzWrW+Kshes=;
        b=jffxPRH9Z/YNCXmkX1tZWbv8axFNapQabedYTBLdIFqKtYD/PGXv1a0N/vbxTMEdSt
         wou85rCuE7C3DMeifcy134Ju1yU2kCQwdh6mhT/nkLBdKEw2Qm4wX5xog2ybFslx3jml
         BFu9Dhw75TY9RNqCC2016D4D3KInZ8Wjb7gR/7hDWULOHfSdQoy7ZMQ5amBxwYfg9PD0
         vuSAs/yiqOekBybDGCOEi4yXrz/3ZOC7Vs9hsWZ24sgX0eCtrfNPa8tBTsoWopJxKkm/
         iA5oqo3kagqG+HrUnp6dnnejL61TDiuPod52X5gVNCd+HeL0f/pxlkIBoey8E+Byu8fD
         Gacw==
X-Gm-Message-State: APjAAAUJ7QmaZAkawiChzzKmR6u06XxXYu9lDedLfl49egyw7XLpVy43
        pTByeEsrL1FY3gQP5M7f2l0=
X-Google-Smtp-Source: APXvYqzXJi1OywHPvz/UMGQbpSIhXCL7uUUems5xyXTvK/MdRQDk1mu/9KgoWuVT+ivz4zR2MUon5w==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr26781571wmb.81.1579009503329;
        Tue, 14 Jan 2020 05:45:03 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id x10sm19361333wrp.58.2020.01.14.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:45:02 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8188eu: refactor rtw_hal_antdiv_before_linked()
Date:   Tue, 14 Jan 2020 14:44:18 +0100
Message-Id: <20200114134422.13598-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtw_hal_antdiv_before_linked() to clear checkpatch warnings.

WARNING: line over 80 characters
WARNING: else is not generally useful after a break or return

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 545d6a6102f1..0aa5e9346787 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -197,15 +197,16 @@ u8 rtw_hal_antdiv_before_linked(struct adapter *Adapter)
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		return false;
 
-	if (dm_swat_tbl->SWAS_NoLink_State == 0) {
-		/* switch channel */
-		dm_swat_tbl->SWAS_NoLink_State = 1;
-		dm_swat_tbl->CurAntenna = (dm_swat_tbl->CurAntenna == Antenna_A) ? Antenna_B : Antenna_A;
-
-		rtw_antenna_select_cmd(Adapter, dm_swat_tbl->CurAntenna, false);
-		return true;
-	} else {
+	if (dm_swat_tbl->SWAS_NoLink_State != 0) {
 		dm_swat_tbl->SWAS_NoLink_State = 0;
 		return false;
 	}
+
+	/* switch channel */
+	dm_swat_tbl->SWAS_NoLink_State = 1;
+	dm_swat_tbl->CurAntenna = (dm_swat_tbl->CurAntenna == Antenna_A) ?
+				  Antenna_B : Antenna_A;
+
+	rtw_antenna_select_cmd(Adapter, dm_swat_tbl->CurAntenna, false);
+	return true;
 }
-- 
2.24.1

