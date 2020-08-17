Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63914204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690261;
	bh=zJJf9ufwWpUpsbzGQo2GcLdzmv5cztp9mfuTvLC4nV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEhqya8/LKD8ZwojsmRvxWthCMeWv8AdtKutloqCP8t+ecTVw7PvjAjHKXPwzdZa6
	 xKMOzCCYobkZZONN4b+KlVPwqTkad3RTbGRGn0DyLtr6qrupzVooKe3ehDjr6jxGff
	 ouaHIJmShXoLoADJHZ0B7kDA7CD0e3GZJEDIyPQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbgHQSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387907AbgHQPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDDF208B3;
        Mon, 17 Aug 2020 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679592;
        bh=zJJf9ufwWpUpsbzGQo2GcLdzmv5cztp9mfuTvLC4nV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl6//lGa5LZ/aybJALS286n4aOCcQ5v5byDq3Va/hr4u1EWFD7CLFQDrJ/nVJK97j
         nuLIHIv83JmT+vvZDB80dPNnhRbb2cQqFtD2SKCh+M+Qnd/P9+2mOcFg0LZo8ts7gy
         XpRMteV+/KUYp/IwggwsGxiE55mNwpbWgUX9vY20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shirisha Ganta <shiganta@in.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Harish <harish@linux.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 268/393] selftests/powerpc: Fix CPU affinity for child process
Date:   Mon, 17 Aug 2020 17:15:18 +0200
Message-Id: <20200817143832.617353076@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harish <harish@linux.ibm.com>

[ Upstream commit 854eb5022be04f81e318765f089f41a57c8e5d83 ]

On systems with large number of cpus, test fails trying to set
affinity by calling sched_setaffinity() with smaller size for affinity
mask. This patch fixes it by making sure that the size of allocated
affinity mask is dependent on the number of CPUs as reported by
get_nprocs().

Fixes: 00b7ec5c9cf3 ("selftests/powerpc: Import Anton's context_switch2 benchmark")
Reported-by: Shirisha Ganta <shiganta@in.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Harish <harish@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reviewed-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200609081423.529664-1-harish@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../powerpc/benchmarks/context_switch.c       | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index a2e8c9da7fa53..d50cc05df4952 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -19,6 +19,7 @@
 #include <limits.h>
 #include <sys/time.h>
 #include <sys/syscall.h>
+#include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <sys/shm.h>
 #include <linux/futex.h>
@@ -104,8 +105,9 @@ static void start_thread_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 
 static void start_process_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 {
-	int pid;
-	cpu_set_t cpuset;
+	int pid, ncpus;
+	cpu_set_t *cpuset;
+	size_t size;
 
 	pid = fork();
 	if (pid == -1) {
@@ -116,14 +118,23 @@ static void start_process_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 	if (pid)
 		return;
 
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpu, &cpuset);
+	ncpus = get_nprocs();
+	size = CPU_ALLOC_SIZE(ncpus);
+	cpuset = CPU_ALLOC(ncpus);
+	if (!cpuset) {
+		perror("malloc");
+		exit(1);
+	}
+	CPU_ZERO_S(size, cpuset);
+	CPU_SET_S(cpu, size, cpuset);
 
-	if (sched_setaffinity(0, sizeof(cpuset), &cpuset)) {
+	if (sched_setaffinity(0, size, cpuset)) {
 		perror("sched_setaffinity");
+		CPU_FREE(cpuset);
 		exit(1);
 	}
 
+	CPU_FREE(cpuset);
 	fn(arg);
 
 	exit(0);
-- 
2.25.1



