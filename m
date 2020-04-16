Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C742C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A1720857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzhNifbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442921AbgDPQVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387478AbgDPQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:21:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D33C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:21:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x6so3340144pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=UzhNifbb77t2kPxIOe5h2V6OwBCa1u7KeMtcqkcPkXVRhkl1nGkMlT/ABsDO/4ITvX
         7O4KYePjbVagmc2hQ7j/xtUKlHeAwXFVXksjkeeeBrPfGXybWvZ/Rx2bjyW5iPlKWNb/
         D59msAcPOaGcQHUX5gDH8EAaTUuwAfmj6oHGtyXeqjLcruyPweUM5TN3mIsAGw/a+HE0
         GmBL4EbKY4V0hucEB1JqGZsyAfhnnspNPKR9V/IzJDbX7hkDSA/qylpxp+1QzDQQuPoI
         iP0H290G4LmvEfZdClc7HWN7Nebpkf88L5ho3A9pxLKo/lFJ1hPdpDGFhjIiYWhho+xV
         J+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3QSq09zanfq5knFKJrjyOnoqvaU4fvmN7ei3XY39p0=;
        b=I2D0XOlTC0I+WLeJxRP7/rZ2RBVlIZiUC6vohsYGsMOdmIbtGAws/R9RKPl3NajDOO
         1VwKwWwqe7JPIZ19Y524JxOOvau+L8POMHmcY48HCq6NWoB/Ry7USjZ8wJDHzq6FP61b
         mAsPXa5AtOfVn0YfrHwgdIiKLpgywG4SNArLim2jT0xiQDzoxr+k63QhyB7QZuSlRC5h
         /RN1wDdSi86I2qEge8hbf+JnajXcIa8Yl9veErk3pBKAu1XJP4/k0BD06W7Wd4Y3ZvpQ
         ILWVGq/revTx3VAJJeJVIXHIjr1oPErDR7V8Fnw86vaR/j6O/OV3xKYBgrOSmj2+OlEl
         0OGA==
X-Gm-Message-State: AGi0PuamRoEVlimo7Ce4zdbscVnoPRsdtigeDYK9PUvHHzSGb8DYUzuM
        PQVOmSFO1z5H3SqnECmlyJB+W7ag5Il6
X-Google-Smtp-Source: APiQypLhs9XROYXNcpvjGVHUmUynnZRHW/PXhtVi1TmAZoN3NUmY+pas6oCPFDiJuNmYVx4+hDre2vk3/Z00
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr25221209pgl.154.1587054065331;
 Thu, 16 Apr 2020 09:21:05 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:20:55 -0700
In-Reply-To: <20200416162058.201954-1-irogers@google.com>
Message-Id: <20200416162058.201954-2-irogers@google.com>
Mime-Version: 1.0
References: <20200416162058.201954-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v10 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow parent makefiles to pass values to asciidoc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 31824d5269cc..6e54979c2124 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -48,7 +48,7 @@ man5dir=$(mandir)/man5
 man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
-ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
+ASCIIDOC_EXTRA += --unsafe -f asciidoc.conf
 ASCIIDOC_HTML = xhtml11
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
@@ -59,7 +59,7 @@ HTML_REF = origin/html
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
-ASCIIDOC_EXTRA = -a compat-mode
+ASCIIDOC_EXTRA += -a compat-mode
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
 ASCIIDOC_HTML = xhtml5
-- 
2.26.1.301.g55bc3eb7cb9-goog

