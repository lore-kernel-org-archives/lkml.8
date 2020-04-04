Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA7C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F22620CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgDDIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDDImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNJ-00018J-If; Sat, 04 Apr 2020 10:41:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5D8DF1C0805;
        Sat,  4 Apr 2020 10:41:53 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:53 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf dso: Fix dso comparison
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158598971301.28353.13896908628058795297.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0d33b34352531ff7029c58eda2321340c0ea3f5f
Gitweb:        https://git.kernel.org/tip/0d33b34352531ff7029c58eda2321340c0ea3f5f
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Tue, 24 Mar 2020 09:54:24 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:57:38 -03:00

perf dso: Fix dso comparison

Perf gets dso details from two different sources. 1st, from builid
headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
header does not have dso_id detail. And dso from MMAP2 samples does
not have buildid information. If detail of the same dso is present
at both the places, filename is common.

Previously, __dsos__findnew_link_by_longname_id() used to compare only
long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
from 'struct map' to 'struct dso'") also added a dso_id comparison.
Because of that, now perf is creating two different dso objects of the
same file, one from buildid header (with dso_id but without buildid)
and second from MMAP2 sample (with buildid but without dso_id).

This is causing issues with archive, buildid-list etc subcommands. Fix
this by comparing dso_id only when it's present. And incase dso is
present in 'dsos' list without dso_id, inject dso_id detail as well.

Before:

  $ sudo ./perf buildid-list -H
  0000000000000000000000000000000000000000 /usr/bin/ls
  0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
  0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so

  $ ./perf archive
  perf archive: no build-ids found

After:

  $ ./perf buildid-list -H
  b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
  641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
  675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so

  $ ./perf archive
  Now please run:

  $ tar xvf perf.data.tar.bz2 -C ~/.debug

  wherever you need to run 'perf report' on.

Committer notes:

Renamed is_empty_dso_id() to dso_id__empty() and inject_dso_id() to
dso__inject_id() to keep namespacing consistent.

Fixes: 0e3149f86b99 ("perf dso: Move dso_id from 'struct map' to 'struct dso'")
Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200324042424.68366-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 591707c..9394717 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -26,13 +26,29 @@ static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	return 0;
 }
 
+static bool dso_id__empty(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+static void dso__inject_id(struct dso *dso, struct dso_id *id)
+{
+	dso->id.maj = id->maj;
+	dso->id.min = id->min;
+	dso->id.ino = id->ino;
+	dso->id.ino_generation = id->ino_generation;
+}
+
 static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
 	/*
 	 * The second is always dso->id, so zeroes if not set, assume passing
 	 * NULL for a means a zeroed id
 	 */
-	if (a == NULL)
+	if (dso_id__empty(a) || dso_id__empty(b))
 		return 0;
 
 	return __dso_id__cmp(a, b);
@@ -249,6 +265,10 @@ struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false);
+
+	if (dso && dso_id__empty(&dso->id) && !dso_id__empty(id))
+		dso__inject_id(dso, id);
+
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
 
