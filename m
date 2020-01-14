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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6176FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3717224679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc53V3tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgANNpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgANNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so12225133wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOinymv8pj0OPIX5ZcmZOCfgWEimDpoAKZBv8j+ojuM=;
        b=Lc53V3tkjlGBkcEODzZEcZMxyr5u7gBymcpf3xPxp3UNZGW7aeizjYh4kDZuGVh5cz
         qj9whch/rqLI3Ms+cNnAas3dr76fCNtoqTEwSGdA76RrNzEzrVBGCQ1ZBpzyZTlYcTSv
         VvYGl1lE+wciZiU2FOgrXwK/Can9sGn8/1L/FJa9ITjGCYnG/2TdK7I53a2xTymkhDi1
         RCq+tyTcQHQXxN0zKysxR6gxzwH+zRKdlzK5vieFInf/jv15TfehzoKPGi+5+4sYlGiV
         eTzHvH9FZjtWHYXp1mLaAvqmL70Tq3QbA+v1JVvijw0rTs4LlhrlZ9kKR/JTSroP7B5E
         FWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOinymv8pj0OPIX5ZcmZOCfgWEimDpoAKZBv8j+ojuM=;
        b=mvDkFbp92BZzZroGhlHkrRqDY+bIRPKyQFBIfYARQCQUMZQbkBfkDZCelHJ21aHYq1
         CxmRNPfYXiZh2gGLVr8ZdAAR3+vbdsFtu7+u6CcUZNfxlj9SLuugPmMkJAElPdKwOSPl
         1P+DZq/ineg4BqwFl6I2dqTCMVj7aYvtra40wsNVGYNkroQTnmizRVFHtMo+8QidsDO5
         MNMArgK7myMwEKIIX2BjZ94sBSTG6fIu7SKR3enHZeXVr8uk+I8PZMPJpJO/je6Nyceq
         EXbsNbPeqJnlYfbay82iQRtdpudX6wECRKV4xr57OgdZysJQ6oB9jIAJB97gT1euKUnp
         A6Pg==
X-Gm-Message-State: APjAAAUfsiTDjtGZXggnFiTEGdH7WLo4JMigOKAvKJsKG8TFtAgRGGJM
        JnHwts04vawOn1otYj3XDfs=
X-Google-Smtp-Source: APXvYqzFCtc2A2pvS5NtVwBfj/8CT2OpaYFNp29LauEBS3MXVSECFCW5PltwLwbBu1K/r6eg2TSLLw==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr25470961wrw.132.1579009504598;
        Tue, 14 Jan 2020 05:45:04 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id x10sm19361333wrp.58.2020.01.14.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:45:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8188eu: convert rtw_hal_antdiv_before_linked() to bool
Date:   Tue, 14 Jan 2020 14:44:19 +0100
Message-Id: <20200114134422.13598-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114134422.13598-1-straube.linux@gmail.com>
References: <20200114134422.13598-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_hal_antdiv_before_linked() returns boolean values, so
change the return type from u8 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c  | 2 +-
 drivers/staging/rtl8188eu/include/hal_intf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 0aa5e9346787..756945d41412 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -184,7 +184,7 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *Adapter, struct wlan_bssid_ex
 }
 
 /*  Add new function to reset the state of antenna diversity before link. */
-u8 rtw_hal_antdiv_before_linked(struct adapter *Adapter)
+bool rtw_hal_antdiv_before_linked(struct adapter *Adapter)
 {
 	struct odm_dm_struct *dm_odm = &Adapter->HalData->odmpriv;
 	struct sw_ant_switch *dm_swat_tbl = &dm_odm->DM_SWAT_Table;
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index 516a89647003..39df30599a5d 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -209,7 +209,7 @@ void	rtw_hal_set_bwmode(struct adapter *padapter,
 void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
 void	rtw_hal_dm_watchdog(struct adapter *padapter);
 
-u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
+bool rtw_hal_antdiv_before_linked(struct adapter *padapter);
 void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
-- 
2.24.1

