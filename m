Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA34C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587B21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMRo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:44:58 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35497 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:44:58 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AE1D91BF206;
        Mon, 13 Jan 2020 17:44:55 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] tools: perf: fix augmented syscall format warning
Date:   Mon, 13 Jan 2020 20:44:39 +0300
Message-Id: <20200113174438.102975-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sockaddr related examples given in
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
2.24.1

