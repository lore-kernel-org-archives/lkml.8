Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6434DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E4207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182531;
	bh=cc+CkFgFN6vx/vr1EwFPm4067hbFz05QJ50Q24OONDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LqpXlK3FNlm5rSf1KINDhjaMPJndXtI9hWL1t1yYyexbOBZb6LLOI8FwPTQkIUhqA
	 Qb5DWxC8pkxpa/GfvN8PJeVBvaAkd04kfWJ47KiN97GyGG7WVIXGgq7iKCnCdsKfaj
	 uLj0N7R8b3jMIGMWV2wiNuxdHkDxQ6XC629X1MxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAPNsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:48 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613562077B;
        Thu, 16 Jan 2020 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182528;
        bh=cc+CkFgFN6vx/vr1EwFPm4067hbFz05QJ50Q24OONDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dR1WEmzxWRABxqN6UneP1rGLFwPkSRMRemQLSna6srxJ8cvjW3vgew6X23K2vZmy
         VxrSt7LqZQto83gMXWk2KZCu1tRuu0VQetXrTdYUFvl+EC8goJTPRmrww/G7uwLVVF
         /wprSH7cZuUjlcyGrc1bl/t1JOgEwJ255zqm2Atg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/12] perf tools: Use %define api.pure full instead of %pure-parser
Date:   Thu, 16 Jan 2020 10:48:09 -0300
Message-Id: <20200116134814.8811-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

bison deprecated the "%pure-parser" directive in favor of "%define
api.pure full".

The api.pure got introduced in bison 2.3 (Oct 2007), so it seems safe to
use it without any version check.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200112192259.GA35080@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.y         | 3 ++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f9a20a39b64a..7d226241f1d7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -12,7 +12,8 @@
 #define MAXIDLEN 256
 %}
 
-%pure-parser
+%define api.pure full
+
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
 %parse-param { const char **pp }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e2eea4e601b4..94f8bcd83582 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -1,4 +1,4 @@
-%pure-parser
+%define api.pure full
 %parse-param {void *_parse_state}
 %parse-param {void *scanner}
 %lex-param {void* scanner}
-- 
2.21.1

