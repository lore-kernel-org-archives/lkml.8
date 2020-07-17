Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F72EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DC720739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQT89uJf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUCjx+Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGQWB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:01:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGQWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:01:24 -0400
Date:   Fri, 17 Jul 2020 22:01:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595023281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th+gkKvG/+jmpvjZOssKqDt+jFEBHCkPIW9S4NULbo4=;
        b=kQT89uJfA1kSNYzSTYQyFl3s633aAyAUrSwz1/Nf2iMnBYmoxO+GxjBElCrrNOONg8yzZd
        ONu7HhFE3tIkw6IbC/+IrGBgZzxNXAlpdRShzet5xSQD4Wq3nTty0y0siuJIdug/zLh8Rq
        6ts0jm6B2B59f839zIxXi3buUlZd+7Qku83wm4FbwkGuBSIcwYdk/qAA3IWsSK7N9n2Ne9
        D9ufpKeMgbxraYX3VwqMx5QgSmmoyklha90HFwADCvH0zAVFWAxLp3SxE8wSvM72knQE5B
        QbP4xqBKMmfeMLK4OySFBApmu8c/uDW2/zHXEL/DUsCMcr34u1UTwsgxGUzLkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595023281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th+gkKvG/+jmpvjZOssKqDt+jFEBHCkPIW9S4NULbo4=;
        b=DUCjx+WsVwT5R9/WqkYCHIe8lXsIk2R82EIMZ7Aa58pXEqXGcMhjMWGDWeSAn26tt1+If+
        eznIX+xyPDjyOqDA==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove needless goto's
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702202843.520764-3-andrealmeid@collabora.com>
References: <20200702202843.520764-3-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <159502328082.4006.1363384803815710771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d7c5ed73b19c4640426d9c106f70ec2cb532034d
Gitweb:        https://git.kernel.org/tip/d7c5ed73b19c4640426d9c106f70ec2cb53=
2034d
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:41 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 23:58:49 +02:00

futex: Remove needless goto's

As stated in the coding style documentation, "if there is no cleanup
needed then just return directly", instead of jumping to a label and
then returning.

Remove such goto's and replace with a return statement.  When there's a
ternary operator on the return value, replace it with the result of the
operation when it is logically possible to determine it by the control
flow.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200702202843.520764-3-andrealmeid@collabora=
.com

---
 kernel/futex.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index bd9adfc..362fbca 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1607,13 +1607,13 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int=
 nr_wake, u32 bitset)
=20
 	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
-		goto out;
+		return ret;
=20
 	hb =3D hash_futex(&key);
=20
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
-		goto out;
+		return ret;
=20
 	spin_lock(&hb->lock);
=20
@@ -1636,7 +1636,6 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int n=
r_wake, u32 bitset)
=20
 	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
-out:
 	return ret;
 }
=20
@@ -1703,10 +1702,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags,=
 u32 __user *uaddr2,
 retry:
 	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
-		goto out;
+		return ret;
 	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
-		goto out;
+		return ret;
=20
 	hb1 =3D hash_futex(&key1);
 	hb2 =3D hash_futex(&key2);
@@ -1724,13 +1723,13 @@ retry_private:
 			 * an MMU, but we might get them from range checking
 			 */
 			ret =3D op_ret;
-			goto out;
+			return ret;
 		}
=20
 		if (op_ret =3D=3D -EFAULT) {
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (ret)
-				goto out;
+				return ret;
 		}
=20
 		if (!(flags & FLAGS_SHARED)) {
@@ -1773,7 +1772,6 @@ retry_private:
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-out:
 	return ret;
 }
=20
@@ -1980,20 +1978,18 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 retry:
 	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
-		goto out;
+		return ret;
 	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret !=3D 0))
-		goto out;
+		return ret;
=20
 	/*
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (requeue_pi && match_futex(&key1, &key2)) {
-		ret =3D -EINVAL;
-		goto out;
-	}
+	if (requeue_pi && match_futex(&key1, &key2))
+		return -EINVAL;
=20
 	hb1 =3D hash_futex(&key1);
 	hb2 =3D hash_futex(&key2);
@@ -2013,7 +2009,7 @@ retry_private:
=20
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
-				goto out;
+				return ret;
=20
 			if (!(flags & FLAGS_SHARED))
 				goto retry_private;
@@ -2079,7 +2075,7 @@ retry_private:
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
-			goto out;
+			return ret;
 		case -EBUSY:
 		case -EAGAIN:
 			/*
@@ -2198,8 +2194,6 @@ out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
-
-out:
 	return ret ? ret : task_count;
 }
=20
@@ -2545,7 +2539,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_=
q *q, int locked)
 		 */
 		if (q->pi_state->owner !=3D current)
 			ret =3D fixup_pi_state_owner(uaddr, q, current);
-		goto out;
+		return ret ? ret : locked;
 	}
=20
 	/*
@@ -2558,7 +2552,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_=
q *q, int locked)
 	 */
 	if (q->pi_state->owner =3D=3D current) {
 		ret =3D fixup_pi_state_owner(uaddr, q, NULL);
-		goto out;
+		return ret;
 	}
=20
 	/*
@@ -2572,8 +2566,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_=
q *q, int locked)
 				q->pi_state->owner);
 	}
=20
-out:
-	return ret ? ret : locked;
+	return ret;
 }
=20
 /**
@@ -2670,7 +2663,7 @@ retry_private:
=20
 		ret =3D get_user(uval, uaddr);
 		if (ret)
-			goto out;
+			return ret;
=20
 		if (!(flags & FLAGS_SHARED))
 			goto retry_private;
@@ -2683,7 +2676,6 @@ retry_private:
 		ret =3D -EWOULDBLOCK;
 	}
=20
-out:
 	return ret;
 }
=20
