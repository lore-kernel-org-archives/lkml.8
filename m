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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EBC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE0B20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1jpTp4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCXGqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:46:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43896 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:46:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id p125so17474850oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2Cpzw4E1MH/apRZiYWRudyXyqXaavHR/FmSYKlPnKY=;
        b=b1jpTp4B/e8ld6W7K2xPIhclIcEVsAnvAe+EMuzBiS31/s3QhUZXKhkCgm3fPyQ1gx
         TQ20cmvwMjxCRuIA8NJ79kYdOSYNrlNgQp3X6sxNUcLdmEcIjnBwLNnnBXn4xVDbM+tS
         9lhk1q/ObYf6vvmpG7fZDO3IEqxho3QLE6SSHTH2P8FyHGbDs3idTKvImBmobYGRigQP
         PSwjHklEuXRsI1OwATpb+tEBuBXz7LXS6nEulfEHFzVAgtpmj5bBduh/KEwb0PtVbMMy
         0+u7HO7/LmL4AAycH6dKs6XyshBp2qXxGht81ERf8eIabT80Uhi+LHiu4/1Wr1IDPRii
         YZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2Cpzw4E1MH/apRZiYWRudyXyqXaavHR/FmSYKlPnKY=;
        b=TbV50qeeZG3G94UTACizdQHDvZm/c1/U8qWKSzGbxhfLhZ1oYL/omfVE9OwJuU3b+g
         4gPTWHzRymoKGNEvKzjAgOamO2UnIGynUDh1tCGX/EAhJwJMl5CxQzkjzm/L4aM1wQrR
         tz04yUn5aVwASWI/RmJ7SSDc1eCzC+Ec6QJtgPaPj+cG8oaNzANbyuEIoSvWAc2QDrTQ
         aTH0OQozKHS+YKDs1v0f/WJgTvjK0vkpSgv5P9CwQSfqU5xJ/qenA0/wmYjwzjY6xmkv
         Nuxoo5RjiFI5Rpy22p1UbVZraZXU2ZrzBni0xSWGqokfLrBX1c5vhDC2B9xgmJPOoxZW
         vKuA==
X-Gm-Message-State: ANhLgQ0pKJV4viqhB2GdjFXsRANYLmdVrDvxfAAtgv0Hu7fZg/ZQZlSQ
        Y0Vrba8AHAwv8zKk4+/QQ1s=
X-Google-Smtp-Source: ADFU+vsM+mBjfop2NBPyp3ELPu1FSyg2p9oSo3vNcQD9CE6eykdqD8v4ElqykaUcGRIGGvZM9AHhAg==
X-Received: by 2002:aca:bd0b:: with SMTP id n11mr2240979oif.90.1585032372991;
        Mon, 23 Mar 2020 23:46:12 -0700 (PDT)
Received: from localhost.localdomain ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id x1sm2910134ota.7.2020.03.23.23.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:46:12 -0700 (PDT)
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
Subject: [PATCH 1/2] staging: vt6656: remove unneeded variable: ret
Date:   Mon, 23 Mar 2020 23:45:44 -0700
Message-Id: <20200324064545.1832227-2-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324064545.1832227-1-jbwyatt4@gmail.com>
References: <20200324064545.1832227-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable ret; replace with 0 for the return value.

Update function documentation (comment) on the return status as
suggested by Julia Lawall <julia.lawall@inria.fr>.

Issue reported by coccinelle (coccicheck).

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/vt6656/card.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..05b57a2489a0 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -716,13 +716,11 @@ int vnt_radio_power_off(struct vnt_private *priv)
  *  Out:
  *      none
  *
- * Return Value: true if success; otherwise false
+ * Return Value: 0
  *
  */
 int vnt_radio_power_on(struct vnt_private *priv)
 {
-	int ret = 0;
-
 	vnt_exit_deep_sleep(priv);
 
 	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
@@ -741,7 +739,7 @@ int vnt_radio_power_on(struct vnt_private *priv)
 
 	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 
-	return ret;
+	return 0;
 }
 
 void vnt_set_bss_mode(struct vnt_private *priv)
-- 
2.25.1

