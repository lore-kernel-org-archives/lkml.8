Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB97C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4C6222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704338;
	bh=ODd1vPugOlD5oReDAIvjqTxvvQx2a1fZwhHGLByqMEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=htYvtxjrle/9iJXypc0ur7d9gwNSlhoAVtTo0zVe7BHgMVGgfH1NFrA1yVu0rufIO
	 qe2J2ovhoDFdwWJQYWelNfH3iHzL7o/H2NI3IBvk25wK2mHAwxipzptn/hQydTfiqu
	 jqCHrJF74tdvpFAG7QnMH6oKdzJOBLZmxO/7jM3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394700AbgBNSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbgBNPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:50:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D3F2469D;
        Fri, 14 Feb 2020 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695441;
        bh=ODd1vPugOlD5oReDAIvjqTxvvQx2a1fZwhHGLByqMEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMxCEtppoG2sB168IB71qJPYBtuR6A9ZQSztxyzVTIaBif2NSW9eQJ4LqdIzg3v4r
         ayjDYOl2W04UHyUg8LbjFpA2qaSswZ+Sr7o9AZpyAXUKKWr6kdjdEZnYaLGsaLjpVx
         X3a7+BuqPfoPWII3FAa3+VOZD2zl2i/38SCJ09Zg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 082/542] sched/uclamp: Fix a bug in propagating uclamp value in new cgroups
Date:   Fri, 14 Feb 2020 10:41:14 -0500
Message-Id: <20200214154854.6746-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

[ Upstream commit 7226017ad37a888915628e59a84a2d1e57b40707 ]

When a new cgroup is created, the effective uclamp value wasn't updated
with a call to cpu_util_update_eff() that looks at the hierarchy and
update to the most restrictive values.

Fix it by ensuring to call cpu_util_update_eff() when a new cgroup
becomes online.

Without this change, the newly created cgroup uses the default
root_task_group uclamp values, which is 1024 for both uclamp_{min, max},
which will cause the rq to to be clamped to max, hence cause the
system to run at max frequency.

The problem was observed on Ubuntu server and was reproduced on Debian
and Buildroot rootfs.

By default, Ubuntu and Debian create a cpu controller cgroup hierarchy
and add all tasks to it - which creates enough noise to keep the rq
uclamp value at max most of the time. Imitating this behavior makes the
problem visible in Buildroot too which otherwise looks fine since it's a
minimal userspace.

Fixes: 0b60ba2dd342 ("sched/uclamp: Propagate parent clamps")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Doug Smythies <dsmythies@telus.net>
Link: https://lore.kernel.org/lkml/000701d5b965$361b6c60$a2524520$@net/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace892..bfe756dee129e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7100,6 +7100,12 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	if (parent)
 		sched_online_group(tg, parent);
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Propagate the effective uclamp value for the new group */
+	cpu_util_update_eff(css);
+#endif
+
 	return 0;
 }
 
-- 
2.20.1

