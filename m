Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F2C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E7521D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gYMCiMCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgAQXpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:45:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbgAQXpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:45:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HNSNUf017480
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:45:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Sok7U8dg0bqgNO0xZwUMVKyUbAR6McyeiedSKBbUSf0=;
 b=gYMCiMCkEkailKk2vKOemzTki7hd38dnEXrDKcefj1t2pyrP8g8uZAqIjytsh8TF944M
 VpcQhn2lBR/J92Flw1rW9xONlweP9PpMwmm43YLuKUaNIq/pMjovy7ZJbzcpeH+gMU6B
 E4SeSiv86MLXG8bT4priMAbYbtLhr75hD7o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0rpn9av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:45:11 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jan 2020 15:45:11 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1F6F662E3453; Fri, 17 Jan 2020 15:45:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Date:   Fri, 17 Jan 2020 15:45:03 -0800
Message-ID: <20200117234503.1324050-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=937
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170178
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl_perf_event_mlock and user->locked_vm can change value
independently, so we can't guarantee:

    user->locked_vm <= user_lock_limit

When user->locked_vm is larger than user_lock_limit, we cannot simply
update extra and user_extra as:

    extra = user_locked - user_lock_limit;
    user_extra -= extra;

Otherwise, user_extra will be negative. In extreme cases, this may lead to
negative user->locked_vm (until this perf-mmap is closed), which break
locked_vm badly.

Fix this with two separate conditions, which make sure user_extra is
always positive.

Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again")
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde19b56..89acdd1574ef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5920,11 +5920,31 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
-		 * charge the rest from pinned_vm
+		 * sysctl_perf_event_mlock and user->locked_vm can change
+		 * value independently, so we can't guarantee:
+		 *
+		 *    user->locked_vm <= user_lock_limit
+		 *
+		 * We need be careful to make sure user_extra >=0.
+		 *
+		 * Using "user_locked - user_extra" to avoid calling
+		 * atomic_long_read() again.
 		 */
-		extra = user_locked - user_lock_limit;
-		user_extra -= extra;
+		if (user_locked - user_extra >= user_lock_limit) {
+			/*
+			 * already used all user_locked_limit, charge all
+			 * to pinned_vm
+			 */
+			extra = user_extra;
+			user_extra = 0;
+		} else {
+			/*
+			 * charge locked_vm until it hits user_lock_limit;
+			 * charge the rest from pinned_vm
+			 */
+			extra = user_locked - user_lock_limit;
+			user_extra -= extra;
+		}
 	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
-- 
2.17.1

