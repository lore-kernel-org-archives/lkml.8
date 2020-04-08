Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9177BC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BF12084D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHXxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:53:43 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40794 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgDHXxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:53:42 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 038NqZ8o002758
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 8 Apr 2020 16:52:45 -0700
Received: from sc2600cp.corp.ad.wrs.com (128.224.56.62) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 16:52:24 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] perf/x86/intel/pt: drop pointless NULL assignment.
Date:   Wed, 8 Apr 2020 19:52:16 -0400
Message-ID: <20200408235216.108980-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a few lines below this removed line is this:

  attrs = kzalloc(size, GFP_KERNEL);

and since there is no code path where this could be avoided, the
NULL assignment is a pointless relic of history and can be removed.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1db7a51d9792..e94af4a54d0d 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -226,8 +226,6 @@ static int __init pt_pmu_hw_init(void)
 			pt_pmu.vmx = true;
 	}
 
-	attrs = NULL;
-
 	for (i = 0; i < PT_CPUID_LEAVES; i++) {
 		cpuid_count(20, i,
 			    &pt_pmu.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM],
-- 
2.17.1

