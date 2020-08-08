Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B90C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC0222CF8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv7rFLy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHHCcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:32:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEFC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:32:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h21so2769215qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mYw7AzLhlZBop67BxTqOn31s2Pt5GUy/mQi9z3//Xw=;
        b=Mv7rFLy1/lxyvRkIrT4DQTvMAKEy+DILcqRgsnAvH4ImssDeitVj+njMOQDnjz0d7e
         EA0uhoA8iL4gXuqSzJnkWutU8sC8dwdJ9HFxFftwmdJRamXom1JfZD4PlSxoaYx++yrc
         Bp2aNIL2sjkiijQcSMVvJga4HL5npvJYt5Qp5fgSpzSZrdaQgqLsi8OuwrDbKcgGOpcR
         lPQf10zIvKa7x0f0Ez6+Xh/06/iY0i91cPfPKwCah+VkLVbo/pRIL8ZZwZenNrL+GZdT
         jaWQE2QA51irFZLHkOg653gTNYNMEcj+o6uL/o/vLNVfb03zbVWDWyMRy9u+6BzOmHQ5
         V4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mYw7AzLhlZBop67BxTqOn31s2Pt5GUy/mQi9z3//Xw=;
        b=KtDSKPqxZEuKk+656zr7Bh70YWHNcffw6J+NGkCowd5AZGEAX016nX2D2qTAXH6qIz
         Yed2DH5AjtwkTLfjGY0YIt1EF+AQb3sIfVsMMAFv6ddGdsrFESbXmVhoOhSIa1bUjlHK
         7yyO8UTbqypOSf8jMG9x0WmzLuYLbGcX+zSQh8Zn6zUH0+h9DS0dPHat0TAFzPEnNy/e
         s8lOG8zyXQDP/eCt9eVVkTBXfI1pR+kaqzRCluk/xyvGTeeTFnTjdbAH9+5j3/PPLZs6
         0j+32MMOu8PbXv2fD5MDRZR7f2/uWkURr7jyMimTsswCP1CNtOWbfJ0+iI84muUzjvAe
         yaLA==
X-Gm-Message-State: AOAM532ky/G3U3UU4rwTASiMG2ARWck0E8FwrXtyeTAeRvSlAvxiy/st
        4A7ihXA9Jbkai4BsPC7KQPU=
X-Google-Smtp-Source: ABdhPJwjknPUUXjM44ETWJnliHbggQpWQVEuLSBB6NROEgxCp81FvZMoV2KLj8DEoHqyU7IEpxczhg==
X-Received: by 2002:ac8:3a65:: with SMTP id w92mr17514773qte.184.1596853949039;
        Fri, 07 Aug 2020 19:32:29 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:32:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 05/18] perf ftrace: show trace column header
Date:   Sat,  8 Aug 2020 10:31:28 +0800
Message-Id: <20200808023141.14227-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes perf-ftrace display column header before printing trace.

  $ sudo perf ftrace
  # tracer: function
  #
  # entries-in-buffer/entries-written: 0/0   #P:8
  #
  #            TASK-PID     CPU#   TIMESTAMP  FUNCTION
  #              | |         |       |         |
             <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
             <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
             <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
             <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
             <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a3a4f4be9dde..39c694be2b71 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -435,6 +435,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
+	/* display column headers */
+	read_tracing_file_to_stdout("trace");
+
 	if (write_tracing_file("tracing_on", "1") < 0) {
 		pr_err("can't enable tracing\n");
 		goto out_close_fd;
-- 
2.25.1

