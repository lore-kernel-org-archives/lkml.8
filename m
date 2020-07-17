Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFE3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053FF20739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aaw82ADE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D2Pvbyrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGQWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:01:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgGQWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:01:24 -0400
Date:   Fri, 17 Jul 2020 22:01:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595023282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKxmJXVwsvYDumCD+2mcEazY3189Dr6bSZIdX1Z/yVY=;
        b=Aaw82ADEPpT6IKheDtp5Fnv1fBsrKYSuJj8204WxDxwosI6g0VUixY78zjvm3uFnfPFqwE
        KhikKQRc2dl8GwLJnGQLh1tJCrg/PJp1R0y5S6AMlusqz0sHl5D2alkNsvOYavY/8D//Nk
        G+SNK8WjC5U0B/BBnQB4EM3wYJ6rgmLUL4kqNpVTE268ymX3Kj8KjMYb25ITFvLNPXgz7x
        CrmEU04tIGdnBKhaXuAH0hLY1l8C5K36i5kevXZVfDK+0p7JmQG27KeG5An8fzGs4ahI9L
        ZIQJsaucV0H1EvKAHo+OeqEWoKuKmINrhAzOYlzHCtgefO0sIUkZUOoLqLNB9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595023282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKxmJXVwsvYDumCD+2mcEazY3189Dr6bSZIdX1Z/yVY=;
        b=D2PvbyrhD/KPQX9d1cQ2QXoinonkmIge5mqRaSnBC58pQ2a98Wd1OXjZHIJ6IPxi4gpgnk
        kcafSXtwHcNyXSCg==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove put_futex_key()
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702202843.520764-2-andrealmeid@collabora.com>
References: <20200702202843.520764-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <159502328144.4006.6432419644443604486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9180bd467f9abdb44afde650d07e3b9dd66d837c
Gitweb:        https://git.kernel.org/tip/9180bd467f9abdb44afde650d07e3b9dd66=
d837c
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:40 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 23:58:49 +02:00

futex: Remove put_futex_key()

Since 4b39f99c ("futex: Remove {get,drop}_futex_key_refs()"),
put_futex_key() is empty.

Remove all references for this function and the then redundant labels.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200702202843.520764-2-andrealmeid@collabora=
.com
---
 kernel/futex.c | 61 +++++++++----------------------------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e646661..bd9adfc 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -677,10 +677,6 @@ out:
 	return err;
 }
=20
-static inline void put_futex_key(union futex_key *key)
-{
-}
-
 /**
  * fault_in_user_writeable() - Fault in user address and verify RW access
  * @uaddr:	pointer to faulting user space address
@@ -1617,7 +1613,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int n=
r_wake, u32 bitset)
=20
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
-		goto out_put_key;
+		goto out;
=20
 	spin_lock(&hb->lock);
=20
@@ -1640,8 +1636,6 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int n=
r_wake, u32 bitset)
=20
 	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
-out_put_key:
-	put_futex_key(&key);
 out:
 	return ret;
 }
@@ -1712,7 +1706,7 @@ retry:
 		goto out;
 	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
-		goto out_put_key1;
+		goto out;
=20
 	hb1 =3D hash_futex(&key1);
 	hb2 =3D hash_futex(&key2);
@@ -1730,13 +1724,13 @@ retry_private:
 			 * an MMU, but we might get them from range checking
 			 */
 			ret =3D op_ret;
-			goto out_put_keys;
+			goto out;
 		}
=20
 		if (op_ret =3D=3D -EFAULT) {
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (ret)
-				goto out_put_keys;
+				goto out;
 		}
=20
 		if (!(flags & FLAGS_SHARED)) {
@@ -1744,8 +1738,6 @@ retry_private:
 			goto retry_private;
 		}
=20
-		put_futex_key(&key2);
-		put_futex_key(&key1);
 		cond_resched();
 		goto retry;
 	}
@@ -1781,10 +1773,6 @@ retry_private:
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-out_put_keys:
-	put_futex_key(&key2);
-out_put_key1:
-	put_futex_key(&key1);
 out:
 	return ret;
 }
@@ -1996,7 +1984,7 @@ retry:
 	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret !=3D 0))
-		goto out_put_key1;
+		goto out;
=20
 	/*
 	 * The check above which compares uaddrs is not sufficient for
@@ -2004,7 +1992,7 @@ retry:
 	 */
 	if (requeue_pi && match_futex(&key1, &key2)) {
 		ret =3D -EINVAL;
-		goto out_put_keys;
+		goto out;
 	}
=20
 	hb1 =3D hash_futex(&key1);
@@ -2025,13 +2013,11 @@ retry_private:
=20
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
-				goto out_put_keys;
+				goto out;
=20
 			if (!(flags & FLAGS_SHARED))
 				goto retry_private;
=20
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			goto retry;
 		}
 		if (curval !=3D *cmpval) {
@@ -2090,8 +2076,6 @@ retry_private:
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -2106,8 +2090,6 @@ retry_private:
 			 */
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
-			put_futex_key(&key2);
-			put_futex_key(&key1);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -2217,10 +2199,6 @@ out_unlock:
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
=20
-out_put_keys:
-	put_futex_key(&key2);
-out_put_key1:
-	put_futex_key(&key1);
 out:
 	return ret ? ret : task_count;
 }
@@ -2697,7 +2675,6 @@ retry_private:
 		if (!(flags & FLAGS_SHARED))
 			goto retry_private;
=20
-		put_futex_key(&q->key);
 		goto retry;
 	}
=20
@@ -2707,8 +2684,6 @@ retry_private:
 	}
=20
 out:
-	if (ret)
-		put_futex_key(&q->key);
 	return ret;
 }
=20
@@ -2853,7 +2828,6 @@ retry_private:
 			 * - EAGAIN: The user space value changed.
 			 */
 			queue_unlock(hb);
-			put_futex_key(&q.key);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -2961,13 +2935,11 @@ no_block:
 		put_pi_state(pi_state);
 	}
=20
-	goto out_put_key;
+	goto out;
=20
 out_unlock_put_key:
 	queue_unlock(hb);
=20
-out_put_key:
-	put_futex_key(&q.key);
 out:
 	if (to) {
 		hrtimer_cancel(&to->timer);
@@ -2980,12 +2952,11 @@ uaddr_faulted:
=20
 	ret =3D fault_in_user_writeable(uaddr);
 	if (ret)
-		goto out_put_key;
+		goto out;
=20
 	if (!(flags & FLAGS_SHARED))
 		goto retry_private;
=20
-	put_futex_key(&q.key);
 	goto retry;
 }
=20
@@ -3114,16 +3085,13 @@ retry:
 out_unlock:
 	spin_unlock(&hb->lock);
 out_putkey:
-	put_futex_key(&key);
 	return ret;
=20
 pi_retry:
-	put_futex_key(&key);
 	cond_resched();
 	goto retry;
=20
 pi_faulted:
-	put_futex_key(&key);
=20
 	ret =3D fault_in_user_writeable(uaddr);
 	if (!ret)
@@ -3265,7 +3233,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, uns=
igned int flags,
 	 */
 	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
-		goto out_key2;
+		goto out;
=20
 	/*
 	 * The check above which compares uaddrs is not sufficient for
@@ -3274,7 +3242,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, uns=
igned int flags,
 	if (match_futex(&q.key, &key2)) {
 		queue_unlock(hb);
 		ret =3D -EINVAL;
-		goto out_put_keys;
+		goto out;
 	}
=20
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
@@ -3284,7 +3252,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, uns=
igned int flags,
 	ret =3D handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
 	spin_unlock(&hb->lock);
 	if (ret)
-		goto out_put_keys;
+		goto out;
=20
 	/*
 	 * In order for us to be here, we know our q.key =3D=3D key2, and since
@@ -3374,11 +3342,6 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, un=
signed int flags,
 		ret =3D -EWOULDBLOCK;
 	}
=20
-out_put_keys:
-	put_futex_key(&q.key);
-out_key2:
-	put_futex_key(&key2);
-
 out:
 	if (to) {
 		hrtimer_cancel(&to->timer);
