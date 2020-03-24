Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33108C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EDE20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUBTb3+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCXGqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:46:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42982 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:46:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so3942386oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxldRsVgM50y/CNdhaywWvfHOux55cFEhCcDUOIPfIc=;
        b=tUBTb3+eObvRl1e/GyketYIRgCE1+FzmKzggzqiKcr26yjwZz9zLn2jScZ8Z+KFMzC
         DBVivRgcnTY0kWmXvqlz2FC0HZS2sJwiq5sp8yZ4S/C3T1KDE/1zTIJxZjzVqbbX/mH5
         5NZcYlf+iRhdxU/BuW66MIp8leVkBwXYSIHFxVbXnlDBSR4qcQUOQBKP+0hmxtlcjcGx
         1ur6/7rP1TKySS8VZ3OUKmPYHAmNjYMgNrJtCFSEPafe36X3JBGAd8t4KxPIwjPs4eU2
         OQg+vfvrbRt/jdjYdCQy/QJ1hs4AhgkRv0p25in+SsyEoAgV0dfZKzOIhDsRWLxmCNpl
         L60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxldRsVgM50y/CNdhaywWvfHOux55cFEhCcDUOIPfIc=;
        b=ji79PMwjjvh/M9AaulW+EePjNIQi1YYFLrmRpz/Rnj0SKL9w1WJ5+YubgF2ASdZG0o
         sFYOjPEaSVKekgxalc/XZacKXK3S7ZmDi7iXAXO9c4Oyuiw8D8OCZUC5PhG7XP8MwNt6
         U9WGcqnNICG4OV1u7H4IAl5lYqHmON3omJdTm2yo5PHSA2m/Eb5FwWV4MFSJaCLVP/9D
         2jhbzXFMp7Nfiu5PdWGpVDlPMEdvu0jdpMPjWCN8nghpSk80Wi4vgi9OVHwR4/S/HAZ9
         +CQbgMBL+BNz9yxFOhjURt0WxKNhioKoTTH3Aipd7FU/mgvhehQCgHuSSzq7IXWiyLx7
         YnBA==
X-Gm-Message-State: ANhLgQ2s/zqiosILe0D83Cvk//fdYkDEtWZuZdm0a27lfShB2m/46uaD
        x3xYZMS0bQdlqJUC0/0zltk=
X-Google-Smtp-Source: ADFU+vvcGS2wRG+9sQbBJ2cv3tSdoHfMLnhAMCIfg0rpuTvYyCCSier8i2eElVAQqcd8mo6C9uUFRA==
X-Received: by 2002:aca:d503:: with SMTP id m3mr2217585oig.165.1585032374928;
        Mon, 23 Mar 2020 23:46:14 -0700 (PDT)
Received: from localhost.localdomain ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id x1sm2910134ota.7.2020.03.23.23.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:46:14 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: change unused int return value to void
Date:   Mon, 23 Mar 2020 23:45:45 -0700
Message-Id: <20200324064545.1832227-3-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324064545.1832227-1-jbwyatt4@gmail.com>
References: <20200324064545.1832227-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change unused int function return value to void from previous patch.

Update function documentation to remove mention of return value.

Remove if statement check of the only usage of function in the
kernel. Replace with calling the function.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/vt6656/card.c     | 7 ++-----
 drivers/staging/vt6656/card.h     | 2 +-
 drivers/staging/vt6656/main_usb.c | 4 +---
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 05b57a2489a0..4be7fca32796 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -715,11 +715,8 @@ int vnt_radio_power_off(struct vnt_private *priv)
  *      priv         - The adapter to be turned on
  *  Out:
  *      none
- *
- * Return Value: 0
- *
  */
-int vnt_radio_power_on(struct vnt_private *priv)
+void vnt_radio_power_on(struct vnt_private *priv)
 {
 	vnt_exit_deep_sleep(priv);
 
@@ -739,7 +736,7 @@ int vnt_radio_power_on(struct vnt_private *priv)
 
 	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 
-	return 0;
+	return;
 }
 
 void vnt_set_bss_mode(struct vnt_private *priv)
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index 75cd340c0cce..fcab6b086e71 100644
--- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -40,7 +40,7 @@ void vnt_update_next_tbtt(struct vnt_private *priv, u64 tsf,
 u64 vnt_get_next_tbtt(u64 tsf, u16 beacon_interval);
 u64 vnt_get_tsf_offset(u8 rx_rate, u64 tsf1, u64 tsf2);
 int vnt_radio_power_off(struct vnt_private *priv);
-int vnt_radio_power_on(struct vnt_private *priv);
+void vnt_radio_power_on(struct vnt_private *priv);
 u8 vnt_get_pkt_type(struct vnt_private *priv);
 void vnt_set_bss_mode(struct vnt_private *priv);
 
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 8e7269c87ea9..8214427f5ee3 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -370,9 +370,7 @@ static int vnt_init_registers(struct vnt_private *priv)
 	if (ret)
 		goto end;
 
-	ret = vnt_radio_power_on(priv);
-	if (ret)
-		goto end;
+	vnt_radio_power_on(priv);
 
 	dev_dbg(&priv->usb->dev, "<----INIbInitAdapter Exit\n");
 
-- 
2.25.1

