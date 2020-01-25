Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB0D20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNm0Po0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAYO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 09:56:24 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39914 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 09:56:23 -0500
Received: by mail-il1-f196.google.com with SMTP id p18so1108541ils.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=azzlYV9p2BdWsb/G+vunmwq5xYwbi8a1Kds9SQOTNYk=;
        b=iNm0Po0Vn8OnFRJrKJhtWkEGXtyQSksmqnjCk3bGXbOJmKnmON5nmDURF009dVsZQ7
         G5NAO1Ff93tdYjTk9A6+o3gInvUHW4yc3ZlQskj7mu3AJAABTb0LTIiP4uaHY4atW3ie
         tPLfadmg5NIQnuNVJDYiupfWkHmb1GcPkQvXOBJbZQaiCqlEXZN2/qxRpg6dlWDWc+Eg
         J6VMtvHbuQbhwwItn02lfY2O+g2d8QOhUGKamrsuI9durlbNteAUcdgYWsMGYaGnWiJw
         Os8F3yrdkShsSLjZCyHK8GEJo7OSRIWBBTKdU82iXj7PouxmShTvNZBI9xDLp0qROXX1
         dTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=azzlYV9p2BdWsb/G+vunmwq5xYwbi8a1Kds9SQOTNYk=;
        b=bnIB8ClrX9JLMmdt7ihxnXt5aTihv9XIjgw1uVObtvaLw/X3gShP7i5W+XPLAkS2vM
         wEDHmSdAVEViZrY/Xj1yorxvow5Kkw3yDxXSz7bR267VMf0iPh8KMSIcO/yNv34G9sK0
         vm7g2u4nF+PtvjKyr2AsjM/Adiq4ix7OFEnfJSA0GaQYEUyziqNW831I+rsHUZH61LM9
         dqZLVYuX2v+ChxkxQeiIbmmDdbN6dW42D5F8vKw5mW3G4sv9FN99WfkPVv+q2xloumFq
         xBfqVrlI2SBYvHjKgQlPzquhk365pgPNf54skhmUNjDWov91/tgTDCT0kJ/2mxUU1UHX
         woPg==
X-Gm-Message-State: APjAAAXIXoh3cHJklm5/cWdpHz728SUuZv4ZsNtzIA+LIpTOcNyAxDb3
        rc2CicG1ugGQKNBWUCsGbDp/rDy+/CLpIOEBquu/oPAxoDQ=
X-Google-Smtp-Source: APXvYqx0QGbCmvOyMmgmQEM5g8KrDtNO8Ec6dgMxpHE4LFRFG29XH+4kakeceWzFZopPebf8W//LV8SWKsJ1N51IzNY=
X-Received: by 2002:a92:c990:: with SMTP id y16mr8035628iln.109.1579964182834;
 Sat, 25 Jan 2020 06:56:22 -0800 (PST)
MIME-Version: 1.0
From:   Sam Lunt <samueljlunt@gmail.com>
Date:   Sat, 25 Jan 2020 08:56:12 -0600
Message-ID: <CAGn10uXOj3n2u01bzhCkUVi-n5dDMVV+Mze3_uLV1K6RC6ebJQ@mail.gmail.com>
Subject: [PATCH] perf: Support Python 3.8+ in Makefile
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
+ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null;
echo $$?), 0)
+  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
+else
+  PYTHON_CONFIG_LDFLAGS := --ldflags
+endif
+
 ifdef PYTHON_CONFIG
-  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
+  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ)
$(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)

base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6
-- 
2.25.0
