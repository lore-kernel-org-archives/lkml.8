Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E31020748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMK43FUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgGAQ55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgGAQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:57:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:57:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 145so20369697qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9+/GjSEEc7IqDOjdKKSFi+z5g58JvqTZ3s2qbSX/ko=;
        b=MMK43FUauGm3oj5f7opsVcbfLUNZIlw8GnpDKA6hed3fTx0bebwdaAyx+DHfuBE6K/
         N/pW9Y5hn+sxxc/0TpUJAWSCp0KTyvLhBIQ58FwNsiCC48obtyqfLyXSiPhtdY/G0FZL
         gJNRFKgm5iCGGlZ9foLJ+cGtmxnBOLPU2H8qcB1Ry3eqEeVjFepn0VH53WzLTGFbkDeT
         fWXEvd8UrixukXFBYoZgMjMbumGEPtsvbH0dlOkqzQgnrjWxKrubLqgtqNLSYkY7EVFl
         z58XUD4keZZfbJVjsJ084CNsTQiGl4jFKB8kkvBhjXOD5IrAuvUFX065SWCDh/AFFoa1
         zQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9+/GjSEEc7IqDOjdKKSFi+z5g58JvqTZ3s2qbSX/ko=;
        b=CFFws5K1iIkpPHy+xrHuop4b1vfrrZWrQjMr2CxdvktQJJJy9bTUjXstgq0lCiWOcx
         76cSX5j0ZE8UFNidh6JvRL3kKh1P2SSPsci+jy/Q8WM6GXhgfImnnHfKmEwJoTFMDH19
         C+ArF1QbFMDXPE1jMueK0SnR6dI6yS+6WsFJjwSObc6vzSoRtjtgcOAm8Myh2xF8VfgI
         +Yhuim3ASkoZMRCa4bn3XDiyAKXJTkN3fY7mjJulEu0Z4kW+KN9qO9YC1WA068q42QPk
         PRNlFy2EvktdNW1uWqcKc1sOZmia3Lz7xw+W6lVFAX7AZYgjHaYUr2lIKZF9l2bgHXXp
         WdLg==
X-Gm-Message-State: AOAM531lCmJofdGbXhRc7vx6Nbf1fd2NKS/ExzvXqCwcAgHLG/HwrvGj
        0ModBfFYjTV06Y1LL9oSAqc=
X-Google-Smtp-Source: ABdhPJwzcGwP45fgxdx3hTw2Gc6eeWQuIs5EbzTQ/zMhxXEnqeVCPSJQa+6Nzqb3BwHdWxd8IzU0kQ==
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr23770720qke.156.1593622675667;
        Wed, 01 Jul 2020 09:57:55 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-214.178.011.pools.vodafone-ip.de. [178.11.230.214])
        by smtp.gmail.com with ESMTPSA id x14sm5890229qki.65.2020.07.01.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:57:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused parameter
Date:   Wed,  1 Jul 2020 18:54:59 +0200
Message-Id: <20200701165459.8904-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameter 'padapter' from rtw_os_xmit_resource_alloc().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c      | 6 +++---
 drivers/staging/rtl8188eu/include/xmit_osdep.h | 3 +--
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c  | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 258531bc1408..1b12afd33d95 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -124,10 +124,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->ext_tag = false;
 
 		/* Tx buf allocation may fail sometimes, so sleep and retry. */
-		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		res = rtw_os_xmit_resource_alloc(pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 		if (res == _FAIL) {
 			msleep(10);
-			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+			res = rtw_os_xmit_resource_alloc(pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL)
 				goto exit;
 		}
@@ -162,7 +162,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->padapter = padapter;
 		pxmitbuf->ext_tag = true;
 
-		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
+		res = rtw_os_xmit_resource_alloc(pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
 		if (res == _FAIL) {
 			res = _FAIL;
 			goto exit;
diff --git a/drivers/staging/rtl8188eu/include/xmit_osdep.h b/drivers/staging/rtl8188eu/include/xmit_osdep.h
index 5283a6d53700..5fd8ca51f156 100644
--- a/drivers/staging/rtl8188eu/include/xmit_osdep.h
+++ b/drivers/staging/rtl8188eu/include/xmit_osdep.h
@@ -22,8 +22,7 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
 void rtw_os_xmit_schedule(struct adapter *padapter);
 
-int rtw_os_xmit_resource_alloc(struct adapter *padapter,
-			       struct xmit_buf *pxmitbuf, u32 alloc_sz);
+int rtw_os_xmit_resource_alloc(struct xmit_buf *pxmitbuf, u32 alloc_sz);
 void rtw_os_xmit_resource_free(struct xmit_buf *pxmitbuf);
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 017e1d628461..3ca1dc30efb7 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -14,8 +14,7 @@
 #include <xmit_osdep.h>
 #include <osdep_intf.h>
 
-int rtw_os_xmit_resource_alloc(struct adapter *padapter,
-			       struct xmit_buf *pxmitbuf, u32 alloc_sz)
+int rtw_os_xmit_resource_alloc(struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
 	int i;
 
-- 
2.27.0

