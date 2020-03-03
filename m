Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF720870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258707;
	bh=7tV0NVotmzh0q+KwNJ3XzdXzL+Cvualt8ZjzXVFz42E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1du4yIY8yRCJR1/eLvmW1lzg3xJXad6+SkCjwG7wzMegc9qe/wfJhvfROQU2k35OH
	 KLKnXs+1kaHmMiLF43PtAjQL26VXbGxCyjTfVXNLZUbBAz+ZSE7Ky35DkDk5Jgev7L
	 KaPCSaoxRCt21ULQi/bN80Z3x2ExrNGvwDiYQOkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbgCCR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbgCCR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:58:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73ABB20728;
        Tue,  3 Mar 2020 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258313;
        bh=7tV0NVotmzh0q+KwNJ3XzdXzL+Cvualt8ZjzXVFz42E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zylpXeisxOBxR0NQlx9S2GDPruXkDhv7rGroAF6nnYWflaIlFd7eAPYS/arGeY5oD
         JlgnJKWDWGOkbkha9JJGKSM5RBX35es7BrmeiRocPd9MzegygTikk9H6dLXPp2JzJX
         fHnIj5osg+zcqF9gWZoMM+GSIPVqwFBrg8OhMCQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 133/152] perf ui gtk: Add missing zalloc object
Date:   Tue,  3 Mar 2020 18:43:51 +0100
Message-Id: <20200303174317.931341457@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

commit 604e2139a1026793b8c2172bd92c7e9d039a5cf0 upstream.

When we moved zalloc.o to the library we missed gtk library which needs
it compiled in, otherwise the missing __zfree symbol will cause the
library to fail to load.

Adding the zalloc object to the gtk library build.

Fixes: 7f7c536f23e6 ("tools lib: Adopt zalloc()/zfree() from tools/perf")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200113104358.123511-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/ui/gtk/Build |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -7,3 +7,8 @@ gtk-y += util.o
 gtk-y += helpline.o
 gtk-y += progress.o
 gtk-y += annotate.o
+gtk-y += zalloc.o
+
+$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)


