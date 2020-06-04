Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667A12072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJpHUHZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFDEsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFDEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:48:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3BC05BD43;
        Wed,  3 Jun 2020 21:48:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u13so3875965wml.1;
        Wed, 03 Jun 2020 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NiqkpM/w+JZs4P0eo38xaVvQUC+7sYCnFp9tM9zgNlA=;
        b=RJpHUHZJ5rtlH079jZ34c9Ewd/nRRN5UOZHSp+yOrq7oq1X1YRuhV/xC7y/GC99ETN
         r1z6+NUygzg7z4z1CLlUN9iJJmDnj+BY6uVNX0GnLjF39TbIPRHpOt9NUNfZ78ZATKLl
         FnXo/Iy+OfVPLILhSPfkm7QIo7ipgGMwRzhPY/DOQ3fvPTW7eYZJy3Q2fKiCxszTLNGB
         sQqjU2wy9G3k0eEkBMpb1pYgHZtU1XUhHKPFSP4hjPlXj3fX4c8A4XUAx+cqjMUzhyM2
         eoMKw8uGEDBYEAil1sOLx5tdSMuGeJIJCEQ4WRNMetTUl3HvVEOGycjqNOA70ecj3F85
         ulMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NiqkpM/w+JZs4P0eo38xaVvQUC+7sYCnFp9tM9zgNlA=;
        b=OQvCVCxTNyB+9Tw4r3DUKIm8M/Y02Edq6o1z91/gpz5ySF6tmYCJBTTNt/kwPnscva
         ZzhX4yFgAdobLcrDnPWWAU3jOPkN4m5E4pE4hsewgSIEMmRcqCk1dyMLLFFZo3KHExAA
         PgLamNEpAW5sxOJOWYNgPjjR/0VVcCxfvGoUqQOo44renEve6IgpuM1D65jisjLx8LoU
         yVHuXGMpBat8n4CR74WGNBiRI01skU7gYLZDj451B3s6GeeeEri4IHK5hTJ1zHfOFuT1
         PL6g89oblaGYw14lZESoxYvotbJWEOGpvznx/k83FCLC/Hz4jBHcGGqSHE8mJJLyYxye
         w/Ug==
X-Gm-Message-State: AOAM533vYKFfwSK2IOA+hk75NSW/mJLbosnJ2h2zaqNpcZSkga6YVMq4
        8S/8j1a+QJY6ih3YxQHlR6s=
X-Google-Smtp-Source: ABdhPJzYH0zI5Nab6ZoyXhJ1nGO3ZWVm28otZxnBQpZbtdQXXLh9do4Nkd8vrhaCUrRwpae8ziyN0g==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr2222544wmj.187.1591246092837;
        Wed, 03 Jun 2020 21:48:12 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a15sm6349708wra.86.2020.06.03.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 21:48:12 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: Fix S905X3 ID
Date:   Thu,  4 Jun 2020 04:48:08 +0000
Message-Id: <20200604044808.30995-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current value is taken from Amlogic's 4.9 bsp kernel which appears
to use the wrong ID. For comparison, here's before/after:

[    0.152237] soc soc0: Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2) Detected
[    0.152463] soc soc0: Amlogic Meson SM1 (S905X3) Revision 2b:c (10:2) Detected

Fixes c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 01fc0d20a70d..c38a1e4db28b 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -68,7 +68,7 @@ static const struct meson_gx_package_id {
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
-	{ "S905X3", 0x2b, 0x5, 0xf },
+	{ "S905X3", 0x2b, 0x10, 0xf0 },
 	{ "S905D3", 0x2b, 0xb0, 0xf0 },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
-- 
2.17.1

