Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADCFC3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36B1222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMg/4Ose"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgCKN7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:59:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35969 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgCKN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:59:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id c7so1266704pgw.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Rsh1wp6Fd0Yl2sa4e9abEs0k+S0Of//VtbBDH+QzLew=;
        b=ZMg/4OseM+M79oricWCYBpDoxsS2CVvN4cPMGCEe8P3CGHaPQ0w7BTSAkx274h4QJy
         +8yaIiFu0l5ahpzCUGJsrPJIIbm4POb1T75sMToETl85JplEDp0glnC61nH58DoykVZy
         +Tn5OCaCkGz4aqcAGCmadxrFeFBIf/k98brvePZLxpqZZyKO1e9bHE0CEsvcHcK8lnDX
         nUoKoHQGFQmF4aYwItlXO2UWvcaqVTwAJR2Bg1nq7npwmiEl3RA0SnjMwavfQjK1Mpxj
         D6khngidz4Q8aTQnmZm1XshHCvhTzf+44UJsjQx2MwnHDxHqcDZs/44mxarwMROEjBle
         vcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Rsh1wp6Fd0Yl2sa4e9abEs0k+S0Of//VtbBDH+QzLew=;
        b=GlSM43A46jGkA8epfAYEjBrP+dEpW8/M3sMq0hiWMaNAUl9D/784aTJeaJtb04Labg
         0NPJZ9ud0NT4+8vvk5Gq3ImZta+sqO+opuIs1d1l5R8vLYX9GQx4T4yLaEfEF1XeR+wc
         vMjLY/XN4xu3H8hv6oF5T4SWJTufVjCdHmmeLbfwxGM+k9PWj2TI6oZDgt4/GU3dHsN1
         kLT3a6ziifwRSt6zc+OyawAvN503dhe89oIih6KnP5T+EftuVnU6U0ojoUKzaOHVf0zV
         omZqgXC9zs1nTGbjzXM+iREGdqx1f7aWvKVrsSGchib0+DBqPNsKGZDcEbx0KR1CWfE2
         AUaw==
X-Gm-Message-State: ANhLgQ2SWFnNmYjRcgtr/dDvUyoLDQ3y4/1f46p918aan+vGtq6+0wBi
        kTiwDZKhLP7EvPz3IeOZpRg=
X-Google-Smtp-Source: ADFU+vv4XED4TC3aAvIDyuy+AczhSmqal1KUnGai7LncdXtqfH/DQowMoDp9kOdzEAJjzpb38KMCBA==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr3101406pfi.69.1583935150671;
        Wed, 11 Mar 2020 06:59:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:287:fb4d:18bc:a849:c699:3914])
        by smtp.gmail.com with ESMTPSA id b11sm5799287pjc.27.2020.03.11.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:59:10 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove unnecessary conditions
Date:   Wed, 11 Mar 2020 19:28:59 +0530
Message-Id: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary if and else conditions since both are leading to the
initialization of "phtpriv->ampdu_enable" with the same value.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 71fcb466019a..48e9faf27321 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2772,13 +2772,9 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 	/* maybe needs check if ap supports rx ampdu. */
 	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
-		if (pregistrypriv->wifi_spec == 1) {
-			/* remove this part because testbed AP should disable RX AMPDU */
-			/* phtpriv->ampdu_enable = false; */
-			phtpriv->ampdu_enable = true;
-		} else {
-			phtpriv->ampdu_enable = true;
-		}
+		/* remove this part because testbed AP should disable RX AMPDU */
+		/* phtpriv->ampdu_enable = false; */
+		phtpriv->ampdu_enable = true;
 	} else if (pregistrypriv->ampdu_enable == 2) {
 		/* remove this part because testbed AP should disable RX AMPDU */
 		/* phtpriv->ampdu_enable = true; */
-- 
2.17.1

