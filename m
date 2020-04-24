Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2CC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E769C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDXN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:58:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXN6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:58:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD1D31B;
        Fri, 24 Apr 2020 06:58:13 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27AAD3F68F;
        Fri, 24 Apr 2020 06:58:12 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] firmware/psci: PSCI checker cleanup
Date:   Fri, 24 Apr 2020 14:56:55 +0100
Message-Id: <20200424135657.32519-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is a small cleanup of the PSCI checker following Peter's objections
to its homegrown do_idle() implementation. It is based on his
sched_setscheduler() unexport series at [1].

I've never really used the thing before, but it still seems to behave
correctly on my Juno r0 & HiKey960.

Cheers,
Valentin

[1]: https://lore.kernel.org/lkml/20200422112719.826676174@infradead.org/T/#t

Valentin Schneider (2):
  firmware/psci: Make PSCI checker not bother with parking
  firmware/psci: Make PSCI checker use play_idle()

 drivers/firmware/psci/psci_checker.c | 159 +++++++--------------------
 1 file changed, 42 insertions(+), 117 deletions(-)

--
2.24.0

