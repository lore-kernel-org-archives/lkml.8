Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D636C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F4320737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956136;
	bh=yq30A9vqJkbH6ukTYjE1PX100A2RCzQdapYKRI6/qVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djtpnWNLl1DS7XXM7PmuNVyrZdCEsCZv7q7DX5IImU0YFEkKg9ewn8pnRVDrZVW9L
	 JmzjK0CGagpjzOJ+nhemMP0TBuZYpKsn41APtfrymmIcDNRcnOfCvCU106xZT0IhyP
	 czhEEnrB13lZh4qZZy6ToRlEgyk6fvJA2sc09RuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504233AbgDONIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408892AbgDOLft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884B020768;
        Wed, 15 Apr 2020 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950549;
        bh=yq30A9vqJkbH6ukTYjE1PX100A2RCzQdapYKRI6/qVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuAZWB4WjTaDmUTCf2EDOSOa1P8tilBW3L00QEJWVJplVexTP3gTHSdtC+HUMqF0y
         9NwZ/+RmrVj7JI+Q6/a7LUgcbmHUXHy2aPzmYjzpcxgC5RpqXkLuCyCBpbQg8vhQ61
         WdDeXQs+m4Fu0kUKZVjRmXW6SaAJ06wA5ifZ5bPU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 055/129] s390/cpum_sf: Fix wrong page count in error message
Date:   Wed, 15 Apr 2020 07:33:30 -0400
Message-Id: <20200415113445.11881-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 4141b6a5e9f171325effc36a22eb92bf961e7a5c ]

When perf record -e SF_CYCLES_BASIC_DIAG runs with very high
frequency, the samples arrive faster than the perf process can
save them to file. Eventually, for longer running processes, this
leads to the siutation where the trace buffers allocated by perf
slowly fills up. At one point the auxiliary trace buffer is full
and  the CPU Measurement sampling facility is turned off. Furthermore
a warning is printed to the kernel log buffer:

cpum_sf: The AUX buffer with 0 pages for the diagnostic-sampling
	mode is full

The number of allocated pages for the auxiliary trace buffer is shown
as zero pages. That is wrong.

Fix this by saving the number of allocated pages before entering the
work loop in the interrupt handler. When the interrupt handler processes
the samples, it may detect the buffer full condition and stop sampling,
reducing the buffer size to zero.
Print the correct value in the error message:

cpum_sf: The AUX buffer with 256 pages for the diagnostic-sampling
	mode is full

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index b095b1c78987d..05b908b3a6b38 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1576,6 +1576,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	unsigned long range = 0, size;
 	unsigned long long overflow = 0;
 	struct perf_output_handle *handle = &cpuhw->handle;
+	unsigned long num_sdb;
 
 	aux = perf_get_aux(handle);
 	if (WARN_ON_ONCE(!aux))
@@ -1587,13 +1588,14 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 			    size >> PAGE_SHIFT);
 	perf_aux_output_end(handle, size);
 
+	num_sdb = aux->sfb.num_sdb;
 	while (!done) {
 		/* Get an output handle */
 		aux = perf_aux_output_begin(handle, cpuhw->event);
 		if (handle->size == 0) {
 			pr_err("The AUX buffer with %lu pages for the "
 			       "diagnostic-sampling mode is full\n",
-				aux->sfb.num_sdb);
+				num_sdb);
 			debug_sprintf_event(sfdbg, 1,
 					    "%s: AUX buffer used up\n",
 					    __func__);
-- 
2.20.1

