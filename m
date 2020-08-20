Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A92C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5532322BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929263;
	bh=n3so6R77g/5ICdm/NwPemyOsyMTa3kJfmjr8hXCUdWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtMODnhnMcD3dAHZTS7d8f5K2krxQyGj3cmBX17g681rBZy0lBzucmjuKfN+6GqNy
	 ZNlE9jNZQPQLfT8SJ6LKUBCe74xYYO21h0Qr+0TjH2nQ5yD5TDwZsID8JpFjYE2Gn6
	 1ZIMa6UvYF6xxbNH2/OZc05Zum86Gbptyw6N3RF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHTNOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgHTJg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67A42075E;
        Thu, 20 Aug 2020 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916187;
        bh=n3so6R77g/5ICdm/NwPemyOsyMTa3kJfmjr8hXCUdWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9W05h7dl3sKv3hiCFoReXTHh7jrnSpq4+fBbOg4P5bVG7xm9oTE9MweostohAS5m
         ohpBNiDt7I5ytgLoutkV/Tmp2qVWX6e36qP/ZNY9qXrFCeqD+JznO01UjYafg3C4E1
         Gz4wTD1xI/LHDSrrqcSSuZZUCqDcTFmltTRMKUGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.7 041/204] xtensa: add missing exclusive access state management
Date:   Thu, 20 Aug 2020 11:18:58 +0200
Message-Id: <20200820091608.324373474@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit a0fc1436f1f4f84e93144480bf30e0c958d135b6 upstream.

The result of the s32ex opcode is recorded in the ATOMCTL special
register and must be retrieved with the getex opcode. Context switch
between s32ex and getex may trash the ATOMCTL register and result in
duplicate update or missing update of the atomic variable.
Add atomctl8 field to the struct thread_info and use getex to swap
ATOMCTL bit 8 as a part of context switch.
Clear exclusive access monitor on kernel entry.

Cc: stable@vger.kernel.org
Fixes: f7c34874f04a ("xtensa: add exclusive atomics support")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/thread_info.h |    4 ++++
 arch/xtensa/kernel/asm-offsets.c      |    3 +++
 arch/xtensa/kernel/entry.S            |   11 +++++++++++
 3 files changed, 18 insertions(+)

--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -55,6 +55,10 @@ struct thread_info {
 	mm_segment_t		addr_limit;	/* thread address space */
 
 	unsigned long		cpenable;
+#if XCHAL_HAVE_EXCLUSIVE
+	/* result of the most recent exclusive store */
+	unsigned long		atomctl8;
+#endif
 
 	/* Allocate storage for extra user states and coprocessor states. */
 #if XTENSA_HAVE_COPROCESSORS
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -93,6 +93,9 @@ int main(void)
 	DEFINE(THREAD_RA, offsetof (struct task_struct, thread.ra));
 	DEFINE(THREAD_SP, offsetof (struct task_struct, thread.sp));
 	DEFINE(THREAD_CPENABLE, offsetof (struct thread_info, cpenable));
+#if XCHAL_HAVE_EXCLUSIVE
+	DEFINE(THREAD_ATOMCTL8, offsetof (struct thread_info, atomctl8));
+#endif
 #if XTENSA_HAVE_COPROCESSORS
 	DEFINE(THREAD_XTREGS_CP0, offsetof(struct thread_info, xtregs_cp.cp0));
 	DEFINE(THREAD_XTREGS_CP1, offsetof(struct thread_info, xtregs_cp.cp1));
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -374,6 +374,11 @@ common_exception:
 	s32i	a2, a1, PT_LCOUNT
 #endif
 
+#if XCHAL_HAVE_EXCLUSIVE
+	/* Clear exclusive access monitor set by interrupted code */
+	clrex
+#endif
+
 	/* It is now save to restore the EXC_TABLE_FIXUP variable. */
 
 	rsr	a2, exccause
@@ -2020,6 +2025,12 @@ ENTRY(_switch_to)
 	s32i	a3, a4, THREAD_CPENABLE
 #endif
 
+#if XCHAL_HAVE_EXCLUSIVE
+	l32i	a3, a5, THREAD_ATOMCTL8
+	getex	a3
+	s32i	a3, a4, THREAD_ATOMCTL8
+#endif
+
 	/* Flush register file. */
 
 	spill_registers_kernel


