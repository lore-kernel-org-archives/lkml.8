Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166DFC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43572071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dGTNCcnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgDUIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgDUIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:01:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B11C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so15308000wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8x2qbrmvJrvzLhSdZyiezkJo4hKvmqVH04B778IZt90=;
        b=dGTNCcnGr7YtPFf7J6XDaRYOU2CiBaCJhYNx09RmlAPeojd7c14ojBOwblaGyqje5J
         WlHC8CdEZ5ZGd2aGNslxywnwSLnzXx66X945Y1gGFesYLDy7pTBXaZVH2xHQ2llnHRJE
         vDYT9lWrKI+Xl6GV5za29OV/+p9Lnm7qhD7moZpHDPwhUYzF301asuOKHkFSC0FrJ5eb
         8Coh7+dbLi4ywxt7d0Wxl/e2rvqbPOGO+/6LRv7cJrOZkSqXFinuBl0ytSHkNtPqWvOM
         sTPL5jKQ/j4QtCgLNgZYIl92+Xf5k0fU8Bdgrv98mdvjRzX4hbDwRD5PWihG8IOAlhAA
         UdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8x2qbrmvJrvzLhSdZyiezkJo4hKvmqVH04B778IZt90=;
        b=RKiOfFLSOdu6+8MhAcgRiADCIfUAVrKkuBSNGg+JKT0sRR/VVi/ZDueghyBkvPA1tp
         x07TKbocExiXu4HdX4mYnozeWoqhd2I9odgy6FN5sXwDUMd7myMdMpnh71FT8QUUzbAa
         v/34lAFbXKWLPcB3JR6BIcslhiBVBEhc4nTRGC/JdY8ZI+TrInDd/Wzyoj+cUPGtvexl
         xAAwBfXNm6aVJFw818vnoRfvjSRPHO4PLUj4xINVyWIsBxsBu/cnoykuocl0V1E2SO5M
         8EUV9Vzk58diYZZ+o1PkmUFlKjIiF3CYIcBNSy1L9n2sWUoYbAKNp2I/j8PxgdAtxxOd
         /mHw==
X-Gm-Message-State: AGi0PuZN9E1sybD+tz1avu4B4gQUf03dM5VJmPaR7Ad2opA9HzHsvqVn
        4EwD+XdiMkDmBtBHJpXIuOBOyg==
X-Google-Smtp-Source: APiQypIiWqXPmC/5mQtYcIdPcfFDsrYy87KwONuuyBh3FM0Eo21Qb7uC8L4gifzvCSJ9ml9PyD7LFQ==
X-Received: by 2002:a5d:4381:: with SMTP id i1mr22202504wrq.194.1587456074451;
        Tue, 21 Apr 2020 01:01:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id x132sm2561552wmg.33.2020.04.21.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:01:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org
Cc:     nick@khadas.com, art@khadas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 5/8] MAINTAINERS: add myself as maintainer for Khadas MCU drivers
Date:   Tue, 21 Apr 2020 10:00:59 +0200
Message-Id: <20200421080102.22796-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200421080102.22796-1-narmstrong@baylibre.com>
References: <20200421080102.22796-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HWMON and NVMEM drivers along the MFD drivers and header
as Maintained by myself.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..4484fa568d42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9431,6 +9431,17 @@ F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
 
+KHADAS MCU MFD DRIVER
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+F:	drivers/mfd/khadas-mcu.c
+F:	include/linux/mfd/khadas-mcu.h
+F:	drivers/hwmon/khadas-mcu-fan.c
+F:	drivers/nvmem/khadas-mcu-user-mem.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
-- 
2.22.0

