Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B4620748
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="u5vq99qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFGJe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgFGJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 05:34:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33017C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 02:34:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so12409759wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jO4Gf5vLoDxG10CqidsBX3PHY+cpXa3QTlcT6snTQY=;
        b=u5vq99qwD8VvgdNaC9gqTFFkWqZzfiHN3S9h5GUQ+biyLVXmEqHMVoa3jYbJG98FGT
         A/l2kQxNffa0d5B0d6pXPCg6xtEsM7fbgmR1QYM+uxoUwDCFzDWcaJam+g9i01jMNAbA
         Hi+A2rlMZoBHCso8VkwQtW2+WSLZV7bZDTffltj7r9p8VDF1I8lYouu4wGslGCdpYN2f
         jvREBKhdxBDHjC9zT1LvZDH6af7DXBG4OoC+hOo1JK1zrfyOMD9NSQuOVWJj/KU/H942
         7QHC5ayh+5lmVsF1kbwnVZRKi6JKeUb+9Hx83VmD4WZPxwTgugxV9zvJ/ajIY+1V97/S
         ap0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jO4Gf5vLoDxG10CqidsBX3PHY+cpXa3QTlcT6snTQY=;
        b=ZEQCgdLOqtx57XEmtfRGi9SWXznCnpLyXGkd6si6qbWHpurLow4nOfKTAbkQ4Mj/VL
         PTUSbqRUwxVBZwxc78JxL/lbbBD+eeT3BeeM5oTOmte+TEkll1Ss4J+Sb/HeQ8+KPNNL
         PuwG+PKprgkanXfW+AkmX/LeOW1mvbLaUcpug8k0XMkM62vA5tugUFZS6mCQw4WwdZfu
         agHLilSoyqnMohngq71NVMeQg2KsbWCn/OnKFS07VkroR8lLhPOeErTGB1ZL+CB55Ju+
         VQdEDdbQMESnjnwzs+NiQIQo9SuCzFNbndK8QiL9odjCYKjP+XhfCwEbwUr0erBmR5Mm
         qFIg==
X-Gm-Message-State: AOAM530rzYLM1irwPNoM2XD5aobkfKJuADqLecooU1WGjt3Pf7GejspN
        LghnX7LxcmFIXBtgSWQsh+UIqA==
X-Google-Smtp-Source: ABdhPJyU515hX/Hph4grEQkiRDNx5GwFKo/3OyB935wW6tQNYCMoV3+gA98My1/SDk53Et+YPOUozg==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr11467437wma.110.1591522464745;
        Sun, 07 Jun 2020 02:34:24 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 40sm20304162wrc.15.2020.06.07.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 02:34:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regmap: fix the kerneldoc for regmap_test_bits()
Date:   Sun,  7 Jun 2020 11:34:21 +0200
Message-Id: <20200607093421.22209-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The kerneldoc comment for regmap_test_bits() says that it returns -1 on
regmap_read() failure. This is not true - it will propagate the error
code returned by regmap_read(). Fix it.

Fixes: aa2ff9dbaedd ("regmap: provide helpers for simple bit operations")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/regmap/regmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c472f624382d..1aedca53cca2 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2944,8 +2944,9 @@ EXPORT_SYMBOL_GPL(regmap_update_bits_base);
  * @reg: Register to read from
  * @bits: Bits to test
  *
- * Returns -1 if the underlying regmap_read() fails, 0 if at least one of the
- * tested bits is not set and 1 if all tested bits are set.
+ * Returns 0 if at least one of the tested bits is not set, 1 if all tested
+ * bits are set and a negative error number if the underlying regmap_read()
+ * fails.
  */
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits)
 {
-- 
2.26.1

