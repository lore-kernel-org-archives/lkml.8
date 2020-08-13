Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6A320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MemtrNgF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUfmMj01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHMUuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:50:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:50:03 -0400
Date:   Thu, 13 Aug 2020 20:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597351800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bsd/TQ/ZE+yOfCb1hQeMBy6ashMeNuJmmWDs+KlvuU=;
        b=MemtrNgFW3qZC+f1iwjB0sY0iOfmjyEkCOkNLs5qayld+JmUFHHH6yXdZgM1hSPVpGaNeJ
        R1MF+SfHD2khep66i2PQXjL7BqVhfr32AgH6cffeoNRU78r9822ivi5r/YPea3ydHwGdOx
        iqGPrmLysgv0fLXl0FPyX3ip0OI4VeMnXVcT7MixS3W6bnqU5gA64/nAPp7VwTKkl38Zkq
        PJOpkF5bnYIoI1ShNnnhzGGvdv8/mtrZ5D+6rfnOtibs599l1WbuK9ctyELD4bLamdDgih
        r9J/in62J8Qw0gsb3xJNioeCqTf97gPV3ImRiqkoFu/bdG+nLimLYUUtFHdbew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597351800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bsd/TQ/ZE+yOfCb1hQeMBy6ashMeNuJmmWDs+KlvuU=;
        b=VUfmMj01O2vihFvSNCtK1KiOS3z0DLVFvPsw7hteZC5xikWjAo9jN71s8Iy2EOtjvRRC7E
        5fAYerfSB6FXUqDQ==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Convert to use the preferred 'fallthrough' macro
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200813122117.51173-1-linmiaohe@huawei.com>
References: <20200813122117.51173-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <159735179972.3192.9928492577920549198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     405fa8ac89e7aaa87282df659e525992f2639e76
Gitweb:        https://git.kernel.org/tip/405fa8ac89e7aaa87282df659e525992f2639e76
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Thu, 13 Aug 2020 08:21:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Aug 2020 21:02:12 +02:00

futex: Convert to use the preferred 'fallthrough' macro

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200813122117.51173-1-linmiaohe@huawei.com
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 61e8153..a587669 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3744,12 +3744,12 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAIT_BITSET:
 		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
