Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C32C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGei6Lyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaSSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:18:34 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37720 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgAaSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:18:34 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so5621390ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4VYyzzGXvpkoeXPD6VYi8iy20yoxe+qDPS3ZbJdgxSw=;
        b=AGei6LyyPbL/uS3xnhgCFxDlX8FD9ZLRHfuc2U2PwbDRurtaUx4dQiSMRQ9jPQ6LfJ
         4/QcpR9QdvlN2irxJcd6/SepI3rNFHDWBlVM4QYqBOIQH5ky7mXuNbOiKQbMjY1fgvED
         9UszIyqchT/Y7Tf1v4/nWRJ5C15HURAJiRJ5lwnx1XOI7RwsHjLfg6LpXr0IH3ff0nT1
         +nv264uCbz0jkfnDPbzbAl/lNAVHrL4tezJyQKAswTLYK6ui2opfY/uddMz3gGpJScJK
         ByO5uHCpavsKvp4wfgUXznB89PuXEG/bkTDk6V1UVNvbNNL4hktgEP6yUeoXhcmfFu/j
         GWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4VYyzzGXvpkoeXPD6VYi8iy20yoxe+qDPS3ZbJdgxSw=;
        b=Wff5sjWQR1VzWTQljkv2VUHKTSG5Uj5/BissdwZOUD9hod5g/P22qMvrzE/yLDqTwO
         Xki89XBVJ3pfb8fzXBRpBOJn62yfzCsvpJpjDUkvJmh6pmLvMeoCbG6kSousmzDaqBVb
         lZo054XBCCjlljjbQVS7/tQNA1XkORxXgPjAVpBgVtqE3eIcGvKjddCeFcaGSJ98uTdG
         3JOu5Y74KlaMPkzDIoZal3qJ2jRuxEIms+QYx/MC61lxQHwWaIt/olikvfLqiH2gu6TZ
         WJrD1JNlE/dyIaMN8Bfma+o4dSwyaJ5Z3tZxnQ2JPdSkJDYzpNF8uU9PWx/vjw+yI+5s
         8GIw==
X-Gm-Message-State: APjAAAVDi5FAuKVP6L9cQqfM+/D215znbcWKo8UnGJbyj8hcNcCLl+Vb
        OkXGR15LbqV3/w2obgw47AJ09no9ibY=
X-Google-Smtp-Source: APXvYqxJGnO1O/rmfQQK1Pc08HE1l2lGIxEBybFDZnB55yHsQoULJyrYbjVS/xdfaTfdSDgBmEopew==
X-Received: by 2002:a25:9c01:: with SMTP id c1mr9362229ybo.200.1580494284802;
        Fri, 31 Jan 2020 10:11:24 -0800 (PST)
Received: from gmail.com ([2601:240:e300:b5b:329c:23ff:fea3:d48c])
        by smtp.gmail.com with ESMTPSA id p62sm4438951ywc.44.2020.01.31.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:11:24 -0800 (PST)
From:   Sam Lunt <samueljlunt@gmail.com>
X-Google-Original-From: Sam Lunt <samuel.j.lunt@gmail.com>
Date:   Fri, 31 Jan 2020 12:11:23 -0600
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, trivial@kernel.org
Subject: [PATCH] perf: Support Python 3.8+ in Makefile
Message-ID: <20200131181123.tmamivhq4b7uqasr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Python 3.8 changed the output of 'python-config --ldflags' to no longer
include the '-lpythonX.Y' flag (this apparently fixed an issue loading
modules with a statically linked Python executable).  The libpython
feature check in linux/build/feature fails if the Python library is not
included in FEATURE_CHECK_LDFLAGS-libpython variable.

This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
the '--embed' flag and passes that flag alongside '--ldflags' if so.

tools/perf is the only place the libpython feature check is used.

Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>
---
 tools/perf/Makefile.config | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c90f4146e5a2..ccf99351f058 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))

 PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))

+# Python 3.8 changed the output of `python-config --ldflags` to not include the
+# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
+# libpython fails if that flag is not included in LDFLAGS
+ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
+  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
+else
+  PYTHON_CONFIG_LDFLAGS := --ldflags
+endif
+
 ifdef PYTHON_CONFIG
-  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
+  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)

base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6
-- 
2.25.0
