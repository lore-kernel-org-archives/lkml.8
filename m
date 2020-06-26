Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D07C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A3320706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyAO/OAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgFZPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFZPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:37:47 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD582C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:37:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g7so4656580qvx.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPSNsR3EOIFVWGXNCRzLROUQIZEmtZcUpU/rvcMJfzQ=;
        b=RyAO/OAWnxDcBcMg3o+SzNFzw0pQO5CARemsH79PlOlCMchDPEjihKT4whLrXSufcH
         k0nbF7dc79rmEEhJnR2Nkx3+Cl3GbW62D7aKxYh+vIdqBzgiGhbRpjLnxP0fKUY/Ofca
         fGLTFCiS13+0SsrcrRTqia9XE/84OMKwF8km0UcR6vTCsLc0cMmrVvdMOD0KGXxYcW2t
         9YHQdniME/NuMQBRAx4nNyY7SnaXvKgrzI2fQOY5Yejpy7joBYumS3eGFPv77sQEHVGR
         5DBZcHv6goHINFTe/q/A8my5HDzJ3hR7EY9jArYjuZlayvATn9j3VaLbZ90G0ZtGkiis
         oLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPSNsR3EOIFVWGXNCRzLROUQIZEmtZcUpU/rvcMJfzQ=;
        b=pALawzx5Xw/eaNdmP6QuOjdRrhMJc5NjCTvAbxLDgE0iKia+4vaU+mjj1W2VvpzBEf
         /saDbj1ZzyKRWTwGjJ85B4PEq6kKB02HA5U2odnhGgmyiJvcz+W+3gjLK+x+g/ODy6wJ
         jHIYBhMrj/WKwvi7vTx0TYzDKGKzegdynXGrjISsyLC7BkMlmoNoUPiTkU8aspDwXtqo
         NkR/eS6oF+I+VHmL4dBBS5aMu6QJ4eoQS+d0eVyUi8ncBUOGbgs5HTSELKZzhLvhHAjv
         T7HRzSppj8jgx0kCiX0rxYXLkwYEpKM0tT/nLzmIHx0q6n42SKsgthjZSgSn67P9mcRO
         RNGQ==
X-Gm-Message-State: AOAM530G71T8BEB9sMP3dwJXQ34i5EzK0oc4eBB1UtuAPe70VywoEEBH
        lXOiehcXn8IzGWf9KCAQBmo=
X-Google-Smtp-Source: ABdhPJw65YClvhV1Pv4cS7AotaqwRxuOlsyG5XSPm8R1eZtUhBUHVXQ5LHaHzftWT3LiWNMfNa49fA==
X-Received: by 2002:ad4:57b2:: with SMTP id g18mr3658374qvx.207.1593185866967;
        Fri, 26 Jun 2020 08:37:46 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id y40sm9719918qtc.29.2020.06.26.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:37:46 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: Fix indentation
Date:   Fri, 26 Jun 2020 11:36:40 -0400
Message-Id: <20200626153639.8097-3-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626153639.8097-2-brookebasile@gmail.com>
References: <20200626153639.8097-1-brookebasile@gmail.com>
 <20200626153639.8097-2-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
	WARNING: suspect code indent for conditional statements (16, 32)

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 44a25d29f1d3..bf6b2fe9735f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -494,23 +494,23 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 		authmode = in_ie[cnt];
 
 		if ((authmode == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-					 ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
-					 sec_idx, in_ie[cnt + 1] + 2));
-
-				if (wpa_ie) {
-					memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
-
-					for (i = 0; i < (in_ie[cnt + 1] + 2); i += 8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							 ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-							 wpa_ie[i], wpa_ie[i + 1], wpa_ie[i + 2], wpa_ie[i + 3], wpa_ie[i + 4],
-							 wpa_ie[i + 5], wpa_ie[i + 6], wpa_ie[i + 7]));
-					}
+			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
+				 ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
+				 sec_idx, in_ie[cnt + 1] + 2));
+
+			if (wpa_ie) {
+				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
+
+				for (i = 0; i < (in_ie[cnt + 1] + 2); i += 8) {
+					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
+						 ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
+						 wpa_ie[i], wpa_ie[i + 1], wpa_ie[i + 2], wpa_ie[i + 3], wpa_ie[i + 4],
+						 wpa_ie[i + 5], wpa_ie[i + 6], wpa_ie[i + 7]));
 				}
+			}
 
-				*wpa_len = in_ie[cnt + 1] + 2;
-				cnt += in_ie[cnt + 1] + 2;  /* get next */
+			*wpa_len = in_ie[cnt + 1] + 2;
+			cnt += in_ie[cnt + 1] + 2;  /* get next */
 		} else {
 			if (authmode == _WPA2_IE_ID_) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-- 
2.27.0

