Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E29DC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DF20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780041;
	bh=j5PYCp0DQXlPHf9ZuHlkBJfnb0z/zwoDWENZXOV9YRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wu1aUDhPZJUSduqHc20pAs6RZDeWds+SNFNK1ZgdVDfbJKPDqlXGwgGsLmIXaE06r
	 bXEqm1xq9eK0ErzmvJwIFOFjrXsyjYOoofD3KNl31biSu8HEGEBkePS2CxurilA7nA
	 lsysiD8X38j9lpnf01i8rwnZ/gVFMZ11FHCmiM6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCISyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgCISx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:53:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F157B20663;
        Mon,  9 Mar 2020 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780038;
        bh=j5PYCp0DQXlPHf9ZuHlkBJfnb0z/zwoDWENZXOV9YRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYL1uZLCtKkORh2rdUuu8aEkMdGZQU0e7rfLfvNMxErGx0TpoVd9RbMVK0d1S9tC0
         afV7hMK/6uKrOOKPRJde/6A+IsZOlt3RCeQNcq+f3LSo5NbZuM401zOsG6o3NfIBSC
         oyQF1aw4dWV3s2zkhCkw+c3lxK81RTLd0WzvPRpA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/6] perf probe: Do not depend on dwfl_module_addrsym()
Date:   Mon,  9 Mar 2020 15:53:23 -0300
Message-Id: <20200309185323.22583-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Do not depend on dwfl_module_addrsym() because it can fail on user-space
shared libraries.

Actually, same bug was fixed by commit 664fee3dc379 ("perf probe: Do not
use dwfl_module_addrsym if dwarf_diename finds symbol name"), but commit
07d369857808 ("perf probe: Fix wrong address verification) reverted to
get actual symbol address from symtab.

This fixes it again by getting symbol address from DIE, and only if the
DIE has only address range, it uses dwfl_module_addrsym().

Fixes: 07d369857808 ("perf probe: Fix wrong address verification)
Reported-by: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Link: http://lore.kernel.org/lkml/158281812176.476.14164573830975116234.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 11 ++++++++---
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
-- 
2.21.1

