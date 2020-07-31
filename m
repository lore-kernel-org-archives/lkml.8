Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B66BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD599208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHNg4jvX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBMb0jJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgGaJ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732445AbgGaJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:26 -0400
Date:   Fri, 31 Jul 2020 09:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s0t51iQ4y/zadAUFFTzS7TmA5Ipav6f9I8SLpArz72I=;
        b=iHNg4jvXlpPOYfFEhTYFtFUVVPa5o+vikSXcrVbiUE7v78BEBJVS/q9nJ8JpNkHJ4fdZWN
        /hm6+wSQjjQ+eCaTvXupxtoMgEk8xZgO1j+Ijh2RkfJyBhhnyFEsUelHZxpNkthKbSjSIN
        x37qcnJEcZ9aUtSG0rv1vJPA9w+8oqq5y0+KXl4RLjJ0j3c2CZ5NmPwYIkImW4iCDTGes4
        cRTiGRY8X5T2Ze6bupAg9ZiLGZ1j4SaawrtbeO6o7Jypm3bJOJo1dEbTUcQ+hHB3SdW1x0
        W2mepfdF5S1ggRGDMQzzYY2SiA4F599r0YpVeBTSRlFm7o/L7Vc2EEs03NW2Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s0t51iQ4y/zadAUFFTzS7TmA5Ipav6f9I8SLpArz72I=;
        b=iBMb0jJtM1b1JJazPudqZ0axFnWTx0VHOWPyrg2xC2IM2uIBuwbCyvPsRzkzP0ac6wIljS
        OXmztH8YSmNeV8DA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740382.4006.17341702768108975880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4d2919411867848fab78c7cb13139e17ad8b85bc
Gitweb:        https://git.kernel.org/tip/4d2919411867848fab78c7cb13139e17ad8b85bc
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 25 May 2020 23:47:46 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Skip entry into the page allocator for PREEMPT_RT

To keep the kfree_rcu() code working in purely atomic sections on RT,
such as non-threaded IRQ handlers and raw spinlock sections, avoid
calling into the page allocator which uses sleeping locks on RT.

In fact, even if the  caller is preemptible, the kfree_rcu() code is
not, as the krcp->lock is a raw spinlock.

Calling into the page allocator is optional and avoiding it should be
Ok, especially with the page pre-allocation support in future patches.
Such pre-allocation would further avoid the a need for a dynamically
allocated page in the first place.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c5de5ad..e0425fa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3202,6 +3202,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
+			/*
+			 * To keep this path working on raw non-preemptible
+			 * sections, prevent the optional entry into the
+			 * allocator as it uses sleeping locks. In fact, even
+			 * if the caller of kfree_rcu() is preemptible, this
+			 * path still is not, as krcp->lock is a raw spinlock.
+			 * With additional page pre-allocation in the works,
+			 * hitting this return is going to be much less likely.
+			 */
+			if (IS_ENABLED(CONFIG_PREEMPT_RT))
+				return false;
+
 			bnode = (struct kfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
