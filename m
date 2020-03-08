Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD507C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E2206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYm3VcqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCHTWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:22:09 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34807 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCHTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:22:09 -0400
Received: by mail-pj1-f65.google.com with SMTP id 39so286567pjo.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=CHPt46wsL19wRxnDRWINkgudvnaGkseqZPfxEjONV8o=;
        b=qYm3VcqXfjE+ASqxyrrUExTc/0TgxqnlC3o+J2cpfIsm3q9byi/yC0npQtxR9dAk+s
         1mzKYSvWwPsweZiIV1dgkuk5F5qhaMldW4sA8Xi65wSuOgHlcLoKNDfYvRpY5wxZOecI
         yc4ffsS5KXe34PBpE1M+ZfUtGh3Obq3y26g+nxA46NQLeY08vd0DG4sNYVSjUjxIGmwI
         wr9itJUheZpQsiLzFZWFixH894oyiy12DSfxQmrjOujwJ+hiG0fwahUqicgP8rkFtQ8x
         9Cwl5W1I0X8KQLTqoDtorF5B9iC62i4gsvZF4WQh7MsB8kmJHBwI5GYulq1cnZondrQt
         Vy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=CHPt46wsL19wRxnDRWINkgudvnaGkseqZPfxEjONV8o=;
        b=S9jVHeKEF2p5LbeegK96kOnc73z7ZhNljPGPsx0qMWqqbJ1ZDclJ9oeQHZRlYtFBt6
         Fk9FjhD050IVX5r5IdCctZ1tTVCDLQSNi+L1DIkxGCERitkQzGN2XrltY8NM6pTQMZk/
         ujAYN66cKxfiAUElpw/694H/hOiW29KgE8GxULCD0h6UkJinGB4Q8xMqR9D22UA3jdOu
         dInNTWSa3A9kM4SYpKN9oLNi227bZDHJIYPry0AfvlpteSiUn3YWrBUTEKSQTLKpKrp8
         oI0W3xWBp69RbiTOQFMzZkA8+Hz/GMhxKoV9jML//0ei0MTtZbp/+1mR9k0AZuT47GNd
         iRlg==
X-Gm-Message-State: ANhLgQ0Q2hqXCTHVcZmGoh3deDW+odzbDzhbbv/WWnwj5lyIBjm1Wrq5
        AWc2ThcQ7gsOov+44rLCpew=
X-Google-Smtp-Source: ADFU+vvqILrSUB/7kKFUu3sBN9G1y2gZ6tW2m1svtr3vjV5NstoQ+8zH6d37OHRZLLBXimuK961lsw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr12834064plk.315.1583695327755;
        Sun, 08 Mar 2020 12:22:07 -0700 (PDT)
Received: from localhost.localdomain ([1.23.250.201])
        by smtp.gmail.com with ESMTPSA id q12sm42157418pfh.158.2020.03.08.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 12:22:07 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, shreeya.patel23498@gmail.com
Subject: [Outreachy kernel] [PATCH] Staging: rtl8188eu: Add space around operator
Date:   Mon,  9 Mar 2020 00:51:52 +0530
Message-Id: <20200308192152.26403-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around & operator for improving the code
readability.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index e764436e120f..8da955e8343b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -924,7 +924,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	/* update fw_state will clr _FW_UNDER_LINKING here indirectly */
 	switch (pnetwork->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
-		if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
+		if (pmlmepriv->fw_state & WIFI_UNDER_WPS)
 			pmlmepriv->fw_state = WIFI_STATION_STATE|WIFI_UNDER_WPS;
 		else
 			pmlmepriv->fw_state = WIFI_STATION_STATE;
-- 
2.17.1

