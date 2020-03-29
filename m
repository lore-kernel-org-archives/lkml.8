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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C66206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTg8tyH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgC2Inf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:43:35 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38578 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgC2Inf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:43:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so5897686pje.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id8d23gHqbRL99BSISU6PhbbkVYUSOo5XcJrW6d+fG4=;
        b=nTg8tyH+FegLXOkebwiGJ2y9whQZ/BxUnZJf/tkkoeL2aw3TZOllyMdv0NSpfV9cEm
         MHJFWMcK3dkxiL5EnQ48t+1t2c0xQDnT3yr/gVUAr8sSTS70FQQI6VI6jxGSuXiMGzoJ
         trkwSu6ZaJXH72eyjvNobSkiz060K1jBvdfqbpYE/FBTo0sKuvxPNGZVNiurkFt43s9Q
         Rz5YLdooUXeUK+8V1/Xp9fxGm94aacy4hSkV9z7i+8OXWkxmwdmzNuQ3aIGppdSm1Nng
         ruUN5weC++HGmv7H972u2CwQ6MpeqIBgClgA7q8vHiBQ8nI0+Ktle5mEXpnBxC5mJssN
         /etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id8d23gHqbRL99BSISU6PhbbkVYUSOo5XcJrW6d+fG4=;
        b=r+3CCiEwo2atZP2I6hSDh6Uol49dEQNAt1D36VFJk4QVg7mcE53YTLVL5rn49swKzJ
         8RDF4UtUAKDLqhcR1BYiNh9Uu1EfOH6TMUCCG2a3k/v6FfNW37vDBdluweVkeqqTOOLV
         NZeap4Rg9l2ouDCa318chA4sp3owxTrETzfPtvduPdnpTTUrC3dl37vPYP3YseC909AY
         zRv90IFs1/Bk9eO7t9TPAAEV+1rhMDQS63Q6hjVqTCwcHvLMMrMp3ksPGXAr/tn26f4W
         trPHDtnHDCAWHTPiNV6+CzLeihgYh3jWdRGY+G+kZgA9z0lZIaW1BY9i+YuTYub8xOSi
         F5xg==
X-Gm-Message-State: ANhLgQ2tb2KJxJX6rRRs/q/fczfD2GYcUuUw4mQU/f5kTKh/JTA1yXb3
        2sNWM3Vsp85d7YTHD0yRado=
X-Google-Smtp-Source: ADFU+vsb7aOT1SwSB0fURY5Khnfm+kq8VNwOxOdMweq/f7MvFzJXDZPEJZvBmotlqmuMF/tQwam/rA==
X-Received: by 2002:a17:90a:b003:: with SMTP id x3mr9264046pjq.140.1585471414051;
        Sun, 29 Mar 2020 01:43:34 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id w2sm1525487pff.195.2020.03.29.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 01:43:33 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH v3] staging: vt6656: add error code handling to unused variable
Date:   Sun, 29 Mar 2020 01:43:20 -0700
Message-Id: <20200329084320.619503-1-jbwyatt4@gmail.com>
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
v3: Forgot to add v2 code changes to commit.

v2: Replace goto statements with return.
    Remove last if check because it was unneeded.
    Suggested-by: Julia Lawall <julia.lawall@inria.fr>

 drivers/staging/vt6656/card.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..239012539e73 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private *priv)
 {
 	int ret = 0;
 
-	vnt_exit_deep_sleep(priv);
+	ret = vnt_exit_deep_sleep(priv);
+	if (ret)
+		return ret;
 
-	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	if (ret)
+		return ret;
 
 	switch (priv->rf_type) {
 	case RF_AL2230:
@@ -734,14 +738,14 @@ int vnt_radio_power_on(struct vnt_private *priv)
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
+		return ret;
 
-	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
-
-	return ret;
+	return vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 }
 
 void vnt_set_bss_mode(struct vnt_private *priv)
-- 
2.25.1

