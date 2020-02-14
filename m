Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0309DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C024B24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707532;
	bh=N63Gjn2Zdofx9AVBGZcwIT5TDyVnDwbm8UDI/7PVCqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XnGvTdrRibGMenUsRFbQZSTNqB6G6tzFM/0KFzH21fgs3fW1p2I35+oyjXcvrHC75
	 mq3M6GTxwGB7SvJBMHnJRJH85xqKvv/sfehEhWAEbpN3f74APmjz9eZKoMgJFFT3kU
	 lWsdXma96Vz3RpABYDBLiFf8wdUWB+6/ZHxfteV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgBNTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388832AbgBNTMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:08 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE1C206D7;
        Fri, 14 Feb 2020 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707528;
        bh=N63Gjn2Zdofx9AVBGZcwIT5TDyVnDwbm8UDI/7PVCqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHPU/6HyznY/85rkVQItaART67HR9LywvBRs5dSnLgm/77uD5LJKn5t+/uovLOlYt
         OwAjowUm9cwIRuXRdN6pGjAtrBP3au3GUYDM8fG54LKpSRfv/kNAMGRxif+17lJkyU
         Eml0vy/UmSvwPenYyFlcUDOZkc1lCHmEpqvCQJEI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mike Christie <mchristi@redhat.com>
Subject: [PATCH 12/23] perf trace: Resolve prctl's 'option' arg strings to numbers
Date:   Fri, 14 Feb 2020 16:10:46 -0300
Message-Id: <20200214191057.26266-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  # perf trace -e syscalls:sys_enter_prctl --filter="option==SET_NAME"
     0.000 Socket Thread/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
     0.053 SSL Cert #78/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
^C  #

If one uses '-v' with 'perf trace', we can see the filter it puts in
place:

  New filter for syscalls:sys_enter_prctl: (option==0xf) && (common_pid != 3859 && common_pid != 2757)

We still need to allow using plain '-e prctl' and have this turn into
creating a 'syscalls:sys_enter_prctl' event so that the filter can be
applied only to it as right now '-e prctl' ends up using the
'raw_syscalls:sys_enter/sys_exit'.

The end goal is to have something like:

  # perf trace -e prctl/option==SET_NAME/

And have that use tracepoint filters or eBPF ones.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46a72ecac427..01d542007c8b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1065,7 +1065,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
 	{ .name	    = "prctl",
-	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
+	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */
+			   .strtoul   = STUL_STRARRAY,
+			   .parm      = &strarray__prctl_options, },
 		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
 		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
 	{ .name	    = "pread", .alias = "pread64", },
-- 
2.21.1

