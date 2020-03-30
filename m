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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE4B20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfMsUMHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgC3Vq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:46:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgC3Vq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:46:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so9297900pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dcAoN1+dU5RRo0qINqwezngMlazlEYMLnB6EmXTGbk=;
        b=gfMsUMHA4Pj+mLP3dWOOZyyRsxv5bDcLC9BidEGTSQ7NW9TvGI91+zRGqK0yyy5U6x
         gAOQq0qrBTTm70t5+5tP7DkIG1xzxdTFpnly5Z/fztRTKFPbxV79ssKcqiTjSNbgZ9vk
         PEfs7JFtlM/1pR+BGeTWQzvf9Dtz9dwxcEmkCG4YaD69Cd9F7R1y5IS6ogrdi7nS0WFA
         Z3xDilkr1yhnZBQGijvSByqe11SdRg7tFFGPjp8mlr5/py8kat4vxrupCdnuimdxz1kj
         EaOdRGf0Cjhh3Z1zmjmFlP+k1lvQf3/HgcNrAmz9HxaJKstu1+nJFpD5PZQic89HbJTN
         Hynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dcAoN1+dU5RRo0qINqwezngMlazlEYMLnB6EmXTGbk=;
        b=UZGCV+eNILM4oyswHEzM8oaqHZCqkX6psjOZuxeIBMCEz57MmG9Tk4zwzZsmNG58C+
         zcNvbBUBV8J2IsRN5yjzgzesCeoj9Iis1Uv4Bb7Ss2KO2M1rZvi/M0YLA3DQuyPsMOaV
         KZf8vsTcR8OAMMKGm9eSV3jJpNbeuEs4ziP6hlgOOMEADKrFW6B9csLHchrAKMo8fZ3f
         BEP3RWA/IYNHrMCiIG2YVG1uFoHTN/cIE5vk90Dudss7zkPGdNb5YXQ5jIoH1w7Fa44z
         LA0lFOp7d5nPtZ68G8BNi2Oy3paXWQWbWw6QSApZnlNqEhiKLX+b9QILMHP2K2LLTNEN
         FPpw==
X-Gm-Message-State: ANhLgQ3FWHWwN/hu3N2LQvbG8jfEKYNY/OJ4ETwTd+Vm2LapfD67m3bR
        J9/uIai5ChPFzv89toaUpjGscZPAq3wbog==
X-Google-Smtp-Source: ADFU+vsWWWw+27Zr3XdfpX0Y8ZYk9FUe5zGzgJbqIr8iQx1frk620ctEY9spPZSzsBtxANrpi36Luw==
X-Received: by 2002:a63:b40d:: with SMTP id s13mr15459446pgf.268.1585604787127;
        Mon, 30 Mar 2020 14:46:27 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id q6sm403410pja.34.2020.03.30.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:46:26 -0700 (PDT)
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
Subject: [PATCH v6] staging: vt6656: add error code handling to unused variable
Date:   Mon, 30 Mar 2020 14:46:13 -0700
Message-Id: <20200330214613.31078-1-jbwyatt4@gmail.com>
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
index dc3ab10eb630..c947e8188384 100644
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
+					  SOFTPWRCTL_SWPE3));
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

