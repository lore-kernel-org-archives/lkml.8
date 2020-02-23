Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56967C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74F20836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbVUvKR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgBWTfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:35:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43058 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:35:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so6789248oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bNSAcK1Y4RTVt5w1GiOECuJlGG3CoUMoepsQyoRrLXQ=;
        b=pbVUvKR8TfpAgiImQ5OxGoZyTyiButMVamczWW9Xa6o/33wn2VOI80C4DdCnrOP/XB
         SHr41FumC4LcT8zxtFsp8n/KQll0LHzwB5sSdg9edEbSHBz3N3HdH92bMbqvDhECu/P4
         4taH/UyAEyt0pM4r/jaPO3OlrHAhI8ND9vY6QjWJh5lcX9+xbZi9j1eWvD2IiMvpeNAu
         SQq4/QYPCnInx4JOsoNHBDSr1har8cB/Qbjvgpsvdi+zAQWcAdSX+KrVvMMcLP8mpnbb
         eY+rO0deuvE/8YCaOJt/7X7f8nIOWYJx/RJbJMEONkEl/N1ph6LtCzrMIXr6/a4A9Znn
         JzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bNSAcK1Y4RTVt5w1GiOECuJlGG3CoUMoepsQyoRrLXQ=;
        b=ASIZZiumaDOIhwmrVi6+KW/FLpWOdor6Q2aOei0/XztcEq6Ku11jJTnJBQ1zsGG976
         FhijOuZReyDjjWL5vTyjAYFI3sU/fpk4VlFmkVNytn8oTMP8pRoO8OHvtFUcU5FRwA8b
         q+6WFx2TAMbaClvRTKezbDe28eqvXV9gakSm4/RMSKKirSW1QLpvCxlN3B1YwSj52WVm
         bD3VuN1eouDPJyyxYD+89W3dNt65Sjzt7rPNPSX6g9Qt1IgFDLNOuOJ6jj20pqNyay+9
         ULyVi1wgqYFKbQ/VTraDRk/S2VV1k7SeNafh52bYfSHrfarSP9ZfXzHx/vRSPxX6yNlz
         S33A==
X-Gm-Message-State: APjAAAVm+aj55TBDdeBSl6Sm6opiVbIH++VfPUJ3+i4tLSMDXeJI1nBc
        ZPp8uN+N0tXkohO0/NI/Y8s=
X-Google-Smtp-Source: APXvYqzZ/lBemIpLGxddOccxNUG4QMcPqY92MrpQTIsUAJMPDivxfCCZ8rVnaSLSiSfpReSMma5OQQ==
X-Received: by 2002:a05:6830:15a:: with SMTP id j26mr35920326otp.137.1582486501481;
        Sun, 23 Feb 2020 11:35:01 -0800 (PST)
Received: from nick-Blade-Stealth.attlocal.net (23-121-157-107.lightspeed.sntcca.sbcglobal.net. [23.121.157.107])
        by smtp.googlemail.com with ESMTPSA id j13sm3267880oij.56.2020.02.23.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 11:35:00 -0800 (PST)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        John Keeping <john@metanate.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix -Wstring-compare
Date:   Sun, 23 Feb 2020 11:34:49 -0800
Message-Id: <20200223193456.25291-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

util/block-info.c:298:18: error: result of comparison against a string
literal is unspecified (use an explicit string comparison function
instead) [-Werror,-Wstring-compare]
        if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                        ^  ~~~~~~~~~~~~~~~
util/block-info.c:298:51: error: result of comparison against a string
literal is unspecified (use an explicit string comparison function
instead) [-Werror,-Wstring-compare]
        if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                                                         ^  ~~~~~~~~~~~~~~~
util/block-info.c:298:18: error: result of comparison against a string
literal is unspecified (use an explicit string
comparison function instead) [-Werror,-Wstring-compare]
        if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                        ^  ~~~~~~~~~~~~~~~
util/block-info.c:298:51: error: result of comparison against a string
literal is unspecified (use an explicit string comparison function
instead) [-Werror,-Wstring-compare]
        if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
                                                         ^  ~~~~~~~~~~~~~~~
util/map.c:434:15: error: result of comparison against a string literal
is unspecified (use an explicit string comparison function instead)
[-Werror,-Wstring-compare]
                if (srcline != SRCLINE_UNKNOWN)
                            ^  ~~~~~~~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/900
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
Note: was generated off of mainline; can rebase on -next if it doesn't
apply cleanly.


 tools/perf/builtin-diff.c    | 3 ++-
 tools/perf/util/block-info.c | 3 ++-
 tools/perf/util/map.c        | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..c03c36fde7e2 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1312,7 +1312,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
 			  start_line, end_line, block_he->diff.cycles);
 	} else {
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030bf6ec2..fbbb6d640dad 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -295,7 +295,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
 				he->ms.sym);
 
-	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
+	if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
+	    (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
 		scnprintf(buf, sizeof(buf), "[%s -> %s]",
 			  start_line, end_line);
 	} else {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a08ca276098e..95428511300d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -431,7 +431,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 
 	if (map && map->dso) {
 		char *srcline = map__srcline(map, addr, NULL);
-		if (srcline != SRCLINE_UNKNOWN)
+		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
 	}
-- 
2.17.1

