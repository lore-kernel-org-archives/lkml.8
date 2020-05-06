Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097EEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC0821841
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778679;
	bh=vIjVfr8/O6yp+vBc50n9txJpOkm0dGInCgTACUkx+Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+do1kkvOTjJdGVpYPrTh7SvwGYGPpqNiwrKbHcehVuyW1rD7yogG/7+ECylPOJIu
	 JGTRrLP3BaWxHFDVC5xObyzn2aoUmRNgFvlNHK0cZDIgYKLhEk+7Y9AjR0jWC+86DX
	 LDMpxl8zRL6WSFyAmzo6B5nKEc7KHmpyCbFUT1U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgEFPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgEFPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB8220CC7;
        Wed,  6 May 2020 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778673;
        bh=vIjVfr8/O6yp+vBc50n9txJpOkm0dGInCgTACUkx+Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+bE8cmuLauRPFtxihg2Qe5FbwMlGmFNiypyEmnDGyqOVvxgtDrVsARKEvHa1xVxT
         vn5ieHUXrTyTEznttiDlFphFXQb41ZMBBVrCqeZA+xHC88NHVaWEzsQcB6aeLKHrJa
         rRdQUjumA9d2rL4DVPT5X7c3IZ6pAS9fTEXY3uXM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 29/91] libsubcmd: Introduce OPT_CALLBACK_SET()
Date:   Wed,  6 May 2020 12:21:32 -0300
Message-Id: <20200506152234.21977-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To register that an option was set, like with the upcoming 'perf record
--switch-output-option' one.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-7-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index af9def589863..d2414144eb8c 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -151,6 +151,8 @@ struct option {
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = "time", .help = (h), .callback = parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f) }
+#define OPT_CALLBACK_SET(s, l, v, os, a, h, f) \
+	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .set = check_vtype(os, bool *)}
 #define OPT_CALLBACK_NOOPT(s, l, v, a, h, f) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = (a), .help = (h), .callback = (f), .flags = PARSE_OPT_NOARG }
 #define OPT_CALLBACK_DEFAULT(s, l, v, a, h, f, d) \
-- 
2.21.1

