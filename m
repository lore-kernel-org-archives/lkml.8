Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D6C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DBA20643
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBAVVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:21:53 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBAVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:21:52 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MowT0-1jLUOR1pKY-00qRXX; Sat, 01 Feb 2020 22:21:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anatoly Pugachev <matorola@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: fix adjtimex regression
Date:   Sat,  1 Feb 2020 22:20:52 +0100
Message-Id: <20200201212104.575657-1-arnd@arndb.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1z5EEIgi4fNbqNsC+tS74bBl1HaQAlYsC7CubqANcDMZKS1sc2O
 2R0UOKIblbYVdpS6ebVQd8sWEApsSDODuELOKRAHDf2pPEP5FmShtdQMsdp3tYqW9TTQuzg
 LDAMyzcFQ7hvyshJe9AyW8gpH13A5ZhKFhNO6LozDHaepfd3g5kuy4kapcW7CQ/sw+7JKb3
 qyQiiV5n7Gp6vn7IKnwoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+G5agGtRXfY=:Eb+1bivj0+gIWZC6TSy3B7
 P80jNTgkmlDQu3jbJahpeLjH14d6ii2xuD2hmv1ipr/C41ASHh99vkih/s5HuxaSpooUG+58u
 Bq521S4VVZXNmudql2Eonu6Ajgue0VgcjFO6ppVGkFK6Z8MhI2DcBlstzxN36Hd2zxsUdoQVW
 W9vFesmTwmMuvt2+vuDD7ge30o7nOeC9ULNCYRL0sPR8BLhP9LkYZUNQs/jVZgVtNCYKXNVDT
 SsdkO+uLTA+LXuWcA+sgoqAdpBba2cjhaUBx1xYx4r2uv0AwtRPTzvNEL98MwC/HrsWGC4GTZ
 mCsY0IhyVEQNuVmoHO3L5TSOyt2JYfrShlyxrdthx/sTxzXG9mvARXYDN7QYVNi3sIUkHO4nz
 nPkf0JsBISwo9sBrdRMBSpRAXqmECEHoHAfLtPwZ6O5nnecMFyx7tCjHABm9V/zm0P7eHy16B
 +mV0ZlonC0nBavfBFmtT6wKRU8GOOIUtXYI2ZvW8EXlzB0vYtdc5YajV4pMf+TnG+RyxuwdD8
 NrYRXjxklP59SyX7hFote+FW65yx3FRczYmk/3YHHVHRqlfsF+k5DUvaAoH+EPeB+cqrkHKLd
 Pp9r8acCwQNNg9h4WIiSE5/PSff+LnprEayIO8fkXxsjs7KMixYjkNIrusCQaFL41ElLG/X6w
 xka6V86A1ce8TFpfSVZEn9w6DgtrgTuSOgkiGFrqONkdoH7q6gEW5t6tYHLNDWrOpabFzQTEC
 4OH2cKUC+y5L7ppToPHHd5nRzN1t/4i2tvfzyPtPY+ZwA26/ftjveoS/5AOqhGZUB3gJzF7oU
 hsAcR2fF28pIbnDLrRjAQzwaXHpwrINNPLHFaNX1V1TjZrRKXQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatoly Pugachev reported one of the y2038 patches to introduce
a fatal bug from a stupid typo:

[   96.384129] watchdog: BUG: soft lockup - CPU#8 stuck for 22s!
...
[   96.385624]  [0000000000652ca4] handle_mm_fault+0x84/0x320
[   96.385668]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
[   96.385720]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[   96.385769]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
[   96.385819]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
[   96.385866]  [0000000000406294] linux_sparc_syscall+0x34/0x44

Fix the code to dereference the correct pointer again.

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Fixes: 251ec1c159e4 ("y2038: sparc: remove use of struct timex")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The bug was introduced through my y2038 branch and is now in
mainline, but not in v5.5. Who should pick up the fix to
get it into v5.6-rc1?
---
 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 34917617f258..6b92fadb6ec7 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -551,7 +551,7 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;
-	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+	struct __kernel_old_timeval *tv = (void *)&txc.time;
 	int ret;
 
 	/* Copy the user data space into the kernel copy
@@ -576,7 +576,7 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,
 		struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;
-	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+	struct __kernel_old_timeval *tv = (void *)&txc.time;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-- 
2.25.0

