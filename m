Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDECC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14812082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PD1xyBi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgBDOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:04:28 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:42237 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBDOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:04:27 -0500
Received: by mail-wm1-f74.google.com with SMTP id d4so1214757wmd.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KtW08c4N/a2oVRHrX0WYeOZxmDiJvCqs/eWAvVn9zAs=;
        b=PD1xyBi0it61cmDpiG9PZDHp+qhrT9OgiLa82dmTHx3mddRhqfoKzbkfPY1XlNNED0
         edSeM6QjA66SGyS7wMEMBCGRbNtF7148dzzX39l8q2w7n/27ooIO322AbDdTDjrfKF06
         f1CLml824JYqce7RAxlqd+crkwigfWwWQO6p3pzKKr6bHEDj8ORD5Kggu6v+GxrXjQ1b
         HsTvlBfg2uBzwesMshwo/2VT365sljDfLwYD2GCsyDFBsQzc+EE6otCdRegG/9iIBrL6
         a6Bs/11+rrYsbR3cdCqwPT5edlj+Hh58bWupgDkk6rHlIc0WQHlIdxBRtMczt3LExH6v
         w2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KtW08c4N/a2oVRHrX0WYeOZxmDiJvCqs/eWAvVn9zAs=;
        b=F/qlfaHGHHjZeFw81pI7YlGYCplWOir+MQ/wuAQj41hdu15c2x8qtBx7qq1DQ13f/w
         2sk0ZZURQH/jjfhnDuThVKHYBd0aIYw5OdQvrYg0XGu+MRsj4QSunrYNVRygj5vmpUk9
         osbyKly9kQlwsFCirtqJJS7GqVj3d6qFOtUFSpt3oeEi92LmFAKtjhBIVTJ3N+mwmaxY
         tJ8x2RszE7oqFyZQfZ7UlMamuxlOXcfd0uhtqOtJB8vLUSpX36CfO106QTsEgzqei56p
         +4Dyjlh3fOVC1GHMnQ9Lf8Ds1+SicY+ByFnegI6HyvTnQ0+5QrWP3jW+RAFiicvgaVbm
         r/HQ==
X-Gm-Message-State: APjAAAVfNb0EWe3j2t6eipghLFcaF6Xgq9vd5TgBBpNk7vXRUKlWcqJO
        mnLB+ug+vaZtoUF44OU1lB3bxkyuNQ==
X-Google-Smtp-Source: APXvYqwncnT9r1x/4RrOaQtvjXAN3GZnAkUK2m/xSD2a6Esfjkx3lDl1yjliLAza6WZ3i1YNQcjujfzqQQ==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr21824539wrr.418.1580825050694;
 Tue, 04 Feb 2020 06:04:10 -0800 (PST)
Date:   Tue,  4 Feb 2020 15:03:52 +0100
In-Reply-To: <20200204140353.177797-1-elver@google.com>
Message-Id: <20200204140353.177797-2-elver@google.com>
Mime-Version: 1.0
References: <20200204140353.177797-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 2/3] kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify difference between options KCSAN_IGNORE_ATOMICS and
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC in help text.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 08972376f0454..35fab63111d75 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -131,8 +131,17 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-	  If enabled, never instruments marked atomic accesses. This results in
-	  not reporting data races where one access is atomic and the other is
-	  a plain access.
+	  Never instrument marked atomic accesses. This option can be used for
+	  more advanced filtering. Conflicting marked atomic reads and plain
+	  writes will never be reported as a data race, however, will cause
+	  plain reads and marked writes to result in "unknown origin" reports.
+	  If combined with CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n, data
+	  races where at least one access is marked atomic will never be
+	  reported.
+
+	  Like KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, conflicting marked atomic
+	  reads and plain writes will not be reported as data races, however,
+	  unlike that option, data races due to two conflicting plain writes
+	  will be reported (if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
 endif # KCSAN
-- 
2.25.0.341.g760bfbb309-goog

