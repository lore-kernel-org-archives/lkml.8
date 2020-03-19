Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D921C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F920CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCSOK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:10:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbgCSOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsl-00025K-Jq; Thu, 19 Mar 2020 15:10:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9558B1C22A8;
        Thu, 19 Mar 2020 15:10:45 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Use strstarts() to look for Android libraries
Cc:     Dominik Czarnota <dominik.b.czarnota@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CABEVAa0_q-uC0vrrqpkqRHy_9RLOSXOJxizMLm1n5faHRy2AeA@mail.gmail.com>
References: <CABEVAa0_q-uC0vrrqpkqRHy_9RLOSXOJxizMLm1n5faHRy2AeA@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <158462704532.28353.11599935829036815046.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bdadd647cbf7b6e7f5d5891bd4e711292793cf23
Gitweb:        https://git.kernel.org/tip/bdadd647cbf7b6e7f5d5891bd4e711292793cf23
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 09 Mar 2020 16:53:41 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Mar 2020 10:48:44 -03:00

perf map: Use strstarts() to look for Android libraries

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
index b342f74..53d9661 100644
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
