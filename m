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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E61CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A5B20826
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Nlvf8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgF2VVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27425C031C58
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:37:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so16021789qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX63ojcBTGYgpVQDnPBqhrIrSpeuTImvwcad9Nat98g=;
        b=a+Nlvf8b0GAArIMrvHg0EqEamnQp9ja+U/Uaeg7YODf1sy6MdhXEIbIC32Z9sDUOi1
         n0YTthCuO1TCQA9Gzu9gdMfESJL1GeRhxHUT5p3EQI87TVgx1NNb13ujax0hp50ZogcJ
         aF7GNAKqkDl24FtYhc1YG1eiDGxe/idMS4E9EP3/SB84Y5mO2I5eNGd+tzlL9pJroJfe
         udmz34RIobKyserhWvMPiFQwaQxXynM9r2sJ0ecK2CcGyL5m3mtv3P35aXs4rPoKs0cb
         ajDa4SmE0yv8vLaOdd76VlRleFAgNw48fp+Nj4vHQ4VJJQKY/gRToo7RdOUsg5NMN62E
         O3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX63ojcBTGYgpVQDnPBqhrIrSpeuTImvwcad9Nat98g=;
        b=KDBc9dqOU0asuzIX4ZIWZK1I+3BkloMky4TgSb2G7VKNbSBAUjRQOsWBgFFfqr5AKl
         BIKLFrbBfKhYel2AgF37NBXy5W4BO5tuahLTUaOS0jFxpghQXFG9TDdy1KegLguAGXrq
         hsA7r98cPkwlw8Q+Vs3fs2SVVkKbCRdEVLJXLFoMBon65UmwcId6GsutjfcWXPelfx1s
         eD7GqnjYVnAROEUoTsqinF0X3PzVT9SPGPFmLPdWvvLN3zHeKG/F2Z9gCTaI29Sgglrb
         mL5n12cdeyDA5vk04bZ8dbaMcj0gOyf1wo4za+t3vObO9J6y9I3mYV1LL9c7LdWMvjkB
         mrAQ==
X-Gm-Message-State: AOAM533xj1ihkR6FMluR1jRm4PHF3WLTCBc44O5JD/62su8qJrbSr+YD
        k3aocfjlXb0x0tj/OKKyh/8=
X-Google-Smtp-Source: ABdhPJx+LIz0P/8LenwLfgW7Ca7V5ftnp3ugGg/IPNoNTAFicH4tYhzrZM00ANPF8tSjhiRWFCtTWw==
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr16203522qka.237.1593452243400;
        Mon, 29 Jun 2020 10:37:23 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id s46sm355282qts.85.2020.06.29.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:37:22 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, yepeilin.cs@gmail.com,
        colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Replace function name with __func__
Date:   Mon, 29 Jun 2020 13:37:11 -0400
Message-Id: <20200629173711.5158-1-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
	WARNING: Prefer using '"%s...", __func__' to using 'rtw_get_bcn_info', this function's name, in a string

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
Changes in v2:
	- This should fix the previous issue that caused the patch to
	  fail to apply. 

 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 3316059238e0..b80273611fb8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -987,10 +987,10 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		if (bencrypt)
 			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-						       pnetwork->BcnInfo.encryp_protocol));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-						       pnetwork->BcnInfo.encryp_protocol));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
+							__func__, pnetwork->BcnInfo.encryp_protocol));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
+							__func__, pnetwork->BcnInfo.encryp_protocol));
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
-- 
2.27.0

