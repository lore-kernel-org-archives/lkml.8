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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC720733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7zLTeCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC2Dfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:35:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35364 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgC2Dfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 23:35:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id k5so4680719pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cF2fdmFT4y8poKQgykSEvBARpVMuKdcuHdJc6rFcq9w=;
        b=N7zLTeCISvKUnj4MGL6o9owyLBSCH99tXRh/ASuxP9IDLdm5DiaD+EBAdeWvWh+PIa
         kaX/PMghFGM2V1z/GCEOEQBmO6CajtTQ010SFPYgl2z07B9LR9qQALKhAc4Jbvm7V7Mn
         4aKin703vIMgt9GleCK58cqWP2ZSwyIE/0hztDW9Cq25NzTy8Zf7q/md1G1CMsCscWn3
         l0vw7dLx9299kn17N1wEYQs+6g1AyqwegMhgAv/m6jLE31MiZNe/hVDNJzajW6A3m0Gp
         0miOyoyxk8h58/w/6GXPetEbamfqAhTn4wZ/oTCXfP7RrxtVpDCC0sjkHhVrMFZ49v6E
         izig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cF2fdmFT4y8poKQgykSEvBARpVMuKdcuHdJc6rFcq9w=;
        b=cy3fvzT4ZfRmvTE/9D1VPAFW97Pf+vTz+g++nuboFeNc5aJV5h/hEhwQmmBP65RIa3
         puSmRakcxf6VY8qMwnjW1n5oiiUI/ws2FR5CNGB6Ml3VLkDPKci2coE6QSNPQFMsgqOI
         D9z9knb/4+ExbOiONhPqM0trEWkwKUBAVt4QJrsa0G2vrUf2FW1C1zchTSuWbXQiocwG
         Pq0CkHr9LAFlBUcy5PdCrEGp/iG0MoWwKts1gWSai5fSd9b0CrmZTNhkyAdY3JajMLKs
         F3fOd1gZdbB2sXK9O8Of+PYCdmVsY3+b8kie+Uu+fdQyVyRD3f2jZ23ohGmYBvaitYZi
         264A==
X-Gm-Message-State: ANhLgQ0ZO/Rq5D5kl+kWNECs95Sn/gY1nl4vOXCpr98KPtxoPByX6HDw
        Q/lMyOwmu+Ek3C0bzL27QD8=
X-Google-Smtp-Source: ADFU+vuZUT/X9VxJIMZrQj0la5108iEnXqvQeZz13RQeUqJhiGt2CctKeng+NKKpZ0lOEQfgWzdHXQ==
X-Received: by 2002:aa7:9471:: with SMTP id t17mr6780192pfq.272.1585452931595;
        Sat, 28 Mar 2020 20:35:31 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id i24sm4943223pgb.57.2020.03.28.20.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 20:35:31 -0700 (PDT)
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
Subject: [PATCH] staging: vt6656: add error code handling to unused variable
Date:   Sat, 28 Mar 2020 20:34:35 -0700
Message-Id: <20200329033435.498485-1-jbwyatt4@gmail.com>
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

