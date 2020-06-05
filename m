Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964B2207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591359942;
	bh=KBOFYH+yltsllB5kxgRuQLTpngYArcwUB4vOgu0wmTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNtaCBnWKDrZ0HUpQT6Uzbqb+zpxukcShulxWvxCz6ZO1RT3PZtl08MNnqO02Y4Pj
	 ivyTlSqL+chT0TzHaJJ9vcOxAAQ3UpJNRvBs1WPjcansfQIK0uzsfF3EkHpAbZwFCR
	 52vKeCDdjKI7W0h9Ft4gvTJuO+B8xlQz6+8bZd78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFEMZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgFEMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00513207F9;
        Fri,  5 Jun 2020 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359931;
        bh=KBOFYH+yltsllB5kxgRuQLTpngYArcwUB4vOgu0wmTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/TvWrfQXggN+n/l47/+usHPqC0X+3ROFUhn/QmsmBHg1B7tVRn8k6cA3v+cWfGM1
         kjQ77GQWtF8Qh92tnjp5ZYsmOsDkZtcVU4RtNMCICl+/aM8rCTRnRxSj/s5fDJPDOf
         elLYLmqvzidjM+qpNpp6W7ytJiCQ3Z53pQ0nx8Ag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 11/17] csky: Fixup abiv2 syscall_trace break a4 & a5
Date:   Fri,  5 Jun 2020 08:25:10 -0400
Message-Id: <20200605122517.2882338-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122517.2882338-1-sashal@kernel.org>
References: <20200605122517.2882338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit e0bbb53843b5fdfe464b099217e3b9d97e8a75d7 ]

Current implementation could destory a4 & a5 when strace, so we need to get them
from pt_regs by SAVE_ALL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/abiv2/inc/abi/entry.h | 2 ++
 arch/csky/kernel/entry.S        | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 9023828ede97..ac8f65a3e75a 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -13,6 +13,8 @@
 #define LSAVE_A1	28
 #define LSAVE_A2	32
 #define LSAVE_A3	36
+#define LSAVE_A4	40
+#define LSAVE_A5	44
 
 #define KSPTOUSP
 #define USPTOKSP
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 9718388448a4..ff908d28f0a0 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -170,8 +170,10 @@ csky_syscall_trace:
 	ldw	a3, (sp, LSAVE_A3)
 #if defined(__CSKYABIV2__)
 	subi	sp, 8
-	stw	r5, (sp, 0x4)
-	stw	r4, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A4)
+	stw	r9, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A5)
+	stw	r9, (sp, 0x4)
 #else
 	ldw	r6, (sp, LSAVE_A4)
 	ldw	r7, (sp, LSAVE_A5)
-- 
2.25.1

