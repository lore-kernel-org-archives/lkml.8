Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A53C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1307208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENSIoo4v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTRxaYMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgGaJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbgGaJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6173C061757;
        Fri, 31 Jul 2020 02:23:18 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t4dir0xOOOUNuoeaiLa4YsLjcpl3ykKVUpTfiu2Xo2A=;
        b=ENSIoo4v8gFYzUrRkFKNNhkE5uxBYGjBuzm0Eef52VQCOC01g3lbr0MmWFvB9wR78WU4sb
        vlelF+2CSO1D9e15KQX4CCEhLjV7Eu3ooqnIACwlU+eYUqmgNQ47OHwyzo2rjUCK/YAQm8
        hqu0LUXWwja4I9C9fh/UHwN2xXcYyi5+L8QBPXdFmuT2pNt9UcMXA+ybbjVR/BbutrO2oa
        4jERmTTyLnrIdW6kWBTd+32GrgZu9aHQ6+NkAZ6U+YpE+A78/84wvNXTAQ3NP5Yn1t45A1
        rEh7y92ZwCDYejlf5bHdPNRePwbDvL+KZm2QuLsA1JuTK6w9jToC/bu9EHAkUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t4dir0xOOOUNuoeaiLa4YsLjcpl3ykKVUpTfiu2Xo2A=;
        b=hTRxaYMVEqNXYk/AP6OW9P5HJJpj4l2h54Mmn8oxVZcb1HvISQednvGCX6y4OsLV8YgD9a
        JNl15AfBCFMerDBg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Introduce 2 arg kvfree_rcu() interface
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739652.4006.9805625045459231035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ce4dce123fdcb5f209752d13f9f06926be65fc78
Gitweb:        https://git.kernel.org/tip/ce4dce123fdcb5f209752d13f9f06926be65fc78
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:57 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu: Introduce 2 arg kvfree_rcu() interface

kvmalloc() can allocate two types of objects: SLAB backed
and vmalloc backed. How it behaves depends on requested
object's size and memory pressure.

Add a kvfree_rcu() interface that can free memory allocated
via kvmalloc(). It is a simple alias to kfree_rcu() which
can now handle either type of object.

<snip>
    struct test_kvfree_rcu {
        struct rcu_head rcu;
        unsigned char array[100];
    };

    struct test_kvfree_rcu *p;

    p = kvmalloc(10 * PAGE_SIZE);
    if (p)
        kvfree_rcu(p, rcu);
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b344fc8..51b26ab 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -875,6 +875,15 @@ do {									\
 		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
+/**
+ * kvfree_rcu() - kvfree an object after a grace period.
+ * @ptr:	pointer to kvfree
+ * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ *
+ * Same as kfree_rcu(), just simple alias.
+ */
+#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
