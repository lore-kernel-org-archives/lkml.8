Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC694C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964302072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921487;
	bh=u7g0uVlz6Q7//GkAk0fCcfv0xaeMWeEVktjLJbLLEGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sVhsIFpP35mg8kNfKhkaulxquFpMzMVpi1B/SpoHsq6pzsbod+DGheUH6hYxsgtxj
	 sobdM702gGajDbNXU7ZQv0DzU3vdsjQUZCi8DZRFkDyxZFRDlWv+MeHAUoDPA8WwOx
	 yWAayVec0V5cmmOuzXv6y3HUAYone09qhvDIHNgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHTLEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgHTKNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:13:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F26206DA;
        Thu, 20 Aug 2020 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918379;
        bh=u7g0uVlz6Q7//GkAk0fCcfv0xaeMWeEVktjLJbLLEGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0BXTvKdAf6Oghk8k7uNexQ5kTwoC6E/nre5FY8WbBDXHSt/jIX99vhBSdP5Rcyxm
         3Hz1S9OCE/+v20pyynl4oGaTu7nNdJVeHpz3iuf1BDxmRN92/f93EZ3Rkt3v/1MU4C
         rD3Rv6oYQJMuwTltLuUHdJFEZq8REl43GA98gY3Q=
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
Subject: [PATCH 4.14 121/228] selftests/powerpc: Fix CPU affinity for child process
Date:   Thu, 20 Aug 2020 11:21:36 +0200
Message-Id: <20200820091613.638646348@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index f4241339edd2a..7136eae2170b7 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -22,6 +22,7 @@
 #include <limits.h>
 #include <sys/time.h>
 #include <sys/syscall.h>
+#include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <sys/shm.h>
 #include <linux/futex.h>
@@ -97,8 +98,9 @@ static void start_thread_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 
 static void start_process_on(void *(*fn)(void *), void *arg, unsigned long cpu)
 {
-	int pid;
-	cpu_set_t cpuset;
+	int pid, ncpus;
+	cpu_set_t *cpuset;
+	size_t size;
 
 	pid = fork();
 	if (pid == -1) {
@@ -109,14 +111,23 @@ static void start_process_on(void *(*fn)(void *), void *arg, unsigned long cpu)
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



