Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41471C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1145E2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IW8Nq1rZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZFoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:44:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgCZFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:44:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so6189250wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=h0ejKou3PvcWas8KLgU1Vgi0OUh6RoWa09ZoLAQ+TQI=;
        b=IW8Nq1rZ/uLO0TwwAi8lrCppYJJJBWSuBSGKMXw5m/TDeX0358hp+NYFcaJWNJ4PZQ
         aOMO4wwXAJgv0TuAC5cGR083rWjKNB46TyC0NC/nhOOmsPsi4VdXMh3hMdLIdoI90F/g
         N/ElwBrxxMYn4KSddSxdYWPOxB+EvgUzemocQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h0ejKou3PvcWas8KLgU1Vgi0OUh6RoWa09ZoLAQ+TQI=;
        b=SaMa0oEok4JXFgO81sNHEqqKsnoFaG7gZ0B0w9uj6Sdti0s0iRxdjjR4CVrxxENjv9
         tUnqlyZCFto4FHLs7+tfdpy7ox4DWYMrM85POmG+zOziN/xOj3kkJwNUJfW39nAsoBtF
         IIL8LDpacr38PE+4fId4zXlFxVuGs5VnFGetvFFp8CTqrEZeEgIVVcHFch+7oaz2fxAn
         rRkw3foEJCgCV9kes7J8gXvbGPORKaRzfA+pX6tzVkNL5ftQBCYqvuXVtRRnWpQGSeJ5
         eeM1N8YfSyHWash6uEMOnoB2OcJUfx1OPGD6z/2XTYmgkZ/CEkg4dbfLHq4kgRB6wpla
         IMmw==
X-Gm-Message-State: ANhLgQ3qRkqsWDrESjMs/Zgmh1c6SiHxc2opnKp4CkwOU07ItF8oeRFo
        uDnhdpp2sUPRjPlXzQQrdEbKPw==
X-Google-Smtp-Source: ADFU+vvDU6utkHBBfkDu4oMFaZYAZVIFeP5ITO7RdCQdQL9nUeIt4oh2YBUjtHz8qBilsaYhgvv2Ng==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr7711875wro.342.1585201448222;
        Wed, 25 Mar 2020 22:44:08 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a14sm1942154wrv.76.2020.03.25.22.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:44:07 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] checks: mask flags bit when check i2c addr
Date:   Thu, 26 Mar 2020 11:13:45 +0530
Message-Id: <20200326054345.9806-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally i2c addr should not be greater than 10-bit.
The highest bytes are used for other purpose, for ex 2 bits
are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS.
Hence mask upper bytes if check slave addr valid.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 checks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/checks.c b/checks.c
index 8acbc05..5c7f2b1 100644
--- a/checks.c
+++ b/checks.c
@@ -1051,6 +1051,12 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
+		/*
+		 * The highest bytes are used for other purpose, for ex 2 bits
+		 * are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS.
+		 * Hence mask upper bytes if check slave addr valid.
+		 */
+		reg &= ~0xFF000000;
 		if (reg > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-- 
2.17.1

