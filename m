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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C05C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D171420706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STNDllPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgFZPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFZPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:37:24 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:37:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t7so4662259qvl.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIv8V6aiMphHJqhfYNfxJUYD+2r3xdbZCzFrzgJJWCw=;
        b=STNDllPjjelrBsIoieiy0INEtKWNlF2uaWkfabX6vdYv8ilr4wSE6LFT8ROW9XNe0+
         10qty50EiFso1CgA2woo1g+I4JQJNtlD/d3l80tAYcYgdwumguTvoTBdE23+c/UhkPjz
         FsYeIFDA76yrQZorEeN+iALi6MYT+qq7ualbKsA7/wsepvDP4eFKepKgBfyW46aNEkUG
         pTto38UOTcRBiYVZQhf9xC6z0jRKv0QWorM/ko3IIy155fTFf9im/p/4r0/r3xo3ow3f
         aE1ySr0hJCx7oIJd+63pFHKT6fQ+/9sJ3fJNYdLPt/bn0Ecb9/koLS9llQa9RydfzlFd
         hMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIv8V6aiMphHJqhfYNfxJUYD+2r3xdbZCzFrzgJJWCw=;
        b=TIy0LozjrMpCXeXMxZGfGPpzgfRZC8UDZZsefIO5YXgRFEsEcymwf40jJKVeZ4tSPd
         jO0P/2E8xXa6QSWizf4HSm/UIUWoXcl9dHNzv2Hj3RdzvO3pZYljfpEWsnLRH/mU5RYX
         EQ4h8p6rgv7kYNqgC5O8Nv1fuUe1VzJ0WcQVHPmWLNyjXPKZfhXRukRQOtmwRZV9uyVW
         07sYzzgdj6pXMddVyrqNpQHOXBzX/hQfGkXEXyCeUzhA1UMFvb+vFEx2sW7H+f1VbRXW
         I5MublRgvBfMIdDkdPfUYUca8y7bD0XFOSEzi+YQrNa4ISnzyZtMJkgb+EYsxjLQjzu8
         J/ag==
X-Gm-Message-State: AOAM533YrRYwSVHpnJV95w6/n8LLcSh1z8wQqQqGjo1mhSYIGW52rxdP
        RGfdyKBfxkm9SdLIaRUJiSI=
X-Google-Smtp-Source: ABdhPJzLJ7jwR4oCRZbzjBD0gRvYeKkpaXYJeYTBy+r1OQFNBmc1DVQaHr4SKs/0rVpC16nttHog/g==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr3466855qvw.211.1593185843344;
        Fri, 26 Jun 2020 08:37:23 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id y40sm9719918qtc.29.2020.06.26.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:37:22 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: Fix strings split across lines
Date:   Fri, 26 Jun 2020 11:36:38 -0400
Message-Id: <20200626153639.8097-2-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626153639.8097-1-brookebasile@gmail.com>
References: <20200626153639.8097-1-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
	WARNING: quoted string split across lines

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index a27dce7f30b3..44a25d29f1d3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -381,8 +381,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		left -= 2;
 
 		if (count == 0 || left < count * WPA_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						"count %u left %u", __func__, count, left));
+			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), count %u left %u",
+						__func__, count, left));
 			return _FAIL;
 		}
 
@@ -448,8 +448,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= 2;
 
 		if (count == 0 || left < count * RSN_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						 "count %u left %u", __func__, count, left));
+			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), count %u left %u",
+						__func__, count, left));
 			return _FAIL;
 		}
 
@@ -943,8 +943,8 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
 				pnetwork->BcnInfo.is_8021x = is8021x;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d,"
-							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->BcnInfo.pairwise_cipher,
+				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_8021x is %d",
+							__func__, pnetwork->BcnInfo.pairwise_cipher,
 							pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x));
 				ret = _SUCCESS;
 			}
-- 
2.27.0

