Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D017C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F8020658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f419reAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBXDAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:00:31 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35933 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXDAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:00:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id ff2so3571945qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 19:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axj+zYhKgui/GRpLokmGt4hkOovhk9D4qksINrRJ1Ak=;
        b=f419reAEsjTeJdGXZaoZyZpTiWQNTrZvDjlFHYNYo6hws9F1baASusMDFHpIAblfCn
         MDrLtDYdBa37g4PRqNh/MPFrxz5Z85DqSVa6Dzdzins0kWeNGM++kzZ0/peBTuhv9UYm
         aqGxFrqA+fqrkOxvGd/d+j1ZSxUtdy6ueQ5HDJ85/8FME2IJ4a9dzvWa2g8Srhpt9dSf
         561JzE6H7EI7d1vJtVqCtT6ZWFOhOjkAtZhzDP0P1Qvn7+S9o3evgs8TcB+UVGHp4XcP
         ATkJnrGXsGL3fYd3Qd07QCnJZ7a7tiJwhOXEUedVP4rxKZTn6s6ROrRoHLSPBHZS/RnR
         e2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axj+zYhKgui/GRpLokmGt4hkOovhk9D4qksINrRJ1Ak=;
        b=sW7gYDuvol5HR6OUXfM59aiIh6GfK1YazJxCoeEx+AI0qtS4K6npDiWX4eZ1deKM5/
         zZajcxdMJHJTG8wyJfof6nfz98my98/9scQIzGOEIkl4FC5dxHzjbY49FRPE/hOoHpo9
         Mca+twtY4Ix/oHywzK7HrTx0jVdtzF8t9JzuA0qGHEZL29DUNrrT5oeRMJO6yv3jN8ZD
         XtBqzA3R6JEB/OMFpcBEjnw/EOty4XQJnwljA+VuqEssrZYezrrwvdmIyyta6TrSz/Gz
         0P1W8EVpHZ6Rk2IUlXY7PbBUNKMBCjCxiw6YIoFkNhjCqo0cdeNAscL72eahrOuhiTh9
         Twfg==
X-Gm-Message-State: APjAAAUMgmOHeCeVGBajAEwzHyanGRrADClBMJvYwsq9tMTInNb8Rtew
        qfknVLN+MPU97ygdeRBMJYMaAA==
X-Google-Smtp-Source: APXvYqwNK5+khXEgg8ag3M7aq6QkrRCoOOzbAMD7wOmLl4yiFPdzv+V2JCKxPRHFxjSSKNReQogbeQ==
X-Received: by 2002:a05:6214:176e:: with SMTP id et14mr40790796qvb.133.1582513230182;
        Sun, 23 Feb 2020 19:00:30 -0800 (PST)
Received: from ovpn-120-117.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t2sm5219859qkc.62.2020.02.23.19.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 19:00:29 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] cgroup: fix psi_show() crash on 32bit ino archs
Date:   Sun, 23 Feb 2020 22:00:07 -0500
Message-Id: <20200224030007.3990-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the commit d7495343228f ("cgroup: fix incorrect
WARN_ON_ONCE() in cgroup_setup_root()"), cgroup_id(root_cgrp) does not
equal to 1 on 32bit ino archs which triggers all sorts of issues with
psi_show() on s390x. For example,

 BUG: KASAN: slab-out-of-bounds in collect_percpu_times+0x2d0/
 Read of size 4 at addr 000000001e0ce000 by task read_all/3667
 collect_percpu_times+0x2d0/0x798
 psi_show+0x7c/0x2a8
 seq_read+0x2ac/0x830
 vfs_read+0x92/0x150
 ksys_read+0xe2/0x188
 system_call+0xd8/0x2b4

Fix it by using cgroup_ino().

Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/cgroup/cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 75f687301bbf..cd5f41289f7d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3542,21 +3542,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_IO);
 }
 static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_MEM);
 }
 static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	struct psi_group *psi = cgroup_id(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
 
 	return psi_show(seq, psi, PSI_CPU);
 }
-- 
2.21.0 (Apple Git-122.2)

