Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A64C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7B20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbec061i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCTTOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:14:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCTTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 15:14:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id d198so1999198wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3DRIuFvLAn4sQyGNJkixzkoSFpSmglRsC01IEMoyeY=;
        b=Vbec061iRyMXEkUcEti9RH855qeclgISN6hc+wsL9Pl06Di0rpMbYDCxo4CCcQgdJx
         lMI78hYGhEK5HhIn8ih40S0xbFJ1Hl3JCnKwIp6+QYrGNhKLbix0cs/H1Bb8TjhXvPCS
         zKUULGMdgjhstQZLbIwJj4+Y0xGODzbjTr/R9XOIion4qA/vUXjDOXhATwj0dGX7bRnh
         LLe1/F1vmLeob7aDoEfMAkDJNlkP1340jQ/vedbU05WTe+wdVoctGTRylO4OjKicbtYm
         7DFPCd/5Vy7iBdj48fTd7P7EPhlbUMITZ/bNI6Gf9zt96tPoYvn2cCFd5wPYMejwza7c
         F0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3DRIuFvLAn4sQyGNJkixzkoSFpSmglRsC01IEMoyeY=;
        b=Xed5DzyJ+wB47s8e25zxPIzPSGmmUD/umjf59R7tyVqoztRZ4xhCNh/uQfm0bYa5Fb
         WiJQDJvbCahW3b/ZXryit/WwIff1pD9VcmHIR5bvw6j1iX0uoLL+3+iFqx4pG7/fHDnb
         aUcConPIN7i8cVrArVgwCUN90MgEiPvaJbOYenJ/CbCgFiG2oMsg3pPxpcZFGzIWTLq2
         L6wL/sz5KGVYHZ0/tv7OgCSVokLVeUkzf97L/Q1ksQ5s2wDCxsKMg4vtbC5Bw2sz1p2c
         E7Mz6jS2wlSwwff/XSwpMVHE2WpQ0oP92dcLiFR0amNOIXFH7ribXfgFDDK9QfD73r4g
         /e3A==
X-Gm-Message-State: ANhLgQ1SQJ2FIgtXQq3OH/33KylsOb1dkAUiNaE+EATo5cAZsurGpaeL
        EypAf4O+tOyRCGFbJdoJSCk=
X-Google-Smtp-Source: ADFU+vs6wRCA+4528+CDV2keByZ63N1T/6GuAeTpM5TJv+nqd6zmZ6bBx+9kkvlM1suNwci6vqAznw==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr12499629wmf.175.1584731673433;
        Fri, 20 Mar 2020 12:14:33 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-020.092.219.pools.vodafone-ip.de. [92.219.207.20])
        by smtp.gmail.com with ESMTPSA id u7sm8988595wme.43.2020.03.20.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 12:14:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove some 5 GHz code
Date:   Fri, 20 Mar 2020 20:13:05 +0100
Message-Id: <20200320191305.10425-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the TODO code valid only for 5 GHz should be removed.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Remove if statement that checks for channel > 14 from rtw_ieee80211.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 29f615443e8f..e186982d5908 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -236,14 +236,10 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->ssid.ssid_length, pdev_network->ssid.ssid, &sz);
 
 	/* supported rates */
-	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
-		if (pdev_network->Configuration.DSConfig > 14)
-			wireless_mode = WIRELESS_11A_5N;
-		else
-			wireless_mode = WIRELESS_11BG_24N;
-	} else {
+	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN)
+		wireless_mode = WIRELESS_11BG_24N;
+	else
 		wireless_mode = pregistrypriv->wireless_mode;
-	}
 
 	rtw_set_supported_rate(pdev_network->SupportedRates, wireless_mode);
 
-- 
2.25.1

