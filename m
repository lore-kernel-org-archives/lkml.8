Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA302075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918460;
	bh=jpjvu5DNSsFhj7TaN3Uplbyo2byrClBWPCIFaW4s2dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KYVR+g3QtCV9hKiF8o/BRjZiGrg8vKpiW7uRicBirPkysJndGZNRdaSQ5lckFGv4v
	 HCI5vZ9RUtQKOocIC6bY0haETIo/T9TW9XR5Lsh/xZvxgiWp5jX/gqyjvJw5EPy/VW
	 A2UrizCNIY7N0EgxqU7QjgdWYDBcOgK+SCe6aUUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgHTKOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731075AbgHTKNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:13:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB02206DA;
        Thu, 20 Aug 2020 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918415;
        bh=jpjvu5DNSsFhj7TaN3Uplbyo2byrClBWPCIFaW4s2dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEqwLUJ0H4PaenfT5LmPmhRsmsKq20uSiT8gMO22fNgXUfDAoIjZdjD78UK1z1lEI
         yo3GmND086h0vZd7Q+hEM3AGh6UR5DUCeE2Y2I2pIEUUyDSg2z1cvW3OuwCQFnbBZU
         tWtvmqvVkeEKohD03R7m6B10i1UN8pCtKKhElQ1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 162/228] ARM: 8992/1: Fix unwind_frame for clang-built kernels
Date:   Thu, 20 Aug 2020 11:22:17 +0200
Message-Id: <20200820091615.672509747@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Huckleberry <nhuck@google.com>

commit b4d5ec9b39f8b31d98f65bc5577b5d15d93795d7 upstream.

Since clang does not push pc and sp in function prologues, the current
implementation of unwind_frame does not work. By using the previous
frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
kernels.

The bounds check on next frame pointer must be changed as well since
there are 8 less bytes between frames.

This fixes /proc/<pid>/stack.

Link: https://github.com/ClangBuiltLinux/linux/issues/912

Reported-by: Miles Chen <miles.chen@mediatek.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/stacktrace.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -20,6 +20,19 @@
  * A simple function epilogue looks like this:
  *	ldm	sp, {fp, sp, pc}
  *
+ * When compiled with clang, pc and sp are not pushed. A simple function
+ * prologue looks like this when built with clang:
+ *
+ *	stmdb	{..., fp, lr}
+ *	add	fp, sp, #x
+ *	sub	sp, sp, #y
+ *
+ * A simple function epilogue looks like this when built with clang:
+ *
+ *	sub	sp, fp, #x
+ *	ldm	{..., fp, pc}
+ *
+ *
  * Note that with framepointer enabled, even the leaf functions have the same
  * prologue and epilogue, therefore we can ignore the LR value in this case.
  */
@@ -32,6 +45,16 @@ int notrace unwind_frame(struct stackfra
 	low = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
+#ifdef CONFIG_CC_IS_CLANG
+	/* check current frame pointer is within bounds */
+	if (fp < low + 4 || fp > high - 4)
+		return -EINVAL;
+
+	frame->sp = frame->fp;
+	frame->fp = *(unsigned long *)(fp);
+	frame->pc = frame->lr;
+	frame->lr = *(unsigned long *)(fp + 4);
+#else
 	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)
 		return -EINVAL;
@@ -40,6 +63,7 @@ int notrace unwind_frame(struct stackfra
 	frame->fp = *(unsigned long *)(fp - 12);
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
+#endif
 
 	return 0;
 }


