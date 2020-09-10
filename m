Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820BC2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8B121D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCSXD6up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgIJTkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgIJTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:39:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:39:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so537984pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OnhzWxRrpb9iMtadcuHWcNh629tQc4KM19Wi54LRtg=;
        b=hCSXD6upMfBV9X5KA/ZtlWSvvN2u/jrPNiyohNzJP5Um1eFsUXMt0IYITSRfjZ2N7F
         CCqyc169XJ1S8IpNzSTR7/Q5A6TudydibF3Vn3kjFa/RYlfcqOXVCvzTm5PgzV4g4OqP
         8v0wzqe/u6KCVeDEuK6H/5IOXZL8hQeFkHNqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OnhzWxRrpb9iMtadcuHWcNh629tQc4KM19Wi54LRtg=;
        b=KTiNrIqO6e9sybQ8xgXGfUno6XIPzlzwd82PqcD6G5yGZUO1dT35GCDRxgJWHH6h7e
         YDZj3jhJ1XOUh5n2QE6ZWTjSDVgfBpdYcpKQa98DwEAQ9GrqJjZShixKoLA79I/dnkzu
         otth90qnQYvIqDgoRe46y+kesNAjL3TRnF5aqji2FMOy2Hrb93n4LIQUoKwXH309XAwl
         0MwiKt6jXaZ/kVrqWj1uuDvu8cZu+4V4MtaUmyThEDFkObIGtdc/hFWcgvf96HzUvXeg
         /Axvxh5NM3IfFeNyK5QkbZgOpcqd4yUy9EzCGvRBS/exV2bt5qUi0Gb/C/B1u/G0ICUo
         v5bQ==
X-Gm-Message-State: AOAM530jAy1mIXLDosQp0/KML40J9CefFb4H4btIqg+WaoIm5B5oJR+I
        SLeb3j5oH3RJ0kBihnSV5tqFMw==
X-Google-Smtp-Source: ABdhPJxXAuAUy5u4R4yCF630iZaul9HrpugdlwL5m6UWHu3jTbgBmhRTURbZ4j97AJLKFthjZy6HwQ==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr1431789pji.181.1599766783160;
        Thu, 10 Sep 2020 12:39:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24sm6804281pfs.206.2020.09.10.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:39:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: Add older email addresses for Kees Cook
Date:   Thu, 10 Sep 2020 12:39:39 -0700
Message-Id: <20200910193939.3798377-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds explicit mailmap entries for my older/other email addresses.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 50096b96c85d..a780211468e4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -169,6 +169,10 @@ Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
 Kamil Konieczny <k.konieczny@samsung.com> <k.konieczny@partner.samsung.com>
 Kay Sievers <kay.sievers@vrfy.org>
+Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>
+Kees Cook <keescook@chromium.org> <keescook@google.com>
+Kees Cook <keescook@chromium.org> <kees@outflux.net>
+Kees Cook <keescook@chromium.org> <kees@ubuntu.com>
 Kenneth W Chen <kenneth.w.chen@intel.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
-- 
2.25.1

