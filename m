Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFC2C3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458532073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzhsNI5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFHL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:11:29 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56004 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgCFHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:28 -0500
Received: by mail-pf1-f202.google.com with SMTP id f193so834328pfa.22
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9hr5GPupGwbq5BPqFVNKaOBEY/rGlCiz7On4PcG+OUA=;
        b=GzhsNI5zGy0Afq9DLXMSBMUzUUlwWtTNhxDqze8qyyfRr2MEiddUCCYlwdjBiJOGHp
         uN8yGevS/XPKQD9CIuNCGoo/skGlpGzl3jDd/inSf/CCFKVF7uUjdcuQIyDMhwsvK5z4
         uC4qfOgemzXen/VD9JwpUoud3U+OM2exPQky62BQauZgym/S/OuISZppeb8OPxOjV29J
         UU1UH585DDshYG69n8dLjzhCrYAo5iwd5msrBRmltZQh6Qb/MwIdbVDpfZUFyO1CJyQo
         WV6ykgIYzzDkx/bLvdu3azhFp/Roj/mNkea49HcVAgj42sTqz4WlbNUKucUJdujRpsKh
         IGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9hr5GPupGwbq5BPqFVNKaOBEY/rGlCiz7On4PcG+OUA=;
        b=Yby81qXvlKvbFP+zj6aSd/o1enVA3YBi2vYHq4ykEtA4FXqnQHNWsk1QL22s7T0HF6
         l3cRTdmaqVz2WtsR5WdCDkKYnGiC/jTaUWyaQOvXUKiTJDuPfYROM/8ZttWExkDfmkOi
         Bgmhz68C9VpHzt1PRoZK2OahKGrbeyuGzDNWoEOyjDNtxvf5TJpDUZpJwXLf4W/d5IiB
         ikUFvzJ04yRAzJOUaR4FUn2qCUKHyqJqnsEWn13J+jL9gpOjYcDYlyJwr3dCebayZEIO
         FdAa01Foauu56f1ipfizjFzSV7y+aLAl6nnyMnpoM/naTH65avqwvFw/WtCO+DyBSvOI
         LJug==
X-Gm-Message-State: ANhLgQ3euVRRSU8XgDYIrWtgGGlMtOIl77Wft33apkuBrzF7eKZ+DiBS
        WHRpRP0W0HyICi5EBZGHAkIjWcTx/ViT
X-Google-Smtp-Source: ADFU+vt8PlpDmvrMOabiXO0JucKRB3F4nFleZzaoQ68rR4oEzCC8Xcea/xS/+EaDAnFA1whL40LgZOmcTiHA
X-Received: by 2002:a17:90a:30d0:: with SMTP id h74mr2215031pjb.161.1583478685300;
 Thu, 05 Mar 2020 23:11:25 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:11:10 -0800
In-Reply-To: <20200306071110.130202-1-irogers@google.com>
Message-Id: <20200306071110.130202-4-irogers@google.com>
Mime-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 3/3] tools/perf: build fixes for arch_errno_names.sh
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the CC compiler to accept a CFLAGS environment variable.
Make the architecture test directory agree with the code comment.
This doesn't change the code generated but makes it easier to integrate
running the shell script in build systems like bazel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 22c9fc900c84..9f9ea45cddc4 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,7 @@ process_arch()
 	local arch="$1"
 	local asm_errno=$(asm_errno_file "$arch")
 
-	$gcc $include_path -E -dM -x c $asm_errno \
+	$gcc $CFLAGS $include_path -E -dM -x c $asm_errno \
 		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
 		|awk '{ print $2","$3; }' \
 		|sort -t, -k2 -nu \
@@ -91,7 +91,7 @@ EoHEADER
 # in tools/perf/arch
 archlist=""
 for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
-	test -d arch/$arch && archlist="$archlist $arch"
+	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
 done
 
 for arch in x86 $archlist generic; do
-- 
2.25.1.481.gfbce0eb801-goog

