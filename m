Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18674C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D1422B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMCI4PZd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8UrTeDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgGaJXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbgGaJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C23BC061575;
        Fri, 31 Jul 2020 02:22:58 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pJCbdw0apZCnC/JUOExJ817JlivpTmQAsz+sQzoYaV4=;
        b=lMCI4PZdwWgXUIv5tIKjnOQk+miS0FUtpQJD/YlZcyD6+suislfvNVp8Y0OB2gsZF8FR/a
        EjuhtEEwAoXjU8CdjavB5ggYLBrcdOXe3N3eeZz1gU+EPRIP1xFkMoAMx5P5kg/DfM10LQ
        n3FTbmyudtm9dcC+VWvpMng1j42i7LeXJw0Rprbydqnqyb3ZntRwROXiWtzKoLkywZ9IGl
        wPBqvdRjFn/T6RBMDhz+FjqK/bFHL+sJ9cUslJfDc9iUWqV9Eed7gApkeP/Tav9c1yYgDI
        Gve2iqFdVT2ZNN9kzhKDpO4UDMwPhSsmzTcmph74wJndkidHDURmujskodpOXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pJCbdw0apZCnC/JUOExJ817JlivpTmQAsz+sQzoYaV4=;
        b=H8UrTeDlfJpNQLG/zjjsnDP8Xz1QdQKr/NbstQTdV3NUwKHlFLql2Zim6ePKxCqC2Q4cX+
        csFh7nwXMlB/v4CA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Work around 64-bit division
Cc:     kbuild test robot <lkp@intel.com>, valdis.kletnieks@vt.edu,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737593.4006.17865090440810592655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7c944d7c67daee84e3c756bb74ad2f32b28c41cf
Gitweb:        https://git.kernel.org/tip/7c944d7c67daee84e3c756bb74ad2f32b28=
c41cf
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 29 May 2020 14:36:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Work around 64-bit division

A 64-bit division was introduced in refperf, breaking compilation
on all 32-bit architectures:

kernel/rcu/refperf.o: in function `main_func':
refperf.c:(.text+0x57c): undefined reference to `__aeabi_uldivmod'

Fix this by using div_u64 to mark the expensive operation.

[ paulmck: Update primitive and format per Nathan Chancellor. ]
Fixes: bd5b16d6c88d ("refperf: Allow decimal nanoseconds")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 063eeb0..80d4490 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -478,7 +478,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
=20
-		result_avg[exp] =3D 1000 * process_durations(nreaders) / (nreaders * loops=
);
+		result_avg[exp] =3D div_u64(1000 * process_durations(nreaders), nreaders *=
 loops);
 	}
=20
 	// Print the average of all experiments
@@ -489,9 +489,13 @@ static int main_func(void *arg)
 	strcat(buf, "Runs\tTime(ns)\n");
=20
 	for (exp =3D 0; exp < nruns; exp++) {
+		u64 avg;
+		u32 rem;
+
 		if (errexit)
 			break;
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(re=
sult_avg[exp] % 1000));
+		avg =3D div_u64_rem(result_avg[exp], 1000, &rem);
+		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
 		strcat(buf, buf1);
 	}
=20
