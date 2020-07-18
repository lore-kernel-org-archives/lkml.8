Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA5DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185E420768
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu25cVGP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qz1YMA79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGRAB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:01:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGRAB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:01:58 -0400
Date:   Sat, 18 Jul 2020 00:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595030515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XpgUWIGgeUWH6liOxP7uwaShsbMbEpbQlEspkHv2+s=;
        b=Wu25cVGPUIA0Le25qGbhqBsnhXRht5KcmaACd/8LWsm73vrsc6Q9kYdNul31fcN5jgtNYA
        tIxtIcFcPpyOA+qxd8VvQQY/nCLNTnL8SnjoO+G2azcUlZLMDoqeBDdF7sATnGymoH5/um
        0IQ/cL3qhpABDIgsLSNFoT5LKhmZLsMzudIMXPxydkXF5Ah2LjNOaggB02bNBwnRb6FmYn
        PlcihFE1/epIvk1CNmJrrmjiTE99dnTXBmuNAIRi0oqpqpCuqe49hoEZvvFajrmydgdPZB
        VNwxQ/BitjUyikAniwXDxcEnqHjqH5GM5hvVUbWqQtV5HfiPbvEVrjYc3nF2cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595030515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XpgUWIGgeUWH6liOxP7uwaShsbMbEpbQlEspkHv2+s=;
        b=Qz1YMA79CaC9glnKsxPfVOkM508HDBVnDpYUCA22s02nZfHOvJ3ea3YPuLsn6ScWd8R4vF
        LfqX0ia9DsqocMBQ==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Consistently use fshared as boolean
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702202843.520764-5-andrealmeid@collabora.com>
References: <20200702202843.520764-5-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <159503051506.4006.14566660709766514564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9261308598ad28b9a8a2237d881833e9f217244e
Gitweb:        https://git.kernel.org/tip/9261308598ad28b9a8a2237d881833e9f21=
7244e
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:43 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 18 Jul 2020 01:56:08 +02:00

futex: Consistently use fshared as boolean

Since fshared is only conveying true/false values, declare it as bool.

In get_futex_key() the usage of fshared can be restricted to the first part
of the function. If fshared is false the function is terminated early and
the subsequent code can use a constant 'true' instead of the variable.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200702202843.520764-5-andrealmeid@collabora=
.com

---
 kernel/futex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 362fbca..cda9175 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -476,7 +476,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -500,8 +500,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-static int
-get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum fut=
ex_access rw)
+static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *k=
ey,
+			 enum futex_access rw)
 {
 	unsigned long address =3D (unsigned long)uaddr;
 	struct mm_struct *mm =3D current->mm;
@@ -538,7 +538,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex=
_key *key, enum futex_a
=20
 again:
 	/* Ignore any VERIFY_READ mapping (futex common case) */
-	if (unlikely(should_fail_futex(fshared)))
+	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
=20
 	err =3D get_user_pages_fast(address, 1, FOLL_WRITE, &page);
@@ -626,7 +626,7 @@ again:
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
 		 */
-		if (unlikely(should_fail_futex(fshared)) || ro) {
+		if (unlikely(should_fail_futex(true)) || ro) {
 			err =3D -EFAULT;
 			goto out;
 		}
