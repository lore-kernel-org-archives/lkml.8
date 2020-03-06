Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A27D206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521929;
	bh=3fdeTMTVLyvy2AI3VyujYmwAndWHM4zwmv0d3on0KZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=re20rEegSvL2oWkDoEGvPF6/aH+ykxq6I7a89FrvdJJj2tCb7k8mnnEYmWWqV4KiN
	 UjcM9Jls3zzPVxOWDC58qYB8GC3WnwqY1vg77gvLgq25LlnS3ONmDqhil0v43bukQB
	 0k9w9bYgFqk5ivX5zjZwezBP/XqJE5qgHwPvc6v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCFTMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFTMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:02 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C42206D7;
        Fri,  6 Mar 2020 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521922;
        bh=3fdeTMTVLyvy2AI3VyujYmwAndWHM4zwmv0d3on0KZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjdVl3lZZ+CtMlNbFxjGi8s3K/LqmbWot01Mu6Msx0RMiky73RQXUPeeGcBeS8lnn
         MVqffnK8ePbcsMt5TmuBV+URk4Besud4hMrqUYy8U0ebKZ0oRGG/BtP9qjyfKk7+yX
         F0ZowkTFurKTPDxKJ5bGz8wl6pcYEu9iP7UrIUfY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/5] perf env: Do not return pointers to local variables
Date:   Fri,  6 Mar 2020 16:11:36 -0300
Message-Id: <20200306191144.12762-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is possible to return a pointer to a local variable when looking up
the architecture name for the running system and no normalization is
done on that value, i.e. we may end up returning the uts.machine local
variable.

While this doesn't happen on most arches, as normalization takes place,
lets fix this by making that a static variable and optimize it a bit by
not always running uname(), only the first time.

Noticed in fedora rawhide running with:

  [perfbuilder@a5ff49d6e6e4 ~]$ gcc --version
  gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8)

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6242a9215df7..4154f944f474 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -343,11 +343,11 @@ static const char *normalize_arch(char *arch)
 
 const char *perf_env__arch(struct perf_env *env)
 {
-	struct utsname uts;
 	char *arch_name;
 
 	if (!env || !env->arch) { /* Assume local operation */
-		if (uname(&uts) < 0)
+		static struct utsname uts = { .machine[0] = '\0', };
+		if (uts.machine[0] == '\0' && uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
 	} else
-- 
2.21.1

