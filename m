Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D0EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4620771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC396dGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgC3XjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:39:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35481 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:39:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id c12so4560518plz.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 16:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pxcOcpWIjOsjvgQ2bPjI1PSxQO2talzx0dTKC3l3L4=;
        b=kC396dGlRCxUqoC3rJNV8jYlr3wqGleHoOt8yaq0lqdFuSL0Of16FsXKKU/XAzjRzQ
         pGr1zi0rM3ZE/SaC2B6/PAr+/2ZQqOEZAGp+D/WVuWmWZ4xEf8IcV7mXVnb02PBsvupX
         CHxglgpl3K+eoPJiil0sa5ALVtYysVoMzlAYeCJ/qnMQRPOA1L+N3kQPNfsyH/+2scAI
         ClvPIhuCrU46Qewkjl9zTWIbb5+Kea0kx/IM86bKYa2Jda6D4aRmlt7YUQo+Gl7ob9mE
         bGAD7gHZRqNlmlLJmgzmXlK6vBTvfa50NHi1NJ4VmIpaww4cizFs4PqMlmIuMBgKTFLh
         D3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pxcOcpWIjOsjvgQ2bPjI1PSxQO2talzx0dTKC3l3L4=;
        b=GPWBuneh2pVFviWgb/q6HqjXgo7txM7KzlgNCygTU2XyjNjXxTi19jEC2cZPTuPhXF
         P5kQhNNp/Oy7K1IzjskasScSHb2gJNdMNPdkoYATmIi7pbt0n3DlCGV/ncLg6L/58d6s
         qPIxfsLauQE1VW0rWwNDDRW5es6V+pY2tiVXplsqyVe0y54iuHxDsi4GfKQhn9dOqHFT
         WCikuXSQpYKG6BBLjTXfrHgRKAb1oLkT7k2a+0pN6DHwMpF9RG0LGdqZDPELIo25CTds
         NagDpYgSvIvCmODKhN944gB7UGummcVIx2iXmFrn15fIZI+L0MKHOuGzhKajhgvhq1se
         7Ltw==
X-Gm-Message-State: AGi0PuYcLYPvgiLkDwwQgD/CTOiasIztk0ojgfT/Oz+sjM14lqSptbbM
        Fl/zCeJ2V0y40eU/f55i/2o=
X-Google-Smtp-Source: APiQypKlxoA/ONi9CDJo1gNa6nL6Gyga6987LV8cZAMa12hHmHi/qm3/QxQYl7+FwWhNV03EMLwK8A==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr613505pjb.41.1585611550428;
        Mon, 30 Mar 2020 16:39:10 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id a15sm10961425pfg.77.2020.03.30.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:39:09 -0700 (PDT)
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
Subject: [PATCH v8] staging: vt6656: add error code handling to unused variable
Date:   Mon, 30 Mar 2020 16:39:00 -0700
Message-Id: <20200330233900.36938-1-jbwyatt4@gmail.com>
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
Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
v8: Fix trailing space reported by checkpatch
    Fix alignment issue suggested by:
    Stefano Brivio <sbrivio@redhat.com>

v7: Move an if check.
    Suggested by Stefano Brivio <sbrivio@redhat.com>

v6: Forgot to add all the v5 code to commit.

v5: Remove Suggested-by: Julia Lawall above seperator line.
	Remove break; statement in switch block.
	break; removal checked by both gcc compile and checkpatch.
	Suggested by Stefano Brivio <sbrivio@redhat.com>

v4: Move Suggested-by: Julia Lawall above seperator line.
    Add Reviewed-by tag as requested by Quentin Deslandes.

v3: Forgot to add v2 code changes to commit.

v2: Replace goto statements with return.
    Remove last if check because it was unneeded.
    Suggested-by: Julia Lawall <julia.lawall@inria.fr>

 drivers/staging/vt6656/card.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..1ef1f6b22195 100644
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
-		break;
+		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
+					  (SOFTPWRCTL_SWPE2 |
+					   SOFTPWRCTL_SWPE3));
+		if (ret)
+			return ret;
 	}
 
-	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
-
-	return ret;
+	return vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 }
 
 void vnt_set_bss_mode(struct vnt_private *priv)
-- 
2.25.1

