Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA61207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffLk41fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgFDPb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgFDPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:31:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76838C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:31:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so1323336pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhswYDutUFPJgb8N0mTl46V4k906NYmLzRtiupxWANA=;
        b=ffLk41faa7mwXKQQnk5dKmHTMftBh9aYYkjKMsLOHu0mx/nu7lwZSQV2WrD8lG1qt7
         JxoH1nQt0se/yYCGkcpoZSftzkxxKght2CG8Gb9srTVekcJMG7jIne+w+5sO6v44JCgl
         bxda8ZxDGJwjUokJaL1wa1OtLurTNJhySWNb4iKWvlBpeEP9sKboGvyi2s5FT7h4+F6D
         nzPA5VcLTctdIXWkUXWVea1EoEfwIu7pq14OA49PQHrwzWUjbU9rkQRBJxOOPP0aZlfs
         35hhQeRkPVRsaKYSVSIV737+hVfNH9x4nA6SGIdv3Xy5SGNV4ZSE3Anid3ZUnwK5SSa5
         icqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhswYDutUFPJgb8N0mTl46V4k906NYmLzRtiupxWANA=;
        b=Ne1RcKFg14+ZNUJrHgBw3QZPZN5R9T8aMw8ReI6of0C7Hizj4KnPF6ypZuQoomUnx+
         5MoVeRqLPl+JoTtsq+/4KuFFVUagTT6afl7HVWirvuJctbIf4x+j9PhdsF0RmAojCJla
         HNf5xkL/D1fzBSCozdEzDY9A4/+JgB1R6eQepnk6w1N/V3z2desl8UhKHI+GLNrpUpIz
         JX0hrfNOtzHDBHVy4DXGftfSF3Eje78IzpRfWfXxpWHIM6ZJkw7EmkaAt6VO87azls9N
         949ae0zO4xehtoOG7cUgRe0L1vaw+cgdbi3uuRBNrQjS2vU64zHaoaZyvL04K/bHbz0u
         JN2w==
X-Gm-Message-State: AOAM531GiggIXqiMISnd7alFCYDg0BDWAQ+fkNBJ10zBGEU2oLJst9QA
        xjJkr03KH2k6hTDK/Gf0Aws=
X-Google-Smtp-Source: ABdhPJxUxp3Z32L5nfJqOxzuA535QyPjHazSxz35A3u5AdsMw+4hopPxmnomDltbOfRdq2a+3OfLxA==
X-Received: by 2002:a17:90a:c094:: with SMTP id o20mr3406247pjs.37.1591284683937;
        Thu, 04 Jun 2020 08:31:23 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id mw5sm6795722pjb.27.2020.06.04.08.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 08:31:23 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] reset: intel: fix a compile warning about REG_OFFSET redefined
Date:   Thu,  4 Jun 2020 23:30:39 +0800
Message-Id: <20200604153039.22957-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports a compile warning about REG_OFFSET redefined
in the reset-intel-gw.c after merging commit e44ab4e14d6f4 ("regmap:
Simplify implementation of the regmap_read_poll_timeout() macro"). the
warning is like that:

drivers/reset/reset-intel-gw.c:18:0: warning: "REG_OFFSET" redefined
 #define REG_OFFSET GENMASK(31, 16)

In file included from ./arch/arm/mach-ixp4xx/include/mach/hardware.h:30:0,
                 from ./arch/arm/mach-ixp4xx/include/mach/io.h:15,
                 from ./arch/arm/include/asm/io.h:198,
                 from ./include/linux/io.h:13,
                 from ./include/linux/iopoll.h:14,
                 from ./include/linux/regmap.h:20,
                 from drivers/reset/reset-intel-gw.c:12:
./arch/arm/mach-ixp4xx/include/mach/platform.h:25:0: note: this is the location of the previous definition
 #define REG_OFFSET 3

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e44ab4e14d6f4 ("regmap: Simplify implementation of the regmap_read_poll_timeout() macro")
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/reset/reset-intel-gw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
index 854238444616..5cfb4892b399 100644
--- a/drivers/reset/reset-intel-gw.c
+++ b/drivers/reset/reset-intel-gw.c
@@ -15,7 +15,7 @@
 #define RCU_RST_STAT	0x0024
 #define RCU_RST_REQ	0x0048
 
-#define REG_OFFSET	GENMASK(31, 16)
+#define REG_OFFSET_MASK	GENMASK(31, 16)
 #define BIT_OFFSET	GENMASK(15, 8)
 #define STAT_BIT_OFFSET	GENMASK(7, 0)
 
@@ -51,7 +51,7 @@ static u32 id_to_reg_and_bit_offsets(struct intel_reset_data *data,
 				     unsigned long id, u32 *rst_req,
 				     u32 *req_bit, u32 *stat_bit)
 {
-	*rst_req = FIELD_GET(REG_OFFSET, id);
+	*rst_req = FIELD_GET(REG_OFFSET_MASK, id);
 	*req_bit = FIELD_GET(BIT_OFFSET, id);
 
 	if (data->soc_data->legacy)
@@ -141,7 +141,7 @@ static int intel_reset_xlate(struct reset_controller_dev *rcdev,
 	if (spec->args[1] > 31)
 		return -EINVAL;
 
-	id = FIELD_PREP(REG_OFFSET, spec->args[0]);
+	id = FIELD_PREP(REG_OFFSET_MASK, spec->args[0]);
 	id |= FIELD_PREP(BIT_OFFSET, spec->args[1]);
 
 	if (data->soc_data->legacy) {
@@ -210,7 +210,7 @@ static int intel_reset_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->reboot_id = FIELD_PREP(REG_OFFSET, rb_id[0]);
+	data->reboot_id = FIELD_PREP(REG_OFFSET_MASK, rb_id[0]);
 	data->reboot_id |= FIELD_PREP(BIT_OFFSET, rb_id[1]);
 
 	if (data->soc_data->legacy)
-- 
2.25.0

