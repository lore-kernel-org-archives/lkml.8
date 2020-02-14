Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789EEC71146
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35254206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707509;
	bh=S+wbcBeU2i8vV4ukop/Pms8FlZx7B61a4wci5Pi8W88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+qq5F2KgoICVI00gVcR/1IVc/GytvsX3X8akzP+tOYA3BPqZYrgL5H59j9vQGFof
	 CFoK/vaIbnQOrKCdSLSouJJkFWFyOOEMaspnyrQAjrxI0e2leM8rir/0omKmRrDGAH
	 sOX3ELcYgp2Z1ncpftPdO2WylcCEKpWtzJisqySo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbgBNTLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388456AbgBNTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:41 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B99206D7;
        Fri, 14 Feb 2020 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707500;
        bh=S+wbcBeU2i8vV4ukop/Pms8FlZx7B61a4wci5Pi8W88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpZDzHazdqQOrXnbaVknh1JsKQIvpQ692VwAI0ZqYJPOk8Jkhf4tbNlGiZBVowL4H
         OvzTEJkV5Qpb0nNIwIHWbL+Y2VWjpugVqnThHS823pt19efpyvhvsua4z8YREbpOfu
         RPj/jLxGsQTlKU9HQIAwtLrwVKYkZFXcqWf6EMZw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/23] perf maps: Mark ksymbol DSOs with kernel type
Date:   Fri, 14 Feb 2020 16:10:40 -0300
Message-Id: <20200214191057.26266-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We add ksymbol map into machine->kmaps, so it needs to be created as
'struct kmap', which is dependent on its dso having kernel type.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210200847.GA36715@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e3e5490f6de5..0ad026561c7f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -727,9 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map) {
+			dso__put(dso);
 			return -ENOMEM;
+		}
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
-- 
2.21.1

