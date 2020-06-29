Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA708C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFDE20842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpmNg9w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgF2Tny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgF2Tmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348CC031410
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so17351777wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AxbpdcHiw/57CHMJ7xpxqgYfQdZczHJYp1MAsDX43Y=;
        b=rpmNg9w/3E0zMNlLG1raYG1/UxOIIlTW68NocFRo+88EeK3tMtRAcrzCYHZKctzMqb
         W540F3Vg47a/dBMpHJQ/o3sqh/M+jK5egjQXfs93zthRONVC10H7Vx5V3pH66eKyePDF
         drmkLMRW6Iv17UAV/GPUiR/BlfHIwAEYbwDdqfkwytbwXqKKWBbFRjdxcy/Vw+XJuzkK
         ABBN9fF/THs0twqcw7trLlD99xkrHiULIh9OX8DSKkr7EnR1U1l6VOakg2dEqtaKaueo
         MXAUWVg2Ib9j6/2On6MEXNBN1Cyb96pWxsIadQ+TpVZbEyE2jSdF6kLCgEVpNYw6B+LI
         LwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/AxbpdcHiw/57CHMJ7xpxqgYfQdZczHJYp1MAsDX43Y=;
        b=aD44hKXieAud57q+PC76bCIEGVmzSXP85Dr7jO7wR2VJA4bozg5FBGLPDlptzkS75y
         LIECNO47EImN3XAyjMfiZxHIFIdoLvfAYeicJdx+7bQJXxCcsARYm99qvgrwFhb0seb/
         rOUBTXhjxp1/rTpiCMEPruY5AlV8jvxfFqaHS6JBuN/JL702nbKrpo3c6H6GQfLHNyPu
         ZCcentOBKG/ZDErYuWSihLEfvCjQSY/PtX7kgVISxyWFhTkyt0kjiq1DB6P2PeeYzQLJ
         AE4MnJNknJGAoBFoD4Cd1z4U5s9QmpqeA8voZC23fpEpt8rGLhh1u7sbsSkSNtn/8BV9
         ghXg==
X-Gm-Message-State: AOAM531AyyVFFFGWLBRy+iMDeToLcQrK+MuT2Al53gR8P6/fozkbvodp
        n2ExjVyJov1yTNBBWKugM1w=
X-Google-Smtp-Source: ABdhPJxWgsvGcIlPWyFh+Qe6tqa2H1kaQYicf6+/H2QtbvZIyg8lEgBQA2xo3nZciQA2TuCnosuo+Q==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr18528004wrt.191.1593451008291;
        Mon, 29 Jun 2020 10:16:48 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-176.178.011.pools.vodafone-ip.de. [178.11.230.176])
        by smtp.gmail.com with ESMTPSA id n14sm432728wro.81.2020.06.29.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:16:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, hdegoede@redhat.com,
        florian.c.schilhabel@googlemail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: remove some ieee80211 constants from wifi.h
Date:   Mon, 29 Jun 2020 19:14:03 +0200
Message-Id: <20200629171405.7711-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL and
IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA are not used in the driver
code and, if ever needed, available from 'include/linux/ieee80211.h'.
Remove them from wifi.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 667055796b66..e12e3d0a45e0 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -453,10 +453,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 				Below is the definition for 802.11n
 ------------------------------------------------------------------------------*/
 
-/* 802.11 BAR control masks */
-#define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
-#define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
-
 /**
  * struct rtw_ieee80211_ht_cap - HT additional information
  *
-- 
2.27.0

