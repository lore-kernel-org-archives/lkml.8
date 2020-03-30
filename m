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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0420784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYt0aT//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgC3Wha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:37:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42867 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3Wha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:37:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so7325643plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkvMuoIYK/X5jlUXAbGp136wP0Q9T5tr7KcVd6q5dxI=;
        b=SYt0aT//aArSMQ/UNzfekQzd0uvKBRqacpgJcWiAUN7HREbwlIsEVwcinfFwcBTEFA
         /fI0lPz5LZkn8m9qzEqPVK4DtytYMrndVNcN37GQV3SnDVElPUpPs5kwj99gYr8rE9Uv
         wK3jp5lDTiEip7wtN1BvRmYG6Q73TkRYHgW+nB3JW6Q2kiPaq6JlK8yucO6wsGc7weFr
         5MWJgKScJEl7yYRkpxIJobghTWzpJXGHqf48Lz99CpLNLM+KXZXl71l3XgoCuW2JY6LR
         NIvvbyxcFjKhs+ByXJnTOna1I58jRULZ9ldefpACM0lclCci8ybYTqNKiSoWA1od7QIz
         Yt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkvMuoIYK/X5jlUXAbGp136wP0Q9T5tr7KcVd6q5dxI=;
        b=lLy9yPO8Ni8SAdSX+Yx1WxsKmYCkA/KekUxHBI+GO8J1Vvc0CyuUPEPIq5gb28cV6D
         25wmo7jH2kDQTU1gmh9K6llLwCKeqkbcilsQeZ8qXyO+FLCVg+fmWX3NVhrZM9MU4qAR
         eSafEsKzOw+yzuWJQL838gisNfYvi8eOSIjFJn4ytgBewtroJ7cjpfUaKu1i01PJ4nVk
         v6Ln4B+zxjlODpTD1ic/LYBRVF1oXIotz/W8I1m1+auIk1ccXQKRyq1gt4D8EwKNCZgg
         IVZIXwQfENGK5MnYeeUmJd6FI8GVC8k5fbD8m5pRZISypwqw8+J2ux4VlhQ3J4y079+b
         TRcg==
X-Gm-Message-State: AGi0PuYfBgHwJpe88gJzaG+6Aq9nBL47+AJ8gm4VdS4Rh4Y045NSPskm
        aY3d9t7aC6oE+bozYmP2u58=
X-Google-Smtp-Source: APiQypLTlPYdWDWjEIMfZYMepqLmhFkJU0jHbxBovrLGm8To7rOQU5pfUL3kI8E6NbE7pHdgLaTOjQ==
X-Received: by 2002:a17:90a:240f:: with SMTP id h15mr385069pje.176.1585607848766;
        Mon, 30 Mar 2020 15:37:28 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id m14sm474522pje.19.2020.03.30.15.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:37:28 -0700 (PDT)
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
Subject: [PATCH v7] staging: vt6656: add error code handling to unused variable
Date:   Mon, 30 Mar 2020 15:37:18 -0700
Message-Id: <20200330223718.33885-1-jbwyatt4@gmail.com>
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
index dc3ab10eb630..df12c73097e0 100644
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

