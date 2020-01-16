Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC9C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8992D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182534;
	bh=/PtDaIZgsh1AvQWIV4lP/+wA/LZ8VNXmVkAkld3xnMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLHfv+KJvZ0ioFcOWzBSStmeQ1X28FKtALyjtSTBM3Pvp5a/T113631kym/rayTwZ
	 G2fJsF3Q8UnQeejbaGDSv/hMRhG14jHz+iF18tYIMERSXN1+ZX130jTdymcF69mH4s
	 lvMrfULxB4E9wUycNEske6kw02cWYn9iMhg28AQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAPNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:52 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E221420748;
        Thu, 16 Jan 2020 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182531;
        bh=/PtDaIZgsh1AvQWIV4lP/+wA/LZ8VNXmVkAkld3xnMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4U9Fw5bJQAroFb/t+NINEL91rdNpdSEj6Na0OpS4riIMX0nE5D26PsQxgybnXMsA
         P0xDMjSdEISdLlLz548lI67VuZj0gZy3zduxPpBkEJPraZ2UrQWwFXtwR0kY6kTiqO
         Q5Bd712bWQQfXz8yuRvFv8YHHLxvxX59erW77tf8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/12] perf ui gtk: Add missing zalloc object
Date:   Thu, 16 Jan 2020 10:48:10 -0300
Message-Id: <20200116134814.8811-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
---
 tools/perf/ui/gtk/Build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index ec22e899a224..9b5d5cbb7af7 100644
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
-- 
2.21.1

