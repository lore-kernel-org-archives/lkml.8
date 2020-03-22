Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D362C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BE420777
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibuy+ubV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVJXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:23:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45529 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCVJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 05:23:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id l22so750923oii.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Cpzw4E1MH/apRZiYWRudyXyqXaavHR/FmSYKlPnKY=;
        b=Ibuy+ubVA2CVcrbPJvsQrC1fRR62x2DqzOpX0d2eshUp/quaABfC1TH/hgxFFG6Wx7
         QdaEazKdUdGwDSYnZ3rBIHMTyVfagmHXs2oyeq07akmRK+cNsI/1WJA8w8eKXVLCpQqm
         p+gxA5mWusTwmt/3IeG7QRB7Fn8m+RaWdfqqoEyQkCph5ZmnCLsXqaGMwLEmxPhi36Ap
         CkJWjmNGHipOBxYYRaCJRKffXEOoMwg+2ycrub/LbFNP2Ia/1J8KMwyxyT0BSCJzWglg
         O8sYQplfT02vYidaK8oYvZl9geWd18FnNYYgjyj+Uwks/9zEEb5/6iRtu4z6ZihMneyX
         BY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Cpzw4E1MH/apRZiYWRudyXyqXaavHR/FmSYKlPnKY=;
        b=PO6X7qVn4z/kUbBZ9mrFAX51bl33nYxpTWhSBOWQn6B1jprTWK7cj8GyvITC4RfsKo
         Dal4w1KVBlF1aFtWfIHLlLacqvIkTxnI27XPNtpBFmuUX/LvjHBi7ykU6CflfOeV5A+l
         OCfy247e+3il+/TiHVZEGaUIpc6EmjDVrGGbVfLNkv6tcgutWTAWG9l8DWzZA2zpJT/L
         c81tE8Z4cEnXZ4+Albalfo+F3HwXnAFT0+o1VDIQAaaJu3436v3EQf6leMTq7hOISGz1
         7wSkTQuZVi/ONdAEFC5hslzbOZITjWnxpNfcVFgjbANHOHMQpDxi50csd57599FmfExC
         dOtw==
X-Gm-Message-State: ANhLgQ3lohLAa2Ln7P1DEbRgxqwLNGp7z+nUtfNjHyRsvx6YwYt0STaQ
        fA1ArJ6pEU8QKh7HL3A8Myg=
X-Google-Smtp-Source: ADFU+vspPS7so6VE8j9qZXzQ0KcQtEgbBXoFaaBDSVq2xbd9/uULvPgCs2C7uBn34CChyWzmhsbjAA==
X-Received: by 2002:aca:4bc5:: with SMTP id y188mr13419644oia.9.1584868994030;
        Sun, 22 Mar 2020 02:23:14 -0700 (PDT)
Received: from ManjaroKDE.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id a33sm3836804otb.70.2020.03.22.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 02:23:13 -0700 (PDT)
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
Subject: [PATCH] staging: vt6656: remove unneeded variable: ret
Date:   Sun, 22 Mar 2020 02:23:03 -0700
Message-Id: <20200322092303.2518033-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
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

