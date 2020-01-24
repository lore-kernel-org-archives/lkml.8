Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1806FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12682071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tIKFta/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbgAXRpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:45:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390021AbgAXRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:45:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so286280wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxZsr9+erAKBNdZA2t780Hdr6dGcg5YpiAsOEL6tapk=;
        b=tIKFta/UGRsSrPMTUf7zZcyb2mArt7Hydx9z3Y1akywCpcNfOoqTlScHBkROIyVZXp
         wcJ0WATkies0puzuLIt0SYYSR7jgjbhriXaRLfwzIpf0hf5jS6C/PhLdCBZ/kIBrqbrM
         uJmIUy3MJjdNmz041Q85Fp9AU8LUpcPORc1aogZioIlXzvgpfHflmuVJpz6oV41XwvJL
         0628RGCZGIrOb1eyK0zHOPRjb+U3iuoOMWmAKmshO6/NUkfi4rSfeYV52c4c81VsKPXa
         d47LOJcov1Qai5F43CtwTXWKUb6nAnrn8tRRtgrrpP3T8SrqG7TlE52P98GW63E7B9oV
         UhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxZsr9+erAKBNdZA2t780Hdr6dGcg5YpiAsOEL6tapk=;
        b=iFmDSsZ7pRKWe4cqmtBdlNnsvv+gUvyDv7fxViK6yKsz2J+ylFIXfBkQxYLeqZsOnt
         5/iTFgWia+n8yoITULqwZwZKQIoD7O6/7+xPD4UBX9liGkkZZ2YXb6X9sYg05dAs34pn
         jZOC/JW76COcTIKIS+BxAGayjqcwlsOFPVV9wCjCKTg3+a1nFz+vPpLcz5RBMhAjLC0p
         1+SUfjsNH1Es1VzwSg6w5iPIPm0SgrDZGtZ+GUxIkAUEmC5KWysjp6w+RBMQkj59CblY
         3Ub2aHF4UWO0LDuvJJKiykvuxY1B6BUkt8VqeoiORA/k1gK/Qfj9fKav5DG0nkMEfbqJ
         Lv9Q==
X-Gm-Message-State: APjAAAU8cAmPKNm6XZGDcKx5640+wSaHqtrIKHIGbJ5Pso9NGgt3EUf1
        pDB06S9l22xrxU2nL0lSCKvBLG7ljFY=
X-Google-Smtp-Source: APXvYqxzRAqxQxmQ0yU0ps/hpAIPkF/pGJrSkKwfL6fWOYiO/bIyOcHM6zuXtqQjnXiTW4YEo7mDnw==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr284435wmm.57.1579887937835;
        Fri, 24 Jan 2020 09:45:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n3sm7995229wrs.8.2020.01.24.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:45:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] MAINTAINERS: add an entry for kfifo
Date:   Fri, 24 Jan 2020 18:45:33 +0100
Message-Id: <20200124174533.21815-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kfifo has been written by Stefani Seibold and she's implicitly expected
to Ack any changes to it. She's not however officially listed as kfifo
maintainer which leads to delays in patch review. This patch proposes to
add an explitic entry for kfifo to MAINTAINERS file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf6ccca6e61c..55dcb53e6a48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9187,6 +9187,13 @@ F:	include/uapi/linux/keyctl.h
 F:	include/keys/
 F:	security/keys/
 
+KFIFO:
+M:	Stefani Seibold <stefani@seibold.net>
+S:	Maintained
+F:	lib/kfifo.c
+F:	include/linux/kfifo.h
+F:	samples/kfifo/
+
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <daniel.thompson@linaro.org>
-- 
2.23.0

