Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C78C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD402465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pawUXEVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAVTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:05:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58602 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728931AbgAVTFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:05:10 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MJ4V7v022572
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:05:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IbY0NCmrDHkR4f+f7AGnaJafs+/Li+YN6y9MFIu6HlY=;
 b=pawUXEVFumepjGfKpfZeukPYb5ImhYsoeZQTeQrakpgVydHNWBTNyhiM/qD+u0YW3/Qm
 xDU0BQWNduuNyo4m6/G/05z48G2MQLy/dROwQXmxo6Ui1LO5KBkcA/fBbGQgBZr7tabm
 xRk3i0ux7EQPpTnBa2o7y3GbByzswgpVfio= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xpr4k99md-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:05:09 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 11:05:00 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AA33262E29FA; Wed, 22 Jan 2020 11:04:54 -0800 (PST)
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
Subject: [PATCH v2] perf/core: fix mlock accounting in perf_mmap()
Date:   Wed, 22 Jan 2020 11:04:47 -0800
Message-ID: <20200122190447.1920297-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220161
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

Fix this by adjusting user_locked before calculating extra and user_extra.

Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again")
Signed-off-by: Song Liu <songliubraving@fb.com>
Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2173c23c25b4..d25f2de45996 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5916,8 +5916,19 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	 */
 	user_lock_limit *= num_online_cpus();
 
-	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
+	user_locked = atomic_long_read(&user->locked_vm);
 
+	/*
+	 * sysctl_perf_event_mlock and user->locked_vm can change value
+	 * independently. so we can't guarantee:
+	 *     user->locked_vm <= user_lock_limit
+	 *
+	 * Adjust user_locked to be <= user_lock_limit so we can calcualte
+	 * correct extra and user_extra.
+	 */
+	user_locked = min_t(unsigned long, user_locked, user_lock_limit);
+
+	user_locked += user_extra;
 	if (user_locked > user_lock_limit) {
 		/*
 		 * charge locked_vm until it hits user_lock_limit;
-- 
2.17.1

