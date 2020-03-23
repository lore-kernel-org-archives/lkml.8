Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BECC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46E220735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgCWNvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:51:46 -0400
Received: from foss.arm.com ([217.140.110.172]:49608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgCWNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A00AFEC;
        Mon, 23 Mar 2020 06:51:41 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C86BE3F52E;
        Mon, 23 Mar 2020 06:51:39 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        sparclinux@vger.kernel.org
Subject: [PATCH v4 11/17] sparc: Replace cpu_up/down with add/remove_cpu
Date:   Mon, 23 Mar 2020 13:51:04 +0000
Message-Id: <20200323135110.30522-12-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index bbf59b3b4af8..75232cbd58bf 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -555,7 +555,7 @@ static int dr_cpu_configure(struct ds_info *dp, struct ds_cap_state *cp,
 
 		printk(KERN_INFO "ds-%llu: Starting cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_up(cpu);
+		err = add_cpu(cpu);
 		if (err) {
 			__u32 res = DR_CPU_RES_FAILURE;
 			__u32 stat = DR_CPU_STAT_UNCONFIGURED;
@@ -611,7 +611,7 @@ static int dr_cpu_unconfigure(struct ds_info *dp,
 
 		printk(KERN_INFO "ds-%llu: Shutting down cpu %d...\n",
 		       dp->id, cpu);
-		err = cpu_down(cpu);
+		err = remove_cpu(cpu);
 		if (err)
 			dr_cpu_mark(resp, cpu, ncpus,
 				    DR_CPU_RES_FAILURE,
-- 
2.17.1

