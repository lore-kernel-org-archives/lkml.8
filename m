Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE93C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8758E204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z8TzPdxp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQpiSCSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHSOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHSOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FDC061346;
        Wed, 19 Aug 2020 07:02:50 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TjGySHKnltSS9pFao0dnMdxOAaO+vzMhuW0sa7+0fw=;
        b=z8TzPdxp4xVvVXzGSVdgsm/wp0jOnRwn08MPT46yKskt3y43fjMVf2VyRK50521FzlsKWa
        A4doM7RXLpOJ1qQRkjFMAxPWeSG3S3VrCpuVs3ugZJKUVb6Iu8Wlhr6rh3rxkSLHhALV+F
        Oa84Vc+YdzR9d/KquUO5Z3GFFqowsmltoAW9v1n/vhUOuvZcPx/bAcmU6TlkhKZSGnUyul
        V6ikAcoys5GiY7QgrOqtDcpP6z5B21lT6lRpnnBrRH0uNcMi4PoyQosD+JdD+iKtDgI5HB
        FgCHTX3Mv+/CEIGAf5bmX1NKVRqs3eBrrlhSAvDRBRU0nFAQvhGoDVmNBiQ8rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TjGySHKnltSS9pFao0dnMdxOAaO+vzMhuW0sa7+0fw=;
        b=ZQpiSCSQHPj1kVXQebmIe6tBVwHwpYeOeNIEXJ3m0el7UuYh7B0QTGiX1nVOf3Ig2mRU9U
        Iohz/aRrJbgg8zCw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Output SD flag names rather than their values
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-7-valentin.schneider@arm.com>
References: <20200817113003.20802-7-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576823.3192.8427103203948194710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a
Gitweb:        https://git.kernel.org/tip/5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/debug: Output SD flag names rather than their values

Decoding the output of /proc/sys/kernel/sched_domain/cpu*/domain*/flags has
always been somewhat annoying, as one needs to go fetch the bit -> name
mapping from the source code itself. This encoding can be saved in a script
somewhere, but that isn't safe from flags being added, removed or even
shuffled around.

What matters for debugging purposes is to get *which* flags are set in a
given domain, their associated value is pretty much meaningless.

Make the sd flags debug file output flag names.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-7-valentin.schneider@arm.com
---
 kernel/sched/debug.c | 56 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 36c5426..0655524 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -245,6 +245,60 @@ set_table_entry(struct ctl_table *entry,
 	entry->proc_handler = proc_handler;
 }
 
+static int sd_ctl_doflags(struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned long flags = *(unsigned long *)table->data;
+	size_t data_size = 0;
+	size_t len = 0;
+	char *tmp;
+	int idx;
+
+	if (write)
+		return 0;
+
+	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
+		char *name = sd_flag_debug[idx].name;
+
+		/* Name plus whitespace */
+		data_size += strlen(name) + 1;
+	}
+
+	if (*ppos > data_size) {
+		*lenp = 0;
+		return 0;
+	}
+
+	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
+		char *name = sd_flag_debug[idx].name;
+
+		len += snprintf(tmp + len, strlen(name) + 2, "%s ", name);
+	}
+
+	tmp += *ppos;
+	len -= *ppos;
+
+	if (len > *lenp)
+		len = *lenp;
+	if (len)
+		memcpy(buffer, tmp, len);
+	if (len < *lenp) {
+		((char *)buffer)[len] = '\n';
+		len++;
+	}
+
+	*lenp = len;
+	*ppos += len;
+
+	kfree(tmp);
+
+	return 0;
+}
+
 static struct ctl_table *
 sd_alloc_ctl_domain_table(struct sched_domain *sd)
 {
@@ -258,7 +312,7 @@ sd_alloc_ctl_domain_table(struct sched_domain *sd)
 	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, sd_ctl_doflags);
 	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[8] is terminator */
