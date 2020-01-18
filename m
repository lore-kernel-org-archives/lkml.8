Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65762C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A3924680
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uY7GjVez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgARU4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:56:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43119 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgARU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:56:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so25854265wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SK7/yao5fsaBBNvMW9060fS3yhEeL6JTPeMbh6+XWqc=;
        b=uY7GjVezYNXJ3TKzjl3dgF372yMrTSK7w8G47a/AMGYZwte7SDotv1Z4OSzMi2hFbU
         HO70+ZQbQIVHEcDERjal0Q4EtM6qCSNRB5pTYuOYBj4F/gmd0cx5jvmYKNCf4BoqyLTF
         oAL1hIaF3KswqbIZ0b7nH4rOZbzF5NqcfONvMDucYT+E+OUBfsDxKdYRBpaxfjrkADEP
         UhQls3ufvsek5LwLYty8+TSLu/Yz0xEB4KlSt2KPffq2sS9DOMomkyOScz7k5THZK4ZO
         VR7PCf69zcSS2jneZ2x+glnImSDlw/hO3OhmwNSulHSrQgbE26NKp0vpGM9hm8VMel74
         EqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SK7/yao5fsaBBNvMW9060fS3yhEeL6JTPeMbh6+XWqc=;
        b=m7BGUi2ub2msJDcwrhybzDYEaHzWdCcWMX03uk7ZdHZaIx7ezrI+9FPPMgQ6y6QnsE
         xQ2D8FwgQZikuAWIyceh0UOVdKmWkskyaEtVuTL4tflSBQ1FhikNreW2kHiGyQNqT61x
         vFeqNZXJ079ESqNfF2UicFMyjLdUuq1wzZvn1yIE67takWDS/Pj7RXVgJKnpZ9pepJ8C
         dPO37EPHT6U+kVaR1Yzlg17WfkMYAoItEv4VJyRIE+TJ6UpM7w4oc7xASbytBBwHbbgk
         revT8oOtXHV5h+y3gHVYMxeueEQh9LGH280dKx8FXMg90K6FPM0zs8v3Z5PuCFhbpfod
         L3yw==
X-Gm-Message-State: APjAAAVhTi6xC6eA7WewAEZEP4/iCe9JKBLZw28Wazkxp89VGy+1jnFo
        48YxozVi5RMDeuk6RwvOU+CMGy2gYKDwIA==
X-Google-Smtp-Source: APXvYqz62KvAMiiicYrdtpzq79/NMDixMBfVUQi/cgwdgvWRPUa4ige7jZ8h4/yZHPX7LjHyYk6pbQ==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr10209792wrx.341.1579380996778;
        Sat, 18 Jan 2020 12:56:36 -0800 (PST)
Received: from Lappy.lan (cpc157701-rdng30-2-0-cust857.15-3.cable.virginm.net. [86.18.131.90])
        by smtp.gmail.com with ESMTPSA id t125sm16244042wmf.17.2020.01.18.12.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:56:35 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afaerber@suse.de, Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v2 1/2] regmap: fix writes to non incrementing registers
Date:   Sat, 18 Jan 2020 20:56:24 +0000
Message-Id: <20200118205625.14532-1-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking if a register block is writable we must ensure that the
block does not start with or contain a non incrementing register.

Fixes: 8b9f9d4dc511 ("regmap: verify if register is writeable before writing operations")
Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/base/regmap/regmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 19f57ccfbe1d..59f911e57719 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1488,11 +1488,18 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 
 	WARN_ON(!map->bus);
 
-	/* Check for unwritable registers before we start */
-	for (i = 0; i < val_len / map->format.val_bytes; i++)
-		if (!regmap_writeable(map,
-				     reg + regmap_get_offset(map, i)))
-			return -EINVAL;
+	/* Check for unwritable or noinc registers in range
+	 * before we start
+	 */
+	if (!regmap_writeable_noinc(map, reg)) {
+		for (i = 0; i < val_len / map->format.val_bytes; i++) {
+			unsigned int element =
+				reg + regmap_get_offset(map, i);
+			if (!regmap_writeable(map, element) ||
+				regmap_writeable_noinc(map, element))
+				return -EINVAL;
+		}
+	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
-- 
2.17.1

