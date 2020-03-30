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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37901C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4BB2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtaEHMs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgC3Qp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:45:58 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:37351 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Qp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:45:57 -0400
Received: by mail-pg1-f178.google.com with SMTP id a32so8920963pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jHmmqwn2svjDpJo/PqcecI2nv0o43iwqhoUvWD12Vs=;
        b=UtaEHMs0yz7OzsCgZpF68S16mE3rpzMGRscsJpWv+NrjN1/ike3O51+Q+Wejvo0baN
         m0UHlGFc13NiDBP55M5QExJcxOwwqQSiwT4ODoytwiX5YW75t9VaupearIW/bs/UXUak
         iGToo5V8SQQIEquNd4I5b4wNnAQJQrgBXhpPFFzplNKWpTZoQvUpGjd918V4WKC0/6n9
         16Edgr0PuVfUlvAJDA53+FiCxJvO6m1S5L8UnUMrnk+sHrcZyJUyRwcYpmXeMHlIDOUn
         WAuQ8OfjPo03bghgj+9d7Vy1bvTI04+PUxWBsPxxvsjk8P9nOWk3NV71Kwwzinr9uE3A
         kOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jHmmqwn2svjDpJo/PqcecI2nv0o43iwqhoUvWD12Vs=;
        b=Y23h5PGvApGkII5foj2OindfwhAM32GLscZY1TtGstsTlFvUCtA3sn2lrI8AG7aOPt
         qNU6384oon6ITBMkgiBue9Z/RnuNHcs/w6SRkJrX9PVqpOUb0uJTN6QGahFI+NP/vXjd
         x1hCzmJpvu5sTqPw1wZEWbmFfDxdUFlZx+k3BCCRknt4XueubynqklL9lxMIIv8RyRk+
         1ErPK4kiQL2V7xO8kXO2DzmNotcG1lh1h4RrCw6Trl9kTMb0wnW9fDkJVQh2cXbv6ENl
         wTOMfBARmohkApWlNwXPtY8MqiTVb0YpmymIsVwDln31KJ2d9BI2MOctRRWClgQzQiUF
         QcuA==
X-Gm-Message-State: ANhLgQ2JtoCWsmefLt3eRVddArIH85Nk02tNx+hmnrUsTLD2PV58wlb/
        OxW8LWw863tLEoZpxz6AE2Y=
X-Google-Smtp-Source: ADFU+vtOhZClSPuPt9LL+z7Wgq9KBychguJqh6cRzsTPUxU7Inz3i+Lc6EnI2CAJBYVtbDwyze8TGQ==
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr13604943pfk.108.1585586756115;
        Mon, 30 Mar 2020 09:45:56 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id d3sm56194pjz.2.2020.03.30.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:45:55 -0700 (PDT)
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
Subject: [PATCH v4] staging: vt6656: add error code handling to unused variable
Date:   Mon, 30 Mar 2020 09:45:30 -0700
Message-Id: <20200330164530.2919-1-jbwyatt4@gmail.com>
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
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
v4: Move Suggested-by: Julia Lawall above seperator line.
    Add Reviewed-by tag as requested by Quentin Deslandes.
    Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

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

