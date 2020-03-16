Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2361AC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB19E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mM4lwSG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgCPWfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:35:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732836AbgCPWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:35:20 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GMUen6021564
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=8v1OnHmR5wX5fICDYV1U9HUzSwtkFptrUKwgJuVU9co=;
 b=mM4lwSG146ZpE7yCU7c2bx8k3Nx2oj8WSsZFuqDD3zireAZV990AovTSEZgmf6Jz2GOK
 E7teFoCvRH3egG89aHA59BlZ7wLPF1srfyiCDaGBr+UWQaNlMV40hys3yGhHYA54+uoF
 eydnEwwc9a2KJS6nkQhNVRpaJuvq1/8OAg8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yrvsnsuvq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:35:19 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 16 Mar 2020 15:35:17 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 494903BA0D448; Mon, 16 Mar 2020 15:35:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: memcg: make memory.oom.group tolerable to task migration
Date:   Mon, 16 Mar 2020 15:35:10 -0700
Message-ID: <20200316223510.3176148-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-16_10:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160092
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task is getting moved out of the OOMing cgroup, it might
result in unexpected OOM killings if memory.oom.group is used
anywhere in the cgroup tree.

Imagine the following example:

          A (oom.group = 1)
         / \
  (OOM) B   C

Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
selects a task in B as a victim, but someone asynchronously moves
the task into C. mem_cgroup_get_oom_group() will iterate over all
ancestors of C up to the root cgroup. In theory it had to stop
at the oom_domain level - the memory cgroup which is OOMing.
But because B is not an ancestor of C, it's not happening.
Instead it chooses A (because it's oom.group is set), and kills
all tasks in A. This behavior is wrong because the OOM happened in B,
so there is no reason to kill anything outside.

Fix this by checking it the memory cgroup to which the task belongs
is a descendant of the oom_domain. If not, memory.oom.group should
be ignored, and the OOM killer should kill only the victim task.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Dan Schatzberg <dschatzberg@fb.com>
---
 mm/memcontrol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index daa399be4688..d8c4b7aa4e73 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1930,6 +1930,14 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 	if (memcg == root_mem_cgroup)
 		goto out;
 
+	/*
+	 * If the victim task has been asynchronously moved to a different
+	 * memory cgroup, we might end up killing tasks outside oom_domain.
+	 * In this case it's better to ignore memory.group.oom.
+	 */
+	if (unlikely(!mem_cgroup_is_descendant(memcg, oom_domain)))
+		goto out;
+
 	/*
 	 * Traverse the memory cgroup hierarchy from the victim task's
 	 * cgroup up to the OOMing cgroup (or root) to find the
-- 
2.24.1

