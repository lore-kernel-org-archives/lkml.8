Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C45C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040D7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCqJpDn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PuXJInS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgGaJZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbgGaJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:31 -0400
Date:   Fri, 31 Jul 2020 09:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cn8Hyqv9Z7RBtVMAViF9wQX5WL9jhMmyY0dwvuZGrww=;
        b=vCqJpDn+eoZ252VcPr1lxkQt7tBna6lFAxYQpWO4VmW/34+SggeaBWbI2jRcphXMSzwA1p
        bAqAie7f7yzpJQ2zpn1k4bXAHeesB6GDjE3bN7BCE2o3ScI4reP4PWQbVeeCjF9BQ+8Fpy
        k0WYmKD3Ud65FbPTmgcWd5fMaSvr/DkYqS1ZKcdxyMw8kUYvkkCZPRViUnYA0xirhbDin1
        1/EB0AQiF9XJYxhf3DGnJ6dPsMkfVE/T1VGU1QUzbWj47in/5fm1j6E7vHdU6gidSBsh5x
        8BmPcZDnR+a0YHd5l+ypGjWJeL4hmuc8VnciT5rD19IyOp729W1RJtpZWD5NGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cn8Hyqv9Z7RBtVMAViF9wQX5WL9jhMmyY0dwvuZGrww=;
        b=3PuXJInSLUPXjiQrAkvfxZ/v/RnhoktETVY39R5vKKYGnAJXtkfH0IG07FtZrWgedHDAQL
        Wk6WhdZvQhNxuiBA==
From:   "tip-bot2 for Peter Enderborg" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Stop shrinker loop
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740918.4006.16794390704113434014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c6dfd72b7a3b70a2054db0f73245ea2f762a8452
Gitweb:        https://git.kernel.org/tip/c6dfd72b7a3b70a2054db0f73245ea2f762a8452
Author:        Peter Enderborg <peter.enderborg@sony.com>
AuthorDate:    Thu, 04 Jun 2020 12:23:20 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: Stop shrinker loop

The count and scan can be separated in time, and there is a fair chance
that all work is already done when the scan starts, which might in turn
result in a needless retry.  This commit therefore avoids this retry by
returning SHRINK_STOP.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d17e5a0..c8196fa 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3332,7 +3332,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			break;
 	}
 
-	return freed;
+	return freed == 0 ? SHRINK_STOP : freed;
 }
 
 static struct shrinker kfree_rcu_shrinker = {
