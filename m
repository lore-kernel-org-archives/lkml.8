Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECE420720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLAfDa0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGHSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:39:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:39:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o26so31577003qko.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nw+HEOTauQz43mrAYZlr+zDtO5nUYDetwjnFUHBshGA=;
        b=rLAfDa0y6ZCEDB9PF+SQT/IdFqpa+k6hvx+osCfPfF6UHizy4IBlAtnW2cl+1za1Su
         enhGj58iyrqOsbF1gT3bn37HLJx/afxMa2u9JQRRgINYCpyZ3xadkEnuQajXo7jzl/JA
         MPm6LopA3quDc0Ax//djOvOimt7B8KH+vwtYHr7hGyMpwwg9f/84E5hBpNfRm+pMFeuY
         Oj9jZlerkEdoHlYsgIt/IgGBLAvAehCeedjrTFUrsSJs4urBEDxNix/A6x6bGRYCdlFD
         f5TdSro0+LxIqkorpCkSguDweLpCV/jYcnlT80GEAYDaMsnocAIF2WvLRm7otFsF85hw
         Nd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nw+HEOTauQz43mrAYZlr+zDtO5nUYDetwjnFUHBshGA=;
        b=gsmWACqLM0tK5ySVOq1CAMMosmiNzMVk13KTbM1Eg2RbEYb6wFzpwYsED53L54Ctd/
         lJFSyesfWnTZlhQyyS5lCmGPbAZl/TetDidaFmMf7Me5jnXsIiv5PV445VXPVUEW0YmK
         LDtKLtXoFnCco7XKAnXUdEqDhDxWzlljwHDLUlia/oakM+EExoJy43Bkh93LORr79kxn
         EzJpB8YYSiZYgVN4ST1CupzWH3Fg/A8tat2I4hW7XEdme4qg7opCrUdXZsDRTDe/RIh8
         mO5ZKDvF52Qdzgxzq3r4lFmVaCB5ErrKLsp1PI0Qy9qfGHRDdskhXTBfKM1bRMYP/1UH
         7KBQ==
X-Gm-Message-State: AOAM530XRC+URryZM8tg+z7gn/gaABSP7fFom8jIZw2lsT2FghFj/NCd
        IWm+G1RvU7d24/f9SMLskiEE/FoP1vF3
X-Google-Smtp-Source: ABdhPJxqpgWn2mnNFcV9TRzpEugqe5d70PX+RK7CBMo/diQ1nMJz4+GI/Hw9bJTRA1dR3FbrEpURJIRKFOQs
X-Received: by 2002:ad4:4105:: with SMTP id i5mr47551535qvp.170.1594233563066;
 Wed, 08 Jul 2020 11:39:23 -0700 (PDT)
Date:   Wed,  8 Jul 2020 11:39:19 -0700
Message-Id: <20200708183919.4141023-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] perf kmem: pass additional arguments to record
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf kmem has an input file option but current an output file option
fails:
```
$ sudo perf kmem record -o /tmp/p.data sleep 1 =C2=A0
=C2=A0Error: unknown switch `o'

Usage: perf kmem [<options>] {record|stat}

=C2=A0 =C2=A0-f, --force =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 don't complain,=
 do it
=C2=A0 =C2=A0-i, --input <file> =C2=A0 =C2=A0input file name
=C2=A0 =C2=A0-l, --line <num> =C2=A0 =C2=A0 =C2=A0show n lines
=C2=A0 =C2=A0-s, --sort <key[,key2...]>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sort by keys: ptr, callsite, bytes, hit, pingpong, frag, p=
age, order, mig>
=C2=A0 =C2=A0-v, --verbose =C2=A0 =C2=A0 =C2=A0 =C2=A0 be more verbose (sho=
w symbol address, etc)
=C2=A0 =C2=A0 =C2=A0 =C2=A0--alloc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show =
per-allocation statistics
=C2=A0 =C2=A0 =C2=A0 =C2=A0--caller =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0show =
per-callsite statistics
=C2=A0 =C2=A0 =C2=A0 =C2=A0--live =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Show live page stat
=C2=A0 =C2=A0 =C2=A0 =C2=A0--page =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Analyze page allocator
=C2=A0 =C2=A0 =C2=A0 =C2=A0--raw-ip =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0show =
raw ip instead of symbol
=C2=A0 =C2=A0 =C2=A0 =C2=A0--slab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Analyze slab allocator
=C2=A0 =C2=A0 =C2=A0 =C2=A0--time <str> =C2=A0 =C2=A0 =C2=A0Time span of in=
terest (start,stop)
```
perf sched is similar in implementation and avoids the problem by
passing additional arguments to perf record. This change makes perf kmem
parse command line options consistently with perf sched, although
neither actually list that -o is a supported option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 38a5ab683ebc..a50dae2c4ae9 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1933,7 +1933,8 @@ int cmd_kmem(int argc, const char **argv)
 		return ret;
=20
 	argc =3D parse_options_subcommand(argc, argv, kmem_options,
-					kmem_subcommands, kmem_usage, 0);
+					kmem_subcommands, kmem_usage,
+					PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (!argc)
 		usage_with_options(kmem_usage, kmem_options);
--=20
2.27.0.383.g050319c2ae-goog

