Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E07C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A4B2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvCRVCdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHRQZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgHRQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:24:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62551C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:24:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so16784353wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x//7OgPSCG9lQ7k2EMJFqXlRtNQgNDXH0lL4Hpq6NU8=;
        b=rvCRVCdZ8CefoCGkW1yi3KLrqAsoiGTsGeXzlfOnBc1aGCuWEXJ25xJv0rdOnTiof3
         qfMmgMBOkIFDrhGqmjVtwRSCBJ8dXdS+akNyLI1hYpfnQPtYlkgPzoJ35M8uT3snBoHA
         0LxY92GGLD32DJeUj77fpBGNlhvLLsI+eMOr8rSWIrguZr3F9Hwik/cpgajZ5MXL3B7Y
         KWh/gRwfiZzpuNXHoYGnNNaqTivlJFW089/11Jn0j31u+XPEFjbV2oU/7KJtkwXXG6gx
         TTL7SFJs64eOBNGCwCLGyLwf65nPvzolXLNrXO0yCVLNIUbyGyZau2Ntc1MINRTRTl07
         9A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x//7OgPSCG9lQ7k2EMJFqXlRtNQgNDXH0lL4Hpq6NU8=;
        b=ivBAscKR/nIhEslRiuLJ8l4MCBrVDVn8hlT328XpV1Dy8U1sjMXPV4382mOEQ9TBhg
         XcJoe7g6bLSOVYWlMOP9lH67uLvz17HjeBgF6UlfvXIQC+ZJ0pVa8sz22b4DE23ytSY9
         r6uC8oGvtYisQYdYnvbCkipJbOjUbhuYeGpNeOfLvM+tBMmzzfu+N1gmQoQo2/QS4lQ+
         HYy38ph6ftgZKT2smeE6z1oSaBEE64tbZCfZ30kf8l1QsE6ukaZdkBoW8v6Rhyxjg6b2
         aijJ4Go1ZVw4hUbmM94lDmx2dL8VRAQeYlFvYqXwrlwIKGlkQBOFXfL6yJvglXYEkqgr
         HwvA==
X-Gm-Message-State: AOAM530fBhwLOwnaR63/q24FQ5hBnCFf0u4K2CxiXR5q2OZeEp3qPlRO
        8rEBspxr5XnFKKYjK1dEdCQ=
X-Google-Smtp-Source: ABdhPJzD9Jk01Ht/EPCaY/hFZqGEbdBFWvCSsMJqjfc7JRzTKBbwRtz3YDEbovyVPjzqhRiY5BmKew==
X-Received: by 2002:a05:600c:25cc:: with SMTP id 12mr673172wml.120.1597767876999;
        Tue, 18 Aug 2020 09:24:36 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id m1sm520580wmc.28.2020.08.18.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:24:36 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] clang-format: Fix: Maximum line length is now 100
Date:   Tue, 18 Aug 2020 17:24:31 +0100
Message-Id: <20200818162431.696423-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
warning") the kernel style is now for lines to be a maximum of 100 rather
than 80 columns. Update .clang-format accordingly.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f..2b314a14a658 100644
--- a/.clang-format
+++ b/.clang-format
@@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
 #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
 BreakAfterJavaFieldAnnotations: false
 BreakStringLiterals: false
-ColumnLimit: 80
+ColumnLimit: 100
 CommentPragmas: '^ IWYU pragma:'
 #CompactNamespaces: false # Unknown to clang-format-4.0
 ConstructorInitializerAllOnOneLineOrOnePerLine: false
-- 
2.28.0

