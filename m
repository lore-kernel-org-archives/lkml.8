Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D30C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A362078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8SHhWvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD0XdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0XdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:33:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D4C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:33:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so7582524plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psE/TVWQ8r0hHEn8TaByg+EQGlqN2iYLLSNjuoRCa9k=;
        b=b8SHhWvZTnoeLLp7IhgorcpvGtX2VBtc6vtxpVWuQoeDabjj0nAmuP6/TiuQUuiRNh
         etINFZ53Wf2AxOzz/nSnynJ4yALdIG4FmtD9L7neNUYUJq9Z2xbTJRF74DW8l6RrICQy
         4m3riY6RULFDgxpguilcjn9XbHCWm0rHcTDJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psE/TVWQ8r0hHEn8TaByg+EQGlqN2iYLLSNjuoRCa9k=;
        b=PIz05DJndbj9J5O8ki2Ow0PvT8y9rwsaM0SIHKUB1Q51H8nAzlXmBYycC3V7w1EzJG
         60wz18Gs1O14QUxT6UEjk+8tye167srciL6sV1CJH5oMgj79+Rjofnu3YsxE2XZo8KDC
         2IEn+4Lai18JXdheMasA0tapTFi264AnXJVjU/tcEFBl8QeqePiDvK7iKVrMo+7RVNJa
         pcBjhzXlFmBeczDl3lSjCmXo+YsZZIsqra0XmVXeBO8LuyyhgsZc7AteQRFC9tT7/dRk
         ucfxYPTEcAd81IanOzr0zeZzyEpakHn4PY+kG021ECOUIRWN8lBbANGqmnHNTTIxB7VT
         jrrg==
X-Gm-Message-State: AGi0PubG92kO39qiraey4VN65tR8nEaDfHX15lmviIgpTVvtX2fmAl5D
        gMh7OyBgqlXhUC/tK81PaQk6rw==
X-Google-Smtp-Source: APiQypIltu09rqzr9JI0Ay36qw8wC98n1LszdiP6AYWaeNG61gnrxNMq7cNJFmvmNXJIZr8u6f1mqQ==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr24753613plb.340.1588030381558;
        Mon, 27 Apr 2020 16:33:01 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:1c5a:73fa:6d5a:5a3c])
        by smtp.gmail.com with ESMTPSA id u15sm308980pjm.47.2020.04.27.16.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2020 16:33:00 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: pxa2xx: Apply CS clk quirk to BXT
Date:   Mon, 27 Apr 2020 16:32:48 -0700
Message-Id: <20200427163238.1.Ib1faaabe236e37ea73be9b8dcc6aa034cb3c8804@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a couple allies at Intel, and much badgering, I got confirmation
from Intel that at least BXT suffers from the same SPI chip-select
issue as Cannonlake (and beyond). The issue being that after going
through runtime suspend/resume, toggling the chip-select line without
also sending data does nothing.

Add the quirk to BXT to briefly toggle dynamic clock gating off and
on, forcing the fabric to wake up enough to notice the CS register
change.

Signed-off-by: Evan Green <evgreen@chromium.org>
Cc: Shobhit Srivastava <shobhit.srivastava@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I don't actually have a BXT (Broxton/Apollolake?) system to test this.
To be honest I suspect the issue is there in older generations as well,
but I couldn't get Intel to confirm that, so this seemed like the
only safe change.
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 73d2a65d0b6ef..20dcbd35611a7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -150,6 +150,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 48,
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
+		.cs_clk_stays_gated = true,
 	},
 	{	/* LPSS_CNL_SSP */
 		.offset = 0x200,
-- 
2.24.1

