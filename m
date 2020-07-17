Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D142070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apu4BkRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVdOLChU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGQWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:01:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGQWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:01:23 -0400
Date:   Fri, 17 Jul 2020 22:01:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595023280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq2LHIRGvY3jdOkMPmgQwTtwfsBH7dNLLPKY0AWtYHw=;
        b=apu4BkRiTfc+RFYjnYaOqZBGT+C2E7c1zUCEoia8XWInaozF9Ro3wxm/C5XfKY01DiyrdM
        Rq+r0NK9QBhcZzTT3L5h2qRi4NHkyLk4/1xUoS5FLtyP/wrQhXcU3xA29h8G21WzS25geh
        esstbCBr0TPbf6YwHcQl4tTZUSO/vgDziXTxedYKFFQjgT29PNZP+0Cv2zcLS8sSWEO4x4
        XVmIBV92b+s3AR7AtP1VDLzZOcrsXLQ22spOmk8OJBFmZdYCrCum4qUNuGToIRSKlXdmQ8
        rtlADvT7k32fAmFE85gmOk53IbUgoLIGb4wbxBiPGKOyUYWtyYIK+KxNSPOvlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595023280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq2LHIRGvY3jdOkMPmgQwTtwfsBH7dNLLPKY0AWtYHw=;
        b=XVdOLChUbaUI/4UDNPDIoQhi5wSCIn8/LZyllVQCQn0D8rQUiH/0pg+hnlgtThOaTzT6cL
        0AVOfztrzR/NmOCQ==
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
Message-ID: <159502327949.4006.682740557157718510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2f3cc106873cb8234300c381a96b0b0e4ba63ab9
Gitweb:        https://git.kernel.org/tip/2f3cc106873cb8234300c381a96b0b0e4ba=
63ab9
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:43 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 23:58:50 +02:00

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
index 697835a..f483bc5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -458,7 +458,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -482,8 +482,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
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
@@ -520,7 +520,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex=
_key *key, enum futex_a
=20
 again:
 	/* Ignore any VERIFY_READ mapping (futex common case) */
-	if (unlikely(should_fail_futex(fshared)))
+	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
=20
 	err =3D get_user_pages_fast(address, 1, FOLL_WRITE, &page);
@@ -608,7 +608,7 @@ again:
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
 		 */
-		if (unlikely(should_fail_futex(fshared)) || ro) {
+		if (unlikely(should_fail_futex(true)) || ro) {
 			err =3D -EFAULT;
 			goto out;
 		}
