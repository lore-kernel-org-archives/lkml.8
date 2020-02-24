Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B6C3567A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA68E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXFDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:03:40 -0500
Received: from foss.arm.com ([217.140.110.172]:57648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXFDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A531E31B;
        Sun, 23 Feb 2020 21:03:38 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC92D3F534;
        Sun, 23 Feb 2020 21:03:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V2 1/4] mm/vma: Add missing VMA flag readable name for VM_SYNC
Date:   Mon, 24 Feb 2020 10:33:10 +0530
Message-Id: <1582520593-30704-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds the missing readable name for VM_SYNC.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/trace/events/mmflags.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d43777e..5fb752034386 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -154,6 +154,7 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
 	{VM_ACCOUNT,			"account"	},		\
 	{VM_NORESERVE,			"noreserve"	},		\
 	{VM_HUGETLB,			"hugetlb"	},		\
+	{VM_SYNC,			"sync"		},		\
 	__VM_ARCH_SPECIFIC_1				,		\
 	{VM_WIPEONFORK,			"wipeonfork"	},		\
 	{VM_DONTDUMP,			"dontdump"	},		\
-- 
2.20.1

