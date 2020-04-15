Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC32C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F2620768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977926;
	bh=fIORlCQbxBxgk9voZ1LkLthTTqwXiwUQiuX5p9e4JlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fE7MYsHGpAwgsFNBAtRmlkg4YJcoMmw6qy/5+AiRDYgdKSu57qWXzkkWqSX7eLTfo
	 UDTQlod4NRsD0TrbbkZogYhJ9Bm1i3AMaHL5EumAI0h0XWYUrKkCHdvVfPxnKQPt5C
	 EKE0EwHAcR5tTPFe1a51qU/smZpYpL7wmhfmFV+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441644AbgDOTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416864AbgDOStt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005B221582;
        Wed, 15 Apr 2020 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976589;
        bh=fIORlCQbxBxgk9voZ1LkLthTTqwXiwUQiuX5p9e4JlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcRlQFeqt483Xm7uouJHrzfgYsFxlmBy049Ay8Q8CPa6F2sUgOOamMvv5SApXu/ZY
         D5IQDTBUJY6WzgSGlkfc5CdcmnafzWC3NvjDOoIYLS+8O0HeBYoEm4AxMDckDg9u3b
         +Vo/U9k3+TVQibMHkyaw+zT6Lw7V+YpNMjJB/qFs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lkmm tip/core/rcu 08/10] Documentation/litmus-tests: Introduce atomic directory
Date:   Wed, 15 Apr 2020 11:49:43 -0700
Message-Id: <20200415184945.16487-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Although we have atomic_t.txt and its friends to describe the semantics
of atomic APIs and lib/atomic64_test.c for build testing and testing in
UP mode, the tests for our atomic APIs in real SMP mode are still
missing. Since now we have the LKMM tool in kernel and litmus tests can
be used to generate kernel modules for testing purpose with "klitmus" (a
tool from the LKMM toolset), it makes sense to put a few typical litmus
tests into kernel so that

1)	they are the examples to describe the conceptual mode of the
	semantics of atomic APIs, and

2)	they can be used to generate kernel test modules for anyone
	who is interested to test the atomic APIs implementation (in
	most cases, is the one who implements the APIs for a new arch)

Therefore, introduce the atomic directory for this purpose. The
directory is maintained by the LKMM group to make sure the litmus tests
are always aligned with our memory model.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/atomic/README | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 Documentation/litmus-tests/atomic/README

diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
new file mode 100644
index 0000000..ae61201
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/README
@@ -0,0 +1,4 @@
+This directory contains litmus tests that are typical to describe the semantics
+of our atomic APIs. For more information about how to "run" a litmus test or
+how to generate a kernel test module based on a litmus test, please see
+tools/memory-model/README.
-- 
2.9.5

