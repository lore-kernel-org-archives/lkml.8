Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2FD2068D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zodKNRyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbgE1MfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389747AbgE1MfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:35:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A178C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:35:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so2961537wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDSm1rPPo/8bMFb7LxsC5JFRiypy8MuySa2sX9QoT6k=;
        b=zodKNRyGTNg5KwqVWbLILj8EVpRQ43j6yVRyfaj1XFuodos5q4ztpHt6BwxCRnMjNj
         NTTiJhdaDCdWk/EFdPe+sPBf9p1nqeIsAHR6SYtD5sJnrOQ5/yrGkHqB7VoLrSNNMZvB
         BbOHzyM3Ob8NxF9JrEtovxhOh7kEAlYHpw3RshZ9G6iUfgBIaftV5iVMnumDsl2MHC45
         /xZ5h0k3mu9osvUv7kq6Q2uoEeTjI5Xf0Bf8HUgmq8jzuRVtjMo3iqhZgPHgUx8Kunc9
         EHswAWcH0gwFiqxp3J/8+la0Oz33xbUZOHwzQ27wt3sN0qBvXvUMVv0uR6pCNEpzYQ+q
         4cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDSm1rPPo/8bMFb7LxsC5JFRiypy8MuySa2sX9QoT6k=;
        b=nTXZiie55BEaadGjzLyazrdyjD4Nm97oFd2eFTHOSjz0+C0/MQauAeHlUrGGYBIN0i
         n1kN7kE1yqtK1qvlMNwdZtXd/45zUCS7CoSJ+eYIcDxrUaoctBhJ62ruuwV2wphwor0X
         4jkLZaWzgthPDQ18aZ/ooltyT3i2MK6sO/6SE9GTJ+F6xA1rg74I99Q+Cx+jgQ0Eljq2
         82Qu8frdfpOhrsw3gWjFMnUQ78boRbDctVdPVse98X5XiPz9w6eU5UobucbHrwETBvxD
         8W2DzOYHEE3aDROaJ2mT9zc5dQ5xlr6PGMaduaE33nBAZRAg2KjkLgs7YbDBISSpk5gS
         UOeA==
X-Gm-Message-State: AOAM533py8iiacohVaDhpBKhSxyR3+3bIUhEeMqto3DQk1Ag2ly2W0N5
        E6omTTsVvAWELhbcd6wEEVEexA==
X-Google-Smtp-Source: ABdhPJzo7HKPky+eiHqC/4RzI4UkiT25uBdmy1Qy7IDl9itDPpLuRbDcwrzxzj4u0gG1VZdg4XRYgA==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr3156200wmg.130.1590669312286;
        Thu, 28 May 2020 05:35:12 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c140sm6027306wmd.18.2020.05.28.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:35:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] regmap: provide helpers for simple bit operations
Date:   Thu, 28 May 2020 14:34:58 +0200
Message-Id: <20200528123459.21168-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200528123459.21168-1-brgl@bgdev.pl>
References: <20200528123459.21168-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In many instances regmap_update_bits() is used for simple bit setting
and clearing. In these cases the last argument is redundant and we can
hide it with a macro.

This adds three new macros for simple bit operations: set_bits,
clear_bits and test_bits.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/regmap.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40b07168fd8e..6ef829169f36 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -71,6 +71,24 @@ struct reg_sequence {
 	unsigned int delay_us;
 };
 
+#define regmap_set_bits(map, reg, bits) \
+	regmap_update_bits_base(map, reg, bits, bits, NULL, false, false)
+#define regmap_clear_bits(map, reg, bits) \
+	regmap_update_bits_base(map, reg, bits, 0, NULL, false, false)
+/*
+ * Returns -1 if the underlying regmap_read() fails, 0 if at least one of the
+ * tested bits is not set and 1 if all tested bits are set.
+ */
+#define regmap_test_bits(map, reg, bits) \
+({ \
+	unsigned int __val, __ret, __bits; \
+	__bits = (bits); \
+	__ret = regmap_read(map, reg, &__val); \
+	if (__ret == 0) \
+		__ret = (__val & __bits) == __bits ? 1 : 0; \
+	__ret; \
+})
+
 #define	regmap_update_bits(map, reg, mask, val) \
 	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
 #define	regmap_update_bits_async(map, reg, mask, val)\
-- 
2.25.0

