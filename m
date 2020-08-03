Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9274C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969A32054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458307;
	bh=p6TsHCvvkp3SLABaDg9z5pQt9RWPKGLg3o7T1fgNJ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b7prsmCc1a4U7eyS0acI6UqOFKmUfTmUdXxBNOHuk4kxdMTY+osBHKjpBtVbb+uSs
	 zP68bc3axA8q3n94HmD6+vrmFLgdmZhy/hlt4Vt0mNNMXKm+tGuIpDZZjyB0twQ5IT
	 btSb+APYovpXdwjiYBaGOQpu5icpTR66P+eaH/XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHCMiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbgHCMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:34:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6CB20781;
        Mon,  3 Aug 2020 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458072;
        bh=p6TsHCvvkp3SLABaDg9z5pQt9RWPKGLg3o7T1fgNJ4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTDgMw5AaA/t2WMn5YsYjUAO1h0JU6QQ7BQitCScyGUMyclHxm5wwuQaT4X2/eCum
         A6/Tq2r20c6Bb1m0GMH1x3kpiOKn+4ciXKjLbVRWEBszoZOA8GuV/ikPBpEDYA7iIv
         MorbAwg84rQe45rwkhzvNE8RuV8F4+BHj0KnkV2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/51] sh: Fix validation of system call number
Date:   Mon,  3 Aug 2020 14:20:14 +0200
Message-Id: <20200803121850.949874057@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

[ Upstream commit 04a8a3d0a73f51c7c2da84f494db7ec1df230e69 ]

The slow path for traced system call entries accessed a wrong memory
location to get the number of the maximum allowed system call number.
Renumber the numbered "local" label for the correct location to avoid
collisions with actual local labels.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Fixes: f3a8308864f920d2 ("sh: Add a few missing irqflags tracing markers.")
Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/kernel/entry-common.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 28cc61216b649..ed5b758c650d7 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -203,7 +203,7 @@ syscall_trace_entry:
 	mov.l	@(OFF_R7,r15), r7   ! arg3
 	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
 	!
-	mov.l	2f, r10			! Number of syscalls
+	mov.l	6f, r10			! Number of syscalls
 	cmp/hs	r10, r3
 	bf	syscall_call
 	mov	#-ENOSYS, r0
@@ -357,7 +357,7 @@ ENTRY(system_call)
 	tst	r9, r8
 	bf	syscall_trace_entry
 	!
-	mov.l	2f, r8			! Number of syscalls
+	mov.l	6f, r8			! Number of syscalls
 	cmp/hs	r8, r3
 	bt	syscall_badsys
 	!
@@ -396,7 +396,7 @@ syscall_exit:
 #if !defined(CONFIG_CPU_SH2)
 1:	.long	TRA
 #endif
-2:	.long	NR_syscalls
+6:	.long	NR_syscalls
 3:	.long	sys_call_table
 7:	.long	do_syscall_trace_enter
 8:	.long	do_syscall_trace_leave
-- 
2.25.1



