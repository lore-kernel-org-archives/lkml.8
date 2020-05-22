Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB75A2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159340;
	bh=SSr626oosF3ax4S4mvuIs1Z3CkLSI8JeRhlwsAREDNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XrpFPlxxuXkqUBvJAV9dO1/E04vXU+IAZ0RGCzcfD+zLONwnGFXWQsXWz8M+o3V8m
	 aBacSqrwDGZeQxW5gxTJKyvIcMY0K+Z/3wkplQUtqtsPgkH8p30LhTgmqM3S7HsdXC
	 UvY64TqlO9JQCPTB16/Pmfb48f25hcQShH2nIMlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgEVOzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730920AbgEVOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAD822409;
        Fri, 22 May 2020 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159070;
        bh=SSr626oosF3ax4S4mvuIs1Z3CkLSI8JeRhlwsAREDNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i36VKZs1I0LzYvUsbP+0WmHJ22S5WQj2eNfL15TfANFuWlQE3OE6Nn3VELX3GDJ9P
         /wnwSWBNPtTAKYzCzZhHYAqdLdgh5B9NwLr2F6fEy72dNMaSfAGmCNvy+FUHzthYpa
         iYy+HRL7ASUiBYiPcFi/HliZqsDeXh/SgHJNBfrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 23/32] riscv: stacktrace: Fix undefined reference to `walk_stackframe'
Date:   Fri, 22 May 2020 10:50:35 -0400
Message-Id: <20200522145044.434677-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 0502bee37cdef755d63eee60236562e5605e2480 ]

Drop static declaration to fix following build error if FRAME_POINTER disabled,
  riscv64-linux-ld: arch/riscv/kernel/perf_callchain.o: in function `.L0':
  perf_callchain.c:(.text+0x2b8): undefined reference to `walk_stackframe'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 0940681d2f68..19e46f4160cc 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -63,7 +63,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 #else /* !CONFIG_FRAME_POINTER */
 
-static void notrace walk_stackframe(struct task_struct *task,
+void notrace walk_stackframe(struct task_struct *task,
 	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
 {
 	unsigned long sp, pc;
-- 
2.25.1

