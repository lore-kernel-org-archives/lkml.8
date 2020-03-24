Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC1C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CC620724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCXEYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:24:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgCXEYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:24:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O46AOX127257
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:24:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuuxkm8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:24:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 24 Mar 2020 04:24:34 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 04:24:30 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O4NT5O9568666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 04:23:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE584AE045;
        Tue, 24 Mar 2020 04:24:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3F6AE068;
        Tue, 24 Mar 2020 04:24:29 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.53.75])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 04:24:28 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf dso: Fix dso comparison
Date:   Tue, 24 Mar 2020 09:54:24 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032404-0020-0000-0000-000003B9E728
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032404-0021-0000-0000-0000221265EC
Message-Id: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_10:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 0e3149f86b99 ("perf dso: Move dso_id from 'struct map' to 'struct dso'")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/dsos.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 591707c69c39..5c5bfa2538a9 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -26,13 +26,29 @@ static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	return 0;
 }
 
+static bool is_empty_dso_id(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+static void inject_dso_id(struct dso *dso, struct dso_id *id)
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
+	if (is_empty_dso_id(a) || is_empty_dso_id(b))
 		return 0;
 
 	return __dso_id__cmp(a, b);
@@ -249,6 +265,10 @@ struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false);
+
+	if (dso && is_empty_dso_id(&dso->id) && !is_empty_dso_id(id))
+		inject_dso_id(dso, id);
+
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
 
-- 
2.24.1

