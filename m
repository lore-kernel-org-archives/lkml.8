Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9599C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9EC206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVClRjld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgGHQsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbgGHQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75470C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so18407265plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKw6kfPj0J2ulSW7Wymvv3jcMEOpa6pRjHdJ48m5ypM=;
        b=QVClRjld/frfAz/eZZGPVIb+gOx2QVMyofiQtCU3QuJaJmLnd50+zXzQ3QDADbwGN+
         EqFwS79R4PiJv/QGJoc9pccrUkw1PyhrADQAKLRAmgbLCsuoirrwVYeXPcIX5FZ+kXXb
         LNq2xNBPKwKFmBTKT2wJ7p1N2olo5FDrFEVLGbCW+q6wm570dsqfyqPCLS2A5RE6YwjP
         f/lUvG9fh33qK8qgZ2GFARU//BBvQGL3DNPMrlohH8Zf0qcJfs4f+yGUcOByZvk3k77v
         NWKLtsBOAAtMkffaFWvdUgDFUoJKQ4pOzi4MWW8HW4J69lv90ZiAFkZK6ldoRPIoDSeK
         jPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKw6kfPj0J2ulSW7Wymvv3jcMEOpa6pRjHdJ48m5ypM=;
        b=V2W2Gm3JRAIYTJVTnKEb5P319SiA7+yTZr1dIqXbOPGiieE/sxwW9K/LyUemh1UPTb
         40ft705Y5JZgrbwuwV3jKB/b+vWqBkPeEo3qmXF0wKTuObUD+BG4soVqyxv2NqL2BLki
         +ljGO3UYPZUeep1vHPiJZia9ypWBABXvIKnenkGEy0D+cGtULR7iCIFXe4ASvFr0AHAi
         s1AoEeJQ1zKH/7oabETd8tyJ+VHf86BFLWcvMFB4vlLszrN8XjWMmHQn4ZJzBYaX+lPq
         APtMqIne740lCDOvddo5mcGERzICB1Lv88AFZMxYxeIGSP2/Sul7sdfOIxeECqkf0TW7
         33gA==
X-Gm-Message-State: AOAM531J5ZsAEdvXrTTe3uq5uZdWXaFPGRz+qs6g48WMi88z0MErMw1e
        VxKsned/rWJWRlQkNd1e104=
X-Google-Smtp-Source: ABdhPJyIoQvF/6+uAsDcQ8/dbYRL9JWgdtHMlUmQL3/0mqTBeMc/neBRm6c3bJFyAIDmD+IMBq/v2w==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr10567911pjb.153.1594226922112;
        Wed, 08 Jul 2020 09:48:42 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 17/17] perf ftrace: add change log
Date:   Thu,  9 Jul 2020 00:46:05 +0800
Message-Id: <20200708164605.31245-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a change log after previous enhancements.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a20187b1556a..664cdfabc77b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -3,6 +3,7 @@
  * builtin-ftrace.c
  *
  * Copyright (c) 2013  LG Electronics,  Namhyung Kim <namhyung@kernel.org>
+ * Copyright (c) 2020  Changbin Du <changbin.du@gmail.com>, significant enhancement.
  */
 
 #include "builtin.h"
-- 
2.25.1

