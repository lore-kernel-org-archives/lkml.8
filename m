Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE48C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC8F206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eVT8cwrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIDLX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbgIDLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E8C061261
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so6315419wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=thgOsxp+Xq4BrFvbMKlBsMkOaotb5Mf5M65feuQsl1g=;
        b=eVT8cwrxekOHbn2awM3ZfKQXGCau9LbF7JlFKYje8HcsBi8kdw8bwT5Me97MX8GNxd
         3zbqMLOZoeBMVagJJ2KhmM40wM0UtJ+/WMZuhV5OgB9h2oGLJVLy/rtJLCizeNyKOCCF
         6+1QVTUCH73zBZK7rxm7PrD4SfW2dqoosEMpUpNv+24E0M4cLbmJzlvWUKC5NbAHrw2/
         TMey3+EIjbq0P7r3dKu6T52ih+OTIH6cXUJNram+F7wOOOq5/VNyA2iIgN4rZthjMPug
         alzaXRn8t1id15l8JjfkYH8EzOEAuongHzcnann6Mgu4XL6Nal/17PKy7WH472sZJD4k
         Ug8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=thgOsxp+Xq4BrFvbMKlBsMkOaotb5Mf5M65feuQsl1g=;
        b=EvKAB+MKoaGKEv3Fad6PikbhyMNG6xRQijJ4twhLFb9T3gEoG1vb5nEg3rwY2XvApA
         pgFyPO6za9VelwTrDJ4htye2CEmneQTXSfAaALYo8YHssKAlVfuB0NiVoY8VXmQ3xThi
         ai/1stkGCGQOPp88bxPM0qzPlLABXE52Njua405IuPrOmUvl37o7PMajrjhx8Wn7LVBU
         SuqiggTQjRlq0ldQoQFfK2biUf4TA8pgcJCTkPv0noBtTSl6EifExlX8sFTHo41hZ/2+
         nGfK7qzc5kALNm6Z5ESlaR1B5yHekak1EZyGHwcnqsg8Yz+eeuIzvPcAy1iMR7tUkjeX
         er8g==
X-Gm-Message-State: AOAM533azvQ3meCU8LR0/abVN6vgXIIdm8gcNYbzXD9gMNtJVwOKzRg+
        r9EGr6cKV7p/9d9WgH3bjzd+kA==
X-Google-Smtp-Source: ABdhPJxBcWh1j08Zum5PgcjZJo2NSCN3nwVnd5GJThQceGa++YbDHwW/64eOMo633e0d2SOMlxBsoA==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr6885796wrt.32.1599217818497;
        Fri, 04 Sep 2020 04:10:18 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:17 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 07/18] crypto: sun8i-ce: handle endianness of t_common_ctl
Date:   Fri,  4 Sep 2020 11:09:52 +0000
Message-Id: <1599217803-29755-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t_common_ctl is LE32 so we need to convert its value before using it.
This value is only used on H6 (ignored on other SoCs) and not handling
the endianness cause failure on xRNG/hashes operations on H6 when running BE.

Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 138759dc8190..08ed1ca12baf 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -120,7 +120,10 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 	/* Be sure all data is written before enabling the task */
 	wmb();
 
-	v = 1 | (ce->chanlist[flow].tl->t_common_ctl & 0x7F) << 8;
+	/* Only H6 needs to write a part of t_common_ctl along with "1", but since it is ignored
+	 * on older SoCs, we have no reason to complicate things.
+	 */
+	v = 1 | ((le32_to_cpu(ce->chanlist[flow].tl->t_common_ctl) & 0x7F) << 8);
 	writel(v, ce->base + CE_TLR);
 	mutex_unlock(&ce->mlock);
 
-- 
2.26.2

