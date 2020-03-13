Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5355C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A26206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWbg2LKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCMK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:29:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33260 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:29:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay11so4057325plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=kqXMRjosvrMwbkpWYYUMv/eKp41LgZaQN2jfs/TMCUU=;
        b=EWbg2LKqIyxcTZt54OZrlCbltZOHFk7QAr/BjENsjZfWl63N37tNSXyfPxxA0hTRu3
         or4rZWujQhztrFqJsYFJUd8k74Q1F4Tqhf2S3hd6rGIxw40W28bThPpt6NfqCcHbHQWA
         4FXoQ7Pd1UOft3mx57iVigFUPwH0cIsV5yat2JaHnEto1jFCq+jPPaepNxUksBrEPIid
         vY9b4GzJoo4MUSaptYYtogEF/CGnjXQOAaYUFXQZCP0VmpL2vY5j+nwNFN0guSeNqH7Z
         D+3voASXKTB12c7Rt0W6n1c5MEXIcUb0v8hC0Y4iv+tApge+jorRS2kNNs5Gpg95KcqX
         CtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kqXMRjosvrMwbkpWYYUMv/eKp41LgZaQN2jfs/TMCUU=;
        b=kuAejmHZlkWJXls0rYoMt4cpvilA0NfAokzlwvPh2k3HaCNN503aEjagLhXlCQ8kqm
         STGfVmBQ+LDaUKiUBT1tP/dmvopl4pXvf/nv9OXSQVu4TwGmZz6hXDU5Cesh74ReNczE
         LFVGxYR9rwAPQleP9/NkZt4F1EPtBrS4MtdVi44VkezAJAWSHDoHKXEFI4JzO8zwlg2P
         L8qfpWbTLIMvy6t0mBge6rKsChW7bSzRElUIPBbtf8nTeu0FPZkHRQezNAWb/wwI6/Zu
         w+Ygjfjae4nFhRwY0yifTI1wikxmXxfS7ryi4VNxQASFBYpTu+P3k5T9kqE8InxTmBEi
         0EIA==
X-Gm-Message-State: ANhLgQ0QZI6jW+7GpzZhCWjE2MDuUlNJGH+Stc2al4DyL3d3sl4XEHsc
        yoXY4wW8hPylL2kp4jxkT8pLO/Og
X-Google-Smtp-Source: ADFU+vsY8iYgbuRFlAd9U61nsaldOQC1hqGGqTzZvDEDjvVId3qGfnZZieGIXk2tsNLODrFDhDxEhQ==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr12588240pll.180.1584095365090;
        Fri, 13 Mar 2020 03:29:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:d418:f8a5:7ca8:f99b:fa30])
        by smtp.gmail.com with ESMTPSA id u24sm55719326pgo.83.2020.03.13.03.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:29:24 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme: Remove unnecessary conditions
Date:   Fri, 13 Mar 2020 15:59:12 +0530
Message-Id: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary if and else conditions since both are leading to the
initialization of "phtpriv->ampdu_enable" with the same value.
Also, remove the unnecessary else-if condition since it does nothing.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2
  - Remove unnecessary comments
  - Remove unnecessary else-if condition which does nothing.

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 71fcb466019a..d7a58af76ea0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2772,16 +2772,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 	/* maybe needs check if ap supports rx ampdu. */
 	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
-		if (pregistrypriv->wifi_spec == 1) {
-			/* remove this part because testbed AP should disable RX AMPDU */
-			/* phtpriv->ampdu_enable = false; */
-			phtpriv->ampdu_enable = true;
-		} else {
-			phtpriv->ampdu_enable = true;
-		}
-	} else if (pregistrypriv->ampdu_enable == 2) {
-		/* remove this part because testbed AP should disable RX AMPDU */
-		/* phtpriv->ampdu_enable = true; */
+		phtpriv->ampdu_enable = true;
 	}
 
 	/* check Max Rx A-MPDU Size */
-- 
2.17.1

