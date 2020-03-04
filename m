Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B175C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CFD24654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgCDLB6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:01:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387844AbgCDLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:01:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9Rmf-0001YN-Gh; Wed, 04 Mar 2020 12:01:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2BCC11C21B2;
        Wed,  4 Mar 2020 12:01:49 +0100 (CET)
Date:   Wed, 04 Mar 2020 11:01:48 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf parse-events: Use asprintf() instead of
 strncpy() to read tracepoint files
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302145535.GA28183@kernel.org>
References: <20200302145535.GA28183@kernel.org>
MIME-Version: 1.0
Message-ID: <158331970880.28353.7024128666821877092.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7125f204501ed55493593209c6c71ac7c38f6b6c
Gitweb:        https://git.kernel.org/tip/7125f204501ed55493593209c6c71ac7c38f6b6c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Mar 2020 11:55:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Mar 2020 11:55:47 -03:00

perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files

Make the code more compact by using asprintf() instead of malloc()+strncpy() which also uses
less memory and avoids these warnings with gcc 10:

    CC       /tmp/build/perf/util/cloexec.o
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:271:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘sys_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:273:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘evt_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
    CC       /tmp/build/perf/util/call-path.o

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200302145535.GA28183@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f..a149958 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 				path = zalloc(sizeof(*path));
 				if (!path)
 					return NULL;
-				path->system = malloc(MAX_EVENT_LENGTH);
-				if (!path->system) {
+				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
 					free(path);
 					return NULL;
 				}
-				path->name = malloc(MAX_EVENT_LENGTH);
-				if (!path->name) {
+				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
 					zfree(&path->system);
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent->d_name,
-					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent->d_name,
-					MAX_EVENT_LENGTH);
 				return path;
 			}
 		}
