Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A9220675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziTb39eZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTj+OTBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgF2UP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732820AbgF2UPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:15:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C996C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:15:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593461738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qzhrv068SVyOclPG+XbY3eTySnVvBXvWF1YU6qPgT4A=;
        b=ziTb39eZbm9oX7ZE+jaxLZodSu6uy93Z0xNo3n7DI0zxs3bEWmqSPFJ/lxw8NpknEelPsE
        fGqKTXyFt2P6L9ni2CA63VRNC1Em/qA//Czrr5ofKER6SwOQIPZYlasj5hv1bDm5gQfx17
        fVf5hfL0LUU4z/+VF1wUzzzG98HoKvslA7vBiZrBtx7qPSOpNGTcRj4RsrvkoyqFHak8YX
        cc6ObdPGBSco/+7JTqsNIlkovLX+fowkYGa9jResv3KFvxorwzWKa7Q9ij8wm1ppJWgJBO
        7ebKCxvB/GRB6RwlqEA3mBOOF1xGEa4n+mviC5qHt09Vp4ii1XAGPzKmK/EjAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593461738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qzhrv068SVyOclPG+XbY3eTySnVvBXvWF1YU6qPgT4A=;
        b=fTj+OTBOaUMG4LLbz3Rk01YlI+4RE8eLIhXKVHt5TPdrnw90mIhKf1L+jxzLWmilZ2zsHM
        BpW1lpdUTz70SyAg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] lockdep: Do no validate wait context for novalidate class
Date:   Mon, 29 Jun 2020 22:15:29 +0200
Message-Id: <20200629201529.1017485-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The novalidate class is ignored in the lockchain validation but is
considered in the wait context validation.
If a mutex and a spinlock_t is ignored by using
lockdep_set_novalidate_class() then both locks will share the same lock
class. From the wait validation point of view the mutex will then appear
like a spinlock_t and the validator will complain if another mutex will
be acquired.

Ignore the nonvalidate locks from wait context checking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/lockdep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4c50b90..fb9a642d8ebef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4067,7 +4067,7 @@ static int check_wait_context(struct task_struct *cur=
r, struct held_lock *next)
 	 */
 	for (depth =3D curr->lockdep_depth - 1; depth >=3D 0; depth--) {
 		struct held_lock *prev =3D curr->held_locks + depth;
-		if (prev->irq_context !=3D next->irq_context)
+		if (prev->check && prev->irq_context !=3D next->irq_context)
 			break;
 	}
 	depth++;
@@ -4078,6 +4078,9 @@ static int check_wait_context(struct task_struct *cur=
r, struct held_lock *next)
 		struct held_lock *prev =3D curr->held_locks + depth;
 		short prev_inner =3D hlock_class(prev)->wait_type_inner;
=20
+		if (!prev->check)
+			continue;
+
 		if (prev_inner) {
 			/*
 			 * We can have a bigger inner than a previous one
--=20
2.27.0

