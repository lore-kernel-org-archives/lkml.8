Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C128220759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjRBs7kQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wz8x4Mgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGQV3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:29:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGQV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:29:19 -0400
Date:   Fri, 17 Jul 2020 21:29:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595021357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tC+yA+yq9E1bqmjYAvSSbLlbvzwfvVgnFftexhEoBEw=;
        b=xjRBs7kQ31CQGW5BE6TwEjEYgIbmq1xX4QQLoqng8NXpn1NSHWus0H2LfOkR1kxpwhoqFK
        qMlnT6iaUiif31sbkyaOfkN8vW98XCnQXUz1+Cga2L3XM9o38+XtfssAe2q63sBJSp1tK+
        Q93Pdy/1j2ni5ZxT1kWep/rMUYzpiGDOW6NmElefr67+FYE68jvMAGc6UYmzVAq/Mp1Owx
        g2N8/Kw1iQQWF5qcJzVvy9idpRCZa3nnMsJRvcxW2gkWi8a0hiW5EtqK8he+Hk8x9eW50r
        /vNomnHsubsOyhNRKWlgj1k0pVZ+hHu2FBlhygryLBAVWfWP1BdPoGuKni8Bag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595021357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tC+yA+yq9E1bqmjYAvSSbLlbvzwfvVgnFftexhEoBEw=;
        b=wz8x4Mgv6YNLBtWMpJtH3fF6GQqhpycaFFG7L8VJfsurVuqE1V0IaytvahaekW08vXjDev
        z9pg8oc97TGOm6BA==
From:   "tip-bot2 for Qinglang Miao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, hch@lst.de,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200716084747.8034-1-miaoqinglang@huawei.com>
References: <20200716084747.8034-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Message-ID: <159502135671.4006.15025741825906317468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     0f85c4805184765ff35e0079b3241ee8f25d1b2b
Gitweb:        https://git.kernel.org/tip/0f85c4805184765ff35e0079b3241ee8f25d1b2b
Author:        Qinglang Miao <miaoqinglang@huawei.com>
AuthorDate:    Thu, 16 Jul 2020 16:47:47 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 23:25:46 +02:00

debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

[ tglx: Distangled it from the mess in -next ]

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hch@lst.de
Link: https://lkml.kernel.org/r/20200716084747.8034-1-miaoqinglang@huawei.com

---
 lib/debugobjects.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 48054db..fe45579 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1022,18 +1022,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
 }
-
-static int debug_stats_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, debug_stats_show, NULL);
-}
-
-static const struct file_operations debug_stats_fops = {
-	.open		= debug_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug_stats);
 
 static int __init debug_objects_init_debugfs(void)
 {
