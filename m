Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492B0208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgGaTVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:21:00 -0400
Received: from foss.arm.com ([217.140.110.172]:36352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgGaTU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:20:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC3D106F;
        Fri, 31 Jul 2020 12:20:55 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CD4A3F71F;
        Fri, 31 Jul 2020 12:20:54 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] sched/doc: Factorize bits between sched-energy.rst & sched-capacity.rst
Date:   Fri, 31 Jul 2020 20:20:16 +0100
Message-Id: <20200731192016.7484-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731192016.7484-1-valentin.schneider@arm.com>
References: <20200731192016.7484-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/scheduler/sched-capacity.rst ought to be the canonical place
to blabber about SD_ASYM_CPUCAPACITY, so remove its explanation from
sched-energy.rst and point to sched-capacity.rst instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 Documentation/scheduler/sched-energy.rst | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 9580c57a52bc..78f850778982 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -331,16 +331,8 @@ asymmetric CPU topologies for now. This requirement is checked at run-time by
 looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
 domains are built.
 
-The flag is set/cleared automatically by the scheduler topology code whenever
-there are CPUs with different capacities in a root domain. The capacities of
-CPUs are provided by arch-specific code through the arch_scale_cpu_capacity()
-callback. As an example, arm and arm64 share an implementation of this callback
-which uses a combination of CPUFreq data and device-tree bindings to compute the
-capacity of CPUs (see drivers/base/arch_topology.c for more details).
-
-So, in order to use EAS on your platform your architecture must implement the
-arch_scale_cpu_capacity() callback, and some of the CPUs must have a lower
-capacity than others.
+See Documentation/sched/sched-capacity.rst for requirements to be met for this
+flag to be set in the sched_domain hierarchy.
 
 Please note that EAS is not fundamentally incompatible with SMP, but no
 significant savings on SMP platforms have been observed yet. This restriction
-- 
2.27.0

