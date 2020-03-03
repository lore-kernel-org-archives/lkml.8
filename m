Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562BAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DA224673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203747;
	bh=zC3Y1C8HwIOEPRo15lvjJ/967zThZkg6I7D9cZHzu88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WU9W17eqFQdTNzIGBYH/gbcvQv48b0dC/noM82AE+Oc0RihsyM1LNTVQl+RsU//kd
	 djWiKi8xCI7xf1X0RO8YjS0hCvyThkNnQQA4j3PC+VJNrbCnZABkYrUavzH7uSm995
	 IY2bdU41XT/YB4pccGeLpi8/OEfelY1ItxbR9C78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgCCCtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgCCCsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F0A24686;
        Tue,  3 Mar 2020 02:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203726;
        bh=zC3Y1C8HwIOEPRo15lvjJ/967zThZkg6I7D9cZHzu88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zbFgYjs4W2jaCD1YD5kY3SWfNWstEpJ4sGREf81VfHbr2IvSppemdeGjfGT5BNqr
         Sa7s31fdI6Qkfn6J3kkxpLlt3oJah+f8ESi/fsZD/8A7mG0dP4V76V9tyFvn5MbHLr
         de5BEBQm7JFAWr8t8aCGznZJO8yA8+rK6eDBfogQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 55/58] csky: Fixup ftrace modify panic
Date:   Mon,  2 Mar 2020 21:47:37 -0500
Message-Id: <20200303024740.9511-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 359ae00d12589c31cf103894d0f32588d523ca83 ]

During ftrace init, linux will replace all function prologues
(call_mcout) with nops, but it need flush_dcache and
invalidate_icache to make it work. So flush_cache functions
couldn't be nested called by ftrace framework.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/mm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
index c94ef64810986..efb7ebab342b3 100644
--- a/arch/csky/mm/Makefile
+++ b/arch/csky/mm/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ifeq ($(CONFIG_CPU_HAS_CACHEV2),y)
 obj-y +=			cachev2.o
+CFLAGS_REMOVE_cachev2.o = $(CC_FLAGS_FTRACE)
 else
 obj-y +=			cachev1.o
+CFLAGS_REMOVE_cachev1.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-y +=			dma-mapping.o
-- 
2.20.1

