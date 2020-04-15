Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B432078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952975;
	bh=VKvRnzrhE79l30fPjNatQ8L377zR5ldGkynql46Qu7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8atnegla/A+XR3C5e36g0+SsoL6DiAJjIJtWFrzqpezDkzB2SZbYXazdnZhaoHwt
	 mer1taKZsSztjRRbP+uoCdnSXU/n1usx6uSwwWSbFDsfd2Ofzm4RDvqgdY1x9ZksPn
	 v+PSUnP0BYRMIMMuzx6JBgQEVpqPaR6LttNTwtKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409788AbgDOMQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409304AbgDOLqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20E320775;
        Wed, 15 Apr 2020 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951196;
        bh=VKvRnzrhE79l30fPjNatQ8L377zR5ldGkynql46Qu7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M74mM3Zt00epk2TO4C2eB8GH6mVHVW83IdSfMq+DiGDkp1Efpm9briAbgFGyT5dQz
         Z8ffT3jVMgRjYSrHuyFL16k8aS8lxv3zl2iVb9hokrz+TyuNLDVmu3hWRN8BoN9GUy
         3ceX7zGXnMCP2fpVxGzGOM7GI4icshUABSnf5uhQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/40] s390/cpum_sf: Fix wrong page count in error message
Date:   Wed, 15 Apr 2020 07:45:54 -0400
Message-Id: <20200415114623.14972-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114623.14972-1-sashal@kernel.org>
References: <20200415114623.14972-1-sashal@kernel.org>
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
 arch/s390/kernel/perf_cpum_sf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 5bfb1ce129f4b..74a296cea21cc 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1537,6 +1537,7 @@ static void hw_collect_aux(struct cpu_hw_sf *cpuhw)
 	perf_aux_output_end(handle, size);
 	num_sdb = aux->sfb.num_sdb;
 
+	num_sdb = aux->sfb.num_sdb;
 	while (!done) {
 		/* Get an output handle */
 		aux = perf_aux_output_begin(handle, cpuhw->event);
-- 
2.20.1

