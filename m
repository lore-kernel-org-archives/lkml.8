Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09904C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D571B20767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZqQWV94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503488AbgDNSLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503472AbgDNSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:11:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7086C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:01 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b14so466055pgi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=TZqQWV94Zuu65bh1l2U2we+9RQv0ecmGJ/H8OsjT+KUkAeOB0Im2t4v6FIP69dmojT
         TXzddpdrsIGUDPp7azXpW1Eok3r27SblClzb6ZvGs0vf8ESCCFAlhjLouhoYbG4aZe0s
         Zqfxgl0hZrH7160buCzm+WwdijtDQEdXVr0f6czTZed9sRSx9fA4Ot2E9x1vYhNhDwAK
         IFt2XupTwy63RUFA9G7aULrBKkPBd3DuXNyfOmmCPzr/+WpJFwG24wcTbnA8wNXH0m26
         cK/37ysy+da+dMHdJRpbtWL2Epdw0PvoUqjLQhy3nZicZqklG/9ungERiZxTOmT+VXyZ
         tO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=cuzVl8YKTezpCGE2pLABW/2Ptt9EBxaZnFJRhCeHzPJzhsMwAHpyLn+XEsXpwbRLAB
         8Che1RFrwBu39Tk3MzeDylYEu8f50UqiZEmn1qrKGL0D/pU5QQ6opRmsat1bYyBgcsZX
         YlqRjXB9rUGZnf2wPL3SUmDNsBkqeZBi5q4icmBO2KKBAi0sAm/6Ey/ZVxj98ks2unFo
         kYqRvrtEGz6p5cRI4LUbDaNhxHp5tFeNlu7haTXB1OCff23oibrnHxSniKsr4BrrI8ox
         pqsD+v/ANVVhhz64iE2TSd3UX/CA5jpTqzMPrvNN+i/aqtap279dEBA8Oq/3RWRq4/xf
         WWUw==
X-Gm-Message-State: AGi0PuaV+Gnk0QIEzjBSj6oXFycc4Bh2ELe68TMnNb5JhJUm73/dV8Ut
        Hq3RiiH85R4KOgw4bBpBQhGOlYxXVSUD
X-Google-Smtp-Source: APiQypJpp1FHKo9I4j4uknzvoQXqGMx6BkeFOtMVeAThGZ2kTspRZEZVLXgIe/H5UnbizK5QcpZHfol1Mqvg
X-Received: by 2002:a63:e74f:: with SMTP id j15mr22888445pgk.153.1586887861370;
 Tue, 14 Apr 2020 11:11:01 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:10:51 -0700
In-Reply-To: <20200414181054.22435-1-irogers@google.com>
Message-Id: <20200414181054.22435-2-irogers@google.com>
Mime-Version: 1.0
References: <20200414181054.22435-1-irogers@google.com>
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

