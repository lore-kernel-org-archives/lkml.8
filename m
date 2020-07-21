Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A29C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AA5206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwb/qpZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgGULe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgGULey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:34:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:34:54 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id o12so12983979wrj.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n1ZQQ5tm9YxfAn570HahPqg+j0IaDyUX9Qsq2a7onMo=;
        b=hwb/qpZldGhFlxoZclsC+n+9Oqd4k+fZDcHif4sKqFgEwrRT3NFdLNJN9XmdIRgagW
         o3ofnp8JlpBRl0gisCitmgsX9NUgywywYJ/d5M3KxlylqLFgN7vcbIZ19EMFJAXbjJ/j
         5BBISNCdXitlqPNIq21eaVpzOUtpOA15xb29HBy3uzw/Abl+HBnbJUrWi5wQXoWd3N6J
         0FgvxcTWULHv3s9FfcGkOqh2RgyJmSbbejkhNfnI22MC5LMZSy2PVulg42Sq8os2WSXl
         hV8TBhuVBpIni9+8okgeZC+IdbTQLO/Xp+McQduFNtQ9CHPPGnB84twzZF5tywlTlpL8
         biVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n1ZQQ5tm9YxfAn570HahPqg+j0IaDyUX9Qsq2a7onMo=;
        b=eCWOHo9fYMSsEnqJxDZlQ9tZAJEygqt1PmXjIS0RDoNoR5lfICqO1mlb0BP/6/Eimn
         xlNI42CCKQlj8eCOozdI/7mdnjurF+2knt6ZNgA8PJWCGBqAEMgdVyoOxK9tshb7m5wp
         jZpT+L+Qsazpumzukm68Ldv3USIRIpxGrlYTYoF+HfdJ8rgwN/Sz4DOT9eMYp84bZSXQ
         OpQ49e0aFgojFzUIa6WSrJAx0Xp8uD/7DmLRsEBpos/yKIOhrikg7Zqhtp/hQsGfHJ5E
         5oGBhWphCPyXKMkFaqe8uUyA0BeDrVUuEYbLg8+polW6wtRZv99bAwpsC0to50XN3cxv
         zJ/A==
X-Gm-Message-State: AOAM530d6sZ1ZI4T+mZATA9XPTtidKbPEyy0xy79eLUQp1QfvD/jXk91
        sVjKRSbgVPX3uSHeUdoxtNjdP+9fEadOSvca
X-Google-Smtp-Source: ABdhPJyXs7GI+AmYjvkMPmziwfxiEEgT3rHmehsVlCqri7ZFjJHuQvP8xl1K9WtQEIsq3q4t3BvsUNs3XO+LUTvg
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr3513543wmo.62.1595331292782;
 Tue, 21 Jul 2020 04:34:52 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:34:44 +0200
Message-Id: <14089ca5568d214295b2028b59fcd630c7adb0e2.1595331056.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH] MAINTAINERS: add KCOV section
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To link KCOV to the kasan-dev@ mailing list.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..eec0b687eb08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9305,6 +9305,15 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
 F:	scripts/kconfig/
 
+KCOV
+R:	Dmitry Vyukov <dvyukov@google.com>
+R:	Andrey Konovalov <andreyknvl@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kcov.rst
+F:	include/linux/kcov.h
+F:	kernel/kcov.c
+
 KCSAN
 M:	Marco Elver <elver@google.com>
 R:	Dmitry Vyukov <dvyukov@google.com>
-- 
2.28.0.rc0.105.gf9edc3c819-goog

