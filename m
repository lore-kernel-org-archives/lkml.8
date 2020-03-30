Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED2C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BC20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCHcJ/WZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgC3NDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:03:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46001 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3NDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:03:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so18683317qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=28eUJEVmjol1gq045R37NXNmypYesyWBFbPNOwffG2I=;
        b=kCHcJ/WZw0DSr54Jg/A5YojwP7ynT9gUFKQBadXJFo5Ba0Z8we2IoMj1LWuVcG20uq
         xxaUNM4BbM4v6swBTg86nsYjlhM8nsCsaEi0+f/5sojnts0sNI6e2MmNm0cyXVxiXLaV
         RYpxiF94RqVtHenxEgYT3j5C08VrOqhoY34p260Wtfeqb1eWJZI9vv3H8hEfeb0gew1y
         hYajZpo5R/h5TX/K8yB92fjbJxhUxfxqkzXBJ8ytwjsyZLWCcEinNbaYMeBwfjzAUWO2
         c7Ua5J2YGeW9Z7WJX0yQMJeFJAEpsUPvZ2KJtERpqM6qe12crKX4HbKpjMDmITwBDJj/
         Qwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=28eUJEVmjol1gq045R37NXNmypYesyWBFbPNOwffG2I=;
        b=JHvF+HHdmrEQeJp8GT9q7VCYr/IMLxqVCDZ43IzIBBJRXLSvmy0L7b8gA6H4fBmC7t
         +5x/9KgdlQ4eF+hg0hl64eKnN7g7U/ZcOy1yh0wcE/xg5EU7M5Aje+UIqEemA7ghXMvk
         TDky4RvMAnPDEWKbVIgz8JTPHwcYp5SMVkdsS+nIsPZ/9n0tgPi1QjD9zWgk35ydRmxi
         VRWXa9Fx6Tfab7F1ULmwwTAnPm4AOjCxHFbANwGWr7aAXdHB6I0hkT49KAqiPSuyX4x+
         wYIrTUgnAr3nZUbGN56cse9X+KZU1BNauPdnA6zyYYhfKEilFNUG/yZ4lr63rmn8A28I
         zFIw==
X-Gm-Message-State: ANhLgQ25vME8zhMnHNLI2KrmZwjhT+zJR8Fh6LTgMcltEKW9NzxoAihb
        7nklaHvzpHAD7ideVMJJ1yQ=
X-Google-Smtp-Source: ADFU+vsqz0LtOrA17BcTV/9W6MqK84JDL7uShWPLbv6LjhkukvOSG/7w5KmI8j0wKK2J0ZSbm6W4OQ==
X-Received: by 2002:a37:a1c9:: with SMTP id k192mr10655738qke.385.1585573385358;
        Mon, 30 Mar 2020 06:03:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c40sm11599115qtk.18.2020.03.30.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:03:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D858409A3; Mon, 30 Mar 2020 10:03:01 -0300 (-03)
Date:   Mon, 30 Mar 2020 10:03:01 -0300
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build-test: Honour JOBS to override detection of
Message-ID: <20200330130301.GA31702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,

	Ack?

----

When one does:

  $ make -C tools/perf build-test

The makefile in tools/perf/tests/ will, just like the main one, detect
how many cores are in the system and use it with -j.

Sometimes we may need to override that, for instance, when using
icecream or distcc to use multiple machines in the build process, then
we need to, as with the main makefile, use:

  $ make JOBS=N -C tools/perf build-test

Fix the tests makefile to honour that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c850d1664c56..5d0c3a9c47a1 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -28,9 +28,13 @@ endif
 
 PARALLEL_OPT=
 ifeq ($(SET_PARALLEL),1)
-  cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
-  ifeq ($(cores),0)
-    cores := 1
+  ifeq ($(JOBS),)
+    cores := $(shell (getconf _NPROCESSORS_ONLN || egrep -c '^processor|^CPU[0-9]' /proc/cpuinfo) 2>/dev/null)
+    ifeq ($(cores),0)
+      cores := 1
+    endif
+  else
+    cores=$(JOBS)
   endif
   PARALLEL_OPT="-j$(cores)"
 endif
-- 
2.25.1

