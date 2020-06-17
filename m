Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5061C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE112098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugb4AiwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgFQWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgFQWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:32:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B99C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so2315189lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xpYgegvJlAfjA6nhvAqU8scim9MLLJ1/B+p2ezgRb8=;
        b=Ugb4AiwNaOytECIaRMhREomTX8cIvwSNDBSUVO8CUgX+0QwXkEP9sruc44k2mjbkN+
         QCNH5cMU2JEcHFOtuUlYreQcrUtldoHl7f+siQClTzFqH/3MHutm77bbHhhcCFfKJkqj
         kHCP06s78lI6ObJc7EV7Hf6T+YkdIMtxsTPPRCSgogzuais3bXSGL/SAwmv7MNAqXVgX
         i/U+irnsVgLBhQ6YHtjrK0KwI+vVTemVCqBT7BKItE3yofdRG9nAouX0X4fLo8VhxDWq
         nY4C3z/XhJx071Ifq4mGsMFR6NQzXbiX+hg/TMFlyPDcAXmIEoIHN7urdFGjwjs5bwqq
         Xv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xpYgegvJlAfjA6nhvAqU8scim9MLLJ1/B+p2ezgRb8=;
        b=AYj7UMkemfc5HNZOr+iBS2OPEzOmp58oUYAtqTuqSjliHsCo2Hd4RCXoHD8uKzNRuA
         4ZcfmoLhM7CSFjhecEXqJTnZaFtWNduHZYlb6bZV447wNVmdR3iJmx8xwPIAECJxNXY8
         9YA4A0xUhD+GX8Pr4VYrXtMDNX9iLpixvzv6xTE8kU4BzxxHsL3bfoJEViBVhLIOLD4O
         6Zd+eO4rMbzMmOIafw1pRR2Jr8kXzeLhl/EwnrGjEFIocFcba2WWMaVBkrpzFJkT1YyF
         BG0i4Sc3mInUY/QDF4Zv1z2ZPiLyllDh74M0+bcjFZE7AOdf+LNZqen5wwXYUWcaJsdQ
         I9jQ==
X-Gm-Message-State: AOAM533Y4NXXBzZd2KMH9EOZLhGfVySu07GYrqL80tMbz1LBaJlytHLD
        liA0+2CKowLSSj7VEb16iZc=
X-Google-Smtp-Source: ABdhPJySw7w9OLtF/+imkVAxU0WWTxK79DPWVFP+yMGy1OTwuXZMZbkXvbpFUQF88/kiQhiZFa4TOQ==
X-Received: by 2002:a19:381a:: with SMTP id f26mr615295lfa.110.1592433175518;
        Wed, 17 Jun 2020 15:32:55 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:54 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/5] regulator: anatop: Constify anatop_core_rops
Date:   Thu, 18 Jun 2020 00:32:43 +0200
Message-Id: <20200617223247.25566-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anatop_core_rops is not modified and can therefore be made const which
allows the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   4502     412       0    4914    1332 drivers/regulator/anatop-regulator.o

After:
   text    data     bss     dec     hex filename
   4634     280       0    4914    1332 drivers/regulator/anatop-regulator.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/anatop-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index ca92b3de0e9c..f9856d4e295f 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -139,7 +139,7 @@ static struct regulator_ops anatop_rops = {
 	.map_voltage = regulator_map_voltage_linear,
 };
 
-static struct regulator_ops anatop_core_rops = {
+static const struct regulator_ops anatop_core_rops = {
 	.enable = anatop_regmap_enable,
 	.disable = anatop_regmap_disable,
 	.is_enabled = anatop_regmap_is_enabled,
-- 
2.27.0

