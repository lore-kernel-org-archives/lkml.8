Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B53C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292ED204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHQLcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:32:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgHQLaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 242851396;
        Mon, 17 Aug 2020 04:30:22 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3D7C3F66B;
        Mon, 17 Aug 2020 04:30:20 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 06/17] sched/debug: Output SD flag names rather than their values
Date:   Mon, 17 Aug 2020 12:29:52 +0100
Message-Id: <20200817113003.20802-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoding the output of /proc/sys/kernel/sched_domain/cpu*/domain*/flags has
always been somewhat annoying, as one needs to go fetch the bit -> name
mapping from the source code itself. This encoding can be saved in a script
somewhere, but that isn't safe from flags being added, removed or even
shuffled around.

What matters for debugging purposes is to get *which* flags are set in a
given domain, their associated value is pretty much meaningless.

Make the sd flags debug file output flag names.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 56 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 36c54265bb2b..0655524700d2 100644
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
-- 
2.27.0

