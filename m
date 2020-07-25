Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506ABC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F72206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lbmvNhTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wL5Ag34O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgGYTvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:51:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45680 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgGYTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:51:48 -0400
Date:   Sat, 25 Jul 2020 19:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595706705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tzxo93bNci/t1uZYtvQ3Ar3hGAVig7CHbrWhhDAfsqY=;
        b=lbmvNhTjFrTQdZiGARR6IGzqB1LWkSoNRDpVrhZt2bB1FFBGOOUTnVpUGIryK+iJciFyjS
        msF7RTY5j/X97c4e9XMM3hGsBfy7YEAK4xZ1oF44STwv2oJyrN5QW5bxSZ7l2xTOloArbh
        /JBi7MIsWZaSMdGMf6zIIcAbqoDkH3z+jNKKUYBgQgrsNfc1GCRjnYMTXS5Bn+hiLO4f30
        DK4br4nqbXIwX+HrSZafCWR2iXg+n5sKvG7050aOHRmpl5SOwREXb0Wuqhrvxa1pkujmvL
        Y4j75l/I5gsn64sqGRCXYZe/eMx70R+lhp4gd8XHhFbFL4nYt8RLCYCD8gXHPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595706705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tzxo93bNci/t1uZYtvQ3Ar3hGAVig7CHbrWhhDAfsqY=;
        b=wL5Ag34OfV7jeHwdAivtw2nBIBoFIPhU+jPVQh77NIEyQskG4iES5OE3HmNHGcHAlS7Rue
        BQCs3IR8jGQnERDA==
From:   "tip-bot2 for Chris Wilson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Fix overflow in presentation
 of average lock-time
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200725185110.11588-1-chris@chris-wilson.co.uk>
References: <20200725185110.11588-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Message-ID: <159570670466.4006.5604761972444184961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a7ef9b28aa8d72a1656fa6f0a01bbd1493886317
Gitweb:        https://git.kernel.org/tip/a7ef9b28aa8d72a1656fa6f0a01bbd1493886317
Author:        Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate:    Sat, 25 Jul 2020 19:51:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 21:47:42 +02:00

locking/lockdep: Fix overflow in presentation of average lock-time

Though the number of lock-acquisitions is tracked as unsigned long, this
is passed as the divisor to div_s64() which interprets it as a s32,
giving nonsense values with more than 2 billion acquisitons. E.g.

  acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
  -------------------------------------------------------------------------
    2350439395           0.07         353.38   649647067.36          0.-32

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200725185110.11588-1-chris@chris-wilson.co.uk
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 5525cd3..02ef87f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -423,7 +423,7 @@ static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
 	seq_time(m, lt->min);
 	seq_time(m, lt->max);
 	seq_time(m, lt->total);
-	seq_time(m, lt->nr ? div_s64(lt->total, lt->nr) : 0);
+	seq_time(m, lt->nr ? div64_u64(lt->total, lt->nr) : 0);
 }
 
 static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
