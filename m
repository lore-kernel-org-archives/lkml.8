Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A68FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D6C2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607865;
	bh=qtD4kttmnNspxcI9KmmiufATSWlPGV+r4mNd/jnyryw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCf1ZWVwTkkziJRlqtaE5sF1kTfbH3K5x/LkcSgv0YKgUvpnRzP2Y50NxkeHxmjD4
	 2qJ0viM2fGDA6GVnAA0M4TBIonnpNocxotHMoatBQ0JfrASLs8Vl8PqdsKBm6vN24L
	 loeYtAh5LUCdowF9uHpFgaQGFiC4A9L9iAYw0ATc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgBMPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbgBMP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:43 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64014222C2;
        Thu, 13 Feb 2020 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607662;
        bh=qtD4kttmnNspxcI9KmmiufATSWlPGV+r4mNd/jnyryw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYXf8AMP0v49S4lFWNaVjz7UJzcnwgmngwtglpSUwVXl/dscV2UL/VJxE2wxw365R
         Slih14ANWQI3fn7Uo/DQSRHQtm/kgs7zwqwjTfAupZPXMSRWH9XjS5Zbtldk7dbM3o
         c+Gy2QuIqZEpGcrOjH909kAzlsttdkLQCczFmlt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Smythies <dsmythies@telus.net>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.4 64/96] sched/uclamp: Fix a bug in propagating uclamp value in new cgroups
Date:   Thu, 13 Feb 2020 07:21:11 -0800
Message-Id: <20200213151903.707374301@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

commit 7226017ad37a888915628e59a84a2d1e57b40707 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7090,6 +7090,12 @@ static int cpu_cgroup_css_online(struct
 
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
 


