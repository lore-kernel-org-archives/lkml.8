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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3AC2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdo7nBGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgGULlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:41:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:41:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8so25154731ybc.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZGCFPc2cu5L5hPar2A1ajGgrC6LxqTxoprChOcpP4yk=;
        b=hdo7nBGVE8ZlSp9EpOrGNPCLfY+CgJgwG3Fu0PC1meVOVCOWS1kY3jh8y28SxGWAPj
         E3H1vY2GTpHDpYTXHlyKjDL3LoaYcWZ/WWyHUzjgwLM8w5A8QXht7XUoWKtK1mDUwcJa
         2i5OZrn2ZqXQftkw9k8halWqZhnzwExW4Oa/45Yeh2Gi1kj7bw1CV0R2tcw/3w3aVyhG
         A1i21+BrhJIi0NVLh8vk44UM/cnG72/24/DLqR+6YM3/CcmQndnbpO4FMaDrLl1AITJw
         56+X/W8mg8EwhwgVNXeHnAuJjVVshmBhXq74AMG/NYQXA9f3dcFRU9K1kDxCfqgs74br
         TbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZGCFPc2cu5L5hPar2A1ajGgrC6LxqTxoprChOcpP4yk=;
        b=IzYBozrfLynFP79kIXSk7lY/PrIhNnZGjg/WsdQGPfrYoZggjcYckY/rPCCj1s/Rn7
         ZFH9qgx2e3FRVeqfpZ6H05nEpVZSS/l7SIbH2hlFzoKUWf7e0VLiZn8wAnUiOSvXYVTA
         DSZRl8vwpzthx0gl9c1RI2c7VJlkA/woFK1JMgyXFu2/J7zhBm2GTKC+IItZ+xD9ZM2a
         t8/ItOaZxXAeNoWmC+a12Lhbyu/xNRIuLX50qWrxVyId/xxuYQ/lusLPh5DmgjAThOFG
         vKjTVqc+yMB7iFk88ecRQtoXUI+x+3fCYIfogl2ytE4s1evWSXJL6d5VJCbwRwYUJ93k
         t5uQ==
X-Gm-Message-State: AOAM531T9C0569ED4cgmIy2ru42VmCN76v5cIXEtWT9RuSLknZWa3Dpp
        0oEPI6uI0KMBzYRfS3VD0pjxbtNwoLFAEoIc
X-Google-Smtp-Source: ABdhPJzJgD+FTXDM1dsoJunp1I9stMRjH6QW+8XH5QVVH9Gaz2mJkIf2X9pOOxOVAfrR5wQMBFVDNzZTsAaKQH5G
X-Received: by 2002:a5b:4c5:: with SMTP id u5mr40648572ybp.500.1595331708193;
 Tue, 21 Jul 2020 04:41:48 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:41:44 +0200
Message-Id: <5fa344db7ac4af2213049e5656c0f43d6ecaa379.1595331682.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] MAINTAINERS: add KCOV section
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
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..fbe59955646d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9305,6 +9305,17 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
 F:	scripts/kconfig/
 
+KCOV
+R:	Dmitry Vyukov <dvyukov@google.com>
+R:	Andrey Konovalov <andreyknvl@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kcov.rst
+F:	include/linux/kcov.h
+F:	include/uapi/linux/kcov.h
+F:	kernel/kcov.c
+F:	scripts/Makefile.kcov
+
 KCSAN
 M:	Marco Elver <elver@google.com>
 R:	Dmitry Vyukov <dvyukov@google.com>
-- 
2.28.0.rc0.105.gf9edc3c819-goog

