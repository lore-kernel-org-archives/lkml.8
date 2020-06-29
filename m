Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6050C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AC920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CITmqLc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgF2Syx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5FC02E2D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so16688858wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObKoaiwUBMsH7RgwRp2nwwP2sLs2C+zRlkZVkrEZxL8=;
        b=CITmqLc3nbGdsGtKVJszDGHLgzCb7zsuvkz+o0c8ghMxDpU6eESRHcmbaHok/SMQ2R
         3BU+t5KbBGhwJFZI+r+/nkGDxLbMDFjegBajaC6W6wItOi04H/OIE/Hth21EIcoxTgPS
         zEG/Pxz8a4/dNmmparDp0h0BLY0sTcsOeYI4rE6yK7E6G6mLkhST9OS1rTALTq79Fozc
         74S2ArYQU1OOHSZ/moJCDIwcmWgFtR5hTcH7/j3iFTt3wuPylApkTXnwcx5VF99WNeKD
         RJvoNJm9t4E/z0j1kjIWLSVgkJIarplQvWgTVfehAFzcmf0+Zp+yvd8G5B8KZftONrdD
         4z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObKoaiwUBMsH7RgwRp2nwwP2sLs2C+zRlkZVkrEZxL8=;
        b=k1yplDKU9lIg0/Ae9q/nRm3eEKr1vQK/5Qdgkj3SuvjX0hWE1SBoM9vqRYFNACr60l
         ywWkllpV66mvxIlv9REzs01Wdm9kvTqUkCmZSOrk3ywZje7sCJQTuTndXwogLTuwCuNh
         oXjA8DyPFHkgpXLjvfCzyaqw2EqF0IVZhYFUxuz82WHnYSEilNVQZhXxU8BFkEK2i/6P
         zbaAsXSMSJZSr9n8Me8ItiHqRC9wVsivfLByhgMLatuXYNe3/NVNJflWPnzmwpOQlFhc
         Q94BUAKwYHENpLJdCeoMFBlyehBKt3xJwMrKKZJAsB4OChqknOgqbxU9pvn7+6gNrofm
         n0Qg==
X-Gm-Message-State: AOAM533Z4KTnqWy3iZx5cVIjGSunuzUpB/dlNZEQB45hBtTtGbL7SJav
        oLxD/D/+IBJ3UkGqh83FKP1/Sw==
X-Google-Smtp-Source: ABdhPJxkqzk0GPRCr9K1MAup+ksNzBdsY/taKwJeGxTcrmTr/Z34GpJMd3SoWqWuUsqXZ3BvIKddTg==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16825329wrr.325.1593439507115;
        Mon, 29 Jun 2020 07:05:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 17/20] misc: genwqe: card_base: Do not  pass unused argument 'fatal_err'
Date:   Mon, 29 Jun 2020 15:04:39 +0100
Message-Id: <20200629140442.1043957-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fatal_err' is taken as an argument to a static function which is only
invoked once.  During this invocation 'fatal_err' is not set.  There
doesn't appear to be a good reason to keep it around.

Also fixes the following W=1 kernel build warning:

 drivers/misc/genwqe/card_base.c:588: warning: Function parameter or member 'fatal_err' not described in 'genwqe_recover_card'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_base.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index bceebf49de2d5..809a6f46f6de3 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -569,30 +569,18 @@ static int genwqe_stop(struct genwqe_dev *cd)
 
 /**
  * genwqe_recover_card() - Try to recover the card if it is possible
- *
- * If fatal_err is set no register access is possible anymore. It is
- * likely that genwqe_start fails in that situation. Proper error
- * handling is required in this case.
+ * @cd: GenWQE device information
  *
  * genwqe_bus_reset() will cause the pci code to call genwqe_remove()
  * and later genwqe_probe() for all virtual functions.
  */
-static int genwqe_recover_card(struct genwqe_dev *cd, int fatal_err)
+static int genwqe_recover_card(struct genwqe_dev *cd)
 {
 	int rc;
 	struct pci_dev *pci_dev = cd->pci_dev;
 
 	genwqe_stop(cd);
 
-	/*
-	 * Make sure chip is not reloaded to maintain FFDC. Write SLU
-	 * Reset Register, CPLDReset field to 0.
-	 */
-	if (!fatal_err) {
-		cd->softreset = 0x70ull;
-		__genwqe_writeq(cd, IO_SLC_CFGREG_SOFTRESET, cd->softreset);
-	}
-
 	rc = genwqe_bus_reset(cd);
 	if (rc != 0) {
 		dev_err(&pci_dev->dev,
@@ -958,7 +946,7 @@ static int genwqe_health_thread(void *data)
 
 			cd->card_state = GENWQE_CARD_FATAL_ERROR;
 
-			rc = genwqe_recover_card(cd, 0);
+			rc = genwqe_recover_card(cd);
 			if (rc < 0) {
 				/* FIXME Card is unusable and needs unbind! */
 				goto fatal_error;
-- 
2.25.1

