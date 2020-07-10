Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D267BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62842078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400041;
	bh=3K5XTQlitj/bwe8CUOw07Oa86EAGRdA3nrYZ6K6ZBqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH8XDvCmiaY+HIN6oh9L7dcFwiVyx1G5D7U7mGUhnfKe3Rp8d3oC5S/WVzA94VK68
	 j3M+MYamLWKScOsR2HPhIY3ps5niBsaVJ7uJCLaqhIfnrJAtgKyLZTxfkvL+FDkTQB
	 I35X20PhAk3AMPPFMk1m1mxzEUdh26nIWV/LS6ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGJQxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJQxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439142078D;
        Fri, 10 Jul 2020 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399980;
        bh=3K5XTQlitj/bwe8CUOw07Oa86EAGRdA3nrYZ6K6ZBqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFzrVhw9Xba3gfX7j5r6u6ydOqRSwtCuUnYHNbVIVRx5hVppjJ3pCseUfBBWyAxBi
         FaE2beH0RhWvr3MvlG/QqqT28zxasoef19BeRngckScT21HhXcALLG4Nsl7ToVxzbB
         86U8+/rWbiYfNi1NznvF1uhROfq8/TxZcx2FXfnc=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 12/19] tools/memory-model: Remove smp_read_barrier_depends() from informal doc
Date:   Fri, 10 Jul 2020 17:51:56 +0100
Message-Id: <20200710165203.31284-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_read_barrier_depends() has gone the way of mmiowb() and so many
esoteric memory barriers before it. Drop the two mentions of this
deceased barrier from the LKMM informal explanation document.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../Documentation/explanation.txt             | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e91a2eb19592..01adf9e0ebac 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1122,12 +1122,10 @@ maintain at least the appearance of FIFO order.
 In practice, this difficulty is solved by inserting a special fence
 between P1's two loads when the kernel is compiled for the Alpha
 architecture.  In fact, as of version 4.15, the kernel automatically
-adds this fence (called smp_read_barrier_depends() and defined as
-nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
-load.  The effect of the fence is to cause the CPU not to execute any
-po-later instructions until after the local cache has finished
-processing all the stores it has already received.  Thus, if the code
-was changed to:
+adds this fence after every READ_ONCE() and atomic load on Alpha.  The
+effect of the fence is to cause the CPU not to execute any po-later
+instructions until after the local cache has finished processing all
+the stores it has already received.  Thus, if the code was changed to:
 
 	P1()
 	{
@@ -1146,14 +1144,14 @@ READ_ONCE() or another synchronization primitive rather than accessed
 directly.
 
 The LKMM requires that smp_rmb(), acquire fences, and strong fences
-share this property with smp_read_barrier_depends(): They do not allow
-the CPU to execute any po-later instructions (or po-later loads in the
-case of smp_rmb()) until all outstanding stores have been processed by
-the local cache.  In the case of a strong fence, the CPU first has to
-wait for all of its po-earlier stores to propagate to every other CPU
-in the system; then it has to wait for the local cache to process all
-the stores received as of that time -- not just the stores received
-when the strong fence began.
+share this property: They do not allow the CPU to execute any po-later
+instructions (or po-later loads in the case of smp_rmb()) until all
+outstanding stores have been processed by the local cache.  In the
+case of a strong fence, the CPU first has to wait for all of its
+po-earlier stores to propagate to every other CPU in the system; then
+it has to wait for the local cache to process all the stores received
+as of that time -- not just the stores received when the strong fence
+began.
 
 And of course, none of this matters for any architecture other than
 Alpha.
-- 
2.27.0.383.g050319c2ae-goog

