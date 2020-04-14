Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A594EC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867A420767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qotcykh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407812AbgDNSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407786AbgDNSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:04:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE87EC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:04:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g11so405519pgd.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=qotcykh6fSG/qm/7oyV0C2RLfqHJRLB9uNOcTZJ+xI0bwdHUs/bval7rxdFichn7Px
         cds/LILyV/qc33RH3PO7JhsOVWmtrGHKMn0tlao0W+RD4sPbBDPtRyuJVZU3jOKAemyp
         xHfGM0o/5HGClnix9GABq0SN2wa9BYukgEInsw6x9yC3nqGHbgPv2nLGv8SDphk9fffG
         OYZvkRedZ3/oU3gQCVmkk5CY9c/P1UAWcN6OZXrkTBpkTbJWXsGFmOot6GCGVaiEZVmg
         hFnLyW50k+bthEAP/4L+LRjcXMnPr1gtQbGvV19aAIrOBcj6YD5wuY14th6lm8XEQC+y
         T7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=fglLH12Tli746MyI2HyazQXA1gSDVEPfDBEj86/0oQV7z04hWRXcoi2MqPhGCJYpOn
         YQHgOSU8fUQLRtRo2Q0+2tWuwN8DGjQledMlomOHA8Tw6pCLIRcDovzm3ena7yVK7SlH
         2fZPYS6vC6z2shCkupWSobGMK3RQhlkSnPf5DijLUYeLmohLsnQQsF8w1MiJsOAAU8WM
         2UHmlB3L1IY2g3f8+3DlizZtCRDi5ZlPDiTjyOpM+9+l01R4o1GDR5mK5TtHIvxLrhpU
         85FuHMtXyyTfoOLSfezBBm5cIQWuZLGVipyDbGMvi1d2b/68of1gW4TdtDnncTeIhkTe
         l8CA==
X-Gm-Message-State: AGi0PubNDulbG8MGT8S8n9CdPgYi1MJ9aHnGTlbLkSKukfNe1vs5huMZ
        lbyUBLwtwXxrAI9oU3nvIBBW/5i/2Vtu
X-Google-Smtp-Source: APiQypINK1iuhPngXC6+csiMJV8tSnHSd+p8i2SPRyYLIKD/yOPb21DGbW6f+TuBhNHqxPj6rbTeaTpyAK/t
X-Received: by 2002:a17:90a:2709:: with SMTP id o9mr1509358pje.168.1586887468161;
 Tue, 14 Apr 2020 11:04:28 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:04:16 -0700
In-Reply-To: <20200414180419.14398-1-irogers@google.com>
Message-Id: <20200414180419.14398-2-irogers@google.com>
Mime-Version: 1.0
References: <20200414180419.14398-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
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
2.26.0.110.g2183baf09c-goog

