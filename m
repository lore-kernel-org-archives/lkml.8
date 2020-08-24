Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3759FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144472067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289633;
	bh=lvzQ/hEjHwDs3sJOe3by2TZKTk4WdMBQkeuthCXtYW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tv5J5dJJwHSl+hjxDKiD2jbgA0fO5QLycNGy2ngRtPYRbFP1wcmvbWf2GmVfgT3SR
	 UXnAZ0qsp0jIuckYe8EeKIzjv8/QiqT04mNT2bgaw4JgBUmM1TGJUiBlIAdviPVnh1
	 ze1Zrlwzj4TTEDdiepKh5z5sPHxu/Cf5ngX6v4m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgHXRUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbgHXQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3FB22CB1;
        Mon, 24 Aug 2020 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286985;
        bh=lvzQ/hEjHwDs3sJOe3by2TZKTk4WdMBQkeuthCXtYW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+lzP+/vOpD3A7L4N0Okxsi5rboeouNP3Xlbb+HcBfNOLDbA3ZkKP91w0cPUbzpJK
         5Bd2bOvPfY+9cen1Hwd9FU67IpsyluM506Q0U5mpuKxvgzVnIIasthro5z2IqTUFLa
         fIsuEWfxO2/KJGFk3ygakMsy1zz8a/kb2Wf38wk4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.8 59/63] powerpc/perf: Fix soft lockups due to missed interrupt accounting
Date:   Mon, 24 Aug 2020 12:34:59 -0400
Message-Id: <20200824163504.605538-59-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

[ Upstream commit 17899eaf88d689529b866371344c8f269ba79b5f ]

Performance monitor interrupt handler checks if any counter has
overflown and calls record_and_restart() in core-book3s which invokes
perf_event_overflow() to record the sample information. Apart from
creating sample, perf_event_overflow() also does the interrupt and
period checks via perf_event_account_interrupt().

Currently we record information only if the SIAR (Sampled Instruction
Address Register) valid bit is set (using siar_valid() check) and
hence the interrupt check.

But it is possible that we do sampling for some events that are not
generating valid SIAR, and hence there is no chance to disable the
event if interrupts are more than max_samples_per_tick. This leads to
soft lockup.

Fix this by adding perf_event_account_interrupt() in the invalid SIAR
code path for a sampling event. ie if SIAR is invalid, just do
interrupt check and don't record the sample information.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1596717992-7321-1-git-send-email-atrajeev@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/core-book3s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 01d70280d2872..190bc4f255b42 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2101,6 +2101,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
+	} else if (period) {
+		/* Account for interrupt in case of invalid SIAR */
+		if (perf_event_account_interrupt(event))
+			power_pmu_stop(event, 0);
 	}
 }
 
-- 
2.25.1

