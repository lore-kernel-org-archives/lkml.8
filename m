Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55DC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BD207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGfz5+HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgGUQor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgGUQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D06FC0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so77176wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALTYTDXKrPwk4EzSNXIMszQ+1kWk/MkRkisy15QSvZc=;
        b=sGfz5+HAe5VqXXtiSLqK9gghUntA+0huTOuHyQEVt6VJ6vRnz7DUsc7t7WDEpDg94Y
         Roxq3KI41Odj8qlq8h/tNgmMpXrRqnUbL0nC48bXCeXjL5E5U7uy41wYw9vM09rOzZL4
         idlc/zgKG0mHuZK/oCP3jHa8qS35Gvpjo+ngTlREE7ckPLP/kPtLVWKzwlE8w/fPILtK
         I92cqZMK29Jd/Apxq7T3EkmpZxTC7o2/MfZSD7S8AnD+dMK9lpd9fRTxko8iTf4iIbQr
         c+CmzPR+CcEhBsG81AeJY+65DarsM7Pns94XOTglcjx9KiLIBRYF388Z24EOaisF6o1p
         +Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALTYTDXKrPwk4EzSNXIMszQ+1kWk/MkRkisy15QSvZc=;
        b=UFh6sCl9y1hSxR7td++OmXg56l+iGL1IUEMG3/JXw+gusqj/5ylJ+53SDDXpBwYDEi
         LE5QfwBYkxgA28wHLUQbGLb9ZZnO+cZ0vuurzr9C9CWwdYDvrt7P471HINnvAL0KhE7T
         sIYTf25VhNAP4nHQF1DtYVF4hBxTy+rE8zEAy2IKhQ3FEdwYQGDerhk2YdbIN+oru3pJ
         eu4UoA1iOx4CehhgTSTG0Uf82ApbwoVz+Wsr9M7tkrBu2CtOOtn1b9l4o5v4WI1sBxHi
         yy8+QagLEw+QUC87h06eD6AAEHBanx9cWpvAn5YyWgLJU4WbrGYxP//0Y9IBOS2NfNar
         ea6g==
X-Gm-Message-State: AOAM531rEk0eOZoJichxw43+jW20FCENkPrg3LHHmBXjXD7hRyMLyJI4
        ZC0f7Bpb8zQI1r+aOb1AjN3tYw==
X-Google-Smtp-Source: ABdhPJzwaE8mu8izokB3w7tSQkCr+/o7WmV0tRpSkzJtMeXoQnThNWs0fP4Amj4kaKXN/X2hL/VUsg==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr4856370wmg.153.1595349721855;
        Tue, 21 Jul 2020 09:42:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Luben Tuikov <luben_tuikov@adaptec.com>
Subject: [PATCH 06/40] scsi: aic94xx: aic94xx_dev: Fix a couple of kerneldoc formatting issues
Date:   Tue, 21 Jul 2020 17:41:14 +0100
Message-Id: <20200721164148.2617584-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic94xx/aic94xx_dev.c:246: warning: Function parameter or member 'dev' not described in 'asd_init_sata_pm_port_ddb'
 drivers/scsi/aic94xx/aic94xx_dev.c:290: warning: Function parameter or member 'dev' not described in 'asd_init_sata_pm_ddb'

Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic94xx/aic94xx_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_dev.c b/drivers/scsi/aic94xx/aic94xx_dev.c
index 604a5331f639b..73506a459bf86 100644
--- a/drivers/scsi/aic94xx/aic94xx_dev.c
+++ b/drivers/scsi/aic94xx/aic94xx_dev.c
@@ -236,7 +236,7 @@ static int asd_init_sata_pm_table_ddb(struct domain_device *dev)
 
 /**
  * asd_init_sata_pm_port_ddb -- SATA Port Multiplier Port
- * dev: pointer to domain device
+ * @dev: pointer to domain device
  *
  * For SATA Port Multiplier Ports we need to allocate one SATA Port
  * Multiplier Port DDB and depending on whether the target on it
@@ -281,7 +281,7 @@ static int asd_init_initiator_ddb(struct domain_device *dev)
 
 /**
  * asd_init_sata_pm_ddb -- SATA Port Multiplier
- * dev: pointer to domain device
+ * @dev: pointer to domain device
  *
  * For STP and direct-attached SATA Port Multipliers we need
  * one target port DDB entry and one SATA PM table DDB entry.
-- 
2.25.1

