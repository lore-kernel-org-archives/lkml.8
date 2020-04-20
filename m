Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C38C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C35C206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387328;
	bh=HBAym8ekahvMlEeslnbCh2FaaepabcjHWf4jPxOqKYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RyfI33sphHAnSNZ+g4zvz/fILSVqr8phx6JSG9tpRXSft/Kpb9eTh0Ex3whHbwiHp
	 3fssloI6/CFR5Kg9W9g02Cj+7I/LwbpNe6rQsK1M2H9e7rS9X7kT3l3p7ONMuBkn72
	 an3SY3PRKDjrkS82RVHoQ2npe+k1EdHOBMUEm09E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgDTMpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgDTMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14210206DD;
        Mon, 20 Apr 2020 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386738;
        bh=HBAym8ekahvMlEeslnbCh2FaaepabcjHWf4jPxOqKYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLFDyL805/K0OlHz1Im6XsPlIdFF6+BkDAJPv0pQpYpZAW1j5vAwBq8ym4jurn6Ce
         uPtItv4M+X1zJF9VfXRx7VrxWN1g4w9GO20OPqMq0qg/3AoXeXx77Ec8O8GkuuYv7K
         Q1Pfol9oiKc1fj5TZN2Mk2XL0ztrJAu8H1pW/cnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 5.6 64/71] rcu: Dont acquire lock in NMI handler in rcu_nmi_enter_common()
Date:   Mon, 20 Apr 2020 14:39:18 +0200
Message-Id: <20200420121521.714417792@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

commit bf37da98c51825c90432d340e135cced37a7460d upstream.

The rcu_nmi_enter_common() function can be invoked both in interrupt
and NMI handlers.  If it is invoked from process context (as opposed
to userspace or idle context) on a nohz_full CPU, it might acquire the
CPU's leaf rcu_node structure's ->lock.  Because this lock is held only
with interrupts disabled, this is safe from an interrupt handler, but
doing so from an NMI handler can result in self-deadlock.

This commit therefore adds "irq" to the "if" condition so as to only
acquire the ->lock from irq handlers or process context, never from
an NMI handler.

Fixes: 5b14557b073c ("rcu: Avoid tick_dep_set_cpu() misordering")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: <stable@vger.kernel.org> # 5.5.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -816,7 +816,7 @@ static __always_inline void rcu_nmi_ente
 			rcu_cleanup_after_idle();
 
 		incby = 1;
-	} else if (tick_nohz_full_cpu(rdp->cpu) &&
+	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		raw_spin_lock_rcu_node(rdp->mynode);


