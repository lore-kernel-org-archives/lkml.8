Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE1C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CD220659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="SDJrM4QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDEVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:04:46 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:1414 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgDEVEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 17:04:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 159AB708;
        Sun,  5 Apr 2020 23:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1586120682; x=1587935083; bh=4DyJE8jaDUiNyYuqX3A
        zu9P6orZ0CMtadRnxAX0eOZw=; b=SDJrM4QBn/GS0RKKTMcVb7y+EOa6v3Z4q0g
        oap4H2Qkn2EOvpxDddo8SwlTJNfRPG1E5onXSJU8xdpIncJaYRtdnmejD4eUyIZZ
        cqbpURFggZlq+aFvs1G21Y5y68Ef/jloMO0YYKBKzehf6z0HkmL3kBjEA6YO+HBB
        Wmx2mrK69Sh/CAkmTema+gC/r0P8RSPGxE/+tSJowh08ANdxO6Ow04LsMHoq7zRr
        f5rI/JUNkxQjbwkGskTs8vz8mr/wrWWx2gGTCz9YVD6cXgeEWVrZ63XEXgVuRJ1o
        5iTPwBlIOw6XAMy5IVfB+sOjIrsEm9gP774G5HknWyAr/5SwwuTevKpSc1fUSQHf
        3nqeYCg0LVmrSh1AqKMELwh4peZqwak0h70HvSXz5mkl2hKt6Z7nEx1rh0UT7BUV
        T1f7c8jdLmNlaL+gqO2qDaqySCmChT0/dKDm/CEyEgDsxj8k7b+vAAuSLSdFXIsm
        UHupoS9LiwhtSbDcYwFjHuXeAZ3ycmt8YvkrXjhR2Fj866jiIWPIRU1EaYBYChwG
        sKcoM2R06paY2Sl3yXOXhMHWKhYtyRA8D/qP9AEuo4MCf4ctP+l6t9qMBr1YItIZ
        o1kBwZCQW0B++YO1K/WkxacgGmBo/y6K+WfyyeC8Fb5YA7qnoPpmCqSkl/hH5d/f
        isedh4q8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id APv-grdysqV3; Sun,  5 Apr 2020 23:04:42 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 8203D364;
        Sun,  5 Apr 2020 23:04:42 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 2F90418E;
        Sun,  5 Apr 2020 23:04:42 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: highlight structure fields using monospace format
Date:   Sun,  5 Apr 2020 23:04:33 +0200
Message-Id: <20200405210433.24791-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to improve readability by highlighting structure fields
using a different format.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/rt-mutex-design.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/locking/rt-mutex-design.rst b/Documentation/locking/rt-mutex-design.rst
index 59c2a64efb21..bdd6b0013e02 100644
--- a/Documentation/locking/rt-mutex-design.rst
+++ b/Documentation/locking/rt-mutex-design.rst
@@ -199,7 +199,7 @@ Mutex Waiters Tree
 Every mutex keeps track of all the waiters that are blocked on itself. The
 mutex has a rbtree to store these waiters by priority.  This tree is protected
 by a spin lock that is located in the struct of the mutex. This lock is called
-wait_lock.
+``wait_lock``.
 
 
 Task PI Tree
@@ -216,9 +216,9 @@ inherited a priority, it will always be the priority of the task that is
 at the top of this tree.
 
 This tree is stored in the task structure of a process as a rbtree called
-pi_waiters.  It is protected by a spin lock also in the task structure,
-called pi_lock.  This lock may also be taken in interrupt context, so when
-locking the pi_lock, interrupts must be disabled.
+``pi_waiters``.  It is protected by a spin lock also in the task structure,
+called ``pi_lock``.  This lock may also be taken in interrupt context, so when
+locking the ``pi_lock``, interrupts must be disabled.
 
 
 Depth of the PI Chain
-- 
2.25.1

