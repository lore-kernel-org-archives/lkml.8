Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077FC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530992176D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182517;
	bh=fpOOGmeyqwLSTfh7bia5+W98zuBwS4m+sGojsuIyFJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wofzKD05CAd1PZboIcV9gTmA3Jb4MZhUSc6vv1PtcLF3XQIdxBCMICMiUDf9hPsdc
	 EBp5vBLbsKimnAeHBvPbPIGmoin07wlSPD2U3ajpgyGA4hTfkDFIeevl3hXODWEpD8
	 JgQaEvIS8Dn3rAWJBuB20JQvdWtwfgDbbS8+dC8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgAPNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC13207E0;
        Thu, 16 Jan 2020 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182514;
        bh=fpOOGmeyqwLSTfh7bia5+W98zuBwS4m+sGojsuIyFJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJEymsU//rF3glta3zlLCnvWyt6+cN8wWxz4uZEHwi0W0N7JCdBv+rMDL28oc6dxC
         /DPVYLZ2jtCerdLUmFf/TAQuKB8GGtkC6kyeFQxY0D+OcZMEDxuKa0VYgDYpetbEhE
         JtEx8oEHDiGaCTRBgbqWCWWhQTcg7Xs4TtooTln0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/12] perf report: Clarify in help that --children is default
Date:   Thu, 16 Jan 2020 10:48:05 -0300
Message-Id: <20200116134814.8811-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Refer to --no-children, which is what most people probably want.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20200103183643.149150-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index de988589d99b..3048c1b95b4c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1164,7 +1164,8 @@ int cmd_report(int argc, const char **argv)
 			     report_callchain_help, &report_parse_callchain_opt,
 			     callchain_default_opt),
 	OPT_BOOLEAN(0, "children", &symbol_conf.cumulate_callchain,
-		    "Accumulate callchains of children and show total overhead as well"),
+		    "Accumulate callchains of children and show total overhead as well. "
+		    "Enabled by default, use --no-children to disable."),
 	OPT_INTEGER(0, "max-stack", &report.max_stack,
 		    "Set the maximum stack depth when parsing the callchain, "
 		    "anything beyond the specified depth will be ignored. "
-- 
2.21.1

