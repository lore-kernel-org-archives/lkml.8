Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF455C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940252087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgGaLnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:43:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732734AbgGaLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:43:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1593DFAFDA3F5F6E2A6;
        Fri, 31 Jul 2020 19:42:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 31 Jul 2020
 19:42:34 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <acme@kernel.org>, <irogers@google.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
Date:   Fri, 31 Jul 2020 19:42:14 +0800
Message-ID: <20200731114214.25654-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function jvmti_write_code called by compiled_method_load_cb may return
error in using fwrite_unlocked, this failure should be captured and
warned.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/perf/jvmti/jvmti_agent.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 88108598d6e9..dfb6cb8564cb 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
 	struct jr_code_load rec;
 	size_t sym_len;
 	FILE *fp = agent;
-	int ret = -1;
+	int sret;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -400,17 +400,24 @@ jvmti_write_code(void *agent, char const *sym,
 	 */
 	rec.code_index = code_generation++;
 
-	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
-	fwrite_unlocked(sym, sym_len, 1, fp);
+	sret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
+	if (sret != 1)
+		goto error;
+	sret = fwrite_unlocked(sym, sym_len, 1, fp);
+	if (sret != 1)
+		goto error;
 
-	if (code)
-		fwrite_unlocked(code, size, 1, fp);
+	if (code) {
+		sret = fwrite_unlocked(code, size, 1, fp);
+		if (sret != 1)
+			goto error;
+	}
 
 	funlockfile(fp);
-
-	ret = 0;
-
-	return ret;
+	return 0;
+error:
+	funlockfile(fp);
+	return -1;
 }
 
 int
-- 
2.25.1

