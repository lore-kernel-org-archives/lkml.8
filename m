Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C560C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B891206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973428;
	bh=UHGPWOeMMPesFHOhN85ifiETrCaVltIOD1OiXejC61g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVWUVKplWf8zhGyghEmKdCyj+2C/XyLYHiehOQ5Ia148x4vMwmHAaEMNonbdiMzaA
	 sFdwbBVLi640YV/pJV5jptBQd1uOE07b6VUN8k9+Y0nVWQrutiBi2tbrN2pwpvI4it
	 MVIASfTIqxKyuKRLg3IDsWKCWImoIvVm7xHiXTt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgIAPRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgIAPQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:16:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD34206EB;
        Tue,  1 Sep 2020 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973363;
        bh=UHGPWOeMMPesFHOhN85ifiETrCaVltIOD1OiXejC61g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtLFq/IY2spXym9V6kHt4K5P9f/sxtOMy98+iPETRTQrT4BnEY69aCFWTjNC6kn7D
         8BjF6HHCeOu9L9SbxS9NC9nT6ccu1OaQSCkKKZVXtXsD+LPxAe5OxcldSdFSOReYl6
         bceG51G81Kp3Nw8geSqNt42eo6fL1MOUCYbZ9jtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 48/78] powerpc/perf: Fix soft lockups due to missed interrupt accounting
Date:   Tue,  1 Sep 2020 17:10:24 +0200
Message-Id: <20200901150927.147652157@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ba49ae6625f1b..a10b67df83bae 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2042,6 +2042,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
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



