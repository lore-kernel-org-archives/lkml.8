Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B3C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833FF2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182541;
	bh=bD73QIIi4NA4zcv9GxK5KEvrUBvwJrFoCih3mDD+zlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+tfWjy42Piq5Ztpt7VktM3GNKA0YNhALavmkXomv9zuKaL10qOz/clMVfm/964w0
	 xAcfSQJJJUffcAEe8ETZIWbPK0Elge2W05kOKLowrtr/8KgEMGwPqOCrbhl/IfQAi2
	 9IkqaGVJBVZKu0SJV5xzYHZZLWY9c1lLGQC266B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAPNtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA02207E0;
        Thu, 16 Jan 2020 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182538;
        bh=bD73QIIi4NA4zcv9GxK5KEvrUBvwJrFoCih3mDD+zlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNkqoH2JXXdxbbxhs4Fa+qiM8DkfWUMYUghoCP0LNq57kj0zhC3o9Sw+ui8DkKz6a
         H2x2ddYGZ5+KwiM+nN8Y5znCdWYvQdhYwrnkYur7kATe0rmb1L3pnWZUZVB8n84Hv3
         GHxPbVTNfHHEKp56DyI3uLgi4iGWhr9otRhIu5gw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/12] perf beauty sockaddr: Fix augmented syscall format warning
Date:   Thu, 16 Jan 2020 10:48:12 -0300
Message-Id: <20200116134814.8811-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cengiz Can <cengiz@kernel.wtf>

The sockaddr related examples given in
`tools/perf/examples/bpf/augmented_syscalls.c` almost always use `long`s
to represent most of their fields.

However, `size_t syscall_arg__scnprintf_sockaddr(..)` has a `scnprintf`
call that uses `"%#x"` as format string.

This throws a warning (whenever the syscall argument is `unsigned
long`).

Added `l` identifier to indicate that the `arg->value` is an unsigned
long.

Not sure about the complications of this with x86 though.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200113174438.102975-1-cengiz@kernel.wtf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sockaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 173c8f760763..e0c13e6a5788 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -72,5 +72,5 @@ size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg
 	if (arg->augmented.args)
 		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
 
-	return scnprintf(bf, size, "%#x", arg->val);
+	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.21.1

