Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C56CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771A724695
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196478;
	bh=NH7YmaENed7733PiOVCPiTH7DV/SfeLsD2y7DmbM7Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHXPcnIqZXIx6qKSTb7P/Pd//j58UXbq35EzCqQt8NeOVJsQPR1PhZFJ/p1VsqzsW
	 HLkCTZ41Ws6i8VriPzI3Fl2Eo0OL1j9GImlrq0FQQsAdr2tM8KTy2040mIHjKGti4K
	 RlFgPzN4zlcwt0H5yilpyloFqCZAnIowS2dOFOWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393756AbgAPRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393608AbgAPRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F397F24718;
        Thu, 16 Jan 2020 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196419;
        bh=NH7YmaENed7733PiOVCPiTH7DV/SfeLsD2y7DmbM7Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOgx0pKIUgwMnYxNz2Nkx+vLHAZ55zodK+qnEHQmm5jXNnqjbMYRMVO+f8fCzKY4E
         rgPM25/jxGM7UEkMOt7j7GlTTG9IJOcHOt1c/DcL4BzOG3sDBOrwX6MmmyYLHOmKKC
         TjsC5ZJOp6kj5IfXHFqt5WcdYBD6ToxWxXQKykPc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        laokz <laokz@foxmail.com>, Stefani Seibold <stefani@seibold.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <greg@kroah.com>, Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 189/251] Partially revert "kfifo: fix kfifo_alloc() and kfifo_init()"
Date:   Thu, 16 Jan 2020 12:35:38 -0500
Message-Id: <20200116173641.22137-149-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit ab9bb6318b0967671e0c9b6537c1537d51ca4f45 ]

Commit dfe2a77fd243 ("kfifo: fix kfifo_alloc() and kfifo_init()") made
the kfifo code round the number of elements up.  That was good for
__kfifo_alloc(), but it's actually wrong for __kfifo_init().

The difference? __kfifo_alloc() will allocate the rounded-up number of
elements, but __kfifo_init() uses an allocation done by the caller.  We
can't just say "use more elements than the caller allocated", and have
to round down.

The good news? All the normal cases will be using power-of-two arrays
anyway, and most users of kfifo's don't use kfifo_init() at all, but one
of the helper macros to declare a KFIFO that enforce the proper
power-of-two behavior.  But it looks like at least ibmvscsis might be
affected.

The bad news? Will Deacon refers to an old thread and points points out
that the memory ordering in kfifo's is questionable.  See

  https://lore.kernel.org/lkml/20181211034032.32338-1-yuleixzhang@tencent.com/

for more.

Fixes: dfe2a77fd243 ("kfifo: fix kfifo_alloc() and kfifo_init()")
Reported-by: laokz <laokz@foxmail.com>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg KH <greg@kroah.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kfifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index 90ba1eb1df06..a94227c55551 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -82,7 +82,8 @@ int __kfifo_init(struct __kfifo *fifo, void *buffer,
 {
 	size /= esize;
 
-	size = roundup_pow_of_two(size);
+	if (!is_power_of_2(size))
+		size = rounddown_pow_of_two(size);
 
 	fifo->in = 0;
 	fifo->out = 0;
-- 
2.20.1

