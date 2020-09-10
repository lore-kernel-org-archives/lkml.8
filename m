Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4091BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05635207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1zpVDFbw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqP/Yqno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIJT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD95C06135A;
        Thu, 10 Sep 2020 08:08:31 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBHuPonnkskzksJG6Zbiq3X3NoXaFg2IEQhNB0u44dk=;
        b=1zpVDFbwqSwixWiiVhhZI9t3RrgtIOywgCrOxNBfeviKrWTWsk1jo6mADVIvSTplGNbU9i
        YbfwDnfAmBbGPgvOMQ8c3ntupfkKGofT+SQY08GD1kwj20aKt+cU1JCVX39+N9lHSdAKHW
        1QBvQSfUnPSacb1eBGmVlGw8H7ld7FMbuYJX5CbjRziSKm4p9Mri1fcG8SgbFga4ZC3c18
        3bgiEu1jqmwRZVT2a0qup6Ry5VF1RWG6JC8X1lrQzFmKdfODKTA0nfzWNWDaOsiFxz39N2
        0m2GK+YK3EBh6TT2zqzqkFA+S/KeIfr/f54EfQ9nItMrb+maWfoX0NFu1xbMEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBHuPonnkskzksJG6Zbiq3X3NoXaFg2IEQhNB0u44dk=;
        b=sqP/YqnopEtz6aJO018G34feZX0oIUi8GTM5XxcUh0qeuOv2gWFJcSn77AZlTuNSeUpK5u
        hRSjavqHqbSwnEAg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] time/sched_clock: Use raw_read_seqcount_latch()
 during suspend
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de>
References: <20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050909.20229.15551175096840400557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     58faf20a086bd34f91983609e26eac3d5fe76be3
Gitweb:        https://git.kernel.org/tip/58faf20a086bd34f91983609e26eac3d5fe76be3
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:28 +02:00

time/sched_clock: Use raw_read_seqcount_latch() during suspend

sched_clock uses seqcount_t latching to switch between two storage
places protected by the sequence counter. This allows it to have
interruptible, NMI-safe, seqcount_t write side critical sections.

Since 7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()"),
raw_read_seqcount_latch() became the standardized way for seqcount_t
latch read paths. Due to the dependent load, it has one read memory
barrier less than the currently used raw_read_seqcount() API.

Use raw_read_seqcount_latch() for the suspend path.

Commit aadd6e5caaac ("time/sched_clock: Use raw_read_seqcount_latch()")
missed changing that instance of raw_read_seqcount().

References: 1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 1c03eec..8c6b5fe 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -258,7 +258,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned int seq = raw_read_seqcount(&cd.seq);
+	unsigned int seq = raw_read_seqcount_latch(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
