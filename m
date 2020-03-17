Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B4C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480820;
	bh=QiFL1SILmoRYQjtmLD5McIsWiutWt1jiVNiQhYym6Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOmSBKbgcR8JIzx/HlYpDn7R7X+qHclkC3wjGyJwogX9EOErrv4ghZviWoABTmviO
	 FVvvJcS09bKZDpu69zl9KprteN8VuVSfTgVdPiPNW5RL1UH2gtnJQhWKpx03y05Sj3
	 2y9PGhrFjmu2qgnQvzvKkRB/3Yb5YFnABKn8PiyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCQVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCQVdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A9D2076D;
        Tue, 17 Mar 2020 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480817;
        bh=QiFL1SILmoRYQjtmLD5McIsWiutWt1jiVNiQhYym6Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPVQDvAcYWlj/BN3LzgcuVCuccVb3SFPDV9x7IfToz2G3i6GJWBGikBxX6bFc1zI0
         Rvay2kK/2dDz4gAKHkvy6C3JWsu5XwLTntvDT3QqzBHk8o49fe99BaGjCpdp8bDa9g
         2dut+S5c+W08lmpVFIfoc060fY1UMfMvNkGoU0Lw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dominik Czarnota <dominik.b.czarnota@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/23] perf map: Use strstarts() to look for Android libraries
Date:   Tue, 17 Mar 2020 18:32:44 -0300
Message-Id: <20200317213259.15494-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And add the '/' to avoid looking at things like "/system/libsomething",
when all we want to know if it is like "/system/lib/something", i.e. if
it is in that system library dir.

Using strstarts() avoids off-by-one errors like recently fixed in this
file.

Since this adds the '/' I separated this patch, another patch will make
this consistent by removing other strncmp(str, prefix, manually
calculated prefix length) usage.

Reported-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Acked-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: Link: http://lore.kernel.org/lkml/CABEVAa0_q-uC0vrrqpkqRHy_9RLOSXOJxizMLm1n5faHRy2AeA@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b342f744b1fc..53d96611e6a6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -44,8 +44,8 @@ static inline int is_no_dso_memory(const char *filename)
 
 static inline int is_android_lib(const char *filename)
 {
-	return !strncmp(filename, "/data/app-lib", 13) ||
-	       !strncmp(filename, "/system/lib", 11);
+	return strstarts(filename, "/data/app-lib/") ||
+	       strstarts(filename, "/system/lib/");
 }
 
 static inline bool replace_android_lib(const char *filename, char *newfilename)
@@ -65,7 +65,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 	app_abi_length = strlen(app_abi);
 
-	if (!strncmp(filename, "/data/app-lib", 13)) {
+	if (strstarts(filename, "/data/app-lib/")) {
 		char *apk_path;
 
 		if (!app_abi_length)
@@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 12)) {
+	if (strstarts(filename, "/system/lib/")) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;
-- 
2.21.1

