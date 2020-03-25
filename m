Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D1CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EC52078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140198;
	bh=YWyp1jMlr4htGsr2fRTgHFECFcMJWl26+n0hic8xDxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=penz8YUIg/42ALqT+KYOJVvdkUa2R62RWH6RcH+f1BmP9oblM9eUkJY2bP5A0+SXU
	 e1DnkdZWskuK1kYpFWzo6M/LHJGRz2/G/RcC18v8sAxlNcCUFfZKPEUXy4yDXtsgJd
	 4H8jISsDbgYjuYRxISbfHyx+WyRE20uZtbCZ5JEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCYMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbgCYMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:43:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8312078D;
        Wed, 25 Mar 2020 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140193;
        bh=YWyp1jMlr4htGsr2fRTgHFECFcMJWl26+n0hic8xDxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFOB4YPqYsZG7y6pyE5RSL1l1sMpEThehvQObfx2spOcrgENmJrCCMKCPH/PVu0Gk
         hwPljxr2fUeNL4mOG7aBekuzXbl0Dn4O0TYRZBsS1qsx4URFmymKcx0wt0H87cjxNk
         DClVy0ajXAeGPZk9KtHWgDADuqGva1nHrIY7TeYI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 24/24] perf dso: Fix dso comparison
Date:   Wed, 25 Mar 2020 09:41:24 -0300
Message-Id: <20200325124124.32648-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

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
index 591707c69c39..939471731ea6 100644
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
 
-- 
2.21.1

