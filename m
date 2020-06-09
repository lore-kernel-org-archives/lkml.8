Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C8F207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWGZMKq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFIINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFIINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:13:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC37C05BD43;
        Tue,  9 Jun 2020 01:13:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so2147881wmf.3;
        Tue, 09 Jun 2020 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lZ7VE8MJqXCHe4aK3RhJA3tLbplzIKIABkTQkxT78RY=;
        b=rWGZMKq/kOuU301GSAaPvp4rBCCwFkzOES+PoDn1UUS7TUCOaBoWz/yWNPukuptWh6
         +bMjxUoQhzLSLKQNZ8CqCnBQozorbON4z3k+T085t+Y4D2IPpaQE1tiITOFFd11mKfZv
         U4LxxjNZZo+lFRHty637BqChZLZKRua1mBeoB3nxT6+grzMnnhPiPli84gFBLpRvjxKc
         oLcQnbvJclLwCz1aeiWQQfJkbTEVx2TmxGSQYGrWRt9libdDBZNG4Gn1Bed8G2wMIcrS
         ns8ZPr00anFE7iwL4SbjAyU0zVR2199DTF3DMGisD27D5+mdGLAu+6I4NuEri1r62Fxd
         jnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lZ7VE8MJqXCHe4aK3RhJA3tLbplzIKIABkTQkxT78RY=;
        b=MSLlyRXQBkaJ4JSqad97OQnIuAA+5YPI03/oN4dhPrU8jKgx1eezkP2y657W0OGw2/
         l+fNQA35928ONZviBaQJtjKFx71eU3NvTukMtF03hquRpm+HPuj0k6i7A0WLOaBNXKU9
         Daq5ujNX+16DNFAjkPzzMhSzE7RDrduHjNdI6AXulKPdiiMo3rZZo+dd3I+q9xGKPmSm
         5HwGFChWuBngvlefEma2BxAoeIZTCEN6g3hxa7gc3PN4wauo1Yk4k1xLFxeNut75Gj1t
         A2N8COAxzkTQoy+DmV3ejZK5BxpYzh1tgI/kqnGOyqsEAsYcDHzHAJMwkYlAjrDSqVZJ
         e26w==
X-Gm-Message-State: AOAM533mlUv3kWQJVMolgUWH2kgdkfuR5v9a5mnU996GyMVH4Ql2axIw
        FtD6bcdvt7RmZ9fV+qv/tNg=
X-Google-Smtp-Source: ABdhPJxCNhNE2GjtWTuK2fi3hX5buGWkwehYCaPfXFVQJllgy0khVjdpFVR+LvdnpUxm1iaF4ALyow==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr2816407wmo.139.1591690403687;
        Tue, 09 Jun 2020 01:13:23 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d11sm2418557wrm.64.2020.06.09.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 01:13:23 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3 ID's
Date:   Tue,  9 Jun 2020 08:13:18 +0000
Message-Id: <20200609081318.28023-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the SoC revision and package bits/mask values for S905D3/X3 to detect
a wider range of observed SoC IDs, and tweak sort order for A311D/S922X.

S905X3 05 0000 0101  (SEI610 initial devices)
S905X3 10 0001 0000  (ODROID-C4 and recent Android boxes)
S905X3 50 0101 0000  (SEI610 later revisions)
S905D3 04 0000 0100  (VIM3L devices in kernelci)
S905D3 b0 1011 0000  (VIM3L initial production)

Fixes commit c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs")
Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 01fc0d20a70d..6f54bd832c8b 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -66,10 +66,12 @@ static const struct meson_gx_package_id {
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
-	{ "S922X", 0x29, 0x40, 0xf0 },
 	{ "A311D", 0x29, 0x10, 0xf0 },
-	{ "S905X3", 0x2b, 0x5, 0xf },
-	{ "S905D3", 0x2b, 0xb0, 0xf0 },
+	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "S905D3", 0x2b, 0x4, 0xf5 },
+	{ "S905X3", 0x2b, 0x5, 0xf5 },
+	{ "S905X3", 0x2b, 0x10, 0x3f },
+	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
-- 
2.17.1

