Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6784C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ADE206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feGw5WyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgC2Iil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:38:41 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52118 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2Iil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:38:41 -0400
Received: by mail-pj1-f68.google.com with SMTP id w9so6103587pjh.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IbFQBYANCkF12Hrlo9wNyHkWayXw9MSU6eCf6YHmKw=;
        b=feGw5WyZuV9ajZvRK9bfLB9F9YycMWXf/o/b6Bw89cGi0v1Ixl7KFkr3UQfF25pdj8
         f2oolo8vlDP0EVxxQmMqH+tUsBGgks7P9GiaNS74sfxP+lvhgdl8dzHDMg67pBtoB3t9
         3DUfCftSZ0cV2oS/j7R23RLhccRa4SaED5bzizMTGOZYCLlG+/FJcH8eldmSDwSLSSe1
         vYJGYp2pgtzF0ETGIdgSmqdAb/bhw+//jpearh6CPbMeVwxQfxRFLQW2tZ0MClw9jZJ/
         sDFrZkwc/7Af7izojKVeK1f1RnqowGSlr0UsrohaodKAqtjQO0dEkYgLzMtndg79ts0x
         BuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IbFQBYANCkF12Hrlo9wNyHkWayXw9MSU6eCf6YHmKw=;
        b=FEOvxLPbuVoOkCTu6m69LA2iT0CY5wKlSjk/AjG/P2cw+ItyjVKbVsW7veHCNdGT+F
         GDBYr2R7y/TWlFnXgCfuOM6BQ+aNwNwGUZhByBnq5PPGsZKqdJwn2UjZ4G90fMy1/xxy
         0c507YFn/xhG/5QvTbKYrdnMsebsiZRXFbA2JNH6hb9g8PIrsMzeYNfEFye3czv2ORfu
         5GVuWtkqPsmbFyiTwbJQPCxb3daoNrDndheENYWs+pLCd9A7gcEH3hTMaXJFZuXbR5Bp
         SfXSANfw4cGsM6j4+G6HKp7M7eBQoTNTIqVaqVeXy5IHxecuA3XDecBqMyNjEk72wjkU
         khEg==
X-Gm-Message-State: ANhLgQ1l9k0LpnGmmZlA/fHVDiVVCQo/9PYwPjnDghFzWMyHl20KdJRq
        zUhvWArzoGCkzK69FlNSghg=
X-Google-Smtp-Source: ADFU+vtV+6vWr188vCD3wNLrf9ol5lsQ6suYkZM2G7x+xuaJT+RWmpMskUFDVJONBugp/F2rlzzgIw==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr9550535pjb.109.1585471119827;
        Sun, 29 Mar 2020 01:38:39 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id k189sm7256529pgc.24.2020.03.29.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 01:38:39 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH v2] staging: vt6656: add error code handling to unused variable
Date:   Sun, 29 Mar 2020 01:38:29 -0700
Message-Id: <20200329083829.619127-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error code handling to unused 'ret' variable that was never used.
Return an error code from functions called within vnt_radio_power_on.

Issue reported by coccinelle (coccicheck).

Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Suggested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
v2: Replace goto statements with return.
    Remove last if check because it was unneeded.
    Suggested-by: Julia Lawall <julia.lawall@inria.fr>

 drivers/staging/vt6656/card.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..9d23c3ec1e60 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private *priv)
 {
 	int ret = 0;
 
-	vnt_exit_deep_sleep(priv);
+	ret = vnt_exit_deep_sleep(priv);
+	if (ret)
+		goto end;
 
-	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	if (ret)
+		goto end;
 
 	switch (priv->rf_type) {
 	case RF_AL2230:
@@ -734,13 +738,18 @@ int vnt_radio_power_on(struct vnt_private *priv)
 	case RF_VT3226:
 	case RF_VT3226D0:
 	case RF_VT3342A0:
-		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
-				    (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
+		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
+					 (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
 		break;
 	}
+	if (ret)
+		goto end;
 
-	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
+	ret = vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
+	if (ret)
+		goto end;
 
+end:
 	return ret;
 }
 
-- 
2.25.1

