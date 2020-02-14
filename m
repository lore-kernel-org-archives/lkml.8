Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0210CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25FC206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702144;
	bh=Srs9+yc0o/XT+FN6YHGUoe6mlRHFCPi0IL/RpXDaEOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0dlxs38tT6A2E1pVe+WurtwANIJpHsBVzc98GT83u459b5uPQnoI3fDN8U7M3Uh3s
	 t66XYyG0mfox4fa9GpnE528Gjf+x8FRDq45k0TVhxobsKaNuQk+djAi62DvCbR7Bfy
	 lsvOB0pDOKNgSuxN8VOHgsMQZOkSEDFbKYK+flv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390042AbgBNRmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:42:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389230AbgBNQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFB624681;
        Fri, 14 Feb 2020 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696207;
        bh=Srs9+yc0o/XT+FN6YHGUoe6mlRHFCPi0IL/RpXDaEOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xU9/UOrokDHrHez8jSgvnM1uXt8FsGLbsG7DYGoZiMbN4IO3SPjoKZvS5eS4Xbyan
         qVyEAqUBWhaw3P9/lKCsw4swmFDFP6in82FYowvmY6iG2gfaGuX1APncpzLsPOf/U5
         3SfeTLFIKJZsrrOGasD1OX3mXTNQ4AfOCI4LNgow=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 072/459] sched/uclamp: Fix a bug in propagating uclamp value in new cgroups
Date:   Fri, 14 Feb 2020 10:55:22 -0500
Message-Id: <20200214160149.11681-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
index 8dacda4b03627..00743684a549a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7090,6 +7090,12 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
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

