Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C61C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 04:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0A20707
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 04:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmABIsS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgECEBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 00:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgECEBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 00:01:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C88C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 21:01:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so6835030pgb.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 21:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tVSFijsXbLJqti8I4BTd6QGjSHIMre6YssZxYYic0uY=;
        b=jmABIsS4GIyMuwAPWPyJ5BPBpEcnSune+56Kb0tKGqIyonZdYf4U548yIl8yUxKzL6
         IBYFQ6qCkeUnsWmnUpMrAGKpzIoUrtdfO4Z+CYur/H85cn+rYeE4z8Rgc3bVfRT1lonK
         FGpNNw5HOxpEzi2CznRusPIlXaiEcctSIOXhlqm1KO73ET4rk4KRVEH2x0qbP8mRYLnx
         uY2Upwp5taGsi8t8PMogQoXPLYtS32MGemqgELDH4IzwThPaVm7UjrZokFNqRJdk4Jd9
         l0508oWAtepPCjY4T8ablW4fxJUAwutmUI9Q9bWHdo6wNgLi5w5UfOuqcnFlnaQF+Rf9
         8jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tVSFijsXbLJqti8I4BTd6QGjSHIMre6YssZxYYic0uY=;
        b=qPra9FGaHgRYOzZgWpc4KlOoYbJbgeEz+K694dfX7gnetY+NSed44CBx6HlB+9cADO
         iRCp0rlitztUlimaqWQ1LmBf5DAFDGAvWQpfKox4pMHxWz07Z3q6vH1QVu0SXYyCqKPc
         OAOcCnsnDKhZF/E4UWeuKWIjaJX6vaJQviBIbQRBQ9RrSG6cG82fndjQJMc1ZVc/iXKP
         t4wYnItWTbea5b8fLTo4hsgQ47G9KxBPVyhzQwNolwQYvtNZHZC/Xwiiq53LcITa6AkZ
         WUM9DNUHa/nPjy+4/hYtncjZbxTFJ19/VQ9nDUV5H8A7g74z73Lxo9ynRpPZM07mPBoL
         XK+g==
X-Gm-Message-State: AGi0PuZys+9bT3KhEh66f7lYxVEfVq+EY6Ab5RvSn1QXYjXiDb5ZlCPX
        83QCRzTgF8mxv1py0qv0IsE=
X-Google-Smtp-Source: APiQypKMvkY+RP18zEA5jzME1ZK8rGXpc+QrO4uWnaLuLduVXm9+ipMbl72MlQL2ubfnN2NUOb+j3A==
X-Received: by 2002:a63:d16:: with SMTP id c22mr11190178pgl.34.1588478468459;
        Sat, 02 May 2020 21:01:08 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id w12sm5537450pfq.133.2020.05.02.21.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 21:01:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf trace: add default value for opt 'call-graph'
Date:   Sun,  3 May 2020 04:00:56 +0000
Message-Id: <20200503040056.29683-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says the default value of call-graph.record_mode is 'fp'.
But actually we never can omit value of call-graph parameter. This patch
can fix this issue.

Meanwhile, this patch adds a short name '-g' for opt 'call-graph' since it's
very useful.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 01d542007c8b..21a9656021a0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4754,9 +4754,9 @@ int cmd_trace(int argc, const char **argv)
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
-	OPT_CALLBACK(0, "call-graph", &trace.opts,
+	OPT_CALLBACK_DEFAULT('g', "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
-		     &record_parse_callchain_opt),
+		     &record_parse_callchain_opt, "fp"),
 	OPT_BOOLEAN(0, "libtraceevent_print", &trace.libtraceevent_print,
 		    "Use libtraceevent to print the tracepoint arguments."),
 	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
-- 
2.17.1

