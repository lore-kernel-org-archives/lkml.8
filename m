Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BD9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAEC20773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxPluckn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgFZPg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFZPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:36:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D720C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:36:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so7729006qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaM022Y/HvL/3x+amPYr1/2gQ3yZjNK4i4/X4H7UZdk=;
        b=WxPlucknbvIlw82ivwskuCV0wvNkaalfBfcDCcbd+cseAq8sIU2Nf8tk8TYqU7H5/C
         LbAKIyK1F3Nl/7gxztG1lqvGgJO9QSDnB8aUtAsoAdzF8IAANwm1UkUQVa+wJM6LAJlw
         Qe6hHoBvfy7efICEbxgBY3QcBwHjwY/sdXJKXMI0DafjErqbNgUrjk5aTEbOS/YXlafp
         +7KvtbsZupKjTaMdlbywLi6kMpZYOMD0kmos1u1+w29FZjyx8tcxgrzJn4hy7o8Qxdlb
         rAAx+yu4utQ1qDCAW+lXr0zal/pHGU2mlMb5OlbzEvt4c7GMg2Yx2K/DIBykb4F4bHZH
         faOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaM022Y/HvL/3x+amPYr1/2gQ3yZjNK4i4/X4H7UZdk=;
        b=D7n6Wxk+RNub8HlzGzomPqwUc2kmtkIEiUMCwP3jD/qMmN70tgnTzR71Pfn9EIIUbr
         AAFjxRDVdGKMMBtScPdrlzWh34+CQgQYOta0PYa5TCjX67gQahvPYnI68Bf7Vm0JSJeG
         wAPx4dGRns8alzqSfK7kaDFFp+lN1Ur4p+jVBo54KuAdIn990jT+jlNRTSd5PmHG0rWi
         MZn36VQPnKrleVSYMWIMPrccTNgnQFpCCqZC3Y34AOH4BnmZ0okiI1EPWCd2NG+37uQv
         /zhl0DXWB9l7Y4UTpXRbI65VGarwgos3dTxUgFUIQUQI0/yawqzFSf6LVc1xM/EFJ+C3
         rRvw==
X-Gm-Message-State: AOAM530bEuMfO2TB8cjcIVbQpm0imwhQLsG6freu/EZCiODBWpf+alwr
        k8Cbk4E/GD8qhlDrErQiqCQ+GOlF/h2HAw==
X-Google-Smtp-Source: ABdhPJyM6dmcoDMp76/DN0TKwYW3uYo931Fm5ycZytXYuV+SwzaN6MBvNHHnynyfoAh20xBIT1lWfg==
X-Received: by 2002:ac8:1907:: with SMTP id t7mr3326757qtj.160.1593185817581;
        Fri, 26 Jun 2020 08:36:57 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id y40sm9719918qtc.29.2020.06.26.08.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:36:56 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: Fix comment formatting
Date:   Fri, 26 Jun 2020 11:36:36 -0400
Message-Id: <20200626153639.8097-1-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warnings:
	WARNING: Block comments use * on subsequent lines
	WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index caf600eba03b..a27dce7f30b3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -139,9 +139,11 @@ u8 *rtw_set_ie
 	return pbuf + len + 2;
 }
 
-/*----------------------------------------------------------------------------
-index: the information element id index, limit is the limit for search
------------------------------------------------------------------------------*/
+/*
+ * ----------------------------------------------------------------------------
+ * index: the information element id index, limit is the limit for search
+ * ----------------------------------------------------------------------------
+ */
 u8 *rtw_get_ie(u8 *pbuf, int index, uint *len, int limit)
 {
 	int tmp, i;
@@ -680,9 +682,11 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 {
 	unsigned int oui;
 
-	/* first 3 bytes in vendor specific information element are the IEEE
+	/*
+	 * first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
-	 * sub-type. */
+	 * sub-type.
+	 */
 	if (elen < 4) {
 		if (show_errors) {
 			DBG_88E("short vendor specific information element ignored (len=%lu)\n",
@@ -694,12 +698,16 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	oui = RTW_GET_BE24(pos);
 	switch (oui) {
 	case OUI_MICROSOFT:
-		/* Microsoft/Wi-Fi information elements are further typed and
-		 * subtyped */
+		/*
+		 * Microsoft/Wi-Fi information elements are further typed and
+		 * subtyped
+		 */
 		switch (pos[3]) {
 		case 1:
-			/* Microsoft OUI (00:50:F2) with OUI Type 1:
-			 * real WPA information element */
+			/*
+			 * Microsoft OUI (00:50:F2) with OUI Type 1:
+			 * real WPA information element
+			 */
 			elems->wpa_ie = pos;
 			elems->wpa_ie_len = elen;
 			break;
-- 
2.27.0

