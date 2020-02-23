Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42804C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E0C20659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425423;
	bh=DlmwdQDlQ9+dL/5tK1OOSNXQg1vVFb3H4mk64k4cgLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FRz1T7GEd4xdDMeVVm3AIP4NM9UdN7hY9+q+bsJGCKpPB65/PtftagiimXDfyNq8b
	 54y3hcQcbZVz2IWW6R4YeDIa10G9zE94GXUD5F7TwG8THaaI3X97hdec3f2L0RnbZ9
	 KppwWcDQaySXcyDyxszvmEkBaKQA2eMKgI4wvX4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBWCVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbgBWCVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23E3214DB;
        Sun, 23 Feb 2020 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424499;
        bh=DlmwdQDlQ9+dL/5tK1OOSNXQg1vVFb3H4mk64k4cgLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/wiWVxhT2D5Kpk8Pxkc8zwYBZaZsKY9DMopvXnX6xKznxw9/g85+6Cx9L0iChyge
         +lcsqQz0aJlMCABR4yJCQNF8XGeNc2Vj/K5Umj2zGCyWxuyL/3En45dzbwZOQM7vqD
         agb6TOXBzGKuv6TFei//1+/txFRQE8GKGNHs75V8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 16/58] sched/psi: Fix OOB write when writing 0 bytes to PSI files
Date:   Sat, 22 Feb 2020 21:20:37 -0500
Message-Id: <20200223022119.707-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

[ Upstream commit 6fcca0fa48118e6d63733eb4644c6cd880c15b8f ]

Issuing write() with count parameter set to 0 on any file under
/proc/pressure/ will cause an OOB write because of the access to
buf[buf_size-1] when NUL-termination is performed. Fix this by checking
for buf_size to be non-zero.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20200203212216.7076-1-surenb@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ce8f6748678a2..9154e745f0978 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1199,6 +1199,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+	if (!nbytes)
+		return -EINVAL;
+
 	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
-- 
2.20.1

