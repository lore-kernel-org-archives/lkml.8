Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D004C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F966246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582818128;
	bh=DaLJtm6KohuN+cM/TAHbV88fZ/uWlTT8YpaA8v4SJKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N1rt9IWJayBJDV5wyTdBzWEMU7tfT1eCkIpT4x4QEeMgroDyPoTehcmlFnQapeGv2
	 mw7s/tNfNTRwQZBqbH8AY6MWK0NZ91zxhmcw74A9SeK+lH1S/2C7lEfdDOOq5pclv7
	 K9XaZkhzWzleeNwQ03soyivoWzxW9nr7ynl3gHx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgB0PmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgB0PmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:42:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4B124697;
        Thu, 27 Feb 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582818126;
        bh=DaLJtm6KohuN+cM/TAHbV88fZ/uWlTT8YpaA8v4SJKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4X1bh43IsWZ3v+GRJ3RGojBfeMMOA8lMQKn/ZEituuza0yS/63sJXTHs83vXyKY1
         09yPCoCNZm0OTqjtexhKZWw8XulpO7ShcJBQZlI9mitjy1aWqGOnacHICExVyPJ3ox
         g65dj6jJmpewX3cPHBLGdQLV1+T0pfPPOZprsbEA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH] perf probe: Do not depend on dwfl_module_addrsym()
Date:   Fri, 28 Feb 2020 00:42:01 +0900
Message-Id: <158281812176.476.14164573830975116234.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002553.31b82876b705aaabbd717131@kernel.org>
References: <20200228002553.31b82876b705aaabbd717131@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not depend on dwfl_module_addrsym() because it can fail
on user-space shared libraries.

Actually, same bug was fixed by commit 664fee3dc379 ("perf
probe: Do not use dwfl_module_addrsym if dwarf_diename finds
symbol name"), but commit 07d369857808 ("perf probe: Fix
wrong address verification) reverted to get actual symbol
address from symtab.

This fixes it again by getting symbol address from DIE,
and only if the DIE has only address range, it uses
dwfl_module_addrsym().

Fixes: 07d369857808 ("perf probe: Fix wrong address verification)
Reported-by: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 1c817add6ca4..e4cff49384f4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -637,14 +637,19 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 		return -EINVAL;
 	}
 
-	/* Try to get actual symbol name from symtab */
-	symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
+	if (dwarf_entrypc(sp_die, &eaddr) == 0) {
+		/* If the DIE has entrypc, use it. */
+		symbol = dwarf_diename(sp_die);
+	} else {
+		/* Try to get actual symbol name and address from symtab */
+		symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
+		eaddr = sym.st_value;
+	}
 	if (!symbol) {
 		pr_warning("Failed to find symbol at 0x%lx\n",
 			   (unsigned long)paddr);
 		return -ENOENT;
 	}
-	eaddr = sym.st_value;
 
 	tp->offset = (unsigned long)(paddr - eaddr);
 	tp->address = (unsigned long)paddr;

